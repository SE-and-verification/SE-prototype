#include "Test.h"

Test::Test(int numberOfRuns, string outFileName):
  storage(outFileName)
{
  this->numberOfRuns = numberOfRuns;
}

bool Test::start()
{
  try
  {
    TestInstruction inst;
    TestResult result;
    for (int j = 0; j < numberOfRuns; j++)
    {
      generator.GenerateTestInstruction(&inst);
      executor.Execute(&inst, &result);
      analysis.Analyze(&inst,&result);
      storage.SaveResult(&inst, &result);
    }

    cout<< "Execution Time ="<< analysis.getTotalExecutionTime() <<" Expected Time ="<<analysis.getTotalExpectedTime() <<"\n";

    if(analysis.IsAnalysisPass()){
      cout<<"Pass\n";
    }else{
      cout<<"Fail\n";
    }

  }
  catch (std::runtime_error e)
  {
    cout << "\nException running test\n";
  }

  return true;
}
