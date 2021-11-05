#ifndef TEST_EXECUTOR_H
#define TEST_EXECUTOR_H

#include "TestInstructionGenerator.h"
#include "TestStorage.h"
#include "SEVerilator.h"

// #include "parameters.h"
// #include "../SE-prototype/functional-library/src/interface/parameters.h"



class TestExecutor {
    private:
      SE se_simulator; //Sequestered encryption cycle accurate simulator 
      unsigned int lastInstTickCount; //The total tick count the last instruction took
      unsigned int lastTotalTickCount;   
    public:
        TestExecutor();
        /**
         * output 
         * The time it took for the last instruction to execute
         * 
         *   
        **/
        unsigned int getLastInstTickCount();

        /*
        * Input 
        * Inst: pointer to constant data contaiining the instruction to execute 
        * 
        * output 
        * result : the result of the execution 
        */
        void  Execute(const TestInstruction *inst,TestResult *result);

};


#endif 