package aes

import chisel3._
import chisel3.util._

class InvCipherRoundIO extends Bundle{
  val input_valid = Input(Bool())
  val state_in = Input(Vec(16, UInt(8.W)))
  val roundKey = Input(Vec(16, UInt(8.W)))
  val state_out = Output(Vec(16, UInt(8.W)))
  val output_valid = Output(Bool())
}
// implements AES_Decrypt round transforms
class InvCipherRound(transform: String) extends Module {
  require(transform == "AddRoundKeyOnly" || transform == "NoInvMixColumns" || transform == "CompleteRound")
  val io = IO(new InvCipherRoundIO)

  // A well defined 'DontCare' or Initialization value
  val ZeroInit = VecInit.tabulate(16)((x:Int)=> 0.U(8.W))

  // Transform sequences
  if (transform == "AddRoundKeyOnly") {

    // Instantiate module objects
    val AddRoundKeyModule = AddRoundKey()

    // AddRoundKey
    when(io.input_valid) {
      AddRoundKeyModule.io.state_in := io.state_in
      AddRoundKeyModule.io.roundKey := io.roundKey
    }.otherwise {
      AddRoundKeyModule.io.state_in := ZeroInit
      AddRoundKeyModule.io.roundKey := ZeroInit
    }

    // output
    io.state_out := RegNext(AddRoundKeyModule.io.state_out)
    io.output_valid := RegNext(io.input_valid)

  } else if (transform == "NoInvMixColumns") {

    // Instantiate module objects
    val AddRoundKeyModule = AddRoundKey()
    val InvSubBytesModule = InvSubBytes()
    val InvShiftRowsModule = InvShiftRows()

    // InvShiftRows and AddRoundKeyModule roundKey
    when(io.input_valid) {
      InvShiftRowsModule.io.state_in := io.state_in
      AddRoundKeyModule.io.roundKey := io.roundKey
    }.otherwise {
      InvShiftRowsModule.io.state_in := ZeroInit
      AddRoundKeyModule.io.roundKey := ZeroInit
    }
    // InvSubBytes
    InvSubBytesModule.io.state_in := InvShiftRowsModule.io.state_out
    // AddRoundKey
    AddRoundKeyModule.io.state_in := InvSubBytesModule.io.state_out

    // output
    io.state_out := RegNext(AddRoundKeyModule.io.state_out)
    io.output_valid := RegNext(io.input_valid)

  } else if (transform == "CompleteRound") {

    // Instantiate module objects
    val AddRoundKeyModule = AddRoundKey()
    val InvSubBytesModule = InvSubBytes()
    val InvShiftRowsModule = InvShiftRows()
    val InvMixColumnsModule = InvMixColumns()

    // InvShiftRows and AddRoundKeyModule roundKey
    when(io.input_valid) {
      InvShiftRowsModule.io.state_in := io.state_in
      AddRoundKeyModule.io.roundKey := io.roundKey
    }.otherwise {
      InvShiftRowsModule.io.state_in := ZeroInit
      AddRoundKeyModule.io.roundKey := ZeroInit
    }
    // InvSubBytes
    InvSubBytesModule.io.state_in := InvShiftRowsModule.io.state_out
    // AddRoundKey
    AddRoundKeyModule.io.state_in := InvSubBytesModule.io.state_out
    // InvMixColumns
    InvMixColumnsModule.io.state_in := AddRoundKeyModule.io.state_out

    // output
    io.state_out := RegNext(InvMixColumnsModule.io.state_out)
    io.output_valid := RegNext(io.input_valid)

  }

}

object InvCipherRound {
  def apply(transform: String): InvCipherRound = Module(new InvCipherRound(transform))
}