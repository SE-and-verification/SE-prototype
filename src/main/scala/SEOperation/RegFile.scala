package se.seoperation

import chisel3._
import chisel3.util._
import chisel3.simplechisel._
import chisel3.simplechisel.util._

class  RegFileInputType extends Bundle{
    val raddr1 = UInt(5.W)
    val raddr2 = UInt(5.W)

    val wen = Bool()
    val waddr = UInt(5.W)
    val wdata = UInt(32.W)
}

class RegFileOutputType extends Bundle{
    val rdata1 = UInt(32.W)
    val rdata2 = UInt(32.W)
}


class RegFile extends SimpleChiselModule {

  val in = IO(Input(new RegFileInputType))
  val out = IO(Output(new RegFileOutputType))
  val ctrl = new NoIOCtrl
  
  val regs = Mem(32, UInt(32.W))


  out.rdata1 := Mux(in.raddr1 === in.waddr & in.wen, in.wdata,
                        Mux(in.raddr1.orR, regs(in.raddr1), 0.U))
  out.rdata2 := Mux(in.raddr2 === in.waddr & in.wen, in.wdata,
                        Mux(in.raddr2.orR, regs(in.raddr2), 0.U))
  when(in.wen & in.waddr.orR) {
    regs(in.waddr) := in.wdata
  }

}
