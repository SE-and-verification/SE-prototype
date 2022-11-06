package se

import chisel3._
import chisel3.util._
import chisel3.experimental._


class RSAEncryptIO extends Bundle{
	val input_valid = Input(Bool())
    val p = Input(UInt(64.W))
    val q = Input(UInt(64.W))
	val input_text= Input(Vec(16, UInt(8.W))) // plaintext, ciphertext, roundKey
	val output_text = Output(Vec(16, UInt(8.W))) // ciphertext or plaintext

	val output_valid = Output(Bool())
}

class RSAEncrypt extends Module {
    val io = IO(new RSAEncryptIO)
    val rsa_enc = Module(new control)

    rsa_enc.io.p := io.p
    rsa_enc.io.q := io.q
    rsa_enc.io.clk := Module.clock.asBool
    rsa_enc.io.reset := Module.reset.asBool
    rsa_enc.io.reset1 := Module.reset.asBool || io.input_valid
    rsa_enc.io.encrypt_decrypt := true.B
    rsa_enc.io.msg_in := io.input_text.asTypeOf(rsa_enc.io.msg_in)
    io.output_text := rsa_enc.io.msg_out.asTypeOf(io.output_text)
    io.output_valid := rsa_enc.io.mod_exp_finish
}