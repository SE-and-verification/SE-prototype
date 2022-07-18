package aes

import chisel3._
import chisel3.util._

class AddRoundKeyIO extends Bundle{
  val state_in = Input(Vec(16, UInt(8.W)))
  val roundKey = Input(Vec(16, UInt(8.W)))
  val state_out = Output(Vec(16, UInt(8.W)))
}

// implements AddRoundKey
class AddRoundKey(Pipelined: Boolean = false) extends Module {
  val io = IO(new AddRoundKeyIO)

  for (i <- 0 until 16) {
    if (Pipelined) {
      io.state_out(i) := RegNext(io.state_in(i) ^ io.roundKey(i))
    } else {
      io.state_out(i) := io.state_in(i) ^ io.roundKey(i)
    }
  }
}

object AddRoundKey {
  def apply(Pipelined: Boolean = false): AddRoundKey = Module(new AddRoundKey(Pipelined))
}