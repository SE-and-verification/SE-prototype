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
    val A = Input(SInt(64.W))
    val B = Input(SInt(64.W))
    val cond = Input(SInt(64.W))
    val fu_op = Input(UInt(3.W))
    val fu_type = Input(UInt(3.W))
    val out = Output(SInt(64.W))
}

class FU(implicit debug: Boolean) extends Module{
  val io = IO(new FUIO)
  val output = Wire(SInt(64.W))

  when(io.fu_op === FU_SHIFT){
    when(io.fu_type === SHIFT_SLL){
      if(debug) printf("Inst: sll\n")
      output := io.A << io.B(5,0)
    }.otherwise{
      if(debug) printf("Inst: srl\n")
      output := io.A >> io.B(5,0)
    }
  }.elsewhen(io.fu_op === FU_ARITH){
    when(io.fu_type === ARITH_ADD){
      if(debug) printf("Inst: add\n")
      output := io.A + io.B
    }.elsewhen(io.fu_type === ARITH_SUB){
      if(debug) printf("Inst: sub\n")
      output := io.A - io.B
    }.elsewhen(io.fu_type === ARITH_MULT){
      if(debug) printf("Inst: mult\n")
      output := io.A * io.B
    }.otherwise{
      if(debug) printf("Inst: neg\n")
      output :=  - io.A.asSInt
    }
  }.elsewhen(io.fu_op === FU_LOGICAL){
      when(io.fu_type === LOGICAL_XOR){
        if(debug) printf("Inst: xor\n")
        output := io.A ^ io.B
      }.elsewhen(io.fu_type === LOGICAL_OR){
        if(debug) printf("Inst: or\n")
        output := io.A | io.B
      }.elsewhen(io.fu_type === LOGICAL_NOT){
        if(debug) printf("Inst: not\n")
        output := Mux(io.A === 0.S, 1.S, 0.S)
      }.otherwise{
        if(debug) printf("Inst: and\n")
        output := io.A & io.B
      }
  }.elsewhen(io.fu_op === FU_COMP){
    when(io.fu_type === COMP_EQ){
      if(debug) printf("Inst: eq\n")
      output := (io.A === io.B).asSInt
    }.elsewhen(io.fu_type === COMP_LT){
      if(debug) printf("Inst: lt\n")
      output := (io.A < io.B).asSInt
    }.elsewhen(io.fu_type === COMP_LET){
      if(debug) printf("Inst: let\n")
      output := (io.A <= io.B).asSInt
    }.elsewhen(io.fu_type === COMP_GT){
      if(debug) printf("Inst: gt\n")
      output := (io.A > io.B).asSInt
    }.elsewhen(io.fu_type === COMP_GET){
      if(debug) printf("Inst: get\n")
      output := (io.A >= io.B).asSInt
    }.otherwise{
      if(debug) printf("Inst: neq\n")
      output := (io.A =/= io.B).asSInt
    }
  }.elsewhen(io.fu_type === FU_COND){
    when(io.cond =/= 0.S){
      if(debug) printf("Inst: cmova\n")
      output := io.A
    }.otherwise{
      if(debug) printf("Inst: cmovb\n")
      output := io.B
    }
  }.otherwise{
      if(debug) printf("Inst: enc\n")
      output := io.A
  }

  io.out := output
}
