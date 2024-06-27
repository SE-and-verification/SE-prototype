package aes

import chisel3._
import chisel3.util._

class InvCipherIO extends Bundle{
  val ciphertext = Input(Vec(Params.StateLength, UInt(8.W)))
  val roundKey = Input(Vec(Params.StateLength, UInt(8.W)))
  val start = Input(Bool())
  val state_out = Output(Vec(Params.StateLength, UInt(8.W)))
  val state_out_valid = Output(Bool())
}
// implements AES_Decrypt
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
class InvCipher(Nk: Int, InvSubBytes_SCD: Boolean, index:Int) extends Module {
  require(Nk == 4 || Nk == 6 || Nk == 8)
  val KeyLength: Int = Nk * Params.rows
  val Nr: Int = Nk + 6 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1

  val io = IO(new InvCipherIO)

  // Instantiate module objects
  val AddRoundKeyModule = AddRoundKey()
  val InvSubBytesModule = InvSubBytes(InvSubBytes_SCD)
  val InvShiftRowsModule = InvShiftRows()
  val InvMixColumnsModule = InvMixColumns()

  // Internal variables
  val initValues = Seq.fill(Params.StateLength)(0.U(8.W))
  val state = RegInit(VecInit(initValues))
  val rounds = RegInit(0.U(4.W))

  // STM
  val sIdle :: sInitialAR :: sBusy :: Nil = Enum(3)
  val STM = RegInit(sIdle)

  switch(STM) {
    is(sIdle) {
      when(io.start) {
        STM := sInitialAR
      } // Start cipher
      rounds := 0.U
    }
    is(sInitialAR) {
      rounds := rounds + 1.U
      STM := sBusy
    }
    is(sBusy) {
      rounds := rounds + 1.U
      when(rounds === Nr.U) {
        STM := sIdle
      }
    }
  }

  // InvShiftRows state
  InvShiftRowsModule.io.state_in := state

  // InvSubBytes state
  InvSubBytesModule.io.state_in := InvShiftRowsModule.io.state_out

  // AddRoundKey state
  AddRoundKeyModule.io.state_in := Mux(STM === sInitialAR, io.ciphertext, InvSubBytesModule.io.state_out)
  AddRoundKeyModule.io.roundKey := io.roundKey

  // InvMixColumns state
  InvMixColumnsModule.io.state_in := AddRoundKeyModule.io.state_out

  state := Mux(STM =/= sIdle, Mux((rounds > 0.U) & (rounds < Nr.U), InvMixColumnsModule.io.state_out, AddRoundKeyModule.io.state_out), VecInit(initValues))

  // Set state_out_valid true when cipher ends
  io.state_out_valid := rounds === Nrplus1.U
  io.state_out := Mux(rounds === Nrplus1.U, state, RegInit(VecInit(initValues)))

  print(s"invcipher index: ${index}\n")

  if(index == 3){
  when(io.start){
    printf("input ciphertext: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", io.ciphertext(0), io.ciphertext(1), io.ciphertext(2), io.ciphertext(3), io.ciphertext(4), io.ciphertext(5), io.ciphertext(6), io.ciphertext(7), io.ciphertext(8),  io.ciphertext(9), io.ciphertext(10), io.ciphertext(11), io.ciphertext(12), io.ciphertext(13), io.ciphertext(14), io.ciphertext(15))
  }
  when(STM === sInitialAR || STM === sBusy){
   printf("D_STM: %d, rounds: %d, valid: %d\n", STM, rounds, io.state_out_valid)
   printf("D_roundKey: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", io.roundKey(0), io.roundKey(1), io.roundKey(2), io.roundKey(3), io.roundKey(4), io.roundKey(5), io.roundKey(6), io.roundKey(7), io.roundKey(8), io.roundKey(9), io.roundKey(10), io.roundKey(11), io.roundKey(12), io.roundKey(13), io.roundKey(14), io.roundKey(15))
   printf("state: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", state(0), state(1), state(2), state(3), state(4), state(5), state(6), state(7), state(8), state(9), state(10), state(11), state(12), state(13), state(14), state(15))
   printf("InvShiftRows: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", InvShiftRowsModule.io.state_out(0), InvShiftRowsModule.io.state_out(1), InvShiftRowsModule.io.state_out(2), InvShiftRowsModule.io.state_out(3), InvShiftRowsModule.io.state_out(4), InvShiftRowsModule.io.state_out(5), InvShiftRowsModule.io.state_out(6), InvShiftRowsModule.io.state_out(7), InvShiftRowsModule.io.state_out(8), InvShiftRowsModule.io.state_out(9), InvShiftRowsModule.io.state_out(10), InvShiftRowsModule.io.state_out(11), InvShiftRowsModule.io.state_out(12), InvShiftRowsModule.io.state_out(13), InvShiftRowsModule.io.state_out(14), InvShiftRowsModule.io.state_out(15))
   printf("InvSubBytes: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", InvSubBytesModule.io.state_out(0), InvSubBytesModule.io.state_out(1), InvSubBytesModule.io.state_out(2), InvSubBytesModule.io.state_out(3), InvSubBytesModule.io.state_out(4), InvSubBytesModule.io.state_out(5), InvSubBytesModule.io.state_out(6), InvSubBytesModule.io.state_out(7), InvSubBytesModule.io.state_out(8), InvSubBytesModule.io.state_out(9), InvSubBytesModule.io.state_out(10), InvSubBytesModule.io.state_out(11), InvSubBytesModule.io.state_out(12), InvSubBytesModule.io.state_out(13), InvSubBytesModule.io.state_out(14), InvSubBytesModule.io.state_out(15))
   printf("AddRoundKey: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", AddRoundKeyModule.io.state_out(0), AddRoundKeyModule.io.state_out(1), AddRoundKeyModule.io.state_out(2), AddRoundKeyModule.io.state_out(3), AddRoundKeyModule.io.state_out(4), AddRoundKeyModule.io.state_out(5), AddRoundKeyModule.io.state_out(6), AddRoundKeyModule.io.state_out(7), AddRoundKeyModule.io.state_out(8), AddRoundKeyModule.io.state_out(9), AddRoundKeyModule.io.state_out(10), AddRoundKeyModule.io.state_out(11), AddRoundKeyModule.io.state_out(12), AddRoundKeyModule.io.state_out(13), AddRoundKeyModule.io.state_out(14), AddRoundKeyModule.io.state_out(15))
   printf("InvMixColumns: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", InvMixColumnsModule.io.state_out(0), InvMixColumnsModule.io.state_out(1), InvMixColumnsModule.io.state_out(2), InvMixColumnsModule.io.state_out(3), InvMixColumnsModule.io.state_out(4), InvMixColumnsModule.io.state_out(5), InvMixColumnsModule.io.state_out(6), InvMixColumnsModule.io.state_out(7), InvMixColumnsModule.io.state_out(8), InvMixColumnsModule.io.state_out(9), InvMixColumnsModule.io.state_out(10), InvMixColumnsModule.io.state_out(11), InvMixColumnsModule.io.state_out(12), InvMixColumnsModule.io.state_out(13), InvMixColumnsModule.io.state_out(14), InvMixColumnsModule.io.state_out(15))

  }
  }
  // Debug statements
  //  printf("D_STM: %d, rounds: %d, valid: %d\n", STM, rounds, io.state_out_valid)
  //  printf("D_roundKey: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", io.roundKey(0), io.roundKey(1), io.roundKey(2), io.roundKey(3), io.roundKey(4), io.roundKey(5), io.roundKey(6), io.roundKey(7), io.roundKey(8), io.roundKey(9), io.roundKey(10), io.roundKey(11), io.roundKey(12), io.roundKey(13), io.roundKey(14), io.roundKey(15))
  //  printf("state: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", state(0), state(1), state(2), state(3), state(4), state(5), state(6), state(7), state(8), state(9), state(10), state(11), state(12), state(13), state(14), state(15))
}

object InvCipher {
  def apply(Nk: Int, InvSubBytes_SCD: Boolean, index:Int): InvCipher = Module(new InvCipher(Nk, InvSubBytes_SCD, index))
}