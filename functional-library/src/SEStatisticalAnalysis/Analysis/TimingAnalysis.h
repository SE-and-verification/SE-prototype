#ifndef TIMING_ANALYSIS_H
#define TIMING_ANALYSIS_H

#include "../TestInstructionGenerator.h"
#include "../TestStorage.h"

class TimingAnalysis
{
private:
    /* data */
    int totalExpectedTime;
    int totalExecutionTime;
public:
    TimingAnalysis();
    void Analyze(TestInstruction *inst,TestResult *res);
    int getTotalExpectedTime();
    int getTotalExecutionTime();
    bool IsAnalysisPass();
    ~TimingAnalysis();
};




#endif 