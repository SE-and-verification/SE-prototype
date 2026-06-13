package se

import java.io.{File, FileWriter}
import chisel3._
import chisel3.stage._
import aes._

object MainInvCipher extends App {
  val dir = new File(args(0)); dir.mkdirs
  val verilog = new FileWriter(new File(dir, "InvCipher4.v"))
  verilog write ChiselStage.emitVerilog(new InvCipher(4, true, 0, 4))
  verilog.close
  println("InvCipher4.v generated successfully")
}
