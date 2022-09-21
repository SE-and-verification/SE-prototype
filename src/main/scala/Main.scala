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
    val coalesce_verilog = new FileWriter(new File(dir, s"SE_coalesce.v"))
    coalesce_verilog write ChiselStage.emitVerilog(new Locality(true))
    coalesce_verilog.close

    val nocoalesce_verilog = new FileWriter(new File(dir, s"SE_nocoalesce.v"))
    nocoalesce_verilog write ChiselStage.emitVerilog(new Locality(false))
    nocoalesce_verilog.close
  }
}
