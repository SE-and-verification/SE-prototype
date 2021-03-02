package se

import chisel3._
import chisel3.simplechisel._
import chisel3.util._
import chisel3.simplechisel.util._
import aes._
import se.seoperation._

class SEInput extends Bundle{
	val inst = UInt(8.W)

	val op1 = UInt(128.W)
	val op1_encrypted = Bool()

	val op2 = UInt(128.W)
	val op2_encrypted = Bool()

	val cond = UInt(128.W)
}

class SEOutput extends Bundle{
	val result = UInt(128.W)
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
	val cond_buffer = RegEnable( in.cond, ctrl.in.valid)

	val valid_buffer = Reg(Bool())
	val key = ExpandedKey.expandedKey128
	valid_buffer := Mux(ctrl.in.valid, true.B, Mux(seoperation.ctrl.in.valid, false.B, valid_buffer))

	aes_invcipher.io.input_op1.connectFromBits(Mux(valid_buffer,op1_buffer,in.op1))
	aes_invcipher.io.input_op2.connectFromBits(Mux(valid_buffer,op2_buffer,in.op2))
	aes_invcipher.io.input_cond.connectFromBits(Mux(valid_buffer,cond_buffer,in.cond))
	aes_invcipher.io.input_roundKeys := key
	aes_invcipher.io.input_valid := ctrl.in.valid

	val op1_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	val op2_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	val cond_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	for(i <- 0 until Params.StateLength){
		op1_reverse(i) := aes_invcipher.io.output_op1(Params.StateLength-i-1)
		op2_reverse(i) := aes_invcipher.io.output_op2(Params.StateLength-i-1)
		cond_reverse(i) := aes_invcipher.io.output_cond(Params.StateLength-i-1)
	}
	seoperation.in.inst := inst_buffer.do_asUInt
	seoperation.in.op1_input := Mux(op1_encrypted_buffer, op1_reverse.do_asUInt, op1_buffer.do_asUInt)
	seoperation.in.op2_input := Mux(op2_encrypted_buffer, op2_reverse.do_asUInt, op2_buffer.do_asUInt)
	seoperation.in.cond_input := cond_reverse.do_asUInt

	seoperation.ctrl.in.valid := aes_invcipher.io.output_valid
	seoperation.ctrl.out.ready := ctrl.out.ready
	// when(ctrl.in.valid && ctrl.in.ready){printf("SE Input:\n\toperand1:%x\n\toperand2:%x\n\tcond:%x\n",in.op1, in.op2, in.cond)}
	// when(seoperation.ctrl.in.valid && seoperation.ctrl.in.ready){printf("SEOp Input:\n\top1_encrypted_buffer:%x\n\top2_encrypted_buffer:%x\n",op1_encrypted_buffer, op2_encrypted_buffer)}
	// when(seoperation.ctrl.out.valid){printf("result:%x\n",seoperation.out.raw_result)}

	val result_valid_buffer = Reg(Bool())
	result_valid_buffer := Mux(seoperation.ctrl.out.valid, true.B, Mux(ctrl.out.valid, false.B, result_valid_buffer))
	val result_buffer = RegEnable( seoperation.out.raw_result, seoperation.ctrl.out.valid)

	ctrl.in.ready := !valid_buffer
	aes_cipher.io.input_text.connectFromBits((Cat(Mux(result_valid_buffer,result_buffer,seoperation.out.raw_result), 0.U(64.W))))
	aes_cipher.io.input_valid := seoperation.ctrl.out.valid
	aes_cipher.io.input_roundKeys := key
	ctrl.out.valid := aes_cipher.io.output_valid
	out.result := aes_cipher.io.output_text.do_asUInt

	InfoAnnotator.info(in.op1, "SensitiveInput")
	InfoAnnotator.info(in.op2, "SensitiveInput")
	InfoAnnotator.info(in.cond, "SensitiveInput")

	InfoAnnotator.info(aes_invcipher, "Decryption")
	InfoAnnotator.info(aes_cipher, "Encryption")
	InfoAnnotator.info(seoperation, "Private")
	InfoAnnotator.info(out.result, "SensitiveOutput")
	InfoAnnotator.info(key, "KeyStore")


}