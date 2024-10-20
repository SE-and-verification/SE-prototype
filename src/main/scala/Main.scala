// See LICENSE for license details.

package se

import java.io.{File, FileWriter}
import chisel3._
import chisel3.stage._
object Main extends App {
  val debug = false
  val canChangeKey = false
  val dir = new File(args(0)) ; dir.mkdirs
  // val raw = new FileWriter(new File(dir, "se_raw.fir"))
  // val raw_firrtl = chisel3.Driver.execute(args,() => new SE)
  // raw write raw_firrtl
  // raw.close
  // val chirrtl = firrtl.Parser.parse(raw_firrtl)
  // val writer = new FileWriter(new File(dir, s"${chirrtl.main}.fir"))
  // writer write chirrtl.serialize
  // writer.close
  val verilog = new FileWriter(new File(dir, s"SE.v"))
  verilog write ChiselStage.emitVerilog(new SE(debug, canChangeKey))
  verilog.close

  val firrtl_file =new FileWriter(new File(dir, s"SE.fir"))
  firrtl_file write ChiselStage.emitFirrtl(new SE(debug, canChangeKey))
  firrtl_file.close

}
