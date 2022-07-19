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
class AESDecrypt(val rolled: Boolean) extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key
  print(s"rolled: ${rolled}\n")
  val io = IO(new DecryptIO)
  if(!rolled){
    val InvCipherRoundARK = Array.fill(3){
      InvCipherRound("AddRoundKeyOnly", true)
      }
    val InvCipherRounds = Array.fill(3){ 
      Array.fill(Nr - 1) {
        InvCipherRound("CompleteRound", true)
      }
    }
    val InvCipherRoundNMC = Array.fill(3){ 
      InvCipherRound("NoInvMixColumns", true)
    }

    InvCipherRoundARK(0).io.input_valid := io.input_valid
    InvCipherRoundARK(0).io.state_in := io.input_op1
    InvCipherRoundARK(0).io.roundKey := io.input_roundKeys(Nr)

    InvCipherRoundARK(1).io.input_valid := io.input_valid
    InvCipherRoundARK(1).io.state_in := io.input_op2
    InvCipherRoundARK(1).io.roundKey := io.input_roundKeys(Nr)

    InvCipherRoundARK(2).io.input_valid := io.input_valid
    InvCipherRoundARK(2).io.state_in := io.input_cond
    InvCipherRoundARK(2).io.roundKey := io.input_roundKeys(Nr)
    // Cipher Nr-1 rounds
    for(j <- 0 to 2){
      for (i <- 0 until (Nr - 1)){
        if (i == 0) {
          InvCipherRounds(j)(i).io.input_valid := InvCipherRoundARK(j).io.output_valid
          InvCipherRounds(j)(i).io.state_in := InvCipherRoundARK(j).io.state_out
        }
        else {
          InvCipherRounds(j)(i).io.input_valid := InvCipherRounds(j)(i - 1).io.output_valid
          InvCipherRounds(j)(i).io.state_in := InvCipherRounds(j)(i - 1).io.state_out
        }
        InvCipherRounds(j)(i).io.roundKey := io.input_roundKeys(Nr - i - 1)
      }
  }
    // Cipher last round
    for(j <- 0 to 2){
      InvCipherRoundNMC(j).io.input_valid := InvCipherRounds(j)(Nr - 1 - 1).io.output_valid
      InvCipherRoundNMC(j).io.state_in := InvCipherRounds(j)(Nr - 1 - 1).io.state_out
      InvCipherRoundNMC(j).io.roundKey := io.input_roundKeys(0)
    }

    io.output_op1 := InvCipherRoundNMC(0).io.state_out
    io.output_op2 := InvCipherRoundNMC(1).io.state_out
    io.output_cond := InvCipherRoundNMC(2).io.state_out
    io.output_valid := InvCipherRoundNMC(0).io.output_valid || InvCipherRoundNMC(1).io.output_valid || InvCipherRoundNMC(2).io.output_valid

  }
  else{
    val invciphers = Array.fill(3){InvCipher(6, true)}

    val address = RegInit(0.U(log2Ceil(EKDepth).W))

    when(io.input_valid) {
      address := Nr.U
    }.elsewhen(address =/= 0.U){
      address := address - 1.U
    }
    invciphers(0).io.start := io.input_valid
    invciphers(0).io.ciphertext := io.input_op1
    invciphers(0).io.roundKey := io.input_roundKeys(address)

    invciphers(1).io.start := io.input_valid
    invciphers(1).io.ciphertext := io.input_op2
    invciphers(1).io.roundKey := io.input_roundKeys(address)

    invciphers(2).io.start := io.input_valid
    invciphers(2).io.ciphertext := io.input_cond
    invciphers(2).io.roundKey := io.input_roundKeys(address)

    io.output_op1 := invciphers(0).io.state_out
    io.output_op2 := invciphers(1).io.state_out
    io.output_cond := invciphers(2).io.state_out
    io.output_valid := invciphers(0).io.state_out_valid || invciphers(1).io.state_out_valid || invciphers(2).io.state_out_valid
  }
}
