#ifndef ASTRO_CALCULATOR_H
#define ASTRO_CALCULATOR_H

#include "FloatStorage.h"
#include "TGraph.h"

class AstroCalculator{

 public:

  AstroCalculator(std::string obsSet);
         ~AstroCalculator();

  double GetChi2();
  void   Calculate();
  void   SetInput(FloatStorage* in);
  void   SetOutput(FloatStorage* out);
  

 private:

  // configuration
  FloatStorage*   _in;
  FloatStorage*   _out;
  double         _xs_observed;
  double         _xs_relTheoUnc;
  TGraph*        _graph;
  std::string _obsSet;

  // input  
  double         _xs_predicted;
  double         _mass_predicted;
  
  // output
  double         _chi2;
  

};

#endif
