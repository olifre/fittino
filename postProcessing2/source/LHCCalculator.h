#ifndef LHC_CALCULATOR_H
#define LHC_CALCULATOR_H

#include "ToyLHCChi2Provider.h"
#include "FloatStorage.h"


class LHCCalculator{

 public:

  enum Mode { paper2012, corr, nocorr };

         LHCCalculator(Mode mode);
         ~LHCCalculator();



  double GetChi2();
  void   Calculate();
  void   SetInput( FloatStorage* in );
  void   SetOutput(FloatStorage* out );
  void   SetMode(Mode mode);
  void   Print();

 private:

  // configuration
  static std::string ModeName[];
  FloatStorage*        _in;
  FloatStorage*        _out;
  ToyLHCChi2Provider* _prov;
  TFile*              _fChi2;
  TH2D*               _hChi2;
  vector<TH2D*>       _vCorr;
  std::string         _dir;
  double              _m0_max;
  double              _m12_max;
  Mode                _mode;

  // input  
  double              _m0;
  double              _m12;
  double              _a0;
  double              _tanBeta;

  // output
  double              _chi2;


  



};













#endif
