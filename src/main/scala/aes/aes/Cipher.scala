package aes

import chisel3._
import chisel3.util._

class CipherIO(val unrollFactor: Int) extends Bundle {
  require(unrollFactor >= 1)
  val plaintext = Input(Vec(Params.StateLength, UInt(8.W)))
  val roundKey = Input(Vec(Params.StateLength, UInt(8.W)))
  /** Keys for combinational stages 1 .. unrollFactor-1 in the same cycle (stage 0 uses roundKey). Empty when unrollFactor == 1. */
  val roundKeysTail = Input(Vec((unrollFactor - 1) max 0, Vec(Params.StateLength, UInt(8.W))))
  val start = Input(Bool())
  val state_out = Output(Vec(Params.StateLength, UInt(8.W)))
  val state_out_valid = Output(Bool())
}
// implements AES_Encrypt
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
class Cipher(Nk: Int, SubBytes_SCD: Boolean, val unrollFactor: Int = 1) extends Module {
  require(Nk == 4 || Nk == 6 || Nk == 8)
  require(unrollFactor >= 1)
  val KeyLength: Int = Nk * Params.rows
  val Nr: Int = Nk + 6 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1

  val io = IO(new CipherIO(unrollFactor))

  val roundBits = log2Ceil(Nr + 3).W
  val stageIdxW = log2Ceil(unrollFactor + 1).W

  // Initial AddRoundKey (AES round 0)
  val AddRoundKeyInit = AddRoundKey()
  AddRoundKeyInit.io.state_in := io.plaintext
  AddRoundKeyInit.io.roundKey := io.roundKey

  val SubBytesStages = Seq.fill(unrollFactor)(SubBytes(SubBytes_SCD))
  val ShiftRowsStages = Seq.fill(unrollFactor)(ShiftRows())
  val MixColumnsStages = Seq.fill(unrollFactor)(MixColumns())
  val AddRoundKeyStages = Seq.fill(unrollFactor)(AddRoundKey())

  val initValues = Seq.fill(Params.StateLength)(0.U(8.W))
  val state = RegInit(VecInit(initValues))
  val rounds = RegInit(0.U(roundBits))

  val sIdle :: sInitialAR :: sBusy :: Nil = Enum(3)
  val STM = RegInit(sIdle)

  val remaining = Wire(UInt(roundBits))
  remaining := Mux(rounds > Nr.U, 0.U, (Nr + 1).U(roundBits) - rounds)
  val stagesThisCycle = Wire(UInt(stageIdxW))
  val ufConst = unrollFactor.U(stageIdxW)
  stagesThisCycle := Mux(remaining < ufConst, remaining, ufConst).asTypeOf(UInt(stageIdxW))

  val nextRounds = rounds +& stagesThisCycle

  switch(STM) {
    is(sIdle) {
      when(io.start) {
        STM := sInitialAR
      }
      rounds := 0.U
    }
    is(sInitialAR) {
      rounds := 1.U
      STM := sBusy
    }
    is(sBusy) {
      rounds := nextRounds
      when(nextRounds === Nrplus1.U) {
        STM := sIdle
      }
    }
  }

  for (i <- 0 until unrollFactor) {
    val roundIndex = rounds + i.U(roundBits)
    val stageIn = if (i == 0) state else AddRoundKeyStages(i - 1).io.state_out
    SubBytesStages(i).io.state_in := stageIn
    ShiftRowsStages(i).io.state_in := SubBytesStages(i).io.state_out
    MixColumnsStages(i).io.state_in := ShiftRowsStages(i).io.state_out
    AddRoundKeyStages(i).io.state_in := Mux(roundIndex === Nr.U,
      ShiftRowsStages(i).io.state_out,
      MixColumnsStages(i).io.state_out)
    AddRoundKeyStages(i).io.roundKey := (if (unrollFactor == 1 || i == 0) {
      io.roundKey
    } else {
      io.roundKeysTail(i - 1)
    })
  }

  val busyStateOut = MuxLookup(
    stagesThisCycle,
    state,
    Seq.tabulate(unrollFactor)(s => ((s + 1).U(stageIdxW), AddRoundKeyStages(s).io.state_out))
  )

  state := Mux(STM =/= sIdle,
    Mux(STM === sInitialAR, AddRoundKeyInit.io.state_out, busyStateOut),
    VecInit(initValues))

  val zeroOut = Wire(Vec(Params.StateLength, UInt(8.W)))
  zeroOut := VecInit(initValues)

  io.state_out_valid := rounds === Nrplus1.U
  io.state_out := Mux(rounds === Nrplus1.U, state, zeroOut)

  // Debug statements
  //  printf("E_STM: %d, rounds: %d, valid: %d\n", STM, rounds, io.state_out_valid)
  //  printf("E_roundKey: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", io.roundKey(0), io.roundKey(1), io.roundKey(2), io.roundKey(3), io.roundKey(4), io.roundKey(5), io.roundKey(6), io.roundKey(7), io.roundKey(8), io.roundKey(9), io.roundKey(10), io.roundKey(11), io.roundKey(12), io.roundKey(13), io.roundKey(14), io.roundKey(15))
  //  printf("state: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", state(0), state(1), state(2), state(3), state(4), state(5), state(6), state(7), state(8), state(9), state(10), state(11), state(12), state(13), state(14), state(15))
}

object Cipher {
  def apply(Nk: Int, SubBytes_SCD: Boolean, unrollFactor: Int = 1): Cipher =
    Module(new Cipher(Nk, SubBytes_SCD, unrollFactor))
}
