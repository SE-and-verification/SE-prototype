package se

import chisel3._
import chisel3.util._
import aes._
import se.seoperation._
import chisel3.util.random._
import sha256._


class SEInput(val canChangeKey: Boolean) extends Bundle {
	val inst            = Input(UInt(8.W)) // Instruction encoding is defined in SEOperation/Instructions.scala
	val op1             = Input(UInt(512.W)) // 128bit mac + 384 bit ciphertext
	val op2             = Input(UInt(512.W)) // 128bit mac + 384 bit ciphertext
	val valid           = Input(Bool())
	val op1_type        = Input(Bool()) // 1 for encrypted, 0 for non-encrypted
	val op2_type        = Input(Bool()) // 1 for encrypted, 0 for non-encrypted
	val ready           = Output(Bool())

	val changeKey_en    = if(canChangeKey) Some(Input(Bool())) else None
	val newKey          = if(canChangeKey) Some(Input(Vec(11, Vec(16, UInt(8.W))))) else None
}


class SEOutput extends Bundle{
  val ready 				= Input(Bool())

	val result 				= Output(UInt(640.W))
	val valid 				= Output(Bool())
	val output_type   = Output(Bool()) // 1 for encrypted, 0 for non-encrypted
}

class SEIO(val canChangeKey: Boolean) extends Bundle {
	val in  = new SEInput(canChangeKey)
	val out = new SEOutput
}


class RNG_IO(val bits: Int) extends Bundle{
	val increment = Input(Bool())
	val PUB_VAR_HASH_LFSR = Output(Bits(bits.W))
}

class moduled_prng(val bits: Int, val pub_var_seed: Option[BigInt]) extends Module{
	val io = IO(new RNG_IO(bits))
	io.PUB_VAR_HASH_LFSR := LFSR(64, io.increment, pub_var_seed)
}

class SE(val debug : Boolean, val canChangeKey: Boolean) extends Module{
	// IO ports and control bits
	val io      = IO(new SEIO(canChangeKey))
	val rolled  = true

	// seoperation: the module to actually compute on decrypted plaintexts
	val seoperation = Module(new SEOperation(debug))

    // key: preset expanded AES ROM key
    val key = Reg(Vec(11, Vec(16,UInt(8.W))))
	  val mac_key = Reg(Vec(11, Vec(16,UInt(8.W))))

		val version_id = RegInit(0xdeabeaf.U(127.W)) // Version ID register
    // Two DECryptors:
    // Firsthlf: get RdNum + Plaintext (Lower 128 bits of Ciph_X) -> ALU part
	// Secondhlf: get Inst + Hash * 2 (Upper 128 bits of Ciph_X) -> Comparison part
  val aes_invcipher_op1 = Module(new AESDecrypt(true, 1))
	val aes_invcipher_op2 = Module(new AESDecrypt(true, 3))
	val aes_cipher_for_op1_mac_validation = Module(new AESMAC(true))
	val aes_cipher_for_op2_mac_validation = Module(new AESMAC(true))
	val aes_cipher_for_output_mac = Module(new AESMAC(true))
	val sha256_for_dataflow = Module(new Sha256Accel)
	val aes_cipher     			= Module(new AESEncrypt384(true))


	// Original AES key
	val expandedKey128 	= VecInit(
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

	// ----------buf_lv1----------
	val inst_buffer 	= RegEnable(io.in.inst, io.in.valid& io.in.ready)
	val op1_buffer 		= RegEnable(io.in.op1, io.in.valid & io.in.ready) // [hsh_A][Ciph_A]
	val op2_buffer 		= RegEnable(io.in.op2, io.in.valid& io.in.ready) // [hsh_B][Ciph_B]
	val op1_type_buffer = RegEnable(io.in.op1_type, io.in.valid& io.in.ready)
	val op2_type_buffer = RegEnable(io.in.op2_type, io.in.valid& io.in.ready)
	val input_buffer_valid = RegInit(false.B)
	val input_buffer_idle = RegInit(true.B)
	io.in.ready := input_buffer_idle
	when(io.in.valid && io.in.ready) {
		input_buffer_idle := false.B
		input_buffer_valid := true.B
	} .elsewhen(aes_invcipher_op1.io.input_valid && aes_invcipher_op2.io.input_valid) {
		input_buffer_idle := true.B
		input_buffer_valid := false.B
	}



	when(reset.asBool) {
		key := expandedKey128
		mac_key := expandedKey128
	}

	val decrypt_buffer_idle = RegInit(true.B)
	val decrypt_buffer_valid = RegInit(false.B)
	when(aes_invcipher_op1.io.input_valid) {
		decrypt_buffer_idle := false.B
	}.elsewhen(aes_cipher.io.input_valid) {
		decrypt_buffer_idle := true.B
	}
	
  aes_invcipher_op1.io.input_text         	:= op1_buffer
  aes_invcipher_op1.io.input_roundKeys   		:= key
  aes_invcipher_op1.io.input_valid       		:= input_buffer_valid && decrypt_buffer_idle
	aes_invcipher_op2.io.input_text        		:= op2_buffer
	aes_invcipher_op2.io.input_roundKeys  		:= key
	aes_invcipher_op2.io.input_valid      		:= input_buffer_valid && decrypt_buffer_idle
	aes_cipher_for_op1_mac_validation.io.input_text		:= Cat(op1_buffer(383, 0), version_id(126,0), op1_type_buffer.asUInt) // [Ciph_A][RdNum][verID_A]
	aes_cipher_for_op1_mac_validation.io.input_valid 		:= input_buffer_valid && decrypt_buffer_idle
	aes_cipher_for_op1_mac_validation.io.input_roundKeys 	:= mac_key
	aes_cipher_for_op2_mac_validation.io.input_text		:= Cat(op2_buffer(383, 0), version_id(126,0), op2_type_buffer.asUInt) // [Ciph_B][RdNum][verID_B]
	aes_cipher_for_op2_mac_validation.io.input_valid 		:= input_buffer_valid && decrypt_buffer_idle
	aes_cipher_for_op2_mac_validation.io.input_roundKeys 	:= mac_key

  
	val decrypted_op1_val_buffer_idle = RegInit(true.B)
	val decrypted_op2_val_buffer_idle = RegInit(true.B)
	val mac_validated_op1 = RegInit(false.B)
	val mac_validated_op2 = RegInit(false.B)


	val decrypted_op1_val_buffer = RegEnable(aes_invcipher_op1.io.output_text, aes_invcipher_op1.io.output_valid) 
	val decrypted_op2_val_buffer = RegEnable(aes_invcipher_op2.io.output_text, aes_invcipher_op2.io.output_valid) 
	val op1_type_buffer_after_decrypt_stage = RegEnable(op1_type_buffer, aes_invcipher_op1.io.input_valid)
	val op2_type_buffer_after_decrypt_stage = RegEnable(op2_type_buffer, aes_invcipher_op2.io.input_valid)
	val op1_buffer_after_decrypt_stage = RegEnable(op1_buffer, aes_invcipher_op1.io.input_valid)
	val op2_buffer_after_decrypt_stage = RegEnable(op2_buffer, aes_invcipher_op2.io.input_valid)
	val ciph1_mac = op1_buffer_after_decrypt_stage(511, 384)
	val ciph2_mac = op2_buffer_after_decrypt_stage(511, 384)
	val op1_mac_check_result_after_decrypt = RegInit(false.B)
	val op2_mac_check_result_after_decrypt = RegInit(false.B)

	when(aes_cipher_for_op1_mac_validation.io.output_valid) {
		when(aes_cipher_for_op1_mac_validation.io.output_text =/= ciph1_mac) {
			// If the MAC does not match, we set the decrypted_op1_val_buffer to 0
			op1_mac_check_result_after_decrypt := false.B
		}.otherwise {
			op1_mac_check_result_after_decrypt := true.B
		}
		mac_validated_op1 := true.B
	}.elsewhen(sha256_for_dataflow.io.inputValid) {
		mac_validated_op1 := false.B
	}

	when(aes_cipher_for_op2_mac_validation.io.output_valid) {
		when(aes_cipher_for_op2_mac_validation.io.output_text =/= ciph2_mac){
			// If the MAC does not match, we set the decrypted_op2_val_buffer to 0
			op2_mac_check_result_after_decrypt := false.B
		}.otherwise {
			op2_mac_check_result_after_decrypt := true.B
		}
		mac_validated_op2 := true.B
	}.elsewhen(sha256_for_dataflow.io.inputValid) {
		mac_validated_op2 := false.B
	}
	val decrypted_op1_val_buffer_valid = RegInit(false.B)
	val decrypted_op2_val_buffer_valid = RegInit(false.B)

	when(aes_invcipher_op1.io.input_valid) {
		decrypted_op1_val_buffer_idle := false.B
	} .elsewhen(sha256_for_dataflow.io.outputValid) {
		decrypted_op1_val_buffer_idle := true.B
	}

	when(aes_invcipher_op1.io.output_valid) {
		decrypted_op1_val_buffer_valid := true.B
	} .elsewhen(sha256_for_dataflow.io.outputValid) {
		decrypted_op1_val_buffer_valid := false.B
	}

	when(aes_invcipher_op2.io.input_valid) {
		decrypted_op2_val_buffer_idle := false.B
	} .elsewhen(sha256_for_dataflow.io.outputValid) {
		decrypted_op2_val_buffer_idle := true.B
	}

	when(aes_invcipher_op2.io.output_valid) {
		decrypted_op2_val_buffer_valid := true.B
	} .elsewhen(sha256_for_dataflow.io.outputValid) {
		decrypted_op2_val_buffer_valid := false.B
	}
	val inst_buffer_buf = RegEnable(inst_buffer, aes_invcipher_op1.io.input_valid) // [inst]
	val result_hash_buffer_idle = RegInit(true.B)
  seoperation.io.inst         := inst_buffer_buf
	seoperation.io.in_valid 	:= decrypted_op1_val_buffer_valid && decrypted_op2_val_buffer_valid 

	val op1_bit 	            = decrypted_op1_val_buffer(383, 256) // [plain_A][RdNum][verID_A]
	val op2_bit 	            = decrypted_op2_val_buffer(383, 256) // [plain_B][RdNum][verID_B]
	val is_enc_const = (inst_buffer_buf === Instructions.ENC_CONST)

	val op1_plaintext_64		= Mux(is_enc_const || op1_type_buffer_after_decrypt_stage, op1_buffer_after_decrypt_stage(383,256) ,op1_bit(127, 64)) // [plain_A]
	val op2_plaintext_64		= Mux(op2_type_buffer_after_decrypt_stage, op2_buffer_after_decrypt_stage(383,256) ,op2_bit(127, 64)) // [plain_B]
  seoperation.io.op1_input    := op1_plaintext_64 // Currently hardcoded (TEMP)
	seoperation.io.op2_input    := op2_plaintext_64 // Currently hardcoded (TEMP)

	val start_dataflow_hash_compute = decrypted_op1_val_buffer_valid && decrypted_op2_val_buffer_valid && result_hash_buffer_idle && mac_validated_op1 && mac_validated_op2
	val op1_mac_check_result_after_dataflow_hash = RegNext(op1_mac_check_result_after_decrypt, start_dataflow_hash_compute)
	val op2_mac_check_result_after_dataflow_hash = RegNext(op2_mac_check_result_after_decrypt, start_dataflow_hash_compute)
	sha256_for_dataflow.io.inputData := Cat(decrypted_op1_val_buffer(255, 0), decrypted_op2_val_buffer(255, 0), inst_buffer_buf) // [hsh_A][hsh_B]
	sha256_for_dataflow.io.inputValid := start_dataflow_hash_compute
	// Once we receive the result from the seoperation, we pad the result with RNG and latch them first.
	// Note that ALU may need 3 to 4 clock cycles (after seOpValid being set high) to calculate the result
	val bit64_randnum = PRNG(new MaxPeriodFibonacciLFSR(64, Some(scala.math.BigInt(46, scala.util.Random))))

	val non_enc_padded_result = Cat(seoperation.io.result, bit64_randnum,  Cat(sha256_for_dataflow.io.outputData)) // [Plain_C][RdNum][hsh_A][hsh_B][inst]

	val result_hash_buffer 					= RegEnable(non_enc_padded_result, sha256_for_dataflow.io.outputValid)
	val result_hash_valid_buffer 			= RegInit(false.B)
	when(sha256_for_dataflow.io.inputValid) {
		result_hash_buffer_idle := false.B
	} .elsewhen(aes_cipher.io.input_valid) {
		result_hash_buffer_idle := true.B
	}
	when(sha256_for_dataflow.io.outputValid) {
		result_hash_valid_buffer := true.B
	} .elsewhen(aes_cipher.io.input_valid) {
		result_hash_valid_buffer := false.B
	}


	val encrypt_buffer_idle = RegInit(true.B)
	val start_encrypt = result_hash_valid_buffer && encrypt_buffer_idle
	// Encrypt the padded result to get the final output
	aes_cipher.io.input_text			:= result_hash_buffer
	aes_cipher.io.input_valid 		:= start_encrypt
	aes_cipher.io.input_roundKeys 	:= key
	val op1_mac_check_result_after_encrypt = RegNext(op1_mac_check_result_after_dataflow_hash, start_encrypt)
	val op2_mac_check_result_after_encrypt = RegNext(op2_mac_check_result_after_dataflow_hash, start_encrypt)
	// enc buf
	val encrypted_result_buffer = RegEnable(aes_cipher.io.output_text, aes_cipher.io.output_valid)
	val encrypted_result_valid_buffer = RegInit(false.B)

	when(aes_cipher.io.output_valid) {
		encrypted_result_valid_buffer := true.B
	} .elsewhen(aes_cipher_for_output_mac.io.input_valid) {
		encrypted_result_valid_buffer := false.B
	}
	when(aes_cipher.io.input_valid) {
		encrypt_buffer_idle := false.B
	} .elsewhen(aes_cipher_for_output_mac.io.input_valid) {
		encrypt_buffer_idle := true.B
	}

	val input_to_mac = Cat(encrypted_result_buffer, version_id(126,0), 1.U(1.W))
	val output_buffer_enc = RegEnable(input_to_mac, aes_cipher_for_output_mac.io.input_valid)
	val output_buffer_valid = RegInit(false.B)
	val output_buffer_idle = RegInit(true.B)

	val start_output_mac = output_buffer_idle && encrypted_result_valid_buffer
	val check_result_after_mac_compute = RegNext(op1_mac_check_result_after_encrypt && op2_mac_check_result_after_encrypt, start_output_mac)
	aes_cipher_for_output_mac.io.input_text := input_to_mac
	aes_cipher_for_output_mac.io.input_valid := start_output_mac
	aes_cipher_for_output_mac.io.input_roundKeys := mac_key
	val output_connect 		= RegEnable(Cat(aes_cipher_for_output_mac.io.output_text, output_buffer_enc(511,128)), aes_cipher_for_output_mac.io.output_valid)
	when(io.out.valid && io.out.ready) {
		output_buffer_idle := true.B
	} .elsewhen(aes_cipher_for_output_mac.io.input_valid) {
		output_buffer_idle := false.B
	}
	when(io.out.valid && io.out.ready) {
		output_buffer_valid := false.B
	} .elsewhen(aes_cipher_for_output_mac.io.output_valid) {
		output_buffer_valid := true.B
	}
	val output_gated = Mux(check_result_after_mac_compute, output_connect, 0xEEEE.U(512.W))
	when(output_buffer_valid) {
		io.out.valid := true.B
		io.out.result 			:= output_gated
		io.out.output_type  := true.B
	}.otherwise{
		io.out.valid := false.B
		io.out.result 			:= 0.U(512.W)
		io.out.output_type := false.B
	}

}
