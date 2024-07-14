package se

import chisel3._
import chisel3.util._
import aes._
import se.seoperation._
import chisel3.util.random._

class SEInput(val canChangeKey: Boolean) extends Bundle{
	val inst = Input(UInt(8.W)) // Instruction encoding is defined in SEOperation/Instructions.scala

	val op1 = Input(UInt(316.W)) // 60bit hash + 256 bit ciphertext

	val op2 = Input(UInt(316.W))

	val valid = Input(Bool())
	val ready = Output(Bool())

	val changeKey_en = if(canChangeKey) Some(Input(Bool())) else None
	val newKey = if(canChangeKey) Some(Input(Vec(11, Vec(16, UInt(8.W))))) else None
}


class SEOutput extends Bundle{
	val result 				= Output(UInt(316.W))
	val valid 				= Output(Bool())
	val ready 				= Input(Bool())
	val op1_compare 		= Output(Bool())
	val op2_compare 		= Output(Bool())
	val op1_compare_valid 	= Output(Bool())
	val op2_compare_valid 	= Output(Bool())
}

class SEIO(val canChangeKey: Boolean) extends Bundle{
	val in = new SEInput(canChangeKey)
	val out = new SEOutput
}

class Hash_Compare extends Module {
	// Given the original 60 bit "hash_orig" and a 128 bit "hash_regenerated", judge whether hash_orig(59, 0) === hash_regenerated(127, 68)
	// Combinational logic
	val io = IO(new Bundle {
		val hash_orig 			= Input(UInt(60.W))
		val hash_regenerated 	= Input(UInt(128.W))
		val valid_in 			= Input(Bool())
		val valid_out 			= Output(Bool())
		val compare_result 		= Output(Bool())
	})
	
	val is_valid 		= Wire(Bool())
	val comp_result 	= Wire(Bool())

	is_valid 			:= Mux(io.valid_in, true.B, false.B) 
	comp_result 		:= io.hash_orig(59, 0) === io.hash_regenerated(127, 68)

	io.valid_out 		:= is_valid
	io.compare_result 	:= comp_result
}

class Plaintext_Reverse_Connector extends Module {
	// Connect 2 reversed 60-bit hash plaintext and 1 8-bit inst together
	val io = IO(new Bundle{
		val op1 	= Input(UInt(316.W))
		val op2 	= Input(UInt(316.W))
		val inst 	= Input(UInt(8.W))
		val out     = Output(Vec(Params.StateLength, UInt(8.W)))
	})
	val op1_hash 		= io.op1(315, 256)
	val op2_hash 		= io.op2(315, 256)
	val connect_result 	= Cat(op1_hash, op2_hash, io.inst)
	val integrityWire = Wire(Vec(Params.new_integrity_length, UInt(8.W)))

  	// Split the 128-bit connect_result into 16 8-bit chunks
  	for (i <- 0 until Params.new_integrity_length) {
    	integrityWire(i) := connect_result((i+1)*8-1, i*8)
  	}
	// Reverse the byte order so we can convert them into uint with Chisel infrastructure.
	// Here new_integrity_length = (60 + 60 + 8) / 8 = 16
	val connect_result_reverse = Wire(Vec(Params.new_integrity_length, UInt(8.W)))
	for(i <- 0 until Params.new_integrity_length){
		connect_result_reverse(i) := integrityWire(Params.new_integrity_length - i - 1)
	}
	// Connect the module output
	io.out := integrityWire

	// printf("op1_hash: %x\n", op1_hash)
	// printf("op2_hash: %x\n", op2_hash)
	// printf("inst: %x\n", io.inst)
	// printf("connect_result: %x\n", connect_result)
	// printf("integrityWire: %x\n", Cat(integrityWire))
}

class SE(val debug:Boolean, val canChangeKey: Boolean) extends Module{
	// Define the input, output ports and the control bits
	val io = IO(new SEIO(canChangeKey))
	val rolled = true

	/*
	seoperation: the module to actually compute on decrypted plaintexts
	key: preset expanded AES ROM key
	*/
	val seoperation = Module(new SEOperation(debug))
	val aes_invcipher_firsthlf = Module(new AESDecrypt(rolled, 1)) // get RDNUM + PLAINTEXT 
	val aes_invcipher_secondhlf = Module(new AESDecrypt(rolled, 3)) // get INST + HASH * 2

	// For ciph_C
	val aes_cipher_firsthlf = Module(new AESEncrypt(rolled))
	val aes_cipher_secondhlf = Module(new AESEncrypt(rolled))

	// New integrity
	val aes_cipher_for_hash_C 	= Module(new AESEncrypt(rolled))
	val aes_cipher_for_op1 		= Module(new AESEncrypt(rolled))
	val aes_cipher_for_op2 		= Module(new AESEncrypt(rolled))

	val key = Reg(Vec(11, Vec(16,UInt(8.W))))

	val ciphers = Reg(Vec(32, UInt(128.W)))
	val cache_valid = Reg(Vec(32, Bool()))
	val plaintexts = Reg(Vec(32, UInt(64.W)))
	val ptr = RegInit(0.U(8.W))
	val expandedKey128 = VecInit(
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
	
	if(canChangeKey){
		when(reset.asBool){
			key := expandedKey128
		}.elsewhen(io.in.changeKey_en.get){
			key := io.in.newKey.get
		}
	}else{
		when(reset.asBool){
			key := expandedKey128
		}
	}
 
	/*----------------------buf_lv1----------------------*/
	// Once we receive the data, first latch them into buffers.
	val inst_buffer 	= RegEnable(io.in.inst, io.in.valid)
	val op1_buffer 		= RegEnable(io.in.op1, io.in.valid)
	val op2_buffer 		= RegEnable(io.in.op2, io.in.valid)
	val valid_buffer 	= Reg(Bool())
	/*----------------------buf_lv1----------------------*/

	val output_valid = RegInit(false.B)

	// TODO: compute hash here, just copy key and re-instantiate a hash key for the moment. Create additional modules if needed
	
	// Instantiate the connector and connect reg input and reg output
	val Plaintext_Reverse_Connector_0 = Module(new Plaintext_Reverse_Connector)
	Plaintext_Reverse_Connector_0.io.op1 	:= op1_buffer 
	Plaintext_Reverse_Connector_0.io.op2 	:= op2_buffer
	Plaintext_Reverse_Connector_0.io.inst 	:= inst_buffer

	val connected_reversed_plaintext_buffer = Wire(Vec(Params.StateLength, UInt(8.W)))
	connected_reversed_plaintext_buffer := Plaintext_Reverse_Connector_0.io.out

	val hash_C_input_valid = Reg(Bool())
	val tmp3 = RegInit(false.B)
	when(io.in.valid && io.in.ready && ~tmp3) {
		hash_C_input_valid := true.B
		tmp3 := true.B
	}.otherwise{
		hash_C_input_valid := false.B
	}

	when(hash_C_input_valid){
		printf("aes_cipher_for_hash_C.io.input_text: %x\n", Cat(aes_cipher_for_hash_C.io.input_text))
	}
	when(aes_cipher_for_hash_C.io.output_valid){
		printf("aes_cipher_for_hash_C.io.output_text: %x\n", Cat(aes_cipher_for_hash_C.io.output_text))
	}

	// Encrypt the connected result
	aes_cipher_for_hash_C.io.input_text 		:= connected_reversed_plaintext_buffer
	aes_cipher_for_hash_C.io.input_roundKeys 	:= key
	aes_cipher_for_hash_C.io.input_valid 		:= hash_C_input_valid

	/*----------------------buf_lv2----------------------*/
	// latch the hash_C_original into the buffer
	val next_hash_C_original_buffer_valid 	= Wire(Bool())
	val hash_C_original_buffer 				= RegEnable(Cat(aes_cipher_for_hash_C.io.output_text), aes_cipher_for_hash_C.io.output_valid)
	val hash_C_original_buffer_valid 		= RegInit(false.B)
	next_hash_C_original_buffer_valid      := Mux(aes_cipher_for_hash_C.io.output_valid, true.B, Mux(output_valid, false.B, hash_C_original_buffer_valid))
	hash_C_original_buffer_valid           := RegNext(next_hash_C_original_buffer_valid)

	// when(hash_C_original_buffer_valid){
	// 	printf("hash_C_original_buffer: %x\n", hash_C_original_buffer) //hash_C_original_buffer working
	// }
	/*----------------------buf_lv2----------------------*/ 

	/*----------------------buf_lv3----------------------*/
	// Trim hash_C_orig and store hash_C
	val next_hash_C_buffer_valid 	= Wire(Bool())
	val hash_C_buffer_valid 		= RegInit(false.B)
	val hash_C_buffer 				= RegEnable(hash_C_original_buffer(127, 68), hash_C_buffer_valid)
	next_hash_C_buffer_valid       := Mux(hash_C_original_buffer_valid, true.B, Mux(output_valid, false.B, hash_C_buffer_valid))
	hash_C_buffer_valid            := RegNext(next_hash_C_buffer_valid)
	/*----------------------buf_lv3----------------------*/

	val n_result_valid_buffer = Wire(Bool())
	val ready_for_input = RegInit(true.B)
	// val n_stage_valid = Wire(Bool())
	io.in.ready := ready_for_input

	// valid_buffer := Mux(io.in.valid && io.in.ready, true.B, Mux(n_stage_valid, false.B, valid_buffer))

	val tmp = RegInit(false.B)
	when(io.in.valid && io.in.ready && ~tmp) {
		valid_buffer := true.B
		tmp := true.B
	}.otherwise{
		valid_buffer := false.B
	}

	// printf("valid buffer: %x\n", valid_buffer);
	// when(valid_buffer){
	// 	printf("valid_buffer: %x\n", valid_buffer);
	// 	printf("io.in.ready: %x\n", io.in.ready);
	// 	printf("io.in.valid: %x\n", io.in.valid);
	// }
	
	when(io.in.valid && io.in.ready){
		ready_for_input := false.B
	}.elsewhen(io.out.valid && io.out.ready){
		ready_for_input := true.B
	}

	val op1_found = ciphers.contains(op1_buffer)
	val op2_found = ciphers.contains(op2_buffer)
	val op1_idx = ciphers.indexWhere(e => (e===op1_buffer))
	val op2_idx = ciphers.indexWhere(e => (e===op2_buffer))

	val op1_val = plaintexts(op1_idx)
	val op2_val = plaintexts(op2_idx)

	val all_match = op1_found && op2_found && cache_valid(op1_idx) && cache_valid(op2_idx)

	// Feed the ciphertexts into the invcipher
	val ciph_op1 = op1_buffer(255,0)
	val ciph_op1_calc = ciph_op1(127, 0)
	val ciph_op1_calc_vec = Wire(Vec(16, UInt(8.W)))
	val ciph_op1_comp = ciph_op1(255, 128)
	val ciph_op1_comp_vec = Wire(Vec(16, UInt(8.W)))
	val ciph_op2 = op2_buffer(255,0)
	val ciph_op2_calc = ciph_op2(127, 0)
	val ciph_op2_calc_vec = Wire(Vec(16, UInt(8.W)))
	val ciph_op2_comp = ciph_op2(255, 128)
	val ciph_op2_comp_vec = Wire(Vec(16, UInt(8.W)))

	for (i <- 0 until 16) {
		ciph_op1_calc_vec(i) := ciph_op1_calc((15 - i) * 8 + 7, (15 - i) * 8)
		ciph_op1_comp_vec(i) := ciph_op1_comp((15 - i) * 8 + 7, (15 - i) * 8)
		// ciph_op1_comp_vec(i) := ciph_op1_comp((i + 1) * 8 - 1, i * 8)
		ciph_op2_calc_vec(i) := ciph_op2_calc((15 - i) * 8 + 7, (15 - i) * 8)
		ciph_op2_comp_vec(i) := ciph_op2_comp((15 - i) * 8 + 7, (15 - i) * 8)
	}

	aes_invcipher_firsthlf.io.input_op1 := ciph_op1_calc_vec // Firsthlf -> ALU part
	aes_invcipher_firsthlf.io.input_op2 := ciph_op2_calc_vec

	aes_invcipher_secondhlf.io.input_op1 := ciph_op1_comp_vec // Secondhlf -> Comparison part
	aes_invcipher_secondhlf.io.input_op2 := ciph_op2_comp_vec 

    aes_invcipher_firsthlf.io.input_roundKeys := key
	aes_invcipher_secondhlf.io.input_roundKeys := key

	aes_invcipher_firsthlf.io.input_valid := valid_buffer && (!all_match)
	aes_invcipher_secondhlf.io.input_valid := valid_buffer && (!all_match)
	
	// n_stage_valid := all_match || valid_buffer

	// use aes_invcipher_firsthlf.io.input_valid for simplicity
	val mid_inst_buffer = RegEnable(inst_buffer, aes_invcipher_firsthlf.io.input_valid) // buf_lv2
	val mid_op1_buffer = RegEnable(op1_buffer, aes_invcipher_firsthlf.io.input_valid) // buf_lv2
	val mid_op2_buffer = RegEnable(op2_buffer, aes_invcipher_firsthlf.io.input_valid) // buf_lv2

	// decrypted hashing part of op for verification
	val decrypted_op1_buffer 		= RegEnable(aes_invcipher_secondhlf.io.output_op1, aes_invcipher_secondhlf.io.output_valid) // buf_lv2
	val decrypted_op1_buffer_valid 	= RegInit(false.B) // buf_lv2
	val decrypted_op2_buffer 		= RegEnable(aes_invcipher_secondhlf.io.output_op2, aes_invcipher_secondhlf.io.output_valid) // buf_lv2
	val decrypted_op2_buffer_valid 	= RegInit(false.B) // buf_lv2

	val tmp2 = RegInit(false.B)
	when(aes_invcipher_firsthlf.io.output_valid && ~tmp2){
		decrypted_op1_buffer_valid := true.B
		decrypted_op2_buffer_valid := true.B
		tmp2 := true.B
	}.otherwise{
		decrypted_op1_buffer_valid := false.B
		decrypted_op2_buffer_valid := false.B
	}

	// Feed the decrypted values to the seoperation module. Depends on whether the data is encrypted when it comes in.
	// Reverse the byte order of decrypted plaintext so we can convert them into uint with Chisel infrastructure.
	seoperation.io.inst 	:= Mux(valid_buffer, inst_buffer, mid_inst_buffer)
	val seOpValid 			= aes_invcipher_firsthlf.io.output_valid // || (all_match && valid_buffer)
	seoperation.io.in_valid 	:= seOpValid

    val op1_bit                     = Cat(aes_invcipher_firsthlf.io.output_op1)
    val op2_bit                     = Cat(aes_invcipher_firsthlf.io.output_op2)
    val op1_asUInt                  = op1_bit(127, 64).do_asUInt // get plain_A
    val op2_asUInt                  = op2_bit(127, 64).do_asUInt // get plain_B


	seoperation.io.op1_input := Mux(all_match && valid_buffer, op1_val, Mux(mid_inst_buffer(7,5) === 5.U(3.W), op1_bit, op1_asUInt))
	seoperation.io.op2_input := Mux(all_match && valid_buffer, op2_val, Mux(mid_inst_buffer(7,5) === 5.U(3.W), op2_bit, op2_asUInt))

	when(seOpValid){
			printf("op1_bit:%x\n", op1_bit)
			printf("op2_bit:%x\n", op2_bit)
			printf("op1_asUInt:%x\n", op1_asUInt)
			printf("op2_asUInt:%x\n", op2_asUInt)
			printf("seoperation.io.op1_input:%x\n", seoperation.io.op1_input)
			printf("seoperation.io.op2_input:%x\n", seoperation.io.op2_input)
	}

	// Reconstruct the hash and compare

	// Encrypt decrypted part of op1 and op2
	aes_cipher_for_op1.io.input_text 		:= decrypted_op1_buffer
	aes_cipher_for_op1.io.input_valid 		:= decrypted_op1_buffer_valid
	aes_cipher_for_op1.io.input_roundKeys 	:= key
	aes_cipher_for_op2.io.input_text 		:= decrypted_op2_buffer
	aes_cipher_for_op2.io.input_valid 		:= decrypted_op2_buffer_valid
	aes_cipher_for_op2.io.input_roundKeys 	:= key

	val rehashed_op1_bit 		= Cat(aes_cipher_for_op1.io.output_text)
	val trimmed_rehashed_op1 	= rehashed_op1_bit(127, 68)
	val op1_compare_result 		= (trimmed_rehashed_op1 === mid_op1_buffer(315, 256))
	val rehashed_op2_bit 		= Cat(aes_cipher_for_op2.io.output_text)
	val trimmed_rehashed_op2 	= rehashed_op2_bit(127, 68)
	val op2_compare_result 		= (trimmed_rehashed_op2 === mid_op2_buffer(315, 256))

  	// Once we receive the result from the seoperation, we latch the result first.
	val result_valid_buffer = RegNext(n_result_valid_buffer)
	n_result_valid_buffer := Mux(seOpValid, true.B, Mux(aes_cipher_firsthlf.io.input_valid, false.B, result_valid_buffer))

	// Pad with RNG
	val bit64_randnum = PRNG(new MaxPeriodFibonacciLFSR(64, Some(scala.math.BigInt(64, scala.util.Random))))
	// val bit64_zero = 0.U(64.W)
	val padded_result = Cat(seoperation.io.result, bit64_randnum, mid_op1_buffer(315, 256), mid_op2_buffer(315, 256), mid_inst_buffer)
	
	
	val result_buffer = RegEnable(padded_result, seoperation.io.out_valid) // buf_lv3
		
	when(seOpValid){
		printf("mid_op1_buffer:%x\n", mid_op1_buffer)
		printf("mid_op2_buffer:%x\n", mid_op2_buffer)
		printf("mid_inst_buffer:%x\n", mid_inst_buffer)

		printf("bit64_randnum:%x\n", bit64_randnum)
		printf("padded_result:%x\n", padded_result)
		printf("seoperation.io.result:%x\n",seoperation.io.result)
	}

	val result_plaintext_buffer = RegInit(0.U(64.W))
	when(seOpValid){
		result_plaintext_buffer := seoperation.io.result
	}

	// TODO: adjust input to the encryption cipher

	// Connect the cipher
	val result_buffer_vectorized = Wire(Vec(Params.CiphLength, UInt(8.W))) // turn it into vector for reversing
	result_buffer_vectorized:= VecInit(Seq.tabulate(Params.CiphLength)(i => result_buffer((i + 1) * 8 - 1, i * 8)))
	val aes_input_reverse = Wire(Vec(Params.CiphLength, UInt(8.W)))
	for(i <- 0 until Params.CiphLength){
		aes_input_reverse(i) := result_buffer_vectorized(Params.CiphLength-i-1)
	}
	val aes_input_reverse_bit = aes_input_reverse.do_asUInt
	aes_cipher_firsthlf.io.input_text := result_buffer(127, 0).asTypeOf(aes_cipher_firsthlf.io.input_text)
	aes_cipher_firsthlf.io.input_valid := result_valid_buffer
	aes_cipher_firsthlf.io.input_roundKeys := key

	aes_cipher_secondhlf.io.input_text := result_buffer(255, 128).asTypeOf(aes_cipher_secondhlf.io.input_text)
	aes_cipher_secondhlf.io.input_valid := result_valid_buffer
	aes_cipher_secondhlf.io.input_roundKeys := key

	when(aes_cipher_firsthlf.io.input_valid){
		printf("aes_input_reverse_bit:%x\n", aes_input_reverse_bit)
		printf("aes_cipher_firsthlf.io.input_text:%x\n", Cat(aes_cipher_firsthlf.io.input_text))
		printf("aes_cipher_secondhlf.io.input_text:%x\n", Cat(aes_cipher_secondhlf.io.input_text))
	}
	when(aes_cipher_firsthlf.io.output_valid){
		printf("aes_cipher_firsthlf.io.output_text:%x\n", Cat(aes_cipher_firsthlf.io.output_text))
		printf("aes_cipher_secondhlf.io.output_text:%x\n", Cat(aes_cipher_secondhlf.io.output_text))
	}
	// Connect the output side
	val output_connect = Cat(hash_C_buffer, Cat(aes_cipher_firsthlf.io.output_text), Cat(aes_cipher_secondhlf.io.output_text))
	val output_buffer = RegInit(0.U(316.W)) // buf_lv4
	when(aes_cipher_firsthlf.io.output_valid){
		printf("output_connect:%x\n", output_connect)
	}
	/*----------------------buf_lv4----------------------*/
	val next_op1_compare_result_buffer_valid = Wire(Bool())
	val next_op2_compare_result_buffer_valid = Wire(Bool())

	val op1_compare_result_buffer 		= RegEnable(op1_compare_result, next_op1_compare_result_buffer_valid)
	val op1_compare_result_buffer_valid = RegInit(false.B)
	op1_compare_result_buffer_valid 	:= RegNext(next_op1_compare_result_buffer_valid)

	val op2_compare_result_buffer 		= RegEnable(op2_compare_result, next_op1_compare_result_buffer_valid)
	val op2_compare_result_buffer_valid = RegInit(false.B)
	op2_compare_result_buffer_valid 	:= RegNext(next_op2_compare_result_buffer_valid)
 
	// op<n>_compare_result_buffer_valid hold till output_valid goes high
	when(aes_cipher_for_op1.io.output_valid){
		next_op1_compare_result_buffer_valid := true.B
	}.elsewhen(output_valid){
		next_op1_compare_result_buffer_valid := false.B
	}.otherwise{
		next_op1_compare_result_buffer_valid := op1_compare_result_buffer_valid
	}
	when(aes_cipher_for_op2.io.output_valid){
		next_op2_compare_result_buffer_valid := true.B
	}.elsewhen(output_valid){
		next_op2_compare_result_buffer_valid := false.B
	}.otherwise{
		next_op2_compare_result_buffer_valid := op2_compare_result_buffer_valid
	}

	/*----------------------buf_lv4----------------------*/

	// Output valid when encryption for ciph_C result valid and two compare results high
	when((op1_compare_result_buffer && op1_compare_result_buffer_valid) && (op2_compare_result_buffer && op2_compare_result_buffer_valid)) {
		output_valid := true.B
	}.elsewhen(io.out.valid && io.out.ready) {
		output_valid := false.B
	}

	// C output is 0 when either of compare results is false
	// FIXME: Changed output logic
	when(aes_cipher_firsthlf.io.output_valid && aes_cipher_secondhlf.io.output_valid){
		output_buffer := output_connect
	}

	io.out.valid 				:= output_valid
	io.out.result 				:= output_buffer
	io.out.op1_compare 			:= op1_compare_result_buffer
	io.out.op2_compare 			:= op2_compare_result_buffer
	io.out.op1_compare_valid 	:= op1_compare_result_buffer_valid
	io.out.op2_compare_valid 	:= op2_compare_result_buffer_valid

	when(output_valid){
		printf("ptr:%x\n",ptr)
		when(ptr === 31.U){
			ptr := 0.U
		}.otherwise{
			ptr := ptr + 1.U
		}
	}
	when(reset.asBool){
		key := expandedKey128
		for(i <- 0 until 32){
			ciphers(i) := 0.U
			plaintexts(i) := 0.U
			cache_valid(i) := false.B
		}
	}.otherwise{	
		when(io.out.valid){
			ciphers(ptr) := output_buffer
			plaintexts(ptr) := result_plaintext_buffer
			cache_valid(ptr) := true.B
		}
	}

	
}
