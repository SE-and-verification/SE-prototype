package aes

import chisel3._
import chisel3.util._

class EncryptIO extends Bundle{
	val input_valid = Input(Bool())
	val input_text= Input(Vec(Params.StateLength, UInt(8.W))) // plaintext, ciphertext, roundKey
  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
	val output_text = Output(Vec(Params.StateLength, UInt(8.W))) // ciphertext or plaintext

	val output_valid = Output(Bool())
}
// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
class AESEncrypt extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key

  val io = IO(new EncryptIO)

  // Instantiate module objects
  val CipherModule = Cipher(4, true)


  // use the same address and dataOut val elements to interface with the parameterized memory
  val address = RegInit(0.U(log2Ceil(EKDepth).W))
  val dataOut = Wire(Vec(Params.StateLength, UInt(8.W)))

	dataOut := io.input_roundKeys(address)

	when(io.input_valid) {
		address := 0.U
	}
	.otherwise {
		when(address =/= Nr.U){
      address := address + 1.U
    }
	}
  val input_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
  for(i <- 0 until Params.StateLength)
    input_reverse(i) := io.input_text(Params.StateLength-i-1)
  // The roundKey for each round can go to both the cipher and inverse cipher (for now TODO)
  CipherModule.io.roundKey := dataOut

  // The input text can go to both the cipher and the inverse cipher (for now TODO)
  CipherModule.io.plaintext := input_reverse

  // Cipher starts at AES_Mode=2
  CipherModule.io.start := io.input_valid

  // AES output_valid can be the Cipher.output_valid OR InvCipher.output_valid
  io.output_valid := CipherModule.io.state_out_valid
  // AES output can be managed using a Mux on the Cipher output and the InvCipher output
  io.output_text := CipherModule.io.state_out

}
