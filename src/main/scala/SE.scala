package se

import chisel3._
import chisel3.util._
import aes._
import se.seoperation._
import chisel3.util.random._
/*
316 bit operand:
- 60bit non-encrypted:
  - 60 bit hash
- 256 bit encrpted:
  - 64 bit secret
	- 47 bit random
	- 1 bit pub_priv --- 1 for pub, 0 for priv
	- 16 bit version id
	- 60 + 60 + 8 bit for verification
*/

/*
any one with secret is secret;
when two publics, 1 variable is variable;
two constants is constant
*/
object PUB_PRIV_ENCODING {
	val secret = 0
	val pub_const = 1
	val pub_var = 3
}
class SEInput(val canChangeKey: Boolean) extends Bundle {
	val inst            = Input(UInt(8.W)) // Instruction encoding is defined in SEOperation/Instructions.scala
	val op1             = Input(UInt(316.W)) // 60bit hash + 256 bit ciphertext
	val op2             = Input(UInt(316.W)) // 60bit hash + 256 bit ciphertext
	val valid           = Input(Bool())

	val ready           = Output(Bool())

	val changeKey_en    = if(canChangeKey) Some(Input(Bool())) else None
	val newKey          = if(canChangeKey) Some(Input(Vec(11, Vec(16, UInt(8.W))))) else None
}


class SEOutput extends Bundle{
    val ready 				= Input(Bool())

	val result 				= Output(UInt(316.W))
	val valid 				= Output(Bool())
	val op1_hash_compare 	= Output(Bool())
	val op2_hash_compare 	= Output(Bool())
}

class SEIO(val canChangeKey: Boolean) extends Bundle {
	val in  = new SEInput(canChangeKey)
	val out = new SEOutput
}

class Plaintext_Reverse_Connector extends Module {
	// Connect 2 60-bit hash plaintext and 1 8-bit inst together, and then reverse it
	val io = IO(new Bundle {
		val op1 	  = Input(UInt(316.W))
		val op2 	  = Input(UInt(316.W))
		val inst 	  = Input(UInt(8.W))
		val out       = Output(Vec(Params.StateLength, UInt(8.W)))
	})

	val op1_hash 		= io.op1(315, 256)
	val op2_hash 		= io.op2(315, 256)
	val connect_result 	= Cat(op1_hash, op2_hash, io.inst) // Structure: [op1_hsh][op2_hsh][inst]

	// Reverse the byte order so we can convert them into uint with Chisel infrastructure.
	// Structure: [op1_hsh][op2_hsh][inst] -> [tsni][hsh_2po][hsh_1po]
	val connect_result_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
    for(i <- 0 until Params.StateLength) {
		connect_result_reverse(i) := connect_result((i + 1) * 8 - 1, i * 8)
	}
	
	// Connect the module output
	io.out := connect_result_reverse
}

class Hash_Compare extends Module {
	// Given the original 60 bit "hash_orig" and a 128 bit "hash_regenerated", judge whether hash_orig(58, 0) === hash_regenerated(126, 68)
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
	comp_result 		:= io.hash_orig(59, 0) === io.hash_regenerated(125, 66) 

	io.valid_out 		:= is_valid
	io.compare_result 	:= comp_result 
}

class Version_ID_Generator extends Module {
	// Generate new version id (or throw error code when detecting unauthorized version data modification)
	// Based on two version id input and Pub_Priv status
	// Combinational logic
	val io = IO(new Bundle {
		val pub_priv_opA 	= Input(Bool())
		val pub_priv_opB 	= Input(Bool())
		val version_id_opA 	= Input(UInt(16.W))
		val version_id_opB 	= Input(UInt(16.W))
		val valid_in 		= Input(Bool())
		val valid_out 		= Output(Bool())
		val version_id_out 	= Output(UInt(16.W))
		val pub_priv_out = Output(Bool())
	})

	val is_valid 		= Wire(Bool())
	val ver_id_result 	= Wire(UInt(16.W))

	is_valid 		:= Mux(io.valid_in, true.B, false.B)
	
	if(io.pub_priv_opA == 0) {
		if(io.pub_priv_opB == 0) {
			// (A, B) is (priv, priv)
			if(io.version_id_opA != io.version_id_opB) {
				ver_id_result := Fill(16, 1.U) // Error
			} else {
				ver_id_result := io.version_id_opA
			}
		} else {
			// (A, B) is (priv, pub)
			ver_id_result := io.version_id_opA
		}
	} else {
		if(io.pub_priv_opB == 0) {
			// (A, B) is (pub, priv)
			ver_id_result := io.version_id_opA
		} else {
			// (A, B) is (pub, pub)
			ver_id_result := DontCare
		}
	}

	io.valid_out 		:= is_valid
	io.version_id_out 	:= ver_id_result
  io.pub_priv_out := io.pub_priv_opA & io.pub_priv_opB
}

class SE(val debug : Boolean, val canChangeKey: Boolean) extends Module{
	// IO ports and control bits
	val io      = IO(new SEIO(canChangeKey))
	val rolled  = true

	// seoperation: the module to actually compute on decrypted plaintexts
	val seoperation = Module(new SEOperation(debug))

    // key: preset expanded AES ROM key
    val key = Reg(Vec(11, Vec(16,UInt(8.W))))

    // Two DECryptors:
    // Firsthlf: get RdNum + Plaintext (Lower 128 bits of Ciph_X) -> ALU part
	// Secondhlf: get Inst + Hash * 2 (Upper 128 bits of Ciph_X) -> Comparison part
  	val aes_invcipher_op1 = Module(new AESDecrypt(rolled, 1))
	val aes_invcipher_op2 = Module(new AESDecrypt(rolled, 3))

    // Five ENCryptors:
    // Firsthlf: get RdNum + Plaintext (Lower 128 bits of Ciph_X) -> ALU part
    // Secondhlf: get Inst p+ Hash * 2 (Upper 128 bits of Ciph_X) -> Comparison part
    // Hash_C: Generate Hash_C_original
    // For_opX: Rehash and comparison
	val aes_cipher     			= Module(new AESEncrypt256(rolled))
	// val aes_cipher    = Module(new AESEncrypt(rolled))
	// val aes_cipher    = Module(new AESEncrypt(rolled))
	val aes_cipher_for_hash_C 	= Module(new AESEncrypt(rolled))
	val aes_cipher_for_op1 		= Module(new AESEncrypt(rolled))
	val aes_cipher_for_op2 		= Module(new AESEncrypt(rolled))
	val aes_cipher_for_pub_var = Module(new AESEncrypt(rolled))
	// Cache (TEMP disabled)
	// val ciphers 		= Reg(Vec(32, UInt(128.W)))
	// val cache_valid 	= Reg(Vec(32, Bool()))
	// val plaintexts 		= Reg(Vec(32, UInt(64.W)))

	// Original AES key
	val ptr 			= RegInit(0.U(8.W))
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
	val pub_var_seed = Some(BigInt(0x0eadbeef))

    // PRC: Plaintext Reverse Connector
    val PRC_0 = Module(new Plaintext_Reverse_Connector)

	// HC: Hash Compare Module
	val HC_op1 = Module(new Hash_Compare)
	val HC_op2 = Module(new Hash_Compare)


	// VID: Version ID Generator
	val VID_0 = Module(new Version_ID_Generator)

	// ----------buf_lv1----------
	val inst_buffer 	= RegEnable(io.in.inst, io.in.valid)
	val op1_buffer 		= RegEnable(io.in.op1, io.in.valid) // [hsh_A][Ciph_A]
	val op2_buffer 		= RegEnable(io.in.op2, io.in.valid) // [hsh_B][Ciph_B]
	val ready_for_input = RegInit(true.B)
	// ----------buf_lv1----------

	// Level_1 buffer debug
	// printf("[Stage:          Input -> Level_1 Buffer]\n")

	// ----------4ok_reg----------
	val lv1ok_buffer 	= RegInit(false.B)
	val lv2ok_buffer 	= RegInit(false.B)
	val lv3ok_buffer 	= RegInit(false.B)
	val lv4ok_buffer 	= RegInit(false.B)
	// ----------4ok_reg----------

	// PUB_VAR_HASH
	val is_enc_const = (inst_buffer === Instructions.ENC_CONST)
	val is_enc_var =  (inst_buffer === Instructions.ENC_VAR)
	val is_enc_var_hash = (inst_buffer === Instructions.ENC_VAR_HASH)
	val is_enc_inst = (is_enc_const&&is_enc_var && is_enc_var_hash)
  val start_enc_var_regs = lv1ok_buffer && is_enc_var

	val incr_pub_var_prng = Wire(Bool())
	val PUB_VAR_HASH_LFSR = LFSR(64, incr_pub_var_prng, pub_var_seed)
	incr_pub_var_prng := start_enc_var_regs

	val pub_var_hash_register = Reg(UInt(64.W))
	when(aes_cipher_for_pub_var.io.output_valid){
		pub_var_hash_register := aes_cipher_for_pub_var.io.output_text(127,64)
	}
	aes_cipher_for_pub_var.io.input_roundKeys := expandedKey128
	aes_cipher_for_pub_var.io.input_text := Cat(pub_var_hash_register, op1_buffer(255,192))
	aes_cipher_for_pub_var.io.input_valid := start_enc_var_regs

    // Key changing logic
	if(canChangeKey) {
		when(reset.asBool) {
			key := expandedKey128
		}.elsewhen(io.in.changeKey_en.get) {
			key := io.in.newKey.get
		}
	} else {
		when(reset.asBool) {
			key := expandedKey128
		}
	}

	val output_valid = RegInit(false.B) // Set high when the final result is ready


	

	io.in.ready := ready_for_input

	// Ready for input logic
	val next_ready_for_input 	= Wire(Bool())
	next_ready_for_input     	:= Mux((io.in.valid && io.in.ready), false.B, Mux((io.out.valid && io.out.ready), true.B, ready_for_input))
	ready_for_input 			:= RegNext(next_ready_for_input)

	// lv1ok_buffer logic
	val next_lv1ok_buffer 	= Wire(Bool())
	next_lv1ok_buffer     	:= Mux((io.in.valid && io.in.ready), true.B, Mux(output_valid, false.B, lv1ok_buffer))
	lv1ok_buffer 			:= RegNext(next_lv1ok_buffer) 
    
	// Level_1 buffer debug
	when(lv1ok_buffer && !lv2ok_buffer && !lv3ok_buffer && !lv4ok_buffer) {
		printf("\tinst_buffer: %x\n", inst_buffer)
		printf("\top1_buffer: %x\n", op1_buffer)
		printf("\top2_buffer: %x\n", op2_buffer)
		printf("\tready_for_input: %x\n", ready_for_input)
		printf("\tlv1ok_buffer: %x\n", lv1ok_buffer);
	}

	// Level_2 buffer debug
	printf("[Stage: Level_1 Buffer -> Level_2 Buffer]\n")

    // Connect reg input and reg output
  PRC_0.io.op1 	                        := op1_buffer 
	PRC_0.io.op2 	                        := op2_buffer
	PRC_0.io.inst 	                      := inst_buffer
    val connected_reversed_plaintext_buffer = Wire(Vec(Params.StateLength, UInt(8.W)))
	connected_reversed_plaintext_buffer     := PRC_0.io.out
	
	// Feed the ciphertexts into the invcipher
	val ciph_op1 			= op1_buffer(255,0) // [Ciph_A]
	val ciph_op1_val 		= ciph_op1(127, 0)
	val ciph_op1_hash 		= ciph_op1(255, 128)
	val ciph_op2 			= op2_buffer(255,0) // [Ciph_B]
	val ciph_op2_val 		= ciph_op2(127, 0)
	val ciph_op2_hash 		= ciph_op2(255, 128)
	val lv2_AES_valid       = RegInit(false.B) // local reg, only components between lv1 and lv2 need it
	val tmp_1 				= RegInit(false.B)


	// lv2_AES_valid logic
	// Set low one cycle after being set high
	val next_lv2_AES_valid  = Wire(Bool())
	val next_tmp_1 			= Wire(Bool())
	next_lv2_AES_valid 		:= Mux((lv1ok_buffer && !tmp_1 && !is_enc_inst), true.B, false.B)
	next_tmp_1 				:= Mux((lv1ok_buffer && !lv2_AES_valid), true.B, Mux(output_valid, false.B, tmp_1))
	lv2_AES_valid 			:= RegNext(next_lv2_AES_valid)
	tmp_1 					:= RegNext(next_tmp_1)

	// Two DECs and one ENC
  aes_invcipher_op1.io.input_text         	:= Cat(ciph_op1_val, ciph_op1_hash)
  aes_invcipher_op1.io.input_roundKeys   		:= key
  aes_invcipher_op1.io.input_valid       		:= lv2_AES_valid // && (!all_match)
	aes_invcipher_op2.io.input_text        		:= Cat(ciph_op2_val, ciph_op2_hash)
	aes_invcipher_op2.io.input_roundKeys  		:= key
	aes_invcipher_op2.io.input_valid      		:= lv2_AES_valid // && (!all_match)
	aes_cipher_for_hash_C.io.input_text 		:= connected_reversed_plaintext_buffer.asUInt
	aes_cipher_for_hash_C.io.input_valid 		:= lv2_AES_valid
	aes_cipher_for_hash_C.io.input_roundKeys 	:= key

	val n_stage_valid 	= Wire(Bool())
	n_stage_valid 		:= lv1ok_buffer // || all_match 
    // CONFUSED: function of n_stage_valid - Yishen Zhou

    // ----------buf_lv2----------
	// val lv2_inst_buffer                     = RegEnable(inst_buffer, aes_invcipher_op1.io.output_valid) // [inst]
	val lv2_op1_buffer                      = RegEnable(op1_buffer, aes_invcipher_op1.io.output_valid) // [hsh_A][Ciph_A]
	val lv2_op2_buffer                      = RegEnable(op2_buffer, aes_invcipher_op1.io.output_valid) // [hsh_B][Ciph_B]
	val hash_C_original_buffer 				= RegEnable(Cat(aes_cipher_for_hash_C.io.output_text), aes_cipher_for_hash_C.io.output_valid)
	val hash_C_original_buffer_valid 		= RegInit(false.B)
    val decrypted_op1_val_buffer	        = RegEnable(aes_invcipher_op1.io.output_text(255,128), aes_invcipher_op1.io.output_valid) // [muNdR][A_nialp]
    val decrypted_op1_val_buffer_valid      = RegInit(false.B)
    val decrypted_op1_hash_buffer	        = RegEnable(aes_invcipher_op1.io.output_text(127,0), aes_invcipher_op1.io.output_valid) // ['tsni][Y_hsh][X_hsh]
	val decrypted_op1_hash_buffer_valid     = RegInit(false.B)
    val decrypted_op2_val_buffer	        = RegEnable(aes_invcipher_op2.io.output_text(255,128), aes_invcipher_op2.io.output_valid) // [muNdR][B_nialp]
	val decrypted_op2_val_buffer_valid      = RegInit(false.B)
    val decrypted_op2_hash_buffer	        = RegEnable(aes_invcipher_op2.io.output_text(127,0), aes_invcipher_op2.io.output_valid) // [''tsni][Q_hsh][P_hsh]
    val decrypted_op2_hash_buffer_valid     = RegInit(false.B) 
	// ----------buf_lv2----------

	val lv3_AES_valid       = RegInit(false.B) // local reg, only components between lv2 and lv3 need it
	val tmp_2 				= RegInit(false.B)

    // Original Hash_C valid logic
    val next_hash_C_original_buffer_valid 	= Wire(Bool())
    next_hash_C_original_buffer_valid       := Mux(aes_cipher_for_hash_C.io.output_valid, true.B, Mux(output_valid, false.B, hash_C_original_buffer_valid))
	hash_C_original_buffer_valid            := RegNext(next_hash_C_original_buffer_valid)

    // Decrypted opX val/hash buffer valid logic
    val next_decrypted_op1_val_buffer_valid     = Wire(Bool())
    val next_decrypted_op2_val_buffer_valid     = Wire(Bool())
    next_decrypted_op1_val_buffer_valid         := Mux(aes_invcipher_op1.io.output_valid, true.B, Mux(output_valid, false.B, decrypted_op1_val_buffer_valid))
    next_decrypted_op2_val_buffer_valid         := Mux(aes_invcipher_op1.io.output_valid, true.B, Mux(output_valid, false.B, decrypted_op2_val_buffer_valid))
	decrypted_op1_val_buffer_valid              := RegNext(next_decrypted_op1_val_buffer_valid)
	decrypted_op2_val_buffer_valid              := RegNext(next_decrypted_op2_val_buffer_valid)
    val next_decrypted_op1_hash_buffer_valid 	= Wire(Bool())
    val next_decrypted_op2_hash_buffer_valid 	= Wire(Bool())
    next_decrypted_op1_hash_buffer_valid        := Mux(aes_invcipher_op2.io.output_valid, true.B, Mux(output_valid, false.B, decrypted_op1_hash_buffer_valid))
    next_decrypted_op2_hash_buffer_valid        := Mux(aes_invcipher_op2.io.output_valid, true.B, Mux(output_valid, false.B, decrypted_op2_hash_buffer_valid))
	decrypted_op1_hash_buffer_valid             := RegNext(next_decrypted_op1_hash_buffer_valid)
	decrypted_op2_hash_buffer_valid             := RegNext(next_decrypted_op2_hash_buffer_valid)

	// lv2ok_buffer logic
	val next_lv2ok_buffer 	= Wire(Bool())
	val lv2_bypass = lv1ok_buffer && is_enc_inst
	next_lv2ok_buffer     	:= Mux(lv2_bypass || (aes_invcipher_op1.io.output_valid && aes_invcipher_op2.io.output_valid && aes_cipher_for_hash_C.io.output_valid), true.B, Mux(output_valid, false.B, lv2ok_buffer))
	lv2ok_buffer 			:= RegNext(next_lv2ok_buffer)

	// lv3_AES_valid logic
	// Set low one cycle after being set high
	val next_lv3_AES_valid  = Wire(Bool())
	val next_tmp_2 			= Wire(Bool())
	next_lv3_AES_valid 		:= Mux((lv2ok_buffer && !tmp_2), true.B, false.B)
	next_tmp_2 				:= Mux((lv2ok_buffer && !lv3_AES_valid), true.B, Mux(output_valid, false.B, tmp_2))
	lv3_AES_valid 			:= RegNext(next_lv3_AES_valid)
	tmp_2 					:= RegNext(next_tmp_2)

	// Level_2 buffer debug
	when(lv2ok_buffer && !lv3ok_buffer && !lv4ok_buffer) {
		printf("\tconnected_reversed_plaintext_buffer: ")
		for(i <- 0 until 16) {
			printf("%x", connected_reversed_plaintext_buffer(i))
		}
		printf("\n")
		printf("\thash_C_original_buffer: %x\n", hash_C_original_buffer)
		// printf("\tciph_op1_calc: %x\n", ciph_op1_calc)
		// printf("\tciph_op1_comp: %x\n", ciph_op1_comp)
		// printf("\tciph_op2_calc: %x\n", ciph_op2_calc)
		// printf("\tciph_op2_comp: %x\n", ciph_op2_comp)
		printf("\tdecrypted_op1_val_buffer: %x\n", Cat(decrypted_op1_val_buffer))
		printf("\tdecrypted_op1_hash_buffer: ")
		for(i <- 0 until 16) {
			printf("%x", decrypted_op1_hash_buffer(i))
		}
		printf("\n")
		printf("\tdecrypted_op2_val_buffer: ")
		for(i <- 0 until 16) {
			printf("%x", decrypted_op2_val_buffer(i))
		}
		printf("\n")
		printf("\tdecrypted_op2_hash_buffer: ")
		for(i <- 0 until 16) {
			printf("%x", decrypted_op2_hash_buffer(i))
		}
		printf("\n")
		printf("\tlv2ok_buffer: %x\n", lv2ok_buffer);
	}

	// Level_3 buffer debug
	printf("[Stage: Level_2 Buffer -> Level_3 Buffer]\n")
    
	// Reverse the byte order of decrypted plaintext so we can convert them into uint with Chisel infrastructure.
    // Feed the decrypted values to the seoperation module. Depends on whether the data is encrypted when it comes in.
	// seoperation.io.inst 	:= Mux(all_match && lv1ok_buffer, inst_buffer, mid_inst_buffer)
    seoperation.io.inst         := inst_buffer
    val seOpValid 			    = lv2ok_buffer
	seoperation.io.in_valid 	:= seOpValid // || (all_match && lv1ok_buffer)
	val op1_bit 	            = Cat(decrypted_op1_val_buffer) // [plain_A][RdNum][verID_A]
	val op2_bit 	            = Cat(decrypted_op2_val_buffer) // [plain_B][RdNum][verID_B]
	val op1_plaintext_64		= Mux(is_enc_var_hash, pub_var_hash_register,
																Mux( is_enc_var || is_enc_const,op1_buffer(255,192) ,op1_bit(127, 64))) // [plain_A]
	val op2_plaintext_64		= op2_bit(127, 64) // [plain_B]
	// seoperation.io.op1_input := Mux(all_match && lv1ok_buffer, op1_val, Mux(mid_inst_buffer(7,5) === 5.U(3.W), Cat(aes_invcipher_op1.io.output_op1), op1_asUInt)) // FIXME: input for ENC is aes_invcipher_op1.io.output_op1 ? 
	// seoperation.io.op2_input := Mux(all_match && lv1ok_buffer, op2_val, Mux(mid_inst_buffer(7,5) === 5.U(3.W), Cat(aes_invcipher_op1.io.output_op2), op2_asUInt))
  seoperation.io.op1_input    := op1_plaintext_64 // Currently hardcoded (TEMP)
	seoperation.io.op2_input    := op2_plaintext_64 // Currently hardcoded (TEMP)


	// Compute version_id
	val opA_pub_priv = op1_bit(16)
	val opB_pub_priv = op2_bit(16)

	VID_0.io.pub_priv_opA 	:= Mux(is_enc_inst, true.B,  opA_pub_priv)
	VID_0.io.pub_priv_opB 	:= Mux(is_enc_inst, true.B,  opB_pub_priv)
	VID_0.io.version_id_opA := op1_bit(15, 0)
	VID_0.io.version_id_opB := op2_bit(15, 0)
	VID_0.io.valid_in 		:= lv2ok_buffer
	
	val verID_C = RegEnable(VID_0.io.version_id_out, VID_0.io.valid_out)
	val verID_C_valid = RegInit(false.B)
	val next_verID_C_valid  = Wire(Bool())
	next_verID_C_valid 		:= Mux(VID_0.io.valid_out, true.B, Mux(output_valid, false.B, verID_C_valid))
	verID_C_valid 			:= RegNext(next_verID_C_valid)

	// "Public & Private" generate
	val pub_prv_bit = RegEnable(VID_0.io.pub_priv_out, VID_0.io.valid_out)
	
	// Once we receive the result from the seoperation, we pad the result with RNG and latch them first.
	// Note that ALU may need 3 to 4 clock cycles (after seOpValid being set high) to calculate the result
	val bit47_randnum = PRNG(new MaxPeriodFibonacciLFSR(47, Some(scala.math.BigInt(47, scala.util.Random))))

	val non_enc_padded_result = Cat(seoperation.io.result, bit47_randnum, pub_prv_bit, verID_C, lv2_op1_buffer(315, 256), lv2_op2_buffer(315, 256), inst_buffer) // [Plain_C][RdNum][hsh_A][hsh_B][inst]
  val enc_datahash = Mux(is_enc_var, seoperation.io.result(59,0), PUB_VAR_HASH_LFSR(59,0) )
	val enc_padded_result = Cat(seoperation.io.result, bit47_randnum, pub_prv_bit, verID_C, enc_datahash, 0.U(60.W), inst_buffer) 
	val padded_result = Mux(is_enc_inst, enc_padded_result, non_enc_padded_result)
	// Two ENCs: Reconstruct the hash
	aes_cipher_for_op1.io.input_text 		:= decrypted_op1_hash_buffer
	aes_cipher_for_op1.io.input_valid 		:= lv3_AES_valid
	aes_cipher_for_op1.io.input_roundKeys 	:= key
	aes_cipher_for_op2.io.input_text 		:= decrypted_op2_hash_buffer
	aes_cipher_for_op2.io.input_valid 		:= lv3_AES_valid
	aes_cipher_for_op2.io.input_roundKeys 	:= key

    // ----------buf_lv3----------
	val result_buffer 					= RegEnable(padded_result, seoperation.io.out_valid && verID_C_valid)
	val result_valid_buffer 			= RegInit(false.B)
	// val result_plaintext_buffer = RegInit(0.U(64.W)) // cache ptr
	val hash_C_buffer_valid 			= RegInit(false.B)
	val hash_C_buffer 					= RegEnable( Mux(is_enc_inst, enc_datahash , hash_C_original_buffer(125, 66)), hash_C_buffer_valid)
	val op1_rehash_result_buffer_valid 	= RegInit(false.B)
	val op1_rehash_result_buffer 		= RegEnable(aes_cipher_for_op1.io.output_text, aes_cipher_for_op1.io.output_valid)
	val op2_rehash_result_buffer_valid 	= RegInit(false.B)
	val op2_rehash_result_buffer 		= RegEnable(aes_cipher_for_op2.io.output_text, aes_cipher_for_op2.io.output_valid)
	// ----------buf_lv3----------

	// when(seOpValid) {
	// 	result_plaintext_buffer := seoperation.io.result
	// }

	// Compare valid logic
	val next_op1_rehash_result_buffer_valid 	= Wire(Bool())
	val next_op2_rehash_result_buffer_valid 	= Wire(Bool())
	next_op1_rehash_result_buffer_valid 		:= Mux(aes_cipher_for_op1.io.output_valid, true.B, Mux(output_valid, false.B, op1_rehash_result_buffer_valid))
	next_op2_rehash_result_buffer_valid 		:= Mux(aes_cipher_for_op2.io.output_valid, true.B, Mux(output_valid, false.B, op2_rehash_result_buffer_valid))
	op1_rehash_result_buffer_valid 				:= RegNext(next_op1_rehash_result_buffer_valid)
	op2_rehash_result_buffer_valid 				:= RegNext(next_op2_rehash_result_buffer_valid)

	// hash_C valid buffer logic
	val next_hash_C_buffer_valid 	= Wire(Bool())
	next_hash_C_buffer_valid       := Mux(hash_C_original_buffer_valid, true.B, Mux(output_valid, false.B, hash_C_buffer_valid))
	hash_C_buffer_valid            := RegNext(next_hash_C_buffer_valid)

	// result valid buffer logic
	val n_result_valid_buffer = Wire(Bool())
	n_result_valid_buffer := Mux(seOpValid, true.B, Mux(output_valid, false.B, result_valid_buffer))
	result_valid_buffer := RegNext(n_result_valid_buffer)

	// lv3ok_buffer logic
	val next_lv3ok_buffer 	= Wire(Bool())
	next_lv3ok_buffer     	:= Mux((result_valid_buffer && hash_C_buffer_valid && op1_rehash_result_buffer_valid && op2_rehash_result_buffer_valid), true.B, Mux(output_valid, false.B, lv3ok_buffer))
	lv3ok_buffer 			:= RegNext(next_lv3ok_buffer) 

	// Level_3 buffer debug
	when(lv3ok_buffer && !lv4ok_buffer) {
		printf("\tresult_buffer: %x %x (<- RdNum, ignore) %x\n", result_buffer(255, 192), result_buffer(191, 128), result_buffer(127, 0))
		printf("\thash_C_buffer: %x\n", hash_C_buffer)
		printf("\top1_bit: %x\n", op1_bit)
		printf("\top2_bit: %x\n", op2_bit)
		printf("\tseoperation.io.op1_input: %x\n", seoperation.io.op1_input)
		printf("\tseoperation.io.op2_input: %x\n", seoperation.io.op2_input)
		printf("\tSE Computation Result: %x\n", Cat(seoperation.io.result))
		printf("\tRdNum: %x\n", Cat(bit47_randnum))
		printf("\top1_rehash_result_buffer: %x\n", Cat(op1_rehash_result_buffer));
		printf("\top2_rehash_result_buffer: %x\n", Cat(op2_rehash_result_buffer));
		printf("\tlv3ok_buffer: %x\n", lv3ok_buffer);
	}

	// Level_4 buffer debug
	printf("[Stage: Level_3 Buffer -> Level_4 Buffer]\n")

	// Connect result_buffer: [Plain_C][RdNum][hsh_A][hsh_B][inst] to the cipher
	// Reverse the result and feed the plaintexts into the cipher
	val result_buffer_vectorized 	= Wire(Vec(Params.CiphLength, UInt(8.W)))
	result_buffer_vectorized		:= VecInit(Seq.tabulate(Params.CiphLength)(i => result_buffer((i + 1) * 8 - 1, i * 8)))
	val aes_input_reverse_bit 		= Cat(result_buffer_vectorized)
	val plain_out_calc 				= aes_input_reverse_bit(127, 0) // [muNdR][C_nialp]
	val plain_out_comp 				= aes_input_reverse_bit(255, 128) // [tsni][B_hsh][A_hsh]


	val lv4_AES_valid       = RegInit(false.B) // local reg, only components between lv3 and lv4 need it
	val tmp_3 				= RegInit(false.B)

	// lv4_AES_valid logic
	// Set low one cycle after being set high
	val next_lv4_AES_valid  = Wire(Bool())
	val next_tmp_3 			= Wire(Bool())
	next_lv4_AES_valid 		:= Mux((lv3ok_buffer && !tmp_3), true.B, false.B)
	next_tmp_3 				:= Mux((lv3ok_buffer && !lv4_AES_valid), true.B, Mux(output_valid, false.B, tmp_3))
	lv4_AES_valid 			:= RegNext(next_lv4_AES_valid)
	tmp_3 					:= RegNext(next_tmp_3)
	
	// Encrypt the padded result to get the final output
	aes_cipher.io.input_op1			:= plain_out_calc
	aes_cipher.io.input_valid 		:= lv4_AES_valid
	aes_cipher.io.input_roundKeys 	:= key
	aes_cipher.io.input_op2			:= plain_out_comp
	
	// Compare the 59-bit hash
	val op1_rehash_result_bit 	= Cat(op1_rehash_result_buffer)
	val op2_rehash_result_bit 	= Cat(op2_rehash_result_buffer)
	HC_op1.io.hash_orig 		:= lv2_op1_buffer(315, 256)
	HC_op1.io.hash_regenerated 	:= Mux(opA_pub_priv, 	decrypted_op1_hash_buffer,	op1_rehash_result_bit)
	HC_op1.io.valid_in 			:= lv3ok_buffer
	HC_op2.io.hash_orig 		:= lv2_op2_buffer(315, 256)
	HC_op2.io.hash_regenerated 	:= Mux(opB_pub_priv, decrypted_op2_hash_buffer, op2_rehash_result_bit)
	HC_op2.io.valid_in 			:= lv3ok_buffer

	// when(lv4_AES_valid){
	// 	printf("Enc input: %x %x\n", plain_out_calc, plain_out_comp)
	// }
	// when(aes_cipher.io.output_valid){
	// 	printf("Enc output: %x %x\n", aes_cipher.io.output_op1, aes_cipher.io.output_op2)
	// }

	// ----------buf_lv4----------
	val output_buffer_enc_valid			= RegInit(false.B)
	val output_buffer_enc 				= RegEnable(aes_cipher.io.output_text, aes_cipher.io.output_valid)
	val output_buffer 					= RegInit(0.U(316.W))
	val hash_compare_result_op1 		= RegEnable(HC_op1.io.compare_result || (!is_enc_var_hash), HC_op1.io.valid_out) // Test: RegInit(false.B) 
	val hash_compare_result_op1_valid	= RegInit(false.B)
	val hash_compare_result_op2 		= RegEnable(HC_op2.io.compare_result || (!is_enc_var_hash), HC_op2.io.valid_out) // Test: RegInit(false.B) 
	val hash_compare_result_op2_valid	= RegInit(false.B)
	// ----------buf_lv4----------

	// output_buffer_XX_valid logic
	val next_output_buffer_enc_valid   	= Mux(aes_cipher.io.output_valid, true.B, Mux(output_valid, false.B, output_buffer_enc_valid))
	output_buffer_enc_valid 			:= RegNext(next_output_buffer_enc_valid)

	// lv4ok_buffer logic
	val next_lv4ok_buffer 	= Mux((output_buffer_enc_valid && hash_compare_result_op1_valid && hash_compare_result_op2_valid), true.B, Mux(output_valid, false.B, lv4ok_buffer))
	lv4ok_buffer 			:= RegNext(next_lv4ok_buffer)

	when(lv4ok_buffer) {
		output_valid := true.B
	}.elsewhen(io.out.valid && io.out.ready) {
		output_valid := false.B
	}

	// HC module valid logic
	val next_hash_compare_result_op1_valid 	= Wire(Bool())
	val next_hash_compare_result_op2_valid 	= Wire(Bool())
	next_hash_compare_result_op1_valid 		:= Mux(HC_op1.io.valid_out, true.B, Mux(output_valid, false.B, hash_compare_result_op1_valid))
	next_hash_compare_result_op2_valid 		:= Mux(HC_op2.io.valid_out, true.B, Mux(output_valid, false.B, hash_compare_result_op2_valid))
	hash_compare_result_op1_valid 			:= RegNext(next_hash_compare_result_op1_valid)
	hash_compare_result_op2_valid 			:= RegNext(next_hash_compare_result_op2_valid)



	// Connect the output side
	// Output set 0 when any compare result is false
	val output_connect 		= Cat(hash_C_buffer, output_buffer_enc)
	val compare_hash_total 	= Wire(Bool())
	compare_hash_total 		:= hash_compare_result_op1 && hash_compare_result_op1_valid && hash_compare_result_op2 && hash_compare_result_op2_valid
	when(compare_hash_total) {
		output_buffer := output_connect
	}.otherwise {
		output_buffer := 0.U
	}

	// Level_4 buffer debug
	when(lv4ok_buffer) {
		printf("\taes_input_reverse_bit: %x\n", aes_input_reverse_bit);
		// printf("\tplain_out_calc_vec: %x\n", Cat(plain_out_calc_vec));
		// printf("\toutput_buffer_lo: %x\n", Cat(output_buffer_lo));
		// printf("\tplain_out_comp_vec: %x\n", Cat(plain_out_comp_vec));
		// printf("\toutput_buffer_up: %x\n", Cat(output_buffer_up));
		printf("\tcompare_hash_total: %x\n", compare_hash_total);
		printf("\toutput_connect: %x\n", output_connect);
		printf("\toutput_buffer: %x\n", output_buffer);
		printf("\thash_compare_result_op1: %x\n", hash_compare_result_op1)
		printf("\thash_compare_result_op2: %x\n", hash_compare_result_op2)
		printf("\tlv4ok_buffer: %x\n", lv4ok_buffer);
	}

	io.out.valid 			:= output_valid
	// io.out.ready CANNOT be hardcoded here! 
	io.out.result 			:= output_buffer
	io.out.op1_hash_compare := hash_compare_result_op1
	io.out.op2_hash_compare := hash_compare_result_op2

	when(output_valid) {
		// printf("ptr:%x\n",ptr)
		when(ptr === 31.U) {
			ptr := 0.U
		}.otherwise {
			ptr := ptr + 1.U
		}
	}
	when(reset.asBool){
		key := expandedKey128
		// for(i <- 0 until 32){
		// 	ciphers(i) := 0.U
		// 	plaintexts(i) := 0.U
		// 	cache_valid(i) := false.B
		// }
	// }.otherwise{	
	// 	when(io.out.valid){
	// 		ciphers(ptr) := output_buffer
	// 		plaintexts(ptr) := result_plaintext_buffer
	// 		cache_valid(ptr) := true.B
	// 	}
	}

}
