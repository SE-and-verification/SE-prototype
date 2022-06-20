// See LICENSE for license details.

package se

import java.io.{File, FileWriter}
import chisel3._
import chisel3.stage._
object Main extends App {
  implicit val debug = false
  val changeKey = false
  val dir = new File(args(0)) ; dir.mkdirs

  if(!changeKey){
    val verilog = new FileWriter(new File(dir, s"SE.v"))
    verilog write ChiselStage.emitVerilog(new Locality)
    verilog.close
  }
}
