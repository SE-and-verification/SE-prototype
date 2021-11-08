#ifndef TEST_H
#define TEST_H
#include "TestExecutor.h"
#include "TestInstructionGenerator.h"
#include "TestStorage.h"
#include "Analysis/TimingAnalysis.h"
#include <string>

using namespace std;

class Test {

    private:
        TestExecutor executor;  
        TestInstructionGenerator generator;
        TestStorage storage;
        TimingAnalysis analysis;
        int numberOfRuns;
    public:
        Test(int numberOfRuns,string outputFileName);
        bool start();
};

#endif 