#ifndef OBSERVABLE_H
#define OBSERVABLE_H

#include <string>
#include "FloatStorage.h"
#include <stdexcept>

class Observable{

 public:

  Observable(std::string name, double measuredValue);
  ~Observable();

  void   AddExpUnc(double expUnc ); 
  void   AddTheoUnc(double theoUnc ); 
  std::string GetTitle();
  void SetTitle(std::string title);
  double GetChi2();
  double GetPull();
  void SetUnit(double unit);
  std::string GetName() const;
  void   SetIsUpperLimit(bool isUpperLimit, bool isHardLimit);
  void   SetIsLowerLimit(bool isLowerLimit, bool isHardLimit);
  void   SetInput(FloatStorage* in);
  void   SetOutput(FloatStorage* out);
  void SetPrecision(int i);
  std::string PrintTheo();
  //  void   UpdatePredictedValue();
  //  void   UpdateMeasuredValue();
  void   Calculate();
  std::string PrintValUnc();
  void   Print();
  //  void   Smear();


 private:
  double _unit;
  int _precision;
  std::string     _title;
  std::string     _name;
  FloatStorage*       _in; 
  FloatStorage*       _out; 
  std::vector<double>  _expUnc;
  std::vector<double>  _theoUnc;
  double          _unc2; 
  double           _pull;
  double           _chi2;
  bool            _isUpperLimit;
  bool            _isLowerLimit;
  bool            _isHardLimit;
  double          _predictedValue;
  double          _measuredValue;

  void ConfigureInput();
  void ConfigureOutput();
  void CalculateTotalUnc();

};

#endif
