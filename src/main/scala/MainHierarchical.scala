package se

import java.io.{File, FileWriter}
import chisel3.stage.ChiselStage
import firrtl.stage.{FirrtlStage, FirrtlSourceAnnotation}
import firrtl.options.TargetDirAnnotation
import firrtl.{EmitCircuitAnnotation, VerilogEmitter}
import firrtl.ir._
import scala.collection.mutable
import scala.io.Source

// Generates SE.v via per-module compilation to avoid FIRRTL 1.5.2's
// ConstraintSolver.forwardSubstitution StackOverflow/OOM on large circuits.
//
// Stage 1: ChiselStage.emitChirrtl -> CHIRRTL (before ALL FIRRTL passes)
// Stage 2: compile each module independently with its deps as ExtModule stubs.
//          For OOM-prone modules, falls back to a subprocess with fresh heap.
object MainHierarchical extends App {
  val dir = new File(args(0)); dir.mkdirs

  // Classpath for subprocess invocations
  val cp = System.getProperty("java.class.path")

  // Stage 1: CHIRRTL — stops before ALL FIRRTL passes (no InferWidths)
  System.err.println("[1/2] Generating CHIRRTL...")
  val firrtlText = ChiselStage.emitChirrtl(new SE(false, false))
  System.err.println(s"[1/2] Done (${firrtlText.length} chars, writing SE.fir)")
  locally {
    val fw = new FileWriter(new File(dir, "SE.fir")); fw.write(firrtlText); fw.close()
  }

  // Stage 2: parse, topo-sort, compile each module independently
  System.err.println("[2/2] Per-module Verilog compilation...")
  val circuit = firrtl.Parser.parse(firrtlText)

  // CHIRRTL has abstract ResetType ports; replace with UInt<1> (synchronous reset)
  // so CheckHighForm doesn't reject each module when compiled as a top-level.
  def fixReset(m: DefModule): DefModule = {
    def fix(t: Type): Type = if (t == ResetType) UIntType(IntWidth(1)) else t
    val np = m.ports.map(p => p.copy(tpe = fix(p.tpe)))
    m match {
      case mm: Module    => mm.copy(ports = np)
      case em: ExtModule => em.copy(ports = np)
      case other         => other
    }
  }

  val modMap = circuit.modules.map(m => m.name -> fixReset(m)).toMap
  System.err.println(s"      Modules: ${modMap.size}")

  def directDeps(m: DefModule): Set[String] = {
    val result = mutable.Set.empty[String]
    def walk(s: Statement): Unit = s match {
      case DefInstance(_, _, mod, _) => result += mod
      case Block(stmts)              => stmts.foreach(walk)
      case Conditionally(_, _, c, a) => walk(c); walk(a)
      case _                         =>
    }
    m match { case mm: Module => walk(mm.body); case _ => }
    result.toSet
  }

  // Post-order topological sort (leaves first, SE last)
  val order   = mutable.ArrayBuffer.empty[String]
  val visited = mutable.Set.empty[String]
  def topo(name: String): Unit = {
    if (visited(name) || !modMap.contains(name)) return
    visited += name
    directDeps(modMap(name)).foreach(topo)
    order += name
  }
  topo(circuit.main)

  val tmpDir = new File(dir, "_hier_tmp"); tmpDir.mkdirs()
  val combined = new StringBuilder

  // Compile a module's mini-circuit via FirrtlStage subprocess.
  // Writes firrtl to a file, runs java -cp ... firrtl.stage.FirrtlMain.
  def compileInSubprocess(name: String, firFile: File, outDir: File): Boolean = {
    System.err.print(s"  (subprocess) $name ... ")
    val cmd = Array("java", "-Xmx3500M", "-XX:+UseG1GC",
      "-cp", cp, "firrtl.stage.FirrtlMain",
      "-i", firFile.getAbsolutePath,
      "-X", "verilog",
      "-td", outDir.getAbsolutePath)
    val proc = new ProcessBuilder(cmd: _*).redirectErrorStream(true).start()
    val procOutput = Source.fromInputStream(proc.getInputStream).mkString
    val rc = proc.waitFor()
    if (rc != 0) {
      System.err.println(s"FAILED (rc=$rc)")
      System.err.println(procOutput.takeRight(500))
    }
    rc == 0
  }

  for (name <- order) {
    val mod  = modMap(name)
    val deps = directDeps(mod)

    val stubs = deps.toSeq.flatMap { dep =>
      modMap.get(dep).map {
        case m: Module    => ExtModule(m.info, m.name, m.ports, m.name, Nil)
        case e: ExtModule => e
      }
    }

    val mini   = circuit.copy(modules = stubs :+ mod, main = name)
    val outDir = new File(tmpDir, name); outDir.mkdirs()
    val vFile  = new File(outDir, s"$name.v")

    if (vFile.exists() && vFile.length() > 0) {
      combined.append(Source.fromFile(vFile).mkString).append("\n")
      System.err.println(s"  cached  $name (${vFile.length()} B)")
    } else {
      System.err.print(s"  compiling $name ... ")
      var compiled = false

      // Fix registers declared as "reg X : UInt," (unknown width) → "reg X : UInt<32>,"
      // FIRRTL 1.5.2's forwardSubstitution builds IsMax constraint trees without cycle
      // detection; unknown-width registers in CompressionFunction (a,b,c,d,e,f,g,h) create
      // multi-way circular IsMax constraints that expand exponentially, causing OOM.
      // Setting them to UInt<32> is correct: Chisel3 already inserts tail(...,1) after
      // every add, so all drivers are exactly 32 bits.
      val miniText = mini.serialize.replaceAll("\\breg (\\w+) : UInt,", "reg $1 : UInt<32>,")

      try {
        new FirrtlStage().execute(
          Array.empty,
          Seq(
            FirrtlSourceAnnotation(miniText),
            EmitCircuitAnnotation(classOf[VerilogEmitter]),
            TargetDirAnnotation(outDir.getAbsolutePath)
          )
        )
        compiled = true
      } catch {
        case _: OutOfMemoryError =>
          System.err.println(s"OOM in-process, retrying in subprocess...")
          // Write FIRRTL to file for subprocess
          val firFile = new File(outDir, s"$name.fir")
          locally { val fw = new FileWriter(firFile); fw.write(miniText); fw.close() }
          compiled = compileInSubprocess(name, firFile, outDir)
      }

      if (compiled) {
        if (vFile.exists() && vFile.length() > 0) {
          combined.append(Source.fromFile(vFile).mkString).append("\n")
          System.err.println(s"OK (${vFile.length()} B)")
        } else {
          val vFiles = outDir.listFiles().filter(f => f.getName.endsWith(".v") && f.length() > 0)
          if (vFiles.nonEmpty) {
            vFiles.foreach(f => combined.append(Source.fromFile(f).mkString).append("\n"))
            System.err.println(s"OK (${vFiles.map(_.length()).sum} B, ${vFiles.length} file(s))")
          } else {
            System.err.println(s"WARNING: no .v output for $name")
          }
        }
      }
    }
  }

  val out = new FileWriter(new File(dir, "SE.v"))
  out.write(combined.toString()); out.close()
  System.err.println(s"[2/2] Done. SE.v: ${combined.length} chars")
}
