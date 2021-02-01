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
  import ALU._

  val default = List(ALU_XXX, ILLEGAL, N)
  val map = Array(
    ADD   -> List(ALU_ADD, ILLEGAL, N),
    SUB   -> List(ALU_SUB, ILLEGAL, N),
    SLL   -> List(ALU_SLL, ILLEGAL, N),
    SLT   -> List(ALU_SLT, ILLEGAL, N),
    SLTU  -> List(ALU_SLTU, ILLEGAL, N),
    XOR   -> List(ALU_XOR, ILLEGAL, N),
    SRL   -> List(ALU_SRL, ILLEGAL, N),
    SRA   -> List(ALU_SRA, ILLEGAL, N),
    OR    -> List(ALU_OR , ILLEGAL, N),
    AND   -> List(ALU_AND, ILLEGAL, N),
    CMOV  -> List(ALU_XXX, ILLEGAL, Y)
	)
}


class SEControlInput extends Bundle{
  val inst = Input(UInt(8.W))
}

class SEControlOutput extends Bundle{
  val inst      = Output(UInt(8.W))
  val alu_op    = Output(UInt(4.W))
  val legal     = Output(Bool())
  val cmov  = Output(Bool())
}


class SEControl extends SimpleChiselModule {
  val in = IO(new SEControlInput)
  val out = IO(new SEControlOutput)
  val ctrl = IO(new DecoupledIOCtrl(0,0))
  val ctrlSignals = ListLookup(in.inst, SEControl.default, SEControl.map)

  ctrl.in.ready := ctrl.out.ready
  ctrl.out.valid := ctrl.in.valid
  
  out.inst := in.inst
  out.alu_op := ctrlSignals(0)
  out.legal := ctrlSignals(1)
  out.cmov := ctrlSignals(2)
}