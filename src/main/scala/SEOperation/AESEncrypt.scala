package aes

import chisel3._
import chisel3.util._
import chisel3.experimental.hierarchy._

class Encrypt384IO extends Bundle{
	val input_valid = Input(Bool())
	val input_text =  Input(UInt(384.W))

  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
	val output_text = Output(UInt(384.W))

	val output_valid = Output(Bool())
}
// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
@instantiable
class AESEncrypt384(val rolled: Boolean) extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key

  @public val io = IO(new Encrypt384IO)

  val input_text_vec1 	= Wire(Vec(16, UInt(8.W)))
  val input_text_vec2 	= Wire(Vec(16, UInt(8.W)))
  val input_text_vec3 	= Wire(Vec(16, UInt(8.W)))
  for (i <- 0 until 16) {
    input_text_vec1(i) := io.input_text((15 - i) * 8 + 7, (15 - i) * 8)
    input_text_vec2(i) := io.input_text((31 - i) * 8 + 7, (31 - i) * 8)
    input_text_vec3(i) := io.input_text((47 - i) * 8 + 7, (47 - i) * 8)
  }

  if(!rolled){
    val arkDef = Definition(new CipherRound("AddRoundKeyOnly", true))
    val fullRoundDef = Definition(new CipherRound("CompleteRound", true))
    val nmcDef = Definition(new CipherRound("NoMixColumns", true))

    val CipherRoundARK = Array.fill(3) { Instance(arkDef) }
    val CipherRoundNMC = Array.fill(3) { Instance(nmcDef) }
    val CipherRounds   = Array.fill(3) { Array.fill(Nr - 1)(Instance(fullRoundDef)) }

    CipherRoundARK(0).io.input_valid := io.input_valid
    CipherRoundARK(0).io.state_in := input_text_vec1
    CipherRoundARK(0).io.roundKey := io.input_roundKeys(0)

    CipherRoundARK(1).io.input_valid := io.input_valid
    CipherRoundARK(1).io.state_in := input_text_vec2
    CipherRoundARK(1).io.roundKey := io.input_roundKeys(0)

    CipherRoundARK(2).io.input_valid := io.input_valid
    CipherRoundARK(2).io.state_in := input_text_vec3
    CipherRoundARK(2).io.roundKey := io.input_roundKeys(0)
    // Cipher Nr-1 rounds
    for(j <- 0 to 2){
      for (i <- 0 until (Nr - 1)) yield {
        if (i == 0) {
          CipherRounds(j)(i).io.input_valid := CipherRoundARK(j).io.output_valid
          CipherRounds(j)(i).io.state_in := CipherRoundARK(j).io.state_out
        }
        else {
          CipherRounds(j)(i).io.input_valid := CipherRounds(j)(i - 1).io.output_valid
          CipherRounds(j)(i).io.state_in := CipherRounds(j)(i - 1).io.state_out
        }
        CipherRounds(j)(i).io.roundKey := io.input_roundKeys(i + 1)
      }
    // last round
      CipherRoundNMC(j).io.input_valid := CipherRounds(j)(Nr - 1 - 1).io.output_valid
      CipherRoundNMC(j).io.state_in := CipherRounds(j)(Nr - 1 - 1).io.state_out
      CipherRoundNMC(j).io.roundKey := io.input_roundKeys(Nr)
    }




    io.output_valid := CipherRoundNMC(0).io.output_valid && CipherRoundNMC(1).io.output_valid && CipherRoundNMC(2).io.output_valid

    io.output_text := Cat(Cat(Cat(CipherRoundNMC(1).io.state_out), Cat(CipherRoundNMC(0).io.state_out)), Cat(CipherRoundNMC(2).io.state_out))
  }else{
    val address = RegInit(0.U(log2Ceil(EKDepth).W))

    val tmp = RegInit(false.B)
    when(io.input_valid && ~tmp) {
      address := 0.U
      tmp     := true.B
    }.elsewhen(address =/= Nr.U){
      address := address + 1.U
    }
    val cipherDef = Definition(new Cipher(4, true))
    val cipher_A = Instance(cipherDef)
    val cipher_B = Instance(cipherDef)
    val cipher_C = Instance(cipherDef)

    cipher_A.io.start := io.input_valid
    cipher_B.io.start := io.input_valid
    cipher_C.io.start := io.input_valid
    cipher_A.io.plaintext := input_text_vec1
    cipher_B.io.plaintext := input_text_vec2
    cipher_C.io.plaintext := input_text_vec3
    cipher_A.io.roundKey := io.input_roundKeys(address)
    cipher_B.io.roundKey := io.input_roundKeys(address)
    cipher_C.io.roundKey := io.input_roundKeys(address)

    io.output_text := Cat( Cat(cipher_B.io.state_out), Cat(cipher_A.io.state_out), Cat(cipher_C.io.state_out))
    io.output_valid := cipher_A.io.state_out_valid && cipher_B.io.state_out_valid && cipher_C.io.state_out_valid

  }
}


class EncryptIO extends Bundle{
	val input_valid = Input(Bool())
	val input_text= Input(UInt(128.W)) // plaintext, ciphertext, roundKey
  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
	val output_text = Output(UInt(128.W)) // ciphertext or plaintext

	val output_valid = Output(Bool())
}
// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
@instantiable
class AESEncrypt(val rolled: Boolean) extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key

  @public val io = IO(new EncryptIO)
  val input_text_vec 	= Wire(Vec(16, UInt(8.W)))
  for (i <- 0 until 16) {
    input_text_vec(i) := io.input_text((15 - i) * 8 + 7, (15 - i) * 8)
  }
  if(!rolled){
    val arkDef = Definition(new CipherRound("AddRoundKeyOnly", true))
    val fullRoundDef = Definition(new CipherRound("CompleteRound", true))
    val nmcDef = Definition(new CipherRound("NoMixColumns", true))

    val CipherRoundARK = Instance(arkDef)
    val CipherRounds   = Array.fill(Nr - 1)(Instance(fullRoundDef))
    val CipherRoundNMC = Instance(nmcDef)

  CipherRoundARK.io.input_valid := io.input_valid
  CipherRoundARK.io.state_in := input_text_vec
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

  io.output_valid := CipherRoundNMC.io.output_valid
  io.output_text := CipherRoundNMC.io.state_out.asUInt
  }else{
    val address = RegInit(0.U(log2Ceil(EKDepth).W))
    val tmp     = RegInit(false.B)
    val cipher  = Module(new Cipher(4, true))

    when(cipher.io.state_out_valid) {
      tmp     := false.B
      address := 0.U
    }.elsewhen(io.input_valid && !tmp) {
      address := 0.U
      tmp     := true.B
    }.elsewhen(address =/= Nr.U) {
      address := address + 1.U
    }

    cipher.io.start    := io.input_valid
    cipher.io.plaintext := input_text_vec
    cipher.io.roundKey  := io.input_roundKeys(address)

    io.output_text  := Cat(cipher.io.state_out)
    io.output_valid := cipher.io.state_out_valid
  }
}