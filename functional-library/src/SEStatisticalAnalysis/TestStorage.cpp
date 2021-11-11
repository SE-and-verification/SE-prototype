#include "TestStorage.h"
#include <iostream>

using namespace std;



bool TestResult::print() const{
        uint64_t lower = (uint64_t)output;
	    uint64_t upper = (uint64_t)(output>>64);
	    std::cout<< std::setw(16) << std::setfill('0') << std::hex << upper<<"|"<<lower<<"->"<<totalTimeInTicks<< std::endl;
    return true;
}

TestStorage::TestStorage(string outputFileName,int numberOfRuns){
	  this->encryptedResultOutFileName = outputFileName+".enc";
	  this->timingResultOutFileName = outputFileName +".time";
	  this->inputOutFileName = outputFileName +".in";

	  encResOut.open(this->encryptedResultOutFileName);
	  encResOut << "type: d\ncount: "<<numberOfRuns<<"\nnumbits: 128\n";// generate header files for diharder input format 
	  this->timeOut.open(this->timingResultOutFileName);
	  this->inout.open(this->inputOutFileName);
}

bool TestStorage::SaveResult(const TestInstruction *inst, const TestResult *res){
	if(!inst){
		throw std::runtime_error("inst is null");
	}
	if(!res){
		throw runtime_error("result is null");
	}
	
	/**
	 * write the output to file 
	*/
	uint64_t lower = (uint64_t)res->output;
	uint64_t upper = (uint64_t)(res->output>>64);
	encResOut<<std::setw(16) << std::setfill('0') << std::dec << upper<<""<<lower<< std::endl;

	/**
	 * write the clear instruction and clear op1, op2 and cond to the file 
	*/
	inout << std::dec << (int)(inst->inst )<< "\t" << std::setw(16) << std::setfill('0')<<inst->cOp1 <<"\t"<<
	std::setw(16) << std::setfill('0')<< inst->cOp2 << "\t" << inst->cCond << "\t";

	/**
	 * write enc operand one to file 
	*/
	lower = (uint64_t)inst->op1;
	upper = (uint64_t)(inst->op1>>64);
	inout <<std::setw(16) << std::setfill('0') << std::hex << upper<<std::setw(16) << std::setfill('0')<<lower <<"\t";

	/**
	 * write enc operand two to the file 
	*/
	lower = (uint64_t)inst->op2;
	upper = (uint64_t)(inst->op2>>64);
	inout <<std::setw(16) << std::setfill('0') << std::hex << upper<<std::setw(16) << std::setfill('0')<<lower <<"\t";

	/**
	 * write enc cond two to the file 
	*/
	lower = (uint64_t)inst->cond;
	upper = (uint64_t)(inst->cond>>64);
	inout <<std::setw(16) << std::setfill('0') << std::hex << upper<<std::setw(16) << std::setfill('0')<<lower <<"\n";


	/**
	 * write the total time for this instruction
	*/
	timeOut <<res->totalTimeInTicks<<endl;

    // res->print();
    return true;
}

TestStorage::~TestStorage(){
	encResOut.close();
	timeOut.close();
	inout.close();
}
