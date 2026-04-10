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
import utils.RotateRight

class MessageScheduleArray extends Module {

    val io = IO(new Bundle {
        val first = Input(Bool())
        val shiftIn = Input(Bool())
        val wordIn = Input(Vec(2, UInt(32.W)))
        // One cycle behind shiftIn / wordIn; element j is the schedule word for round i+j (two-round step).
        val wOut = Output(Vec(2, UInt(32.W)))
    })

    val iReg = RegInit(0.U(7.W))
    val resetSched = io.first

    when (resetSched) {
        when (io.shiftIn) {
            iReg := 2.U
        }.otherwise {
            iReg := 0.U
        }
    }.elsewhen (io.shiftIn) {
        iReg := iReg + 2.U
    }

    val pairBase = Wire(UInt(7.W))
    pairBase := Mux(resetSched && io.shiftIn, 0.U, iReg)

    def shiftedIn(cur: Vec[UInt], w: UInt): Vec[UInt] =
        VecInit(Seq.tabulate(16)(k => if (k == 0) w else cur(k - 1)))

    def expandW(cur: Vec[UInt]): UInt = {
        val s0 = RotateRight(cur(14), 7) ^ RotateRight(cur(14), 18) ^ (cur(14) >> 3).asUInt
        val s1 = RotateRight(cur(1), 17) ^ RotateRight(cur(1), 19) ^ (cur(1) >> 10).asUInt
        cur(15) + s0 + cur(6) + s1
    }

    val regs = Reg(Vec(16, UInt(32.W)))

    val w0Wire = WireDefault(0.U(32.W))
    val w1Wire = WireDefault(0.U(32.W))
    val outPair = RegInit(VecInit(Seq(0.U(32.W), 0.U(32.W))))
    io.wOut := outPair
    outPair := VecInit(Seq(w0Wire, w1Wire))

    when (io.shiftIn) {
        when (pairBase < 16.U) {
            w0Wire := io.wordIn(0)
        }.otherwise {
            w0Wire := expandW(regs)
        }
        val after0 = shiftedIn(regs, w0Wire)
        when (pairBase + 1.U < 16.U) {
            w1Wire := io.wordIn(1)
        }.otherwise {
            w1Wire := expandW(after0)
        }
        regs := shiftedIn(after0, w1Wire)
    }.otherwise {
        w0Wire := 0.U
        w1Wire := 0.U
    }
}
