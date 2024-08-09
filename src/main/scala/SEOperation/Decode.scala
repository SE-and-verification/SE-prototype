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
  import COND._
  import CRYPTO._
  val default = List(FU_XXX, COMP_XXX,LEGAL, N)
  val map = Array(
  // Shifts
  SLL   -> List(FU_SHIFT,SHIFT_SLL, LEGAL, N),
  SRL   -> List(FU_SHIFT,SHIFT_SRL, LEGAL, N),
  SRA   -> List(FU_SHIFT,SHIFT_SRA, LEGAL, N),

  // Arithmetic
  ADD   -> List(FU_ARITH,ARITH_ADD, LEGAL, N),
  SUB   -> List(FU_ARITH,ARITH_SUB, LEGAL, N),
  MULT  -> List(FU_ARITH,ARITH_MULT, LEGAL, N),
  MULTS -> List(FU_ARITH,ARITH_MULT, LEGAL, Y),


  // Logical
  XOR   -> List(FU_LOGICAL,LOGICAL_XOR, LEGAL, N),
  OR    -> List(FU_LOGICAL,LOGICAL_OR, LEGAL, N),
  AND   -> List(FU_LOGICAL,LOGICAL_AND, LEGAL, N),

  // Compare
  LT    -> List(FU_COMP,COMP_LT, LEGAL, N),
  LTS   -> List(FU_COMP,COMP_LT, LEGAL, Y),
 
  // Conditional
  CMOV  -> List(FU_COND, COND_COND, LEGAL, N),

  // ENC
  ENC_VAR   -> List(FU_ENC, CRYPTO_ENC_VAR, LEGAL, N),
  ENC_CONST  -> List(FU_ENC, CRYPTO_ENC_CONST, LEGAL, N)
	)
}


class SEControlIO extends Bundle{
  val inst_in = Input(UInt(8.W))

  val inst_out   = Output(UInt(8.W))
  val fu_op   = Output(UInt(3.W))
  val fu_type = Output(UInt(2.W))
  val legal   = Output(Bool())
  val signed = Output(Bool()) // signed version or not
}


class SEControl extends Module {
  val io = IO(new SEControlIO)

  val ctrlSignals = ListLookup(io.inst_in, SEControl.default, SEControl.map)

  io.inst_out := io.inst_in
  io.fu_op := ctrlSignals(0)
  io.fu_type := ctrlSignals(1)
  io.legal := ctrlSignals(2)
  io.signed := ctrlSignals(3)
}