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

	val op1_input = Input(UInt(128.W))
	val op1_is_a_byte = Input(Bool())

	val op2_input  = Input(UInt(128.W))
	val op2_is_a_byte = Input(Bool())

	val cond_input  = Input(UInt(128.W))

	val raw_result = Output(UInt(64.W))
	val raw_result_is_a_byte = Output(Bool())
}

class SEOperation extends Module{
  val io = IO(new SEOpIO)
	
	val decode = Module(new SEControl)
	val fu = Module(new FU)

	val op1 = io.op1_input(127,64)
	val op2 = io.op2_input(127,64)
	val cond = io.cond_input(127,64)

	decode.io.inst_in := io.inst

 
  fu.io.A := op1
  fu.io.B := op2
  fu.io.fu_op := decode.io.fu_op
	fu.io.fu_type := Mux(decode.io.fu_op === FU_COND, Mux(cond >= 0.U, COND_A, COND_B), decode.io.fu_op)

	io.raw_result_is_a_byte := decode.io.fu_op === FU_COMP || (io.op1_is_a_byte && io.op2_is_a_byte)
	io.raw_result := Mux(io.raw_result_is_a_byte, fu.io.out<<56,fu.io.out)
}