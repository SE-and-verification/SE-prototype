package se.seoperation

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import chiseltest.simulator.WriteVcdAnnotation

class BasicTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "SEOperation"
  // test class body here

  it should "test mult operation" in {
    test(new SEOperation(false)).withAnnotations(Seq(WriteVcdAnnotation))  { c =>
        c.io.op1_input.poke(3.U) // happen at falling clock edge
        c.io.op2_input.poke(2.U)
        c.io.valid.poke(true.B) // saying operands are valid
        c.io.inst.poke(40.U)
        c.clock.step()

        c.io.valid.poke(false.B) // ready goes low after 1 cycle
        c.io.op1_input.poke(0.U)
        c.io.op2_input.poke(0.U) // inputs go to 0 after 1 cycle
      
        println("output value :" + c.io.result.peek().litValue)
        println("valid :" + c.io.validOutput.peek().litValue)
        
        c.clock.step()

        println("output value :" + c.io.result.peek().litValue)
        println("valid :" + c.io.validOutput.peek().litValue)

        c.clock.step()
        c.clock.step()

    }
  }

}