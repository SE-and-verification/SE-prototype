package aes

import chisel3._
import chisel3.util._
import chisel3.experimental.hierarchy._
import chisel3.util.HasBlackBoxPath


class InvCipherIO(val unrollFactor: Int = 1) extends Bundle {
  val ciphertext   = Input(Vec(Params.StateLength, UInt(8.W)))
  val roundKey     = Input(Vec(Params.StateLength, UInt(8.W)))
  val roundKeysTail = Input(Vec((unrollFactor - 1) max 0, Vec(Params.StateLength, UInt(8.W))))
  val start        = Input(Bool())
  val state_out    = Output(Vec(Params.StateLength, UInt(8.W)))
  val state_out_valid = Output(Bool())
}

// AES inverse cipher with optional round unrolling.
// unrollFactor=1 reproduces the original 1-round/cycle behaviour (12-cycle latency).
// unrollFactor=4 matches AESEncrypt's throughput (5-cycle latency).
@instantiable
class InvCipher(Nk: Int, InvSubBytes_SCD: Boolean, index: Int, val unrollFactor: Int = 1) extends Module {
  require(Nk == 4 || Nk == 6 || Nk == 8)
  require(unrollFactor >= 1)
  val KeyLength: Int = Nk * Params.rows
  val Nr: Int        = Nk + 6
  val Nrplus1: Int   = Nr + 1

  @public val io = IO(new InvCipherIO(unrollFactor))

  val initValues = Seq.fill(Params.StateLength)(0.U(8.W))
  val state  = RegInit(VecInit(initValues))

  // Use concrete Int widths everywhere to prevent FIRRTL grow-width inference.
  val roundNrBits: Int  = log2Ceil(Nr + 3)
  val stageIdxBits: Int = log2Ceil(unrollFactor + 1)
  val roundBits = roundNrBits.W
  val stageIdxW = stageIdxBits.W

  val rounds = RegInit(0.U(roundBits))

  val sIdle :: sInitialAR :: sBusy :: Nil = Enum(3)
  val STM = RegInit(sIdle)

  // Fixed-width remaining: use -% (FIRRTL subw) to avoid grow-by-1 width inference.
  val remaining = Wire(UInt(roundBits))
  remaining := Mux(rounds > Nr.U(roundBits), 0.U(roundBits), (Nr + 1).U(roundBits) -% rounds)

  // Follow Cipher.scala pattern exactly for stagesThisCycle.
  val stagesThisCycle = Wire(UInt(stageIdxW))
  val ufConst = unrollFactor.U(stageIdxW)
  stagesThisCycle := Mux(remaining < ufConst, remaining, ufConst).asTypeOf(UInt(stageIdxW))

  // Fixed-width nextRounds: assign to explicit wire to prevent cascading inference.
  val nextRounds = Wire(UInt(roundBits))
  nextRounds := (rounds +& stagesThisCycle)(roundNrBits - 1, 0)

  // Initial AddRoundKey (applied in sInitialAR with the ciphertext as input)
  val AddRoundKeyInit = AddRoundKey()
  AddRoundKeyInit.io.state_in := io.ciphertext
  AddRoundKeyInit.io.roundKey := io.roundKey

  // Unrolled combinational pipeline stages
  val InvShiftRowsStages  = Seq.fill(unrollFactor)(InvShiftRows())
  val InvSubBytesStages   = Seq.fill(unrollFactor)(InvSubBytes(InvSubBytes_SCD))
  val AddRoundKeyStages   = Seq.fill(unrollFactor)(AddRoundKey())
  val InvMixColumnsStages = Seq.fill(unrollFactor)(InvMixColumns())

  // Wire stages: stageIn uses InvMixColumns output (clean single endpoint per stage,
  // matching Cipher.scala's AddRoundKey endpoint pattern). When stage i-1 is the
  // final AES round, stage i is not selected by MuxLookup so the incorrect stageIn
  // value is harmless.
  for (i <- 0 until unrollFactor) {
    val stageIn = if (i == 0) state else InvMixColumnsStages(i - 1).io.state_out
    InvShiftRowsStages(i).io.state_in  := stageIn
    InvSubBytesStages(i).io.state_in   := InvShiftRowsStages(i).io.state_out
    AddRoundKeyStages(i).io.state_in   := InvSubBytesStages(i).io.state_out
    AddRoundKeyStages(i).io.roundKey   := (if (unrollFactor == 1 || i == 0) io.roundKey else io.roundKeysTail(i - 1))
    InvMixColumnsStages(i).io.state_in := AddRoundKeyStages(i).io.state_out
  }

  // Terminal output per stage (val, not def — each Mux node created exactly once).
  // Use a fixed-width wire for roundIndex to prevent FIRRTL from growing width on +.
  val stageTerminals: Seq[Vec[UInt]] = Seq.tabulate(unrollFactor) { s =>
    val roundIndex = Wire(UInt(roundBits))
    roundIndex := (rounds +& s.U(roundBits))(roundNrBits - 1, 0)
    Mux(roundIndex === Nr.U(roundBits),
      AddRoundKeyStages(s).io.state_out,
      InvMixColumnsStages(s).io.state_out)
  }

  val busyStateOut = MuxLookup(
    stagesThisCycle,
    state,
    Seq.tabulate(unrollFactor)(s => ((s + 1).U(stageIdxW), stageTerminals(s))))

  switch(STM) {
    is(sIdle) {
      when(io.start) { STM := sInitialAR }
      rounds := 0.U(roundBits)
    }
    is(sInitialAR) {
      rounds := 1.U(roundBits)
      STM    := sBusy
    }
    is(sBusy) {
      rounds := nextRounds
      when(nextRounds === Nrplus1.U(roundBits)) { STM := sIdle }
    }
  }

  state := Mux(STM =/= sIdle,
    Mux(STM === sInitialAR, AddRoundKeyInit.io.state_out, busyStateOut),
    VecInit(initValues))

  io.state_out_valid := rounds === Nrplus1.U(roundBits)
  io.state_out       := Mux(rounds === Nrplus1.U(roundBits), state, VecInit(initValues))

  if (index == 3) {
    when(io.start) { }
    when(STM === sInitialAR || STM === sBusy) { }
  }
}

object InvCipher {
  def apply(Nk: Int, InvSubBytes_SCD: Boolean, index: Int, unrollFactor: Int = 1): InvCipher =
    Module(new InvCipher(Nk, InvSubBytes_SCD, index, unrollFactor))
}

// BlackBox wrapper for unrollFactor=4. FIRRTL treats this as an opaque extmodule,
// bypassing the width-inference constraint explosion that occurs when InvCipher(unrollFactor=4)
// is elaborated alongside the full SE design. InvCipher4.v must be provided at synthesis time.
class InvCipherBB extends BlackBox with HasBlackBoxPath {
  override val desiredName = "InvCipher"
  val io = IO(new InvCipherIO(4))
  addPath(new java.io.File("generated-src/InvCipher4.v").getAbsolutePath)
}
