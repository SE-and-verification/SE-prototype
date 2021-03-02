package se.seoperation

import chisel3._
import chisel3.simplechisel._
import chisel3.util._
import chisel3.simplechisel.util._
import FU._

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
  val ctrl = IO(new DecoupledIOCtrl(0,0))
	
	val decode = Module(new SEControl)
	val fu = Module(new FU)
	val op1 = in.op1_input(127,64)
	val op2 = in.op2_input(127,64)
	val cond = in.cond_input(127,64)

	SimpleChiselBundle(in.inst) >>> decode


	decode.ctrl.out.ready := fu.ctrl.in.ready
	fu.ctrl.in.valid := decode.ctrl.out.valid && decode.out.legal
	fu.ctrl.out.ready := ctrl.in.valid

 
  fu.in.A := op1
  fu.in.B := op2
  fu.in.fu_op := Mux(decode.out.cmov, Mux(cond >= 0.U, FU_COPY_A, FU_COPY_B), decode.out.fu_op)

	out.raw_result := fu.out.out
	ctrl.out.valid := fu.ctrl.out.valid
}