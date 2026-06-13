package se

import java.io.{File, FileWriter}
import chisel3._
import chisel3.stage._
import sha256.Sha256Accel

object MainSha256Accel extends App {
  val dir = new File(args(0)); dir.mkdirs
  val v = new FileWriter(new File(dir, "Sha256Accel.v"))
  v write ChiselStage.emitVerilog(new Sha256Accel)
  v.close
  println("Sha256Accel.v generated")
}
