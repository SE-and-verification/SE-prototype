package se

import chisel3._
import chisel3.util._
import chisel3.experimental._


class RSAEncryptIO extends Bundle{
	val input_valid = Input(Bool())
    val n = Input(UInt(128.W))
    val e = Input(UInt(128.W))
	val input_text= Input(Vec(16, UInt(8.W))) // plaintext, ciphertext, roundKey
	val output_text = Output(Vec(16, UInt(8.W))) // ciphertext or plaintext

	val output_valid = Output(Bool())
}

class RSAEncrypt extends Module {
    val io = IO(new RSAEncryptIO)
    val rsa_enc = Module(new RSAEncDec)

    rsa_enc.io.e := io.e
    rsa_enc.io.n := io.n
    rsa_enc.io.valid := io.input_valid

    rsa_enc.io.m := io.input_text.asTypeOf(rsa_enc.io.m)
    io.output_text := rsa_enc.io.c.asTypeOf(io.output_text)
    io.output_valid := rsa_enc.io.ready
}