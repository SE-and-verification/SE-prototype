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
import chisel3.experimental.hierarchy._
import utils.RotateRight

class CompressionFunctionIO extends Bundle {
    val first = Input(Bool())
    val newChunk = Input(Bool())
    val shiftIn = Input(Bool())
    val wordIn = Input(Vec(2, UInt(32.W)))

    val valid = Output(Bool())
    val out = Output(Vec(8, UInt(32.W)))
}

@instantiable
class CompressionFunction extends Module {

    @public val io = IO(new CompressionFunctionIO)

    val valid = RegInit(false.B)
    io.valid := valid

    val i = RegInit(0.U(7.W))

    val hash_val = RegInit(Constants.hashInit())
    io.out := hash_val

    // Explicit UInt(32.W) literals prevent FIRRTL from emitting `reg a : UInt` (no width).
    // Without explicit widths, forwardSubstitution creates a divergent constraint cycle:
    // width(a) >= width(shaRound_output) >= width(a)+k, so inference never converges.
    val a = RegInit(0x6a09e667L.U(32.W))
    val b = RegInit(0xbb67ae85L.U(32.W))
    val c = RegInit(0x3c6ef372L.U(32.W))
    val d = RegInit(0xa54ff53aL.U(32.W))
    val e = RegInit(0x510e527fL.U(32.W))
    val f = RegInit(0x9b05688cL.U(32.W))
    val g = RegInit(0x1f83d9abL.U(32.W))
    val h = RegInit(0x5be0cd19L.U(32.W))

    val messageScheduleArray = Module(new MessageScheduleArray)
    messageScheduleArray.io.first := io.first | io.newChunk
    // Skip schedule advance on chunk setup so W[0],W[1] align with the first compress step (i=0).
    val doScheduleShift = io.shiftIn && !io.first && !io.newChunk
    messageScheduleArray.io.shiftIn := doScheduleShift
    messageScheduleArray.io.wordIn := io.wordIn

    val shiftDelayed = RegNext(doScheduleShift)

    def shaRound(
        ai: UInt,
        bi: UInt,
        ci: UInt,
        di: UInt,
        ei: UInt,
        fi: UInt,
        gi: UInt,
        hi: UInt,
        k: UInt,
        w: UInt
    ): (UInt, UInt, UInt, UInt, UInt, UInt, UInt, UInt) = {
        val S1 = RotateRight(ei, 6) ^ RotateRight(ei, 11) ^ RotateRight(ei, 25)
        val ch = (ei & fi) ^ ((~ei).asUInt & gi)
        val T1 = hi + S1 + ch + k + w
        val S0 = RotateRight(ai, 2) ^ RotateRight(ai, 13) ^ RotateRight(ai, 22)
        val maj = (ai & bi) ^ (ai & ci) ^ (bi & ci)
        val T2 = S0 + maj
        val ao = T1 + T2
        val bo = ai
        val co = bi
        val ddo = ci
        val eo = di + T1
        val fo = ei
        val go = fi
        val ho = gi
        (ao, bo, co, ddo, eo, fo, go, ho)
    }

    when (io.first | io.newChunk) {
        valid := false.B
        i := 0.U
    }

    when (io.first) {
        a := Constants.hashInit()(0)
        b := Constants.hashInit()(1)
        c := Constants.hashInit()(2)
        d := Constants.hashInit()(3)
        e := Constants.hashInit()(4)
        f := Constants.hashInit()(5)
        g := Constants.hashInit()(6)
        h := Constants.hashInit()(7)
        hash_val := Constants.hashInit()

    }.elsewhen (io.newChunk) {
        a := hash_val(0)
        b := hash_val(1)
        c := hash_val(2)
        d := hash_val(3)
        e := hash_val(4)
        f := hash_val(5)
        g := hash_val(6)
        h := hash_val(7)
    }

    when (shiftDelayed) {
        val cur_i = i
        val w0 = messageScheduleArray.io.wOut(0)
        val w1 = messageScheduleArray.io.wOut(1)

        val (a0, b0, c0, d0, e0, f0, g0, h0) =
            shaRound(a, b, c, d, e, f, g, h, Constants.roundConstants()(cur_i), w0)
        val (a1, b1, c1, d1, e1, f1, g1, h1) =
            shaRound(a0, b0, c0, d0, e0, f0, g0, h0, Constants.roundConstants()(cur_i + 1.U), w1)

        a := a1
        b := b1
        c := c1
        d := d1
        e := e1
        f := f1
        g := g1
        h := h1

        i := cur_i + 2.U

        when (cur_i === 62.U) {
            valid := true.B

            val n0 = hash_val(0) + a1
            val n1 = hash_val(1) + b1
            val n2 = hash_val(2) + c1
            val n3 = hash_val(3) + d1
            val n4 = hash_val(4) + e1
            val n5 = hash_val(5) + f1
            val n6 = hash_val(6) + g1
            val n7 = hash_val(7) + h1

            a := n0
            b := n1
            c := n2
            d := n3
            e := n4
            f := n5
            g := n6
            h := n7

            hash_val(0) := n0
            hash_val(1) := n1
            hash_val(2) := n2
            hash_val(3) := n3
            hash_val(4) := n4
            hash_val(5) := n5
            hash_val(6) := n6
            hash_val(7) := n7

        }.otherwise {
            valid := false.B
        }
    }

}
