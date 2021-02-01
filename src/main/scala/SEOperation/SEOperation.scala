package se.seoperation

import chisel3._
import chisel3.simplechisel._
import chisel3.util._
import chisel3.simplechisel.util._
import ALU._

class SEOpInput extends Bundle{
	val inst = UInt(8.W)

	val op1_input = UInt(128.W)

	val op2_input  = UInt(128.W)

	val cond_input  = UInt(128.W)
}

class SEOpOutput extends Bundle{
	val raw_result = UInt(64.W)
}

class SEOperation extends SimpleChiselModule{
  val in = IO(Input(new SEOpInput))
  val out = IO(Output(new SEOpOutput))
  val ctrl = IO(new DecoupledIOCtrl(1,1))
	
	val decode = Module(new SEControl)
	val alu = Module(new ALU)
	val op1 = in.op1_input(127,64)
	val op2 = in.op2_input(127,64)
	val cond = in.cond_input(127,64)

	SimpleChiselBundle(in.inst) >>> decode


	decode.ctrl.out.ready := alu.ctrl.in.ready

	alu.ctrl.in.valid := decode.ctrl.out.valid && decode.out.legal
	alu.ctrl.out.ready := ctrl.in.valid

 
  alu.in.A := op1
  alu.in.B := op2
  alu.in.alu_op := Mux(decode.out.cmov, Mux(cond >= 0.U, ALU_COPY_A, ALU_COPY_B), decode.out.alu_op)

	SimpleChiselBundle(alu.out.out) >>> out
}