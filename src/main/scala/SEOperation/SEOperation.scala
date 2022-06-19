package se.seoperation

import chisel3._
import chisel3.util._
import FU._
import COMP._
import ARITH._
import SHIFT._
import LOGICAL._
import COND._

class SEOpIO  extends Bundle{
	val inst = Input(UInt(8.W))
	val valid = Input(Bool())

	val op1_input = Input(SInt(64.W))

	val op2_input  = Input(SInt(64.W))

	val cond_input  = Input(SInt(64.W))

	val result = Output(SInt(64.W))
}


class SEOperation(implicit debug: Boolean) extends Module{

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
	io.result := fu.io.out

	if(debug){
		when(io.valid){
			printf("\n------fu-----\n")
			printf("fu op1: %x\n",op1)
			printf("fu op2: %x\n",op2)
			printf("fu cond: %x\n",cond)
			printf("fu result: %x\n",io.result)
			printf("fu fu_op: %d\n",decode.io.fu_op)
			printf("fu fu_type: %d\n",decode.io.fu_type)
		}
	}
}