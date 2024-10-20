#ifndef TEST_INSTRUCTION_GENERATOR_H
#define TEST_INSTRUCTION_GENERATOR_H

#include <inttypes.h>
#include "Instruction.h"

struct InstructionTime{
    uint8_t instruction;
    int expected_time;  
};



static const int TOTAL_INST = 4;
// static uint8_t insts[TOTAL_INST]={Instruction::ADD(),Instruction::MULT(),Instruction::SUB(),Instruction::CMOV()};

static InstructionTime insts[TOTAL_INST] ={
    {Instruction::ADD(),25},
    {Instruction::MULT(),25},
    {Instruction::SUB(),25},
    {Instruction::CMOV(),25}
};

struct TestInstruction{
    __uint128_t op1; //128bit cipher text of operand 1 
    int cOp1; // clear text of operand 1 
    __uint128_t op2; //128bit cipher text of operand 2
    int cOp2; //clear text of operand 2
    __uint128_t cond; //conditional move ??
    int cCond; //clear text of condition 
        uint8_t inst; //instruction to execute. As defined in Instructions.h
};

class TestInstructionGenerator{
    public:
        TestInstructionGenerator();
        /*
        * Generate an instruction randomly 
        * The function first picks the instruction to execute then 
        * it will randomly generate the coresponding operands and condition 
        */
        void GenerateTestInstruction( TestInstruction * result) ;
};

#endif 