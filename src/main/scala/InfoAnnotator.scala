package se

import chisel3._
import chisel3.experimental.{annotate, ChiselAnnotation, RunFirrtlTransform}
import chisel3.internal.InstanceId

import firrtl._
import firrtl.annotations.{Annotation, SingleTargetAnnotation}
import firrtl.annotations.{CircuitTarget, ModuleTarget, InstanceTarget, ReferenceTarget, Target}

/** An annotation that contains some string information */
case class InfoAnnotation(target: Target, info: String) extends SingleTargetAnnotation[Target] {
  def duplicate(newTarget: Target) = this.copy(target = newTarget)
}

object InfoAnnotator {
  def info(component: InstanceId, info: String): Unit = {
    annotate(new ChiselAnnotation {
      def toFirrtl: Annotation = InfoAnnotation(component.toTarget, info)
    })
  }
}