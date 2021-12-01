package aes

import chisel3._
import chisel3.util._

class EncryptIO extends Bundle{
	val input_valid = Input(Bool())
	val input_text= Input(Vec(Params.StateLength, UInt(8.W))) // plaintext, ciphertext, roundKey
  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
	val output_text = Output(Vec(Params.StateLength, UInt(8.W))) // ciphertext or plaintext
  val output_intermediate = Output(UInt(8.W))
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

 val CipherRoundARK = CipherRound("AddRoundKeyOnly", true)
  val CipherRounds = Array.fill(Nr - 1) {
    CipherRound("CompleteRound", true)
  }
  val CipherRoundNMC = CipherRound("NoMixColumns", true)

  CipherRoundARK.io.input_valid := io.input_valid
  CipherRoundARK.io.state_in := io.input_text
  CipherRoundARK.io.roundKey := io.input_roundKeys(0)

  // Cipher Nr-1 rounds
  for (i <- 0 until (Nr - 1)) yield {
    if (i == 0) {
      CipherRounds(i).io.input_valid := CipherRoundARK.io.output_valid
      CipherRounds(i).io.state_in := CipherRoundARK.io.state_out
    }
    else {
      CipherRounds(i).io.input_valid := CipherRounds(i - 1).io.output_valid
      CipherRounds(i).io.state_in := CipherRounds(i - 1).io.state_out
    }
    CipherRounds(i).io.roundKey := io.input_roundKeys(i + 1)
  }

  // Cipher last round
  CipherRoundNMC.io.input_valid := CipherRounds(Nr - 1 - 1).io.output_valid
  CipherRoundNMC.io.state_in := CipherRounds(Nr - 1 - 1).io.state_out
  CipherRoundNMC.io.roundKey := io.input_roundKeys(Nr)
  io.output_intermediate := CipherRounds(3).io.state_out(2)
  io.output_valid := CipherRoundNMC.io.output_valid
  io.output_text := CipherRoundNMC.io.state_out
  // when(io.input_valid){
  //   printf("input valid \n")
  // }
  // when(io.output_valid){
  //   printf("output valid \n")
  // }
}
