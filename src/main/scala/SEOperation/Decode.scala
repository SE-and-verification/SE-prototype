package se.seoperation

import chisel3._
import chisel3.simplechisel._
import chisel3.util._
import chisel3.simplechisel.util._


object SEControl {
  val Y = true.B
  val N = false.B


  // A_sel
  val A_XXX  = 0.U(1.W)
  val A_PC   = 0.U(1.W)
  val A_RS1  = 1.U(1.W)

  // B_sel
  val B_XXX  = 0.U(1.W)
  val B_IMM  = 0.U(1.W)
  val B_RS2  = 1.U(1.W)

  // imm_sel
  val IMM_X  = 0.U(3.W)
  val IMM_I  = 1.U(3.W)
  val IMM_S  = 2.U(3.W)
  val IMM_U  = 3.U(3.W)
  val IMM_J  = 4.U(3.W)
  val IMM_B  = 5.U(3.W)
  val IMM_Z  = 6.U(3.W)

  // legal
  val LEGAL = true.B
  val ILLEAGAL = false.B

  import Instructions._
  import ALU._

  val default = List(A_XXX,  B_XXX, IMM_X, ALU_XXX, ILLEAGAL)
  val map = Array(
    ADDI  -> List(A_RS1,  B_IMM, IMM_I, ALU_ADD, ILLEGAL),
    SLTI  -> List(A_RS1,  B_IMM, IMM_I, ALU_SLT, ILLEGAL),
    SLTIU -> List(A_RS1,  B_IMM, IMM_I, ALU_SLTU, ILLEGAL),
    XORI  -> List(A_RS1,  B_IMM, IMM_I, ALU_XOR, ILLEGAL),
    ORI   -> List(A_RS1,  B_IMM, IMM_I, ALU_OR , ILLEGAL),
    ANDI  -> List(A_RS1,  B_IMM, IMM_I, ALU_AND, ILLEGAL),
    SLLI  -> List(A_RS1,  B_IMM, IMM_I, ALU_SLL, ILLEGAL),
    SRLI  -> List(A_RS1,  B_IMM, IMM_I, ALU_SRL, ILLEGAL),
    SRAI  -> List(A_RS1,  B_IMM, IMM_I, ALU_SRA, ILLEGAL),
    ADD   -> List(A_RS1,  B_RS2, IMM_X, ALU_ADD, ILLEGAL),
    SUB   -> List(A_RS1,  B_RS2, IMM_X, ALU_SUB, ILLEGAL),
    SLL   -> List(A_RS1,  B_RS2, IMM_X, ALU_SLL, ILLEGAL),
    SLT   -> List(A_RS1,  B_RS2, IMM_X, ALU_SLT, ILLEGAL),
    SLTU  -> List(A_RS1,  B_RS2, IMM_X, ALU_SLTU, ILLEGAL),
    XOR   -> List(A_RS1,  B_RS2, IMM_X, ALU_XOR, ILLEGAL),
    SRL   -> List(A_RS1,  B_RS2, IMM_X, ALU_SRL, ILLEGAL),
    SRA   -> List(A_RS1,  B_RS2, IMM_X, ALU_SRA, ILLEGAL),
    OR    -> List(A_RS1,  B_RS2, IMM_X, ALU_OR , ILLEGAL),
    AND   -> List(A_RS1,  B_RS2, IMM_X, ALU_AND, ILLEGAL)
	)
}


class SEControlInput extends Bundle{
  val inst = Input(UInt(8.W))
}

class SEControlOutput extends Bundle{
  val inst      = Output(UInt(8.W))
  val A_sel     = Output(UInt(1.W))
  val B_sel     = Output(UInt(1.W))
  val imm_sel   = Output(UInt(3.W))
  val alu_op    = Output(UInt(4.W))
  val legal     = Output(Bool())
}


class SEControl extends SimpleChiselModule {
  val in = IO(new SEControlInput)
  val out = IO(new SEControlOutput)
  val ctrl = DecoupledIOCtrl(0,0)
  val ctrlSignals = ListLookup(in.inst, Control.default, Control.map)

  ctrl.in.ready := ctrl.out.ready
  ctrl.out.valid := ctrl.in.valid
  
  out.inst := in.inst
  out.A_sel := ctrlSignals(0)
  out.B_sel := ctrlSignals(1)
  out.imm_sel := ctrlSignals(2)
  out.alu_op := ctrlSignals(3)
  out.legal := ctrlSignals(4)
}