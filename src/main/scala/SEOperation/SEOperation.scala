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

	val op1_input = Input(UInt(64.W))
	val op1_input_hash = Input(UInt(64.W))
	val op1_input_version = Input(UInt(64.W))

	val op2_input  = Input(UInt(64.W))
	val op2_input_hash = Input(UInt(64.W))
	val op2_input_version = Input(UInt(64.W))

	val cond_input  = Input(UInt(64.W))
	val cond_input_hash = Input(UInt(64.W))
	val cond_input_version = Input(UInt(64.W))

	val result = Output(UInt(64.W))
	val result_hash = Output(Int(64.W))
	val result_version = Output(Int(64.W))
	val result_ready = Output(Bool())
}


class SEOperation(val debug: Boolean, val single_cycle_integrity: Boolean) extends Module{

	val io = IO(new SEOpIO)

	
	val decode = Module(new SEControl)
	val fu = Module(new FU(debug))

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

	if(single_cycle_integrity){
		val crc_dut = Module(new SingleCycleCRC)

		crc_dut.io.inst := io.inst
		crc_dut.io.op1_hash := io.op1_input_hash
		crc_dut.io.op2_hash := io.op2_input_hash
		crc_dut.io.cond_hash := io.cond_input_hash

		when(io.inst === Instructions.ENC){
			io.result := fu.io.out
			io.result_hash := io.op1_input
			io.result_version := 0.U
		}.elsewhen(io.inst === Instructions.CMOV){
			when( ((io.op1_input_version ^ io.op2_input_version) === 0.U || io.op1_input_version === 0.U || io.op1_input_version === 0.U) &&
						((io.op2_input_version ^ io.cond_input_version) === 0.U || io.op2_input_version === 0.U || io.cond_input_version === 0.U) &&
						((io.op1_input_version ^ io.cond_input_version) === 0.U || io.op1_input_version === 0.U || io.cond_input_version === 0.U)
						){
				io.result := fu.io.out
				io.result_version := Mux(io.cond, io.op1_input_version, io.op2_input_version)
				io.result_hash := crc_dut.io.output_hash
			}.otherwise{
				io.result := 0.U
				io.result_version := 0.U
				io.result_hash := 0.U
			}
		}.otherwise{
			when( ((io.op1_input_version ^ io.op2_input_version) === 0.U || io.op1_input_version === 0.U || io.op1_input_version === 0.U) ){
				io.result := fu.io.out
				io.result_version := io.op1_input_version & io.op2_input_version
				io.result_hash := crc_dut.io.output_hash
			}.otherwise{
				io.result := 0.U
				io.result_version := 0.U
				io.result_hash := 0.U
			}
		}

		io.result_ready := io.valid
	}else{
		val crc_dut = Module(new MultiCycleCRC)
		val result_tmp = Wire(UInt(64.W))
		val result_buf = RegEnable(result_tmp, io.valid)

		val result_version_tmp = Wire(UInt(64.W))
		val result_version_buf = RegEnable(result_version_tmp, io.valid)

		crc_du.io.valid := io.valid
		crc_dut.io.inst := io.inst
		crc_dut.io.op1_hash := Mux(io.inst === Instructions.ENC, io.op1_input, io.op1_input_hash)
		crc_dut.io.op2_hash := io.op2_input_hash
		crc_dut.io.cond_hash := io.cond_input_hash

		when(io.inst === Instructions.ENC){
			result_tmp := fu.io.out
			result_version_tmp := 0.U
		}.elsewhen(io.inst === Instructions.CMOV){
			when( ((io.op1_input_version ^ io.op2_input_version) === 0.U || io.op1_input_version === 0.U || io.op1_input_version === 0.U) &&
						((io.op2_input_version ^ io.cond_input_version) === 0.U || io.op2_input_version === 0.U || io.cond_input_version === 0.U) &&
						((io.op1_input_version ^ io.cond_input_version) === 0.U || io.op1_input_version === 0.U || io.cond_input_version === 0.U)
						){
				result_tmp := fu.io.out
				result_version_tmp := Mux(io.cond, io.op1_input_version, io.op2_input_version)
			}.otherwise{
				result_tmp := 0.U
				result_version_tmp := 0.U
			}
		}.otherwise{
			when( ((io.op1_input_version ^ io.op2_input_version) === 0.U || io.op1_input_version === 0.U || io.op1_input_version === 0.U) ){
				result_tmp := fu.io.out
				result_version_tmp := io.op1_input_version & io.op2_input_version
			}.otherwise{
				result_tmp := 0.U
				result_version_tmp := 0.U
			}
		}

		io.result_hash := crc_dut.io.output_hash
		io.result_version := result_version_buf
		io.result := result_buf
		io.result_ready := crc_dut.io.output_ready
	}

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