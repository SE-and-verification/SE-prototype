package se.seoperation

import chisel3._
import chisel3.util._

object FU {
  // Shifts
  val FU_SHIFT  = 0.U(3.W)

  val FU_ARITH = 1.U(3.W)

  val FU_COMP = 2.U(3.W)
  
  val FU_COND = 3.U(3.W)

  val FU_LOGICAL = 4.U(3.W)

  val FU_ENC = 5.U(3.W)

  val FU_XXX = 6.U(3.W)
}

import FU._
import COMP._
import ARITH._
import SHIFT._
import LOGICAL._
import COND._
import CRYPTO._

class  FUIO extends Bundle{
    val A = Input(UInt(64.W))
    val B = Input(UInt(64.W))
    val fu_op = Input(UInt(3.W))
    val fu_type = Input(UInt(2.W))
    val signed = Input(Bool())
    val out = Output(UInt(64.W))
}

class FU(val debug: Boolean) extends Module{
  val io = IO(new FUIO)
  val output = Wire(UInt(64.W))

  when(io.fu_op === FU_SHIFT){
    when(io.fu_type === SHIFT_SLL){
      if(debug) printf("Inst: sll\n")
      output := io.A << io.B(5,0)
    }.elsewhen(io.fu_type === SHIFT_SRL){
      if(debug) printf("Inst: srl\n")
      output := io.A >> io.B(5,0)
    }.otherwise{
      if(debug) printf("Inst: sra\n")
      output := Cat(io.A(63),(io.A.asSInt >> io.B(5,0))(62,0)).asUInt
    }
  }.elsewhen(io.fu_op === FU_ARITH){
    when(io.signed){
        if(debug) printf("Inst: mults\n")
        output := (io.A.asSInt * io.B.asSInt).asUInt
    }.otherwise{
      when(io.fu_type === ARITH_ADD){
        if(debug) printf("Inst: add\n")
        output := io.A + io.B
      }.elsewhen(io.fu_type === ARITH_SUB){
        if(debug) printf("Inst: sub\n")
        output := io.A - io.B
      }.otherwise{
        if(debug) printf("Inst: mult\n")
        output := io.A * io.B
      }
    }
  }.elsewhen(io.fu_op === FU_LOGICAL){
      when(io.fu_type === LOGICAL_XOR){
        if(debug) printf("Inst: xor\n")
        output := io.A ^ io.B
      }.elsewhen(io.fu_type === LOGICAL_OR){
        if(debug) printf("Inst: or\n")
        output := io.A | io.B
      }.otherwise{
        if(debug) printf("Inst: and\n")
        output := io.A & io.B
      }
  }.elsewhen(io.fu_op === FU_COMP){
    when(io.signed){
      if(debug) printf("Inst: lts\n")
      output := io.A.asSInt < io.B.asSInt
    }.otherwise{
      if(debug) printf("Inst: lt\n")
      output := io.A < io.B
    }
  }.elsewhen(io.fu_type === FU_COND){
    when(io.A =/= 0.U){
      if(debug) printf("Inst: cmovb\n")
      output := io.B
    }.otherwise{
      if(debug) printf("Inst: cmov0\n")
      output := 0.U
    }
  }.otherwise{
      if(debug) printf("Inst: enc\n")
      output := io.A
  }

  io.out := output
}
