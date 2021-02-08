package se

import chisel3._
import chisel3.simplechisel._
import chisel3.util._
import chisel3.simplechisel.util._
import aes._
import se.seoperation._

class SEInput extends Bundle{
	val inst = UInt(8.W)

	val op1 = Vec(Params.StateLength, UInt(8.W))
	val op1_encrypted = Bool()

	val op2 = Vec(Params.StateLength, UInt(8.W))
	val op2_encrypted = Bool()

	val cond = Vec(Params.StateLength, UInt(8.W))
}

class SEOutput extends Bundle{
	val result = Vec(Params.StateLength, UInt(8.W))
}

class SE extends SimpleChiselModuleBase{
	val ctrl = IO(new DecoupledIOCtrl(1,1))
	val in = IO(Input(new SEInput))
	val out = IO(Output(new SEOutput))

	val seoperation = Module(new SEOperation)
	val aes_invcipher = Module(new AESDecrypt)
	val aes_cipher = Module(new AESEncrypt)

	val inst_buffer = RegEnable(in.inst, ctrl.in.valid)
	val op1_buffer = RegEnable(in.op1, ctrl.in.valid)
	val op1_encrypted_buffer = RegEnable(in.op1_encrypted, ctrl.in.valid)
	val op2_buffer = RegEnable( in.op2, ctrl.in.valid)
	val op2_encrypted_buffer = RegEnable(in.op2_encrypted, ctrl.in.valid)

	val cond_buffer = RegEnable(in.cond, ctrl.in.valid)
	val cond_encrypted_buffer = RegEnable(in.inst(7), ctrl.in.valid)

	val valid_buffer = Reg(Bool())
	val key = ExpandedKey.expandedKey128
	valid_buffer := Mux(ctrl.in.valid, true.B, Mux(seoperation.ctrl.in.valid, false.B, valid_buffer))

	aes_invcipher.io.input_op1 := in.op1
	aes_invcipher.io.input_op2 := in.op2
	aes_invcipher.io.input_cond := in.cond
	aes_invcipher.io.input_roundKeys := key
	aes_invcipher.io.input_valid := ctrl.in.valid

	seoperation.in.inst := inst_buffer.do_asUInt
	seoperation.in.op1_input := Mux(op1_encrypted_buffer, aes_invcipher.io.output_op1.do_asUInt, op1_buffer.do_asUInt)
	seoperation.in.op2_input := Mux(op2_encrypted_buffer, aes_invcipher.io.output_op2.do_asUInt, op2_buffer.do_asUInt)
	seoperation.in.cond_input := Mux(cond_encrypted_buffer, aes_invcipher.io.output_cond.do_asUInt, cond_buffer.do_asUInt)

	seoperation.ctrl.in.valid := aes_invcipher.io.output_valid
	seoperation.ctrl.out.ready := ctrl.out.ready
	
	ctrl.in.ready := !valid_buffer
	aes_cipher.io.input_text.connectFromBits(Cat(seoperation.out.raw_result, 0.U(64.W)))
	aes_cipher.io.input_valid := seoperation.ctrl.out.valid
	aes_cipher.io.input_roundKeys := key
	ctrl.out.valid := aes_cipher.io.output_valid
	out.result := aes_cipher.io.output_text

	InfoAnnotator.info(in.op1, "SensitiveInput")
	InfoAnnotator.info(in.op2, "SensitiveInput")
	InfoAnnotator.info(in.cond, "SensitiveInput")

	InfoAnnotator.info(aes_invcipher, "Decryption")
	InfoAnnotator.info(aes_cipher, "Encryption")
	InfoAnnotator.info(seoperation, "Private")
	InfoAnnotator.info(out.result, "SensitiveOutput")
	InfoAnnotator.info(key, "KeyStore")


}