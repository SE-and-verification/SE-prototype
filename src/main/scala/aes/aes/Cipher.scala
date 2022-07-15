package aes

import chisel3._
import chisel3.util._

class CipherIO extends Bundle{
  val plaintext = Input(Vec(16, UInt(8.W)))
  val roundKeys = Input(Vec(11, Vec(16, UInt(8.W))))
  val start = Input(Bool())
  val state_out = Output(Vec(16, UInt(8.W)))
  val state_out_valid = Output(Bool())
}

// implements AES_Encrypt
class Cipher extends Module {
  val KeyLength: Int = 16
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1

  val io = IO(new CipherIO)

  // TODO: reverse roundKeys in users of {Inv,}Cipher instead of here
  val roundKeys = VecInit(io.roundKeys.reverse)

  // Instantiate module objects
  val AddRoundKeyModule = AddRoundKey()
  val SubBytesModule = SubBytes()
  val ShiftRowsModule = ShiftRows()
  val MixColumnsModule = MixColumns()

  // Internal variables
  val initValues = Seq.fill(16)(0.U(8.W))
  val state = RegInit(VecInit(initValues))
  val rounds = RegInit(0.U(4.W))

  // STM
  val sIdle :: sStartRound :: sWaitRound :: sDone :: Nil = Enum(4)
  val STM = RegInit(sIdle)

  when (io.start) {
    rounds := 0.U
    STM := sStartRound
  }

  when (STM === sStartRound) {
    STM := sWaitRound
  }

  // AddRoundKeyModule.io.valid could be true when
  // STM === sStartRound if Pipelined === false, so
  // check for it in both sStartRound and sWaitRound
  when (STM === sStartRound || STM === sWaitRound) {
    when (AddRoundKeyModule.io.valid) {
      state := AddRoundKeyModule.io.state_out
      rounds := rounds + 1.U
      STM := Mux(rounds === Nr.U, sDone, sStartRound)
    }
  }

  when (STM === sDone) {
    rounds := 0.U
    STM := sIdle
  }

  // SubBytes state
  SubBytesModule.io.state_in := state
  SubBytesModule.io.ready := (STM === sStartRound && rounds =/= 0.U)

  // ShiftRows state
  ShiftRowsModule.io.state_in := SubBytesModule.io.state_out
  ShiftRowsModule.io.ready := SubBytesModule.io.valid

  // MixColumns state
  MixColumnsModule.io.state_in := ShiftRowsModule.io.state_out
  MixColumnsModule.io.ready := ShiftRowsModule.io.valid

  // AddRoundKey state
  AddRoundKeyModule.io.state_in := Mux(STM === sStartRound && rounds === 0.U, io.plaintext,
    Mux(rounds === Nr.U, ShiftRowsModule.io.state_out, MixColumnsModule.io.state_out))
  AddRoundKeyModule.io.roundKey := roundKeys(rounds)
  AddRoundKeyModule.io.ready := ((STM === sStartRound && rounds === 0.U) ||
    Mux(rounds === Nr.U, ShiftRowsModule.io.valid, MixColumnsModule.io.valid))

  // Set state_out_valid true when cipher ends
  io.state_out_valid := (STM === sDone)
  io.state_out := Mux(io.state_out_valid, state, VecInit(initValues))

  // Debug statements
  //  printf("E_STM: %d, rounds: %d, valid: %d\n", STM, rounds, io.state_out_valid)
  //  printf("E_roundKey: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", io.roundKey(0), io.roundKey(1), io.roundKey(2), io.roundKey(3), io.roundKey(4), io.roundKey(5), io.roundKey(6), io.roundKey(7), io.roundKey(8), io.roundKey(9), io.roundKey(10), io.roundKey(11), io.roundKey(12), io.roundKey(13), io.roundKey(14), io.roundKey(15))
  //  printf("state: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", state(0), state(1), state(2), state(3), state(4), state(5), state(6), state(7), state(8), state(9), state(10), state(11), state(12), state(13), state(14), state(15))
}

object Cipher {
  def apply(): Cipher = Module(new Cipher)
}