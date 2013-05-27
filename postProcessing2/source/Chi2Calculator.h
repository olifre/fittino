#ifndef CHI2_CALCULATOR
#define CHI2_CALCULATOR 

#include <vector>
#include "FloatStorage.h"
#include "Observable.h"
#include "TH1I.h"
#include "HiggsCalculator.h"
#include "LHCCalculator.h" 
#include "AstroCalculator.h" 



class Chi2Calculator{

public:

  Chi2Calculator();
  ~Chi2Calculator();

  void   AddObservable( Observable obs );
  void   RemoveObservable( std::string name );

  void AddChi2Contribution(std::string name);

  std::vector<std::string> GetChi2Contributions();

  LHCCalculator*   GetLHCCalculator(); 
  AstroCalculator* GetAstroCalculator(); 
  HiggsCalculator* GetHiggsCalculator();

  std::vector<Observable>* GetObservables();

  void   SetLHCCalculator(LHCCalculator* lhc); 
  void   SetAstroCalculator(AstroCalculator* astro); 
  void   SetHiggsCalculator(HiggsCalculator* higgs);

  bool     Calculate();
  double   GetChi2();

  void  SetInput(FloatStorage* in);
  void  SetOutput(FloatStorage* out);

  void SetMaxChi2(double chi2);
  double GetMaxChi2();

  void Print();
  
private:

  std::vector<Observable> _observableVector;

  std::vector<std::string> _chi2Contribution;

  HiggsCalculator* _higgs;  
  LHCCalculator* _lhc; 
  AstroCalculator* _astro; 

  FloatStorage*   _in;
  FloatStorage*  _out;

  double _chi2;
  double _maxChi2;
};

#endif
