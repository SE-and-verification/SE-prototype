package se.seoperation

import chisel3._
import chisel3.simplechisel._
import chisel3.util._
import chisel3.simplechisel.util._


class SEOpInput extends Bundle{
	val inst = UInt(8.W)

	val op1 = UInt(64.W)

	val op2 = UInt(64.W)

	val cond_operator = UInt(8.W)
	val cond_ref = UInt(64.W)
}

class SEOpOutput extends Bundle{
	val raw_result
}

class SEOperation extends SimpleChiselModule{
  val in = IO(Input(new SEOpInput))
  val out = IO(Output(new SEOpOutput))
  val ctrl = IO(new DecoupledIOCtrl(1,1))
	
	val decode = Module(new Decode)
	val alu = Module(new ALU)
	
	SimpleChiselBundle(in.inst) >>> decode


	decode.ctrl.out.ready := alu.ctrl.in.ready

	alu.ctrl.in.valid := decode.ctrl.out.valid && decode.out.legal
	alu.ctrl.out.ready := ctrl.in.valid

 
  alu.in.A := in.op1
  alu.in.B := in.op2
  alu.in.alu_op := decode.out.alu_op

	SimpleChiselBundle(alu.out.out) >>> out
}