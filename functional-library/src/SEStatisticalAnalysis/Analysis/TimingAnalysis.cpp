#include "TimingAnalysis.h"

// static const int TOTAL_INST = 4;
// static uint8_t instsTime[TOTAL_INST]={Instruction::ADD(),Instruction::MULT(),Instruction::SUB(),Instruction::CMOV()};

TimingAnalysis::TimingAnalysis(/* args */)
{
    this->totalExpectedTime = 0;
    this->totalExecutionTime = 0;
}

TimingAnalysis::~TimingAnalysis()
{
}
int getExpectedTimeForInstruction(uint8_t instruction){
    for(int i=0;i<TOTAL_INST;i++){
        if(insts[i].instruction == instruction){
            return insts[i].expected_time;
        }
    }
    throw "Unknowen instruction"; 
}

void TimingAnalysis::Analyze(TestInstruction *inst,TestResult *res){
    if(!inst){
        throw "Instruction is null";
    }
    if(!res){
        throw "result is null";
    }
    int expectedTime = getExpectedTimeForInstruction(inst->inst);
     this->totalExpectedTime  += expectedTime;
     this->totalExecutionTime += res->totalTimeInTicks;

}


int TimingAnalysis::getTotalExpectedTime(){
    return this->totalExpectedTime;
}

int TimingAnalysis::getTotalExecutionTime(){
    return this->totalExecutionTime;
}

bool TimingAnalysis::IsAnalysisPass(){
    return getTotalExpectedTime() == getTotalExecutionTime();
}
