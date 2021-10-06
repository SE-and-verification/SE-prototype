package se.seoperation

import chisel3._
import chisel3.util._


object SEControl {
  val Y = true.B
  val N = false.B

  // legal
  val LEGAL = true.B
  val ILLEGAL = false.B

  import Instructions._
  import FU._
  import COMP._
  import ARITH._
  import SHIFT._
  import LOGICAL._
  val default = List(FU_XXX, COMP_XXX,LEGAL, N)
  val map = Array(
  // Shifts
  SLL   -> List(FU_SHIFT,SHIFT_SLL, LEGAL, N),
  SLA   -> List(FU_SHIFT,SHIFT_SLA, LEGAL, N),
  SRL   -> List(FU_SHIFT,SHIFT_SRL, LEGAL, N),
  SRA   -> List(FU_SHIFT,SHIFT_SRA, LEGAL, N),

  // Arithmetic
  ADD   -> List(FU_ARITH,ARITH_ADD, LEGAL, Y),
  SUB   -> List(FU_ARITH,ARITH_SUB, LEGAL, Y),
  MULT  -> List(FU_ARITH,ARITH_MULT, LEGAL, Y),
  DIV   -> List(FU_ARITH,ARITH_DIV, LEGAL, Y),

  ADDU   -> List(FU_ARITH,ARITH_ADD, LEGAL, N),
  SUBU   -> List(FU_ARITH,ARITH_SUB, LEGAL, N),
  MULTU  -> List(FU_ARITH,ARITH_MULT, LEGAL, N),
  DIVU   -> List(FU_ARITH,ARITH_DIV, LEGAL, N),

  // Logical
  XOR   -> List(FU_LOGICAL,LOGICAL_XOR, LEGAL, N),
  OR    -> List(FU_LOGICAL,LOGICAL_OR, LEGAL, N),
  AND   -> List(FU_LOGICAL,LOGICAL_AND, LEGAL, N),
  NEG   -> List(FU_LOGICAL,LOGICAL_NEG, LEGAL, N),

  // Compare
  LT   -> List(FU_COMP,COMP_LT, LEGAL, N),
  SLTU -> List(FU_COMP,COMP_LT, LEGAL, Y),
  GT   -> List(FU_COMP,COMP_GT, LEGAL, N),
  SGTU -> List(FU_COMP,COMP_GT, LEGAL, Y),
  EQ   -> List(FU_COMP,COMP_EQ, LEGAL, N),
  SEQU -> List(FU_COMP,COMP_EQ, LEGAL, Y),
  NEQ  -> List(FU_COMP,COMP_NEQ, LEGAL, N),
  SNEQU-> List(FU_COMP,COMP_NEQ, LEGAL, Y),
  LE   -> List(FU_COMP,COMP_LE, LEGAL, N),
  SLEU -> List(FU_COMP,COMP_LE, LEGAL, Y),
  GE   -> List(FU_COMP,COMP_GE, LEGAL, N),
  SGEU -> List(FU_COMP,COMP_GE, LEGAL, Y),

  // Conditional
  CMOV  ->  List(FU_COND, COMP_XXX, LEGAL, N)
	)
}


class SEControlIO extends Bundle{
  val inst_in = Input(UInt(8.W))

  val inst_out   = Output(UInt(8.W))
  val fu_op   = Output(UInt(3.W))
  val fu_type = Output(UInt(3.W))
  val legal   = Output(Bool())
  val cmov = Output(Bool())
  val signed = Output(Bool()) // signed version or not
}


class SEControl extends Module {
  val io = IO(new SEControlIO)

  val ctrlSignals = ListLookup(in.inst_in, SEControl.default, SEControl.map)

  io.inst_out := io.inst_in
  io.fu_op := ctrlSignals(0)
  io.fu_type := ctrlSignals(1)
  io.legal := ctrlSignals(2)
  io.signed := ctrlSignals(3)
}