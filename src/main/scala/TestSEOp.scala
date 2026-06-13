package se
import java.io.{File, FileWriter}
import chisel3._
import chisel3.stage._
import se.seoperation._

object TestSEOp extends App {
  val dir = new File(args(0)); dir.mkdirs
  val v = new FileWriter(new File(dir, "SEOpTest.v"))
  v write ChiselStage.emitVerilog(new SEOperation(false))
  v.close
  println("SEOperation OK")
}
