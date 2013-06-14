#ifndef SPHENO_CALCULATOR_H
#define SPHENO_CALCULATOR_H

#include "FloatStorage.h"
#include "slhaea.h"

class SPhenoCalculator{


 public:

  SPhenoCalculator(std::string model);
  ~SPhenoCalculator();

  void SetInput(FloatStorage* in);
  void SetOutput(FloatStorage* out);
  int  Calculate();

 private:

  int WriteSLHA();
  int ReadSLHA();
  int CallExecutable();

  FloatStorage* _in;
  FloatStorage* _out;
  std::string   _model;
  SLHAea::Coll _coll;

};

#endif
