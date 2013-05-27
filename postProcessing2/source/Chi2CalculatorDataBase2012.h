#ifndef CHI2_CALCULATOR_DATA_BASE_2012
#define CHI2_CALCULATOR_DATA_BASE_2012


#include <string>

#include "Chi2Calculator.h"

class Chi2CalculatorDataBase2012{

 public:
  
  Chi2CalculatorDataBase2012();
  ~Chi2CalculatorDataBase2012();

  Chi2Calculator GetChi2Calculator(std::string name);
  
 private:

  Chi2Calculator GetPaper2012_LHCmh();
  

};

#endif
