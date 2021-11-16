
// SPDX-License-Identifier: Apache-2.0

package firrtl
package transforms
// Compiler Infrastructure
import firrtl.{CircuitState, LowForm, Transform, Utils}
// Firrtl IR classes
import firrtl.ir._
// Map functions
import firrtl.Mappers._
// Scala's mutable collections
import scala.collection.mutable
import java.io.{File, FileWriter}


class Tagrize extends Transform with DependencyAPIMigration{

  override def prerequisites = firrtl.stage.Forms.LowForm

  override def invalidates(a: Transform) = false

  override def optionalPrerequisites = firrtl.stage.Forms.LowFormOptimized

  override def optionalPrerequisiteOf = Seq.empty

  /** Called by [[firrtl.Compiler Compiler]] to run your pass. [[firrtl.CircuitState CircuitState]] contains the circuit
    * and its form, as well as other related data.
    */
  def execute(state: CircuitState): CircuitState = {
    val new_circuit = state.circuit.mapToTag
    // val writer = new FileWriter(new File("generated-src", s"tag.fir"))
    // writer.write(new_circuit.serialize)
    // val vwriter = new FileWriter(new File("generated-src", s"tag.v"))
    // val verilogEmitter = new VerilogEmitter
    // verilogEmitter.emit(new_state, vwriter)
    state.copy(circuit = new_circuit)
  }
}