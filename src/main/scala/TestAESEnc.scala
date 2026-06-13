package se
import java.io.{File, FileWriter}
import chisel3._
import chisel3.stage._
import aes._

object TestAESEnc extends App {
  val dir = new File(args(0)); dir.mkdirs
  val v = new FileWriter(new File(dir, "AESEncTest.v"))
  v write ChiselStage.emitVerilog(new AESEncrypt(true))
  v.close
  println("AESEncrypt OK")
}
