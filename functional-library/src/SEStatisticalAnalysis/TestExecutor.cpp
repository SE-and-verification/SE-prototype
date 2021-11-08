
#include "TestExecutor.h"
using namespace std;
TestExecutor::TestExecutor(){
    //  setParameters();
}

void TestExecutor::Execute(const TestInstruction *inst,TestResult *result){
    //save the last tick count before before execution 
    //used to get the total ticks for the current instruction
   
    if(!inst){
        throw "inst is null";
    }
    if(!result){
        throw "result is null";
    }

    lastTotalTickCount = se_simulator.real_tickcount; 

    //Execute the cycle accurate simulator  
    __uint128_t cipher = this->se_simulator.SECompute(inst->op1,inst->op2,inst->cond,inst->inst);   

    //Compute the time it took for this instruction 
    result->totalTimeInTicks = getLastInstTickCount();
    result->output = cipher;

}
unsigned int TestExecutor::getLastInstTickCount(){
            return se_simulator.real_tickcount - lastTotalTickCount;
}

