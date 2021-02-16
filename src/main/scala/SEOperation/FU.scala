package se.seoperation

import chisel3._
import chisel3.util._
import chisel3.simplechisel._
import chisel3.simplechisel.util._

object FU {
  val FU_ADD    = 0.U(5.W)
  val FU_SUB    = 1.U(5.W)
  val FU_AND    = 2.U(5.W)
  val FU_OR     = 3.U(5.W)
  val FU_XOR    = 4.U(5.W)
  val FU_SLT    = 5.U(5.W)
  val FU_SLL    = 6.U(5.W)
  val FU_SLTU   = 7.U(5.W)
  val FU_SRL    = 8.U(5.W)
  val FU_SRA    = 9.U(5.W)
  val FU_COPY_A = 10.U(5.W)
  val FU_COPY_B = 11.U(5.W)
  val FU_MULT   = 15.U(5.W)
  val FU_DIV    = 16.U(5.W)
  val FU_SGT    = 17.U(5.W)
  val FU_SGTU   = 18.U(5.W)
  val FU_SLE    = 19.U(5.W)
  val FU_EQ     = 20.U(5.W)
  val FU_SLEU   = 21.U(5.W)
  val FU_NEQ    = 22.U(5.W)
  val FU_SGE    = 23.U(5.W)
  val FU_SGEU   = 24.U(5.W)
  val FU_NEG    = 26.U(5.W)
  val FU_XXX    = 26.U(5.W)
}

import FU._

class  AlUInput extends Bundle{
    val A = UInt(64.W)
    val B = UInt(64.W)
    val fu_op = UInt(5.W)
}

class AlUOutput extends Bundle{
    val out = UInt(64.W)
}

class FU extends SimpleChiselModule{
  val in = IO(Input(new AlUInput))
  val out = IO(Output(new AlUOutput))
  val ctrl = IO(new DecoupledIOCtrl(1,0))

  ctrl.out.ready >>> ctrl.in.ready
  ctrl.in.valid  >>> ctrl.out.valid

  val sum = in.A + Mux(in.fu_op(0), -in.B, in.B)
  val cmplt = Mux(in.A(63) === in.B(63), sum(63),
            Mux(in.fu_op(1), in.B(63), in.A(63)))
  val shamt  = in.B(4,0).asUInt
  val shin   = Mux(in.fu_op(3), in.A, Reverse(in.A))
  val shiftr = (Cat(in.fu_op(0) && shin(63), shin).asSInt >> shamt)(63, 0)
  val shiftl = Reverse(shiftr)
  val output = Wire(UInt(64.W))
  when(in.fu_op === FU_ADD || in.fu_op === FU_SUB){
    output := sum
  }.elsewhen(in.fu_op === FU_SLT || in.fu_op === FU_SLTU){
    output := cmplt
  }.elsewhen(in.fu_op === FU_SRA || in.fu_op === FU_SRL){
    output := shiftr
  }.elsewhen(in.fu_op === FU_SLL){
    output := shiftl
  }.elsewhen(in.fu_op === FU_AND){
    output := in.A & in.B
  }.elsewhen(in.fu_op === FU_OR){
    output := in.A | in.B
  }.elsewhen(in.fu_op === FU_XOR){
    output := in.A ^ in.B
  }.elsewhen(in.fu_op === FU_COPY_A){
    output := in.A
  }.elsewhen(in.fu_op === FU_COPY_B){
    output := in.B
  }.elsewhen(in.fu_op === FU_MULT){
    output := in.A * in.B
  }.elsewhen(in.fu_op === FU_DIV){
    output := in.A/in.B
  }.elsewhen(in.fu_op === FU_EQ){
    output := in.A === in.B
  }.elsewhen(in.fu_op === FU_NEQ){
    output := in.A =/= in.B
  }.elsewhen(in.fu_op === FU_SGT){
    output := Mux(in.A(63) === in.B(63), ~((in.A - in.B)(63)) &&(sum=/=0.U), ~in.A(63))
  }.elsewhen(in.fu_op === FU_SGTU){
    output := in.A > in.B
  }.elsewhen(in.fu_op === FU_SLEU){
    output := in.A <= in.B
  }.elsewhen(in.fu_op === FU_SLE){
    output := Mux(in.A(63) === in.B(63), (in.A - in.B)(63), in.A(63))|| ( in.A === in.B)
  }.elsewhen(in.fu_op === FU_SGEU){
    output := in.A >= in.B
  }.elsewhen(in.fu_op === FU_SGE){
    output := Mux(in.A(63) === in.B(63), ~((in.A - in.B)(63)), ~in.A(63))
  }.elsewhen(in.fu_op === FU_NEG){
    output := Mux(in.A === 0.U, 1.U, 0.U)
  }otherwise{
    output := 0.U
  }

  SimpleChiselBundle(output) >>> out
}
