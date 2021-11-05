#include "TestInstructionGenerator.h"
#include "Instruction.h"
#include "enc_lib.h"
#include <assert.h>
#include <stdexcept>

using namespace enc_lib;
using namespace std;

// static const int TOTAL_INST = 4;
// static uint8_t insts[TOTAL_INST]={Instruction::ADD(),Instruction::MULT(),Instruction::SUB(),Instruction::CMOV()};

TestInstructionGenerator::TestInstructionGenerator(){
    setParameters();
    srand(2);
}

void TestInstructionGenerator::GenerateTestInstruction( TestInstruction * inst) {
    // cout<<"generatin inst"<<endl;
    if(!inst){
        throw std::runtime_error("inst is null");
    }
    /*
    * pick the instruction at random 
    */
    uint8_t inst_index = rand() % TOTAL_INST;
    uint8_t instruction = insts[inst_index].instruction;

    inst->inst = instruction;

    /**
     * for c move generate the condition at random
    */
    if (instruction == 96)//Instruction::CMOV()
    {
        uint8_t cond = rand()%2; 
        enc_lib::enc_int econd = cond;
        inst->cond = econd.ciphertext.convert_to_128();
        inst->cCond = cond;
    }else     //Otherwise ignore the conditions 
    {
        inst->cond = 0;
        inst->cCond =0;
        // break;
    }
   
    /**
     * Generate the operands randomly 
    */
    int op1= rand();
    int op2= rand();
    enc_lib::enc_int x= op1;
    enc_lib::enc_int y= op2;

    inst->cOp1 = op1;
    inst->cOp2 = op2;
    inst->op1 = x.ciphertext.convert_to_128(); //cipher text 
    inst->op2 = y.ciphertext.convert_to_128(); //cipher text



}
