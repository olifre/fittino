#ifndef CHI2_CALCULATOR_DATA_BASE_2013
#define CHI2_CALCULATOR_DATA_BASE_2013

#include <string>
#include "Chi2Calculator.h"

class Chi2CalculatorDataBase2013{

 public:
  
  Chi2CalculatorDataBase2013();
  ~Chi2CalculatorDataBase2013();

  Chi2Calculator GetChi2Calculator(std::string name, std::string HS);
  
 private:

  Chi2Calculator GetPaper2013_LEO();

};

#endif
