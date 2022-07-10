package se

import chisel3._
import chisel3.util._
import aes._
import se.seoperation._
import chisel3.util.random._
import se.Params._
import aes.Params
class SEInput extends Bundle{
	val inst = Input(UInt(8.W)) // Instruction encoding is defined in SEOperation/Instructions.scala

	val op1 = Input(UInt(128.W))

	val op2 = Input(UInt(128.W))

	// The condition for CMOV. Should always be encrypted. Can be anything if not used
	val cond = Input(UInt(128.W))
}

class SEOutput extends Bundle{
	val out = Output(UInt(128.W))
}

class SEIO extends Bundle{
	val in_idx = Input(UInt(log2Ceil(NumFPGAEntries).W))
	val out_idx = Output(UInt(log2Ceil(NumFPGAEntries).W))
	val request = Flipped(DecoupledIO(new SEInput))
	val result = DecoupledIO(new SEOutput)
}

class SE(implicit debug:Boolean) extends Module{
	// Define the input, output ports and the control bits
	val io = IO(new SEIO)
	val rolled = true

	/*
	seoperation: the module to actually compute on decrypted plaintexts
	key: preset expanded AES ROM key
	*/
	val seoperation = Module(new SEOperation)
	val aes_invcipher = Module(new AESDecrypt(rolled))
	val aes_cipher = Module(new AESEncrypt(rolled))
	val key = Reg(Vec(11, Vec(16,UInt(8.W))))

	val expandedKey128 =VecInit(
    VecInit(0x00.U(8.W), 0x01.U(8.W), 0x02.U(8.W), 0x03.U(8.W), 0x04.U(8.W), 0x05.U(8.W), 0x06.U(8.W), 0x07.U(8.W), 0x08.U(8.W), 0x09.U(8.W), 0x0a.U(8.W), 0x0b.U(8.W), 0x0c.U(8.W), 0x0d.U(8.W), 0x0e.U(8.W), 0x0f.U(8.W)),
    VecInit(0xd6.U(8.W), 0xaa.U(8.W), 0x74.U(8.W), 0xfd.U(8.W), 0xd2.U(8.W), 0xaf.U(8.W), 0x72.U(8.W), 0xfa.U(8.W), 0xda.U(8.W), 0xa6.U(8.W), 0x78.U(8.W), 0xf1.U(8.W), 0xd6.U(8.W), 0xab.U(8.W), 0x76.U(8.W), 0xfe.U(8.W)),
    VecInit(0xb6.U(8.W), 0x92.U(8.W), 0xcf.U(8.W), 0x0b.U(8.W), 0x64.U(8.W), 0x3d.U(8.W), 0xbd.U(8.W), 0xf1.U(8.W), 0xbe.U(8.W), 0x9b.U(8.W), 0xc5.U(8.W), 0x00.U(8.W), 0x68.U(8.W), 0x30.U(8.W), 0xb3.U(8.W), 0xfe.U(8.W)),
    VecInit(0xb6.U(8.W), 0xff.U(8.W), 0x74.U(8.W), 0x4e.U(8.W), 0xd2.U(8.W), 0xc2.U(8.W), 0xc9.U(8.W), 0xbf.U(8.W), 0x6c.U(8.W), 0x59.U(8.W), 0x0c.U(8.W), 0xbf.U(8.W), 0x04.U(8.W), 0x69.U(8.W), 0xbf.U(8.W), 0x41.U(8.W)),
    VecInit(0x47.U(8.W), 0xf7.U(8.W), 0xf7.U(8.W), 0xbc.U(8.W), 0x95.U(8.W), 0x35.U(8.W), 0x3e.U(8.W), 0x03.U(8.W), 0xf9.U(8.W), 0x6c.U(8.W), 0x32.U(8.W), 0xbc.U(8.W), 0xfd.U(8.W), 0x05.U(8.W), 0x8d.U(8.W), 0xfd.U(8.W)),
    VecInit(0x3c.U(8.W), 0xaa.U(8.W), 0xa3.U(8.W), 0xe8.U(8.W), 0xa9.U(8.W), 0x9f.U(8.W), 0x9d.U(8.W), 0xeb.U(8.W), 0x50.U(8.W), 0xf3.U(8.W), 0xaf.U(8.W), 0x57.U(8.W), 0xad.U(8.W), 0xf6.U(8.W), 0x22.U(8.W), 0xaa.U(8.W)),
    VecInit(0x5e.U(8.W), 0x39.U(8.W), 0x0f.U(8.W), 0x7d.U(8.W), 0xf7.U(8.W), 0xa6.U(8.W), 0x92.U(8.W), 0x96.U(8.W), 0xa7.U(8.W), 0x55.U(8.W), 0x3d.U(8.W), 0xc1.U(8.W), 0x0a.U(8.W), 0xa3.U(8.W), 0x1f.U(8.W), 0x6b.U(8.W)),
    VecInit(0x14.U(8.W), 0xf9.U(8.W), 0x70.U(8.W), 0x1a.U(8.W), 0xe3.U(8.W), 0x5f.U(8.W), 0xe2.U(8.W), 0x8c.U(8.W), 0x44.U(8.W), 0x0a.U(8.W), 0xdf.U(8.W), 0x4d.U(8.W), 0x4e.U(8.W), 0xa9.U(8.W), 0xc0.U(8.W), 0x26.U(8.W)),
    VecInit(0x47.U(8.W), 0x43.U(8.W), 0x87.U(8.W), 0x35.U(8.W), 0xa4.U(8.W), 0x1c.U(8.W), 0x65.U(8.W), 0xb9.U(8.W), 0xe0.U(8.W), 0x16.U(8.W), 0xba.U(8.W), 0xf4.U(8.W), 0xae.U(8.W), 0xbf.U(8.W), 0x7a.U(8.W), 0xd2.U(8.W)),
    VecInit(0x54.U(8.W), 0x99.U(8.W), 0x32.U(8.W), 0xd1.U(8.W), 0xf0.U(8.W), 0x85.U(8.W), 0x57.U(8.W), 0x68.U(8.W), 0x10.U(8.W), 0x93.U(8.W), 0xed.U(8.W), 0x9c.U(8.W), 0xbe.U(8.W), 0x2c.U(8.W), 0x97.U(8.W), 0x4e.U(8.W)),
    VecInit(0x13.U(8.W), 0x11.U(8.W), 0x1d.U(8.W), 0x7f.U(8.W), 0xe3.U(8.W), 0x94.U(8.W), 0x4a.U(8.W), 0x17.U(8.W), 0xf3.U(8.W), 0x07.U(8.W), 0xa7.U(8.W), 0x8b.U(8.W), 0x4d.U(8.W), 0x2b.U(8.W), 0x30.U(8.W), 0xc5.U(8.W)))
		when(reset.asBool){
			key := expandedKey128
		}

	// Once we receive the data, first latch them into buffers. 
	val inst_buffer = RegEnable(io.request.bits.inst, io.request.valid)

	val op1_buffer = RegEnable(io.request.bits.op1, io.request.valid)

	val op2_buffer = RegEnable( io.request.bits.op2, io.request.valid)

	val cond_buffer = RegEnable( io.request.bits.cond, io.request.valid)

	val valid_buffer = Reg(Bool())

	val ready_for_input = RegInit(true.B)

	val in_idx_reg = RegInit(0.U(8.W))
	
	io.request.ready := ready_for_input
	io.out_idx := in_idx_reg
	valid_buffer := Mux(io.request.valid && io.request.ready, true.B, 
		Mux(valid_buffer, !aes_invcipher.io.input_valid, valid_buffer))
	when(io.request.valid && io.request.ready){
		ready_for_input := false.B
		in_idx_reg := io.in_idx
	}.elsewhen(io.result.valid && io.result.ready){
		ready_for_input := true.B
	}

	if(debug){
		when(reset.asBool){
			printf("resetting\n")
		}
		when(io.request.valid && io.request.ready){
			printf("changed to false\n")
		}.elsewhen(io.result.valid && io.result.ready){
			printf("changed to true\n")
		}
	}
	if(debug){
		when(valid_buffer){
			printf("\n-----front----\n")
			printf("op1 buffer:%x\n",op1_buffer)
			printf("op2 buffer:%x\n",op2_buffer)
			printf("cond:%x\n",cond_buffer)
			printf("inst:%b\n",inst_buffer)
		}
	}



	// Feed the ciphertexts into the invcipher
	aes_invcipher.io.input_op1 := op1_buffer.asTypeOf(aes_invcipher.io.input_op1)
	aes_invcipher.io.input_op2 := op2_buffer.asTypeOf(aes_invcipher.io.input_op2)
	aes_invcipher.io.input_cond := cond_buffer.asTypeOf(aes_invcipher.io.input_cond)
	aes_invcipher.io.input_roundKeys := key
	aes_invcipher.io.input_valid := valid_buffer
	when(aes_invcipher.io.input_valid){
		printf("op1_buffer: %x\n",op1_buffer)
		printf("op2_buffer: %x\n",op2_buffer)
	}

	// Reverse the byte order so we can convert them into uint with Chisel infrastructure.
	val op1_reverse = Wire(Vec(aes.Params.StateLength, UInt(8.W)))
	val op2_reverse = Wire(Vec(aes.Params.StateLength, UInt(8.W)))
	val cond_reverse = Wire(Vec(aes.Params.StateLength, UInt(8.W)))
	for(i <- 0 until aes.Params.StateLength){
		op1_reverse(i) := aes_invcipher.io.output_op1(aes.Params.StateLength-i-1)
		op2_reverse(i) := aes_invcipher.io.output_op2(aes.Params.StateLength-i-1)
		cond_reverse(i) := aes_invcipher.io.output_cond(aes.Params.StateLength-i-1)
	}

	val seop_input_valid = RegNext(aes_invcipher.io.output_valid)
	val op1_reverse_reg = RegNext(op1_reverse)
	val op2_reverse_reg = RegNext(op2_reverse)
	val cond_reverse_reg = RegNext(cond_reverse)
	val inst_reg = RegNext(inst_buffer)

	// Feed the decrypted values to the seoperation module. Depends on whether the data is encrypted when it comes in.


	val op1_asSInt = op1_reverse_reg.do_asUInt.asSInt
	val op2_asSInt = op2_reverse_reg.do_asUInt.asSInt
	val cond_asSInt = cond_reverse_reg.do_asUInt.asSInt
	// printf("op1_found: %d\n",op1_found)
	// printf("op2_found: %d\n",op2_found)
	// printf("cond_found: %d\n",cond_found)
	// printf("seOpValid: %d\n",seOpValid)
	// printf("all_match: %d\n",all_match)
	// printf("aes_invcipher.io.output_valid: %d\n",aes_invcipher.io.output_valid)
	// printf("aes_invcipher.io.input_valid: %d\n",aes_invcipher.io.input_valid)

	// when(seOpValid ){
	// 	printf("\n-----mid----\n")
	// 	printf("op1_asUInt:%x\n",seoperation.io.op1_input)
	// 	printf("op2_asUInt:%x\n",seoperation.io.op2_input)
	// 	printf("cond_asUInt:%x\n",seoperation.io.cond_input)
	// 	printf("op1_asUInt:%x\n",Mux(mid_inst_buffer(7,5) === 5.U(3.W), mid_op1_buffer(127,64),op1_asUInt(127,64)))
	// 	printf("op2_asUInt:%x\n",op2_asUInt(127,64))
	// 	printf("cond_asUInt:%x\n",cond_asUInt(127,64))
	// 	printf("inst:%b\n",mid_inst_buffer)
	// }
	seoperation.io.inst := inst_reg
	seoperation.io.valid := seop_input_valid
	seoperation.io.op1_input := op1_asSInt(127,64).asSInt
	seoperation.io.op2_input := op2_asSInt(127,64).asSInt
	seoperation.io.cond_input := cond_asSInt(127,64).asSInt

  // Once we receive the result form the seoperation, we latech the result first.
	val result_valid_buffer = RegNext(seop_input_valid)

	// Pad with RNG
	val bit64_randnum = PRNG(new MaxPeriodFibonacciLFSR(64, Some(scala.math.BigInt(64, scala.util.Random))))
	val padded_result = Cat(seoperation.io.result, 0.U(64.W))
	val result_buffer = RegEnable( padded_result, seop_input_valid)
	if(debug){
		when(result_valid_buffer){
			printf("\n-----back----\n")
			printf("padded_result:%x\n",result_buffer )
			printf("seoperation.io.result:%x\n",seoperation.io.result)
			printf("se.result.counter:%d\n",io.out_idx)
		}
	}

	// Connect the cipher
	val aes_input = result_buffer.asTypeOf(aes_cipher.io.input_text)
	val aes_input_reverse = Wire(Vec(aes.Params.StateLength, UInt(8.W)))
	for(i <- 0 until aes.Params.StateLength){
		aes_input_reverse(i) := aes_input(aes.Params.StateLength-i-1)
	}
	aes_cipher.io.input_text := aes_input_reverse
	aes_cipher.io.input_valid := result_valid_buffer
	aes_cipher.io.input_roundKeys := key

	// Connect the output side
	val output_buffer = RegEnable(aes_cipher.io.output_text.do_asUInt, aes_cipher.io.output_valid)
	val output_valid = RegInit(false.B)

	when(aes_cipher.io.output_valid){
		output_valid := true.B
	}.elsewhen(io.result.valid && io.result.ready){
		output_valid := false.B
	}
	io.result.valid := output_valid
	io.result.bits.out := output_buffer


	when(reset.asBool){
		key := expandedKey128
	}

	
}