package se.seoperation

import chisel3._
import chisel3.util._
import FU._
import COMP._
import ARITH._
import SHIFT._
import LOGICAL._
import COND._

class SEOpIO extends Bundle{
	val inst = Input(UInt(8.W))

	val op1_input = Input(UInt(64.W))

	val op2_input  = Input(UInt(64.W))

	val cond_input  = Input(UInt(64.W))

	val result = Output(UInt(64.W))
}

class SEOperation extends Module{
  val io = IO(new SEOpIO)
	
	val decode = Module(new SEControl)
	val fu = Module(new FU)

	val op1 = io.op1_input
	val op2 = io.op2_input
	val cond = io.cond_input

	decode.io.inst_in := io.inst

 
  fu.io.A := op1
  fu.io.B := op2
	fu.io.cond := cond
  fu.io.fu_op := decode.io.fu_op
	fu.io.fu_type := decode.io.fu_type
	fu.io.signed := decode.io.signed

	io.result := fu.io.out
}