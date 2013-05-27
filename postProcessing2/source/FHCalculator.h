#ifndef FH_CALCULATOR_H
#define FH_CALCULATOR_H

#include <vector>
#include <string>
#include "FloatStorage.h"
#include "slhaea.h"

class FHCalculator{

 public:

  FHCalculator();
  ~FHCalculator();

  void SetOutput(FloatStorage* out);
  int Calculate();


 private:

  std::vector<std::string> _couplings_row;
  std::vector<std::string> _couplings_col;

  std::vector<std::string> _rates1_row;
  std::vector<std::string> _rates1_col;

  std::vector<std::string> _rates2_row;
  std::vector<std::string> _rates2_col;

  FloatStorage* _out;
  SLHAea::Coll _coll;
  

  int ReadCouplingsFile(std::string fileName, std::string tag);
  void Fill(const std::vector<std::string>& row, const std::vector<std::string>& col, std::string tag);
  void Add(const std::vector<std::string>& row, const std::vector<std::string>& col, std::string tag);
  int ReadSLHAFile(std::string file);
  

};





#endif
