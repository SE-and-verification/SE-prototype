package se

import chisel3._
import chisel3.simplechisel._
import chisel3.util._
import chisel3.simplechisel.util._
import aes._
import se.seoperation._
import chisel3.util.random._

class SEInput extends Bundle{
	val inst = UInt(8.W) // Instruction encoding is defined in SEOperation/Instructions.scala

	val op1 = UInt(128.W)
	/* True if operand is encrypted, false if it is plaintext.
		 If plaintext, it is placed at the most significant parts.*/
	val op1_encrypted = Bool() 
	val op1_is_a_byte = Bool() // True is operand is a boolean or a char

	val op2 = UInt(128.W)
	val op2_encrypted = Bool()
	val op2_is_a_byte = Bool()	

	// The condition for CMOV. Should always be encrypted. Can be anything if not used
	val cond = UInt(128.W) 
}

class SEOutput extends Bundle{
	val result = UInt(128.W)
}

class SE extends SimpleChiselModuleBase{
	// Define the input, output ports and the control bits
	val ctrl = IO(new DecoupledIOCtrl(1,1))
	val in = IO(Input(new SEInput))
	val out = IO(Output(new SEOutput))

	// Instantiate the components
	/*
	seoperation: the module to actually compute on decrypted plaintexts
	key: preset expanded AES ROM key
	*/
	val seoperation = Module(new SEOperation)
	val aes_invcipher = Module(new AESDecrypt)
	val aes_cipher = Module(new AESEncrypt)
	val key = ExpandedKey.expandedKey128

	// Once we receive the data, first latch them into buffers. 
	val inst_buffer = RegEnable(in.inst, ctrl.in.valid)

	val op1_buffer = RegEnable(in.op1, ctrl.in.valid)
	val op1_encrypted_buffer = RegEnable(in.op1_encrypted, ctrl.in.valid)
	val op1_is_a_byte_buffer = RegEnable(in.op1_is_a_byte, ctrl.in.valid)

	val op2_buffer = RegEnable( in.op2, ctrl.in.valid)
	val op2_encrypted_buffer = RegEnable(in.op2_encrypted, ctrl.in.valid)
	val op2_is_a_byte_buffer = RegEnable(in.op2_is_a_byte, ctrl.in.valid)

	val cond_buffer = RegEnable( in.cond, ctrl.in.valid)

	val valid_buffer = Reg(Bool())

	valid_buffer := Mux(ctrl.in.valid, true.B, Mux(seoperation.ctrl.in.valid, false.B, valid_buffer))
	ctrl.in.ready := !valid_buffer

	// Feed the ciphertexts into the invcipher
	aes_invcipher.io.input_op1.connectFromBits(Mux(valid_buffer,op1_buffer,in.op1))
	aes_invcipher.io.input_op2.connectFromBits(Mux(valid_buffer,op2_buffer,in.op2))
	aes_invcipher.io.input_cond.connectFromBits(Mux(valid_buffer,cond_buffer,in.cond))
	aes_invcipher.io.input_roundKeys := key
	aes_invcipher.io.input_valid := ctrl.in.valid

	// Reverse the byte order so we can convert them into uint with Chisel infrastructure.
	val op1_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	val op2_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	val cond_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	for(i <- 0 until Params.StateLength){
		op1_reverse(i) := aes_invcipher.io.output_op1(Params.StateLength-i-1)
		op2_reverse(i) := aes_invcipher.io.output_op2(Params.StateLength-i-1)
		cond_reverse(i) := aes_invcipher.io.output_cond(Params.StateLength-i-1)
	}

	// Feed the decrypted values to the seoperation module. Depends on whether the data is encrypted when it comes in.
	seoperation.in.inst := inst_buffer.do_asUInt
	seoperation.in.op1_input := Mux(op1_encrypted_buffer, op1_reverse.do_asUInt, op1_buffer.do_asUInt)
	seoperation.in.op1_is_a_byte := op1_is_a_byte_buffer 
	seoperation.in.op2_input := Mux(op2_encrypted_buffer, op2_reverse.do_asUInt, op2_buffer.do_asUInt)
	seoperation.in.op2_is_a_byte := op2_is_a_byte_buffer 
	seoperation.in.cond_input := cond_reverse.do_asUInt

	seoperation.ctrl.in.valid := aes_invcipher.io.output_valid
	seoperation.ctrl.out.ready := ctrl.out.ready

  // Once we receive the result form the seoperation, we latech the result first.
	val result_valid_buffer = Reg(Bool())
	result_valid_buffer := Mux(seoperation.ctrl.out.valid, true.B, Mux(ctrl.out.valid, false.B, result_valid_buffer))

	// Pad with RNG
	val bit64_randnum = LFSR(64)
	val bit120_randnum = LFSR(120)
	val byte_padded_result = Cat(seoperation.out.raw_result(63,56),bit120_randnum)
	val padded_64_result = Cat(seoperation.out.raw_result,bit64_randnum)
	val padded_result = Mux(seoperation.out.raw_result_is_a_byte,byte_padded_result, padded_64_result)
	val result_buffer = RegEnable( padded_result, seoperation.ctrl.out.valid)

	// Connect the cipher
	aes_cipher.io.input_text.connectFromBits(Mux(result_valid_buffer, result_buffer, padded_result))
	aes_cipher.io.input_valid := seoperation.ctrl.out.valid
	aes_cipher.io.input_roundKeys := key

	// Connect the output side
	val output_buffer = RegEnable(aes_cipher.io.output_text.do_asUInt, aes_cipher.io.output_valid)
	val output_valid = RegInit(false.B)

	when(aes_cipher.io.output_valid){
		output_valid := true.B
	}.elsewhen(ctrl.out.valid && ctrl.out.ready){
		output_valid := false.B
	}
	ctrl.out.valid := output_valid
	out.result := output_buffer

	InfoAnnotator.info(in.op1, "SensitiveInput")
	InfoAnnotator.info(in.op2, "SensitiveInput")
	InfoAnnotator.info(in.cond, "SensitiveInput")

	InfoAnnotator.info(aes_invcipher, "Decryption")
	InfoAnnotator.info(aes_cipher, "Encryption")
	InfoAnnotator.info(seoperation, "Private")
	InfoAnnotator.info(out.result, "SensitiveOutput")
	InfoAnnotator.info(key, "KeyStore")
	
}