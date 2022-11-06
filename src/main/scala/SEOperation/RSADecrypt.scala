package se

import chisel3._
import chisel3.util._
import chisel3.experimental._


class RSADecryptIO extends Bundle{
	val input_valid = Input(Bool())
    val p = Input(UInt(64.W))
    val q = Input(UInt(64.W))
	val input_op1= Input(Vec(16, UInt(8.W))) // plaintext, ciphertext, roundKey
	val input_op2= Input(Vec(16, UInt(8.W))) // plaintext, ciphertext, roundKey
	val input_cond= Input(Vec(16, UInt(8.W))) // plaintext, ciphertext, roundKey

    val output_op1 = Output(Vec(16, UInt(8.W))) // ciphertext or plaintext
    val output_op2 = Output(Vec(16, UInt(8.W))) // ciphertext or plaintext
    val output_cond = Output(Vec(16, UInt(8.W))) // ciphertext or plaintext

	val output_valid = Output(Bool())
}

class RSADecrypt extends Module {
    val io = IO(new RSADecryptIO)
    val rsa_dec1 = Module(new control)
    val rsa_dec2 = Module(new control)
    val rsa_dec3 = Module(new control)

    rsa_dec1.io.p := io.p
    rsa_dec1.io.q := io.q
    rsa_dec1.io.clk := Module.clock.asBool
    rsa_dec1.io.reset := Module.reset.asBool
    rsa_dec1.io.reset1 := Module.reset.asBool || io.input_valid
    rsa_dec1.io.encrypt_decrypt := false.B
    rsa_dec1.io.msg_in := io.input_op1.asTypeOf(rsa_dec1.io.msg_in)
    io.output_op1 := rsa_dec1.io.msg_out.asTypeOf(io.output_op1)
    io.output_valid := rsa_dec1.io.mod_exp_finish

    rsa_dec2.io.p := io.p
    rsa_dec2.io.q := io.q
    rsa_dec2.io.clk := Module.clock.asBool
    rsa_dec2.io.reset := Module.reset.asBool
    rsa_dec2.io.reset1 := Module.reset.asBool || io.input_valid
    rsa_dec2.io.encrypt_decrypt := false.B
    rsa_dec2.io.msg_in := io.input_op2.asTypeOf(rsa_dec2.io.msg_in)
    io.output_op2 := rsa_dec2.io.msg_out.asTypeOf(io.output_op2)

    rsa_dec3.io.p := io.p
    rsa_dec3.io.q := io.q
    rsa_dec3.io.clk := Module.clock.asBool
    rsa_dec3.io.reset := Module.reset.asBool
    rsa_dec3.io.reset1 := Module.reset.asBool || io.input_valid
    rsa_dec3.io.encrypt_decrypt := false.B
    rsa_dec3.io.msg_in := io.input_cond.asTypeOf(rsa_dec3.io.msg_in)
    io.output_cond := rsa_dec3.io.msg_out.asTypeOf(io.output_cond)
}