package se

import chisel3._
import chisel3.util._
import chisel3.experimental._

class RSAIO extends Bundle{
    val valid = Input(Bool())
    val ready = Output(Bool())
    val e = Input(UInt(128.W))
    val m = Input(UInt(128.W))
    val n = Input(UInt(128.W))
    val c = Output(UInt(128.W))
}

class RSAEncDec extends Module{
    val io = IO(new RSAIO)

    val v_reg = RegInit(false.B)
    
    v_reg := io.valid || (v_reg && (!io.ready))

    val e_reg = RegInit(0.U(256.W))

    val n_reg = RegInit(0.U(128.W))

    val m_reg = RegInit(0.U(256.W))

    val c_reg = RegInit(1.U(128.W))

    val m_next_reg = RegInit(0.U(128.W))

    when(io.valid){
        e_reg := io.e
        m_reg := io.m % io.n
        c_reg := 1.U
        n_reg := io.n
    }.elsewhen(v_reg){
        when(e_reg === 0.U && v_reg){
        }.otherwise{
            e_reg := e_reg >> 1.U
            m_reg := (m_reg * m_reg) % n_reg
            when(e_reg(0) === 1.U){
                c_reg := (c_reg * m_reg) % n_reg
            }
        }
    }
    io.ready := e_reg === 0.U && v_reg
    io.c := c_reg


}