package se

import chisel3._
import chisel3.simplechisel._
import chisel3.util._
import chisel3.simplechisel.util._
import aes._

class SEInput extends Bundle{
	val inst = UInt(8.W)

	val op1 = UInt(128.W)
	val op1_encrypted = Bool()

	val op2 = UInt(128.W)
	val op2_encrypted = Bool()

	val cond_operator = UInt(8.W)
	val cond_ref = UInt(128.W)
	val cond_encrypted = Bool()
}

class SEOutput extends Bundle{
	val result = UInt(128.W)
}

class SE extends SimpleChiselModuleBase{
	val ctrl = new ValidIOCtrl
	val in = IO(Input(new SEInput))
	val out = IO(Input(new SEOutput))

	val key = 0.U(128.W)
	val seoperation = Module(new SEOperation)
	val aes_invcipher1 = Module(new InvCipher(4,false))
	val aes_invcipher2 = Module(new InvCipher(4,false))
	val aes_invcipher3 = Module(new InvCipher(4,false))
	val aes_cipher = Module(new Cipher(4,false))

	val inst_buffer = RegEnable(ctrl.in.valid, in.inst)
	val op1_buffer = RegEnable(ctrl.in.valid, in.op1)
	val op1_encrypted_buffer = RegEnable(ctrl.in.valid, in.op1_encrypted)
	val op2_buffer = RegEnable(ctrl.in.valid, in.op2)
	val op2_encrypted_buffer = RegEnable(ctrl.in.valid, in.op2_encrypted)

	val cond_operatord_buffer = RegEnable(ctrl.in.valid, in.cond_operator)
	val cond_ref_buffer = RegEnable(ctrl.in.valid, in.cond_ref)
	val cond_encrypted_buffer = RegEnable(ctrl.in.valid, in.cond_encrypted)

	val valid_buffer = Reg(Bool())
	valid_buffer := Mux(ctrl.in.valid, true.B, Mux(seoperation.ctrl.in.valid, false.B, valid_buffer))

	aes_invcipher1.io.ciphertext := in.op1
	aes_invcipher1.io.roundKey := key
	aes_invcipher1.io.start := op1_encrypted && ctrl.in.valid

	aes_invcipher2.io.ciphertext := in.op2
	aes_invcipher2.io.roundKey := key
	aes_invcipher2.io.start := op2_encrypted && ctrl.in.valid

	aes_invcipher3.io.ciphertext := in.cond_ref
	aes_invcipher3.io.roundKey := key
	aes_invcipher3.io.start := cond_encrypted && ctrl.in.valid

	seoperation.in.inst := inst_buffer
	seoperation.in.cond_operator := cond_op_buffer
	seoperation.in.op1 := Mux(op1_encrypted_buffer, aes_invcipher1.io.state_out_valid, op1_buffer)
	seoperation.in.op2 := Mux(op2_encrypted_buffer, aes_invcipher2.io.state_out_valid, op2_buffer)
	seoperation.in.cond_ref := Mux(cond_encrypted_buffer, aes_invcipher3.io.state_out_valid, cond_ref_buffer)

	seoperation.ctrl.in.valid := valid_buffer 
							&& ( (!op1_encrypted_buffer) || aes_invcipher1.io.state_out_valid)
							&& ( (!op2_encrypted_buffer) || aes_invcipher2.io.state_out_valid)
							&& ( (!cond_encrypted_buffer) || aes_invcipher3.io.state_out_valid)

	aes_cipher.io.plaintext := Cat(seoperation.out.raw_result, 0.U(64.W))
	aes_cipher.io.roundKey := key
	aes_cipher.io.start := seoperation.ctrl.out.valid

	ctrl.out.valid := aes_cipher.io.state_out_valid
	out.result := aes_cipher.io.state_out
}