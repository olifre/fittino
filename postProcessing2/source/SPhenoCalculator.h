#ifndef SPHENO_CALCULATOR_H
#define SPHENO_CALCULATOR_H

#include "FloatStorage.h"
#include "slhaea.h"

class SPhenoCalculator{


 public:

  SPhenoCalculator();
  ~SPhenoCalculator();

  void SetInput(FloatStorage* in);
  void SetOutput(FloatStorage* out);
  int Calculate();

 private:

  int WriteSLHA();
  int ReadSLHA();

  FloatStorage* _in;
  FloatStorage* _out;

  SLHAea::Coll _coll;

};





#endif
