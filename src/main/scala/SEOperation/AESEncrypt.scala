package aes

import chisel3._
import chisel3.util._

class EncryptIO extends Bundle{
	val input_valid = Input(Bool())
	val input_text = Input(Vec(16, UInt(8.W))) // plaintext, ciphertext, roundKey
  val input_roundKeys = Input(Vec(11,Vec(16, UInt(8.W))))
	val output_text = Output(Vec(16, UInt(8.W))) // ciphertext or plaintext

	val output_valid = Output(Bool())
}

// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
class AESEncrypt(val rolled: Boolean) extends Module {
  val KeyLength: Int = 16
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key

  val io = IO(new EncryptIO)

  assert(rolled)
  val cipher = Module(new Cipher)
  cipher.io.start := io.input_valid
  cipher.io.plaintext := io.input_text
  cipher.io.roundKeys := io.input_roundKeys

  io.output_text := cipher.io.state_out
  io.output_valid := cipher.io.state_out_valid
}