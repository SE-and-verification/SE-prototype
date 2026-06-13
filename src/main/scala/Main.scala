// See LICENSE for license details.

package se

import java.io.{File, FileWriter}
import chisel3._
import chisel3.stage._

object Main extends App {
  val debug = false
  val canChangeKey = false
  val dir = new File(args(0)) ; dir.mkdirs

  // FIRRTL 1.5.2's ConstraintSolver.forwardSubstitution is deeply recursive for
  // large circuits. Run generation in a thread with a large explicit stack so the
  // JVM honours the size regardless of -Xss or ulimit.
  var genError: Throwable = null
  val genThread = new Thread(null, () => {
    try {
      val verilog = new FileWriter(new File(dir, s"SE.v"))
      verilog write ChiselStage.emitVerilog(new SE(debug, canChangeKey))
      verilog.close
    } catch {
      case t: Throwable => genError = t
    }
  }, "gen", 4L * 1024 * 1024 * 1024)   // 4 GB stack reservation (virtual only)
  genThread.start()
  genThread.join()
  if (genError != null) throw genError
}
