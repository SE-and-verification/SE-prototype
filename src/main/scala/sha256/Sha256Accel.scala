// SPDX-FileCopyrightText: 2020 Anish Singhani
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0
package sha256

import chisel3._
import chisel3.util._
import chisel3.experimental.hierarchy._
import chisel3.util.HasBlackBoxPath

class Sha256AccelIO extends Bundle {
    val inputData = Input(UInt(520.W))
    val inputValid = Input(Bool())

    val outputData = Output(Vec(8, UInt(32.W)))
    val outputValid = Output(Bool())
}

@instantiable
class Sha256Accel extends Module {

    @public val io = IO(new Sha256AccelIO)

    val vec_data = RegEnable(io.inputData, io.inputValid)

    val accel = Module(new CompressionFunction)

    val ctr = RegInit(0.U(6.W))

    val first = RegInit(true.B)
    first := Mux(io.inputValid, true.B, Mux(accel.io.shiftIn && (ctr === 1.U), false.B, first))

    val start = RegInit(false.B)
    when(io.inputValid) {
        start := true.B
    }.elsewhen(accel.io.valid) {
        start := false.B
    }

    io.outputData := accel.io.out
    io.outputValid := accel.io.valid

    // Preamble at ctr === 0: chunk setup without shiftIn so the schedule stays aligned with compress.
    when(start) {
        accel.io.shiftIn := ctr =/= 0.U
    }.otherwise {
        accel.io.shiftIn := false.B
    }

    accel.io.newChunk := start && (ctr === 0.U)
    accel.io.first := first && start && (ctr === 0.U)

    val schedStep = Mux(ctr === 0.U, 0.U(6.W), ctr - 1.U)
    val wIdx0 = Cat(schedStep, 0.U(1.W))
    val wIdx1 = Cat(schedStep, 1.U(1.W))

    def scheduleWord(idx: UInt): UInt = {
        MuxCase(
            0.U(32.W),
            Seq(
                (idx < 16.U) -> ((vec_data >> (idx * 32.U))(31, 0)),
                (idx === 16.U) -> Cat(vec_data(519, 512), 0.U(24.W)),
                (idx === 63.U) -> 520.U(32.W)
            )
        )
    }

    accel.io.wordIn(0) := scheduleWord(wIdx0)
    accel.io.wordIn(1) := scheduleWord(wIdx1)

    when(io.inputValid) {
        ctr := 0.U
    }.elsewhen(start) {
        when(ctr === 0.U) {
            ctr := 1.U
        }.elsewhen(accel.io.shiftIn) {
            ctr := Mux(ctr === 32.U, 0.U, ctr + 1.U)
        }
    }
}

class Sha256AccelBB extends BlackBox with HasBlackBoxPath {
    override val desiredName = "Sha256Accel"
    val io = IO(new Sha256AccelIO)
    addPath(new java.io.File("generated-src/Sha256Accel.v").getAbsolutePath)
}
