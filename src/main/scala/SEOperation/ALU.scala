package se.seoperation

import chisel3._
import chisel3.util._
import chisel3.simplechisel._
import chisel3.simplechisel.util._

object ALU {
  val ALU_ADD    = 0.U(4.W)
  val ALU_SUB    = 1.U(4.W)
  val ALU_AND    = 2.U(4.W)
  val ALU_OR     = 3.U(4.W)
  val ALU_XOR    = 4.U(4.W)
  val ALU_SLT    = 5.U(4.W)
  val ALU_SLL    = 6.U(4.W)
  val ALU_SLTU   = 7.U(4.W)
  val ALU_SRL    = 8.U(4.W)
  val ALU_SRA    = 9.U(4.W)
  val ALU_COPY_A = 10.U(4.W)
  val ALU_COPY_B = 11.U(4.W)
  val ALU_XXX    = 15.U(4.W)
}

import ALU._

class  AlUInput extends Bundle{
    val A = UInt(32.W)
    val B = UInt(32.W)
    val alu_op = UInt(4.W)
}

class AlUOutput extends Bundle{
    val out = UInt(32.W)
    val sum = UInt(32.W)
}

class ALU extends SimpleChiselModule{
  val in = IO(Input(new AlUInput))
  val out = IO(Output(new AlUOutput))
  val ctrl = IO(new DecoupledIOCtrl(1,0))

  ctrl.out.ready >>> ctrl.in.ready
  ctrl.in.valid  >>> ctrl.out.valid

  val sum = in.A + Mux(in.alu_op(0), -in.B, in.B)
  val cmp = Mux(in.A(32-1) === in.B(32-1), sum(32-1),
            Mux(in.alu_op(1), in.B(32-1), in.A(32-1)))
  val shamt  = in.B(4,0).asUInt
  val shin   = Mux(in.alu_op(3), in.A, Reverse(in.A))
  val shiftr = (Cat(in.alu_op(0) && shin(32-1), shin).asSInt >> shamt)(32-1, 0)
  val shiftl = Reverse(shiftr)

  val output = 
    Mux(in.alu_op === ALU_ADD || in.alu_op === ALU_SUB, sum,
    Mux(in.alu_op === ALU_SLT || in.alu_op === ALU_SLTU, cmp,
    Mux(in.alu_op === ALU_SRA || in.alu_op === ALU_SRL, shiftr,
    Mux(in.alu_op === ALU_SLL, shiftl,
    Mux(in.alu_op === ALU_AND, (in.A & in.B),
    Mux(in.alu_op === ALU_OR,  (in.A | in.B),
    Mux(in.alu_op === ALU_XOR, (in.A ^ in.B), 
    Mux(in.alu_op === ALU_COPY_A, in.A, in.B))))))))

  SimpleChiselBundle(output, sum) >>> out
}
