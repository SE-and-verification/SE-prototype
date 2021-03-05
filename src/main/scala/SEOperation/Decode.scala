package se.seoperation

import chisel3._
import chisel3.simplechisel._
import chisel3.util._
import chisel3.simplechisel.util._


object SEControl {
  val Y = true.B
  val N = false.B

  // legal
  val LEGAL = true.B
  val ILLEGAL = false.B

  import Instructions._
  import FU._

  val default = List(FU_XXX, LEGAL, N, N)
  val map = Array(
    ADD   -> List(FU_ADD, LEGAL, N, N),
    SUB   -> List(FU_SUB, LEGAL, N, N),
    SLL   -> List(FU_SLL, LEGAL, N, N),
    SLT   -> List(FU_SLT, LEGAL, N, Y),
    SLTU  -> List(FU_SLTU, LEGAL, N, Y),
    XOR   -> List(FU_XOR, LEGAL, N, N),
    SRL   -> List(FU_SRL, LEGAL, N, N),
    SRA   -> List(FU_SRA, LEGAL, N, N),
    OR    -> List(FU_OR , LEGAL, N, N),
    AND   -> List(FU_AND, LEGAL, N, N),
    CMOV  -> List(FU_XXX, LEGAL, Y, N),
    SGT   -> List(FU_SGT, LEGAL, N, Y),
    SGTU  -> List(FU_SGTU, LEGAL, N, Y),
    EQ    -> List(FU_EQ, LEGAL, N, Y),
    NEQ   -> List(FU_NEQ, LEGAL, N, Y),
    SLE   -> List(FU_SLE, LEGAL, N, Y),
    SLEU  -> List(FU_SLEU, LEGAL, N, Y),
    SGE   -> List(FU_SGE, LEGAL, N, Y),
    SGEU  -> List(FU_SGEU, LEGAL, N, Y),
    MULT  -> List(FU_MULT, LEGAL, N, N),
    DIV   -> List(FU_DIV, LEGAL, N, N),
    NEG   -> List(FU_NEG, LEGAL, N, Y)
	)
}


class SEControlInput extends Bundle{
  val inst = Input(UInt(8.W))
}

class SEControlOutput extends Bundle{
  val inst      = Output(UInt(8.W))
  val fu_op    = Output(UInt(5.W))
  val legal     = Output(Bool())
  val cmov  = Output(Bool())
  val isCmp = Output(Bool()) // if it is cmp, then result is only a byte
}


class SEControl extends SimpleChiselModule {
  val in = IO(new SEControlInput)
  val out = IO(new SEControlOutput)
  val ctrl = IO(new DecoupledIOCtrl(0,0))
  val ctrlSignals = ListLookup(in.inst, SEControl.default, SEControl.map)

  ctrl.in.ready := ctrl.out.ready
  ctrl.out.valid := ctrl.in.valid
  
  out.inst := in.inst
  out.fu_op := ctrlSignals(0)
  out.legal := ctrlSignals(1)
  out.cmov := ctrlSignals(2)
  out.isCmp := ctrlSignals(3)
}