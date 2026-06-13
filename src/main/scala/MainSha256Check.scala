package se

import java.io.{File, FileWriter}
import chisel3._
import chisel3.stage._
import sha256.Sha256Accel

object MainSha256Check extends App {
  val dir = new File(args(0)); dir.mkdirs
  val fir = new FileWriter(new File(dir, "Sha256Accel.fir"))
  fir write ChiselStage.emitFirrtl(new Sha256Accel)
  fir.close
  println("Sha256Accel FIRRTL emitted")
}
