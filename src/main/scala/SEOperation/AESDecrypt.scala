package aes

import chisel3._
import chisel3.util._

class DecryptIO extends Bundle{
	val input_valid = Input(Bool())
  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))

	val input_op1_secret_salt = Input(Vec(Params.StateLength, UInt(8.W))) // plaintext, ciphertext, roundKey
  val input_op1_hash_version = Input(Vec(Params.StateLength, UInt(8.W)))

	val input_op2_secret_salt = Input(Vec(Params.StateLength, UInt(8.W))) // plaintext, ciphertext, roundKey
  val input_op2_hash_version = Input(Vec(Params.StateLength, UInt(8.W)))

	val input_cond_secret_salt = Input(Vec(Params.StateLength, UInt(8.W))) // plaintext, ciphertext, roundKey
  val input_cond_hash_version = Input(Vec(Params.StateLength, UInt(8.W)))

	val output_op1 = Output(Vec(Params.StateLength, UInt(8.W))) // ciphertext or plaintext
  val output_op1_hash_version = Output(Vec(Params.StateLength, UInt(8.W)))

	val output_op2 = Output(Vec(Params.StateLength, UInt(8.W))) // ciphertext or plaintext
  val output_op2_hash_version = Output(Vec(Params.StateLength, UInt(8.W)))

	val output_cond = Output(Vec(Params.StateLength, UInt(8.W))) // ciphertext or plaintext
  val output_cond_hash_version = Output(Vec(Params.StateLength, UInt(8.W)))

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
  val io = IO(new DecryptIO)
  if(!rolled){
    val InvCipherRoundARK = Array.fill(6){
      InvCipherRound("AddRoundKeyOnly", true)
      }
    val InvCipherRounds = Array.fill(6){ 
      Array.fill(Nr - 1) {
        InvCipherRound("CompleteRound", true)
      }
    }
    val InvCipherRoundNMC = Array.fill(6){ 
      InvCipherRound("NoInvMixColumns", true)
    }

    InvCipherRoundARK(0).io.input_valid := io.input_valid
    InvCipherRoundARK(0).io.state_in := io.input_op1_secret_salt
    InvCipherRoundARK(0).io.roundKey := io.input_roundKeys(Nr)

    InvCipherRoundARK(1).io.input_valid := io.input_valid
    InvCipherRoundARK(1).io.state_in := io.input_op1_hash_version
    InvCipherRoundARK(1).io.roundKey := io.input_roundKeys(Nr)

    InvCipherRoundARK(2).io.input_valid := io.input_valid
    InvCipherRoundARK(2).io.state_in := io.input_op2_secret_salt
    InvCipherRoundARK(2).io.roundKey := io.input_roundKeys(Nr)

    InvCipherRoundARK(3).io.input_valid := io.input_valid
    InvCipherRoundARK(3).io.state_in := io.input_op2_hash_version
    InvCipherRoundARK(3).io.roundKey := io.input_roundKeys(Nr)

    InvCipherRoundARK(4).io.input_valid := io.input_valid
    InvCipherRoundARK(4).io.state_in := io.input_cond_secret_salt
    InvCipherRoundARK(4).io.roundKey := io.input_roundKeys(Nr)

    InvCipherRoundARK(5).io.input_valid := io.input_valid
    InvCipherRoundARK(5).io.state_in := io.input_cond_hash_version
    InvCipherRoundARK(5).io.roundKey := io.input_roundKeys(Nr)

    // Cipher Nr-1 rounds
    for(j <- 0 to 5){
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
    for(j <- 0 to 5){
      InvCipherRoundNMC(j).io.input_valid := InvCipherRounds(j)(Nr - 1 - 1).io.output_valid
      InvCipherRoundNMC(j).io.state_in := InvCipherRounds(j)(Nr - 1 - 1).io.state_out
      InvCipherRoundNMC(j).io.roundKey := io.input_roundKeys(0)
    }

    io.output_op1 := InvCipherRoundNMC(0).io.state_out
    io.output_op1_hash_version := InvCipherRoundNMC(1).io.state_out

    io.output_op2 := InvCipherRoundNMC(2).io.state_out
    io.output_op2_hash_version := InvCipherRoundNMC(3).io.state_out

    io.output_cond := InvCipherRoundNMC(4).io.state_out
    io.output_cond_hash_version := InvCipherRoundNMC(5).io.state_out

    io.output_valid := InvCipherRoundNMC(0).io.output_valid || InvCipherRoundNMC(1).io.output_valid || InvCipherRoundNMC(2).io.output_valid || InvCipherRoundNMC(3).io.output_valid || InvCipherRoundNMC(4).io.output_valid || InvCipherRoundNMC(5).io.output_valid
  }
  else{
    val invciphers = Array.fill(6){InvCipher(4, true)}

    val address = RegInit(0.U(log2Ceil(EKDepth).W))

    when(io.input_valid) {
      address := Nr.U
    }.elsewhen(address =/= 0.U){
      address := address - 1.U
    }
    invciphers(0).io.start := io.input_valid
    invciphers(0).io.ciphertext := io.input_op1_secret_salt
    invciphers(0).io.roundKey := io.input_roundKeys(address)

    invciphers(1).io.start := io.input_valid
    invciphers(1).io.ciphertext := io.input_op1_hash_version
    invciphers(1).io.roundKey := io.input_roundKeys(address)

    invciphers(2).io.start := io.input_valid
    invciphers(2).io.ciphertext := io.input_op2_secret_salt
    invciphers(2).io.roundKey := io.input_roundKeys(address)

    invciphers(3).io.start := io.input_valid
    invciphers(3).io.ciphertext := io.input_op2_hash_version
    invciphers(3).io.roundKey := io.input_roundKeys(address)

    invciphers(4).io.start := io.input_valid
    invciphers(4).io.ciphertext := io.input_cond_secret_salt
    invciphers(4).io.roundKey := io.input_roundKeys(address)

    invciphers(5).io.start := io.input_valid
    invciphers(5).io.ciphertext := io.input_cond_hash_version
    invciphers(5).io.roundKey := io.input_roundKeys(address)

    io.output_op1 := invciphers(0).io.state_out
    io.output_op1_hash_version := invciphers(1).io.state_out

    io.output_op2 := invciphers(2).io.state_out
    io.output_op2_hash_version := invciphers(3).io.state_out


    io.output_cond := invciphers(4).io.state_out
    io.output_cond_hash_version := invciphers(5).io.state_out

    io.output_valid := invciphers(0).io.state_out_valid || invciphers(1).io.state_out_valid || invciphers(2).io.state_out_valid || invciphers(3).io.state_out_valid || invciphers(4).io.state_out_valid || invciphers(5).io.state_out_valid
  }
}
