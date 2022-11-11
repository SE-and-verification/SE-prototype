package se

import chisel3._
import chisel3.util._
import chisel3.experimental._


class RSADecryptIO extends Bundle{
	val input_valid = Input(Bool())
    val n = Input(UInt(128.W))
    val e = Input(UInt(128.W))
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
    val rsa_dec1 = Module(new RSAEncDec)
    val rsa_dec2 = Module(new RSAEncDec)
    val rsa_dec3 = Module(new RSAEncDec)

    rsa_dec1.io.e := io.e
    rsa_dec1.io.n := io.n
    rsa_dec1.io.valid := io.input_valid

    rsa_dec1.io.m := io.input_op1.asTypeOf(rsa_dec1.io.m)
    io.output_op1 := rsa_dec1.io.c.asTypeOf(io.output_op1)
    io.output_valid := rsa_dec1.io.ready

    rsa_dec2.io.e := io.e
    rsa_dec2.io.n := io.n
    rsa_dec2.io.valid := io.input_valid

    rsa_dec2.io.m := io.input_op2.asTypeOf(rsa_dec2.io.m)
    io.output_op2 := rsa_dec2.io.c.asTypeOf(io.output_op2)

    rsa_dec3.io.e := io.e
    rsa_dec3.io.n := io.n
    rsa_dec3.io.valid := io.input_valid

    rsa_dec3.io.m := io.input_cond.asTypeOf(rsa_dec3.io.m)
    io.output_cond := rsa_dec3.io.c.asTypeOf(io.output_cond)
}