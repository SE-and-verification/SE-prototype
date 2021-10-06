package se.seoperation

import chisel3._
import chisel3.util._

object FU {
  // Shifts
  val FU_SHIFT  = 0.U(3.W)

  val FU_ARITH = 1.U(3.W)

  val FU_LOGICAL = 2.U(3.W)

  val FU_COMP = 3.U(3.W)

  val FU_COND = 4.U(3.W)

  val FU_XXX = 5.U(3.W)
}

object COMP {
  // comp type 
  val COMP_LT  = 0.U(3.W)
  val COMP_GT  = 1.U(3.W)
  val COMP_EQ  = 2.U(3.W)
  val COMP_NEQ = 3.U(3.W)
  val COMP_LE  = 4.U(3.W)
  val COMP_GE  = 5.U(3.W)
  val COMP_XXX = 6.U(3.W)
}

object ARITH {
  val ARITH_ADD = 0.U(3.W)
  val ARITH_SUB = 1.U(3.W)
  val ARITH_MULT = 2.U(3.W)
  val ARITH_DIV = 3.U(3.W)
  val ARITH_XXX = 4.U(3.W)
}

object SHIFT{
  val SHIFT_SLL = 0.U(3.W)
  val SHIFT_SLA = 1.U(3.W)
  val SHIFT_SRL = 2.U(3.W)
  val SHIFT_SRA = 3.U(3.W)
  val SHIFT_XXX = 4.U(3.W)
}

object LOGICAL{
  val LOGICAL_XOR = 0.U(3.W)
  val LOGICAL_OR = 1.U(3.W)
  val LOGICAL_AND = 2.U(3.W)
  val LOGICAL_NEG = 3.U(3.W)
  val LOGICAL_XXX = 4.U(3.W)
}

object COND{
  val COND_A = 0.U(3.W)
  val COND_B = 1.U(3.W)
  val COND_XXX = 2.U(3.W)
}

import FU._
import COMP._
import ARITH._
import SHIFT._
import LOGICAL._
import COND._

class  AlUInput extends Bundle{
    val A = Input(UInt(64.W))
    val B = Input(UInt(64.W))
    val cond = Input(UInt(8.W))
    val fu_op = Input(UInt(3.W))
    val fu_type = Input(UInt(3.W))
    val signed = Input(Bool())
    val out = UInt(64.W)
}

class FU extends Module{
  val io = IO(new AlUInput)
  val output = Wire(UInt(64.W))

  when(io.fu_op === FU_SHIFT){
    when(io.fu_type === SHIFT_SLL){
      output := (Cat(0.U(1.W),io.A) << io.B)(63,0)
    }.elsewhen(io.fu_type === SHIFT_SLA){
      output := io.A << io.B
    }.elsewhen(io.fu_type === SHIFT_SRL){
      output := (Cat(0.U(1.W),io.A) >> io.B)(63,0)
    }.otherwise{
      output := io.A >> io.B
    }
  }.elsewhen(io.fu_op === FU_ARITH){
    when(io.signed){
      when(io.fu_type === ARITH_ADD){
        output := (io.A.asSInt + io.B.asSInt).asUInt
      }.elsewhen(io.fu_type === ARITH_SUB){
        output := (io.A.asSInt - io.B.asSInt).asUInt
      }.elsewhen(io.fu_type === ARITH_MULT){
        output := (io.A.asSInt * io.B.asSInt).asUInt
      }.otherwise{
        output := (io.A.asSInt / io.B.asSInt).asUInt
      }
    }.otherwise{
      when(io.fu_type === ARITH_ADD){
        output := io.A + io.B
      }.elsewhen(io.fu_type === ARITH_SUB){
        output := io.A - io.B
      }.elsewhen(io.fu_type === ARITH_MULT){
        output := io.A * io.B
      }.otherwise{
        output := io.A / io.B
      }
    }
  }.elsewhen(io.fu_op === FU_LOGICAL){
      when(io.fu_type === LOGICAL_XOR){
        output := io.A ^ io.B
      }.elsewhen(io.fu_type === LOGICAL_OR){
        output := io.A | io.B
      }.elsewhen(io.fu_type === LOGICAL_AND){
        output := io.A & io.B
      }.otherwise{
        output := ~io.A
      }
  }.elsewhen(io.fu_op === FU_COMP){
    when(io.signed){
      when(io.fu_type === COMP_LT){
        output := Mux(io.A(63), 1.U, io.A < io.B)
      }.elsewhen(io.fu_type === io.fu_type === COMP_GT){
        output := Mux(io.A(63), 0.U, io.A > io.B)
      }.elsewhen(io.fu_type === io.fu_type === COMP_EQ){
        output := Mux(io.A(63), 0.U, io.A === io.B)
      }.elsewhen(io.fu_type === io.fu_type === COMP_NEQ){
        output := Mux(io.A(63), 1.U, io.A =/= io.B)
      }.elsewhen(io.fu_type === io.fu_type === COMP_LE){
        output := Mux(io.A(63), 1.U, io.A <= io.B)
      }.otherwise{
        output := Mux(io.A(63), 0.U, io.A >= io.B)
      }
    }.otherwise{
      when(io.fu_type === COMP_LT){
        output := io.A < io.B
      }.elsewhen(io.fu_type === io.fu_type === COMP_GT){
        output := io.A > io.B
      }.elsewhen(io.fu_type === io.fu_type === COMP_EQ){
        output := io.A === io.B
      }.elsewhen(io.fu_type === io.fu_type === COMP_NEQ){
        output := io.A =/= io.B
      }.elsewhen(io.fu_type === io.fu_type === COMP_LE){
        output :=  io.A <= io.B
      }.otherwise{
        output := io.A >= io.B
      }
    }
  }.elsewhen(io.fu_type === FU_COND){
    when(io.fu_type === COND_A){
      output := io.A
    }.otherwise{
      output := io.B
    }
  }.otherwise{
      output := 0.U
  }

  io.out := output
}
