#ifndef TEST_STORAGE_H
#define TEST_STORAGE_H

#include "TestInstructionGenerator.h"
#include <iostream>
#include <iomanip>
#include <fstream>
using namespace std;

class TestResult{

    public:
        __uint128_t output;
        unsigned int totalTimeInTicks;

        bool print() const;      
};

class TestStorage {
    private:
        string timingResultOutFileName;
        string encryptedResultOutFileName;
        string inputOutFileName;

        ofstream timeOut;
        ofstream inout;
        ofstream encResOut;

    public:
        TestStorage(string outputFileName, int numberOfRuns);
        bool SaveResult(const TestInstruction *inst, const TestResult * res);
        ~TestStorage();
};

#endif 