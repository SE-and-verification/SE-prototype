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

class Sha256Accel extends Module {

    val io = IO(new Bundle {
        // first must be raised for one cycle before starting an actual write

        val inputData = Input(UInt(520.W))
        val inputValid = Input(Bool())

        val outputData = Output(Vec(8, UInt(32.W)))
        val outputValid = Output(Bool())
    })
    val vec_data = RegEnable(io.inputData, io.inputValid)
    val input_valid = RegInit(false.B)
    val first = RegInit(true.B)
    input_valid := Mux(io.inputValid, true.B, Mux(io.outputValid, false.B, input_valid))
    val accel = Module(new CompressionFunction)

    first := Mux(io.inputValid, true.B, Mux(accel.io.first, false.B, first))
    io.outputData := accel.io.out
    val start = RegInit(false.B)
    val ctr = RegInit(0.U(8.W))
    io.outputValid := ctr === 63.U 

    accel.io.newChunk := (ctr === 0.U) && accel.io.shiftIn
    accel.io.first := first && accel.io.shiftIn
    when(ctr < 16.U) {
        accel.io.wordIn := (vec_data >> (32.U*ctr))(31,0)
    } .elsewhen(ctr === 16.U) {
        // The first 16 words are the message schedule
        accel.io.wordIn := Cat(vec_data(519, 512), 0.U(24.W))
    }.elsewhen(ctr === 63.U) {
        // The last word is the length of the message
        accel.io.wordIn := 520.U(32.W)
    } .otherwise {
        accel.io.wordIn := 0.U
    }
    when(io.inputValid) {
        start := true.B
    } .elsewhen(io.outputValid) {
        start := false.B
    }

    when (start) {
        accel.io.shiftIn := true.B
    } .otherwise {
        accel.io.shiftIn := false.B
    }
    when (io.inputValid) {
        first := true.B
        ctr := 0.U
    } .elsewhen (accel.io.shiftIn) {
        first := false.B
    }
    when (ctr =/= 63.U && start) {
        ctr := ctr + 1.U
    } .otherwise{
       ctr := 0.U
    }

    when (io.inputValid) { ctr := 0.U }
    .otherwise {
        accel.io.wordIn := 0.U
    }

    when (io.inputValid) { ctr := 0.U }
}

