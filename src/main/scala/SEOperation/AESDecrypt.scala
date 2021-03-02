package aes

import chisel3._
import chisel3.util._

class DecryptIO extends Bundle{
	val input_valid = Input(Bool())
  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
	val input_op1 = Input(Vec(Params.StateLength, UInt(8.W))) // plaintext, ciphertext, roundKey
	val input_op2 = Input(Vec(Params.StateLength, UInt(8.W))) // plaintext, ciphertext, roundKey
	val input_cond = Input(Vec(Params.StateLength, UInt(8.W))) // plaintext, ciphertext, roundKey

	val output_op1 = Output(Vec(Params.StateLength, UInt(8.W))) // ciphertext or plaintext
	val output_op2 = Output(Vec(Params.StateLength, UInt(8.W))) // ciphertext or plaintext
	val output_cond = Output(Vec(Params.StateLength, UInt(8.W))) // ciphertext or plaintext

	val output_valid = Output(Bool())
}
// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
class AESDecrypt extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key

  val io = IO(new DecryptIO)


  val InvCipherModule1 = InvCipher(4, true)
  val InvCipherModule2 = InvCipher(4, true)
  val InvCipherModule3 = InvCipher(4, true)

  // use the same address and dataOut val elements to interface with the parameterized memory
  val address = RegInit(0.U(log2Ceil(EKDepth).W))
  val dataOut = Wire(Vec(Params.StateLength, UInt(8.W)))

	dataOut := io.input_roundKeys(address)

	when(io.input_valid) {
		address := Nr.U
	}
	.otherwise {
		when(address =/= 0.U){
      address := address - 1.U
    }
	}

  // The roundKey for each round can go to both the cipher and inverse cipher (for now TODO)
  InvCipherModule1.io.roundKey := dataOut
  InvCipherModule1.io.ciphertext <> io.input_op1
  InvCipherModule1.io.start := (io.input_valid) // no delay for Mem and ROM

  InvCipherModule2.io.roundKey := dataOut
  InvCipherModule2.io.ciphertext <> io.input_op2
  InvCipherModule2.io.start := (io.input_valid) // no delay for Mem and ROM

  InvCipherModule3.io.roundKey := dataOut
  InvCipherModule3.io.ciphertext <> io.input_cond
  InvCipherModule3.io.start := (io.input_valid) // no delay for Mem and ROM

  // AES output_valid can be the Cipher.output_valid OR InvCipher.output_valid
  io.output_valid := InvCipherModule1.io.state_out_valid || InvCipherModule2.io.state_out_valid || InvCipherModule3.io.state_out_valid 

  // AES output can be managed using a Mux on the Cipher output and the InvCipher output
  io.output_op1 := InvCipherModule1.io.state_out
  io.output_op2 := InvCipherModule2.io.state_out
  io.output_cond := InvCipherModule3.io.state_out


  // Debug statements
  // printf("AES mode=%b, mem_address=%d, mem_dataOut=%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x \n", io.AES_mode, address, dataOut(0), dataOut(1), dataOut(2), dataOut(3), dataOut(4), dataOut(5), dataOut(6), dataOut(7), dataOut(8), dataOut(9), dataOut(10), dataOut(11), dataOut(12), dataOut(13), dataOut(14), dataOut(15))
}
