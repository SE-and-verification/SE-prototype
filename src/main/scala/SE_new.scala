package se

import chisel3._
import chisel3.util._
import aes._
import se.seoperation._
import chisel3.util.random._

class SEInput(val canChangeKey: Boolean) extends Bundle {
	val inst            = Input(UInt(8.W)) // Instruction encoding is defined in SEOperation/Instructions.scala
	val op1             = Input(UInt(316.W)) // 60bit hash + 256 bit ciphertext
	val op2             = Input(UInt(316.W))
	val valid           = Input(Bool())

	val ready           = Output(Bool())

	val changeKey_en    = if(canChangeKey) Some(Input(Bool())) else None
	val newKey          = if(canChangeKey) Some(Input(Vec(11, Vec(16, UInt(8.W))))) else None
}


class SEOutput extends Bundle{
    val ready 				= Input(Bool())

	val result 				= Output(UInt(316.W))
	val valid 				= Output(Bool())
	val op1_compare 		= Output(Bool())
	val op2_compare 		= Output(Bool())
	val op1_compare_valid 	= Output(Bool())
	val op2_compare_valid 	= Output(Bool())
}

class SEIO(val canChangeKey: Boolean) extends Bundle {
	val in  = new SEInput(canChangeKey)
	val out = new SEOutput
}

class Plaintext_Reverse_Connector extends Module {
	// Connect 2 60-bit hash plaintext and 1 8-bit inst together, and then reverse it
	val io = IO(new Bundle {
		val op1 	= Input(UInt(316.W))
		val op2 	= Input(UInt(316.W))
		val inst 	= Input(UInt(8.W))
		val out     = Output(Vec(Params.StateLength, UInt(8.W)))
	})
	val op1_hash 		= io.op1(315, 256)
	val op2_hash 		= io.op2(315, 256)
	val connect_result 	= Cat(op1_hash, op2_hash, io.inst) // Structure: [op1_hsh][op2_hsh][inst]
	// Reverse the byte order so we can convert them into uint with Chisel infrastructure.
	val connect_result_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	// Structure: [op1_hsh][op2_hsh][inst] -> [tsni][hsh_2po][hsh_1po]
    for(i <- 0 until Params.StateLength) {
		connect_result_reverse(i) := connect_result(Params.new_integrity_length - i - 1)
	}
	// Connect the module output
	io.out := connect_result_reverse
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
    // Firsthlf: RdNum + Plaintext (Lower 128 bits of Ciph_X) -> ALU part
	// Secondhlf: Inst + Hash * 2 (Upper 128 bits of Ciph_X) -> Comparison part
    val aes_invcipher_firsthlf  = Module(new AESDecrypt(rolled))
	val aes_invcipher_secondhlf = Module(new AESDecrypt(rolled))

    // Five ENCryptors:
    // Firsthlf: RdNum + Plaintext (Lower 128 bits of Ciph_X) -> ALU part
    // Secondhlf: Inst + Hash * 2 (Upper 128 bits of Ciph_X) -> Comparison part
    // Hash_C: Generate Hash_C_original
    // For_opX: Rehash and comparison
	val aes_cipher_firsthlf     = Module(new AESEncrypt(rolled))
	val aes_cipher_secondhlf    = Module(new AESEncrypt(rolled))
	val aes_cipher_for_hash_C 	= Module(new AESEncrypt(rolled))
	val aes_cipher_for_op1 		= Module(new AESEncrypt(rolled))
	val aes_cipher_for_op2 		= Module(new AESEncrypt(rolled))

	// TEMP: cache is temporarily disabled
	
    // PRC: Plaintext Reverse Connector
    val PRC_0 = Module(new Plaintext_Reverse_Connector)

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
 
	// ----------buf_lv1----------
	val inst_buffer 	= RegEnable(io.in.inst, io.in.valid)
	val op1_buffer 		= RegEnable(io.in.op1, io.in.valid) // [hsh_A][Ciph_A]
	val op2_buffer 		= RegEnable(io.in.op2, io.in.valid) // [hsh_B][Ciph_B]
	val lv1ok_buffer 	= Reg(Bool()) // High when (??)
	// ----------buf_lv1----------

	val ready_for_input = RegInit(true.B)
	val n_stage_valid   = Wire(Bool())
	io.in.ready         := ready_for_input

    when(io.in.valid && io.in.ready) {
		lv1ok_buffer := true.B
	}.elsewhen(n_stage_valid) {
		output_valid := false.B
	}
    
    when(io.in.valid && io.in.ready){
		ready_for_input := false.B
	}.elsewhen(io.out.valid && io.out.ready){
		ready_for_input := true.B
	}

    // Connect reg input and reg output
    PRC_0.io.op1 	                        := op1_buffer 
	PRC_0.io.op2 	                        := op2_buffer
	PRC_0.io.inst 	                        := inst_buffer
    val connected_reversed_plaintext_buffer = Wire(Vec(Params.StateLength, UInt(8.W)))
	connected_reversed_plaintext_buffer     := PRC_0.io.out

    // Encrypt the connected result
	aes_cipher_for_hash_C.io.input_text 		:= connected_reversed_plaintext_buffer
	aes_cipher_for_hash_C.io.input_valid 		:= io.in.valid
	aes_cipher_for_hash_C.io.input_roundKeys 	:= key

    // Feed the ciphertexts into the invcipher
	val ciph_op1                                = op1_buffer(255,0) // [Ciph_A]
	val ciph_op2                                = op2_buffer(255,0) // [Ciph_B]
    aes_invcipher_firsthlf.io.input_op1         := ciph_op1(127, 0).asTypeOf(aes_invcipher_firsthlf.io.input_op1)
	aes_invcipher_firsthlf.io.input_op2         := ciph_op2(127, 0).asTypeOf(aes_invcipher_firsthlf.io.input_op2)
    aes_invcipher_firsthlf.io.input_roundKeys   := key
    aes_invcipher_firsthlf.io.input_valid       := lv1ok_buffer // && (!all_match)
	aes_invcipher_secondhlf.io.input_op1        := ciph_op1(255, 128).asTypeOf(aes_invcipher_secondhlf.io.input_op1)
	aes_invcipher_secondhlf.io.input_op2        := ciph_op2(255, 128).asTypeOf(aes_invcipher_secondhlf.io.input_op2)
	aes_invcipher_secondhlf.io.input_roundKeys  := key
	aes_invcipher_secondhlf.io.input_valid      := lv1ok_buffer // && (!all_match)

	n_stage_valid := lv1ok_buffer // || all_match 
    // CONFUSED: function of n_stage_valid - Yishen Zhou

    // ----------buf_lv2----------
	val lv2_inst_buffer                     = RegEnable(inst_buffer, aes_invcipher_firsthlf.io.input_valid) // [inst]
	val lv2_op1_buffer                      = RegEnable(op1_buffer, aes_invcipher_firsthlf.io.input_valid) // [hsh_A][Ciph_A]
	val lv2_op2_buffer                      = RegEnable(op2_buffer, aes_invcipher_firsthlf.io.input_valid) // [hsh_B][Ciph_B]
	val hash_C_original_buffer 				= RegEnable(aes_cipher_for_hash_C.io.output_text.do_asUInt, aes_cipher_for_hash_C.io.output_valid)
	val hash_C_original_buffer_valid 		= RegInit(false.B)
    val decrypted_op1_val_buffer	        = RegEnable(aes_invcipher_firsthlf.io.output_op1, aes_invcipher_firsthlf.io.output_valid) // [muNdR][A_nialp]
    val decrypted_op1_val_buffer_valid      = RegInit(false.B)
    val decrypted_op1_hash_buffer	        = RegEnable(aes_invcipher_secondhlf.io.output_op1, aes_invcipher_secondhlf.io.output_valid) // ['tsni][Y_hsh][X_hsh]
	val decrypted_op1_hash_buffer_valid     = RegInit(false.B)
    val decrypted_op2_val_buffer	        = RegEnable(aes_invcipher_firsthlf.io.output_op2, aes_invcipher_firsthlf.io.output_valid) // [muNdR][B_nialp]
	val decrypted_op2_val_buffer_valid      = RegInit(false.B)
    val decrypted_op2_hash_buffer	        = RegEnable(aes_invcipher_secondhlf.io.output_op2, aes_invcipher_secondhlf.io.output_valid) // [''tsni][Q_hsh][P_hsh]
    val decrypted_op2_hash_buffer_valid     = RegInit(false.B) 
	// ----------buf_lv2----------

    // Original Hash_C valid logic
    val next_hash_C_original_buffer_valid 	= Wire(Bool())
    next_hash_C_original_buffer_valid       := Mux(aes_cipher_for_hash_C.io.output_valid, true.B, Mux(output_valid, false.B, hash_C_original_buffer_valid))
	hash_C_original_buffer_valid            := RegNext(next_hash_C_original_buffer_valid)

    // Decrypted opX val/hash buffer valid logic
    val next_decrypted_op1_val_buffer_valid     = Wire(Bool())
    val next_decrypted_op2_val_buffer_valid     = Wire(Bool())
    next_decrypted_op1_val_buffer_valid         := Mux(aes_invcipher_firsthlf.io.output_valid, true.B, Mux(output_valid, false.B, decrypted_op1_val_buffer_valid))
    next_decrypted_op2_val_buffer_valid         := Mux(aes_invcipher_firsthlf.io.output_valid, true.B, Mux(output_valid, false.B, decrypted_op2_val_buffer_valid))
	decrypted_op1_val_buffer_valid              := RegNext(next_decrypted_op1_val_buffer_valid)
	decrypted_op2_val_buffer_valid              := RegNext(next_decrypted_op2_val_buffer_valid)
    val next_decrypted_op1_hash_buffer_valid 	= Wire(Bool())
    val next_decrypted_op2_hash_buffer_valid 	= Wire(Bool())
    next_decrypted_op1_hash_buffer_valid        := Mux(aes_invcipher_secondhlf.io.output_valid, true.B, Mux(output_valid, false.B, decrypted_op1_hash_buffer_valid))
    next_decrypted_op2_hash_buffer_valid        := Mux(aes_invcipher_secondhlf.io.output_valid, true.B, Mux(output_valid, false.B, decrypted_op2_hash_buffer_valid))
	decrypted_op1_hash_buffer_valid             := RegNext(next_decrypted_op1_hash_buffer_valid)
	decrypted_op2_hash_buffer_valid             := RegNext(next_decrypted_op2_hash_buffer_valid)

    // Reverse the byte order of decrypted plaintext so we can convert them into uint with Chisel infrastructure.
    // Structure: [][]
	val op1_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	val op2_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	for(i <- 0 until Params.StateLength) {
		op1_reverse(i) := aes_invcipher_firsthlf.io.output_op1(Params.StateLength - i - 1)
		op2_reverse(i) := aes_invcipher_firsthlf.io.output_op2(Params.StateLength - i - 1)
	}




    // buf_lv3
	
	// buf_lv3
    val n_result_valid_buffer   = Wire(Bool())

}