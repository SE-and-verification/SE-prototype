package aes

import chisel3._
import chisel3.util._

class DecryptIO extends Bundle{
	val input_valid = Input(Bool())
  val input_roundKeys = Input(Vec(11,Vec(16, UInt(8.W))))
	val input_op1 = Input(Vec(16, UInt(8.W))) // plaintext, ciphertext, roundKey
	val input_op2 = Input(Vec(16, UInt(8.W))) // plaintext, ciphertext, roundKey
	val input_cond = Input(Vec(16, UInt(8.W))) // plaintext, ciphertext, roundKey

	val output_op1 = Output(Vec(16, UInt(8.W))) // ciphertext or plaintext
	val output_op2 = Output(Vec(16, UInt(8.W))) // ciphertext or plaintext
	val output_cond = Output(Vec(16, UInt(8.W))) // ciphertext or plaintext

	val output_valid = Output(Bool())
}

// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
class AESDecrypt(val rolled: Boolean) extends Module {
  val KeyLength: Int = 16
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key
  print(s"rolled: ${rolled}\n")
  val io = IO(new DecryptIO)

  assert(rolled)
  val invciphers = Array.fill(3){InvCipher()}
  for (cipher <- invciphers) {
    cipher.io.start := io.input_valid
    cipher.io.roundKeys := io.input_roundKeys
  }

  invciphers(0).io.start := io.input_valid
  invciphers(0).io.ciphertext := io.input_op1

  invciphers(1).io.start := io.input_valid
  invciphers(1).io.ciphertext := io.input_op2

  invciphers(2).io.start := io.input_valid
  invciphers(2).io.ciphertext := io.input_cond

  io.output_op1 := invciphers(0).io.state_out
  io.output_op2 := invciphers(1).io.state_out
  io.output_cond := invciphers(2).io.state_out

  // TODO: the commented line was what this originally was; why was it using || and not && ?! that seems very weird and wrong
  //io.output_valid := invciphers(0).io.state_out_valid || invciphers(1).io.state_out_valid || invciphers(2).io.state_out_valid
  io.output_valid := invciphers.map(c => c.io.state_out_valid).reduce((a, b) => a && b)
}
