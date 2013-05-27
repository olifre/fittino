#include "Observable.h"
#include "TMath.h"
#include "TRandom.h"
#include <iostream>
#include <sstream>


Observable::Observable(std::string name,
		       double measuredValue
		       ){

  _name=name;
  _measuredValue=measuredValue;
  _in = 0;
  _out = 0; 
  _unc2=0;
  _pull = 0;
  _chi2 = 0;
  _isUpperLimit = false;
  _isLowerLimit = false;
  _isHardLimit = false;
  _unit=1;
  
}

std::string Observable::GetName() const{

  return _name;

}

void Observable::SetPrecision(int i){

  _precision=i;

}
std::string Observable::GetTitle(){

  return _title;

}

void Observable::SetUnit(double unit){

  _unit=unit;

}
void Observable::SetTitle(std::string title){

  _title=title;

}

void Observable::SetOutput(FloatStorage* out){

  _out = out;
  _out->Add("pull_"+_name);

}

// void Observable::Smear(){

//   _measuredValue= gRandom->Gaus(_measuredValue, TMath::Sqrt(_unc2));
  
// }

void Observable::AddExpUnc(double expUnc){

  _expUnc.push_back( expUnc );
  _unc2+=TMath::Power( expUnc, 2 );
  
}

double Observable::GetChi2(){

  return _chi2;

}


void Observable::AddTheoUnc(double theoUnc){

  _theoUnc.push_back( theoUnc );
  _unc2+=TMath::Power( theoUnc, 2);
  
}


// void Observable::CalculateTotalUnc(){

//   _unc2=0;

//   for (unsigned int i=0; i< _expUnc.size(); i++)
//     _unc2+=TMath::Power(_expUnc[i], 2);
  
//   for (unsigned int i=0; i< _theoUnc.size(); i++)
//     _unc2+=TMath::Power(_theoUnc[i], 2);

// }


Observable::~Observable(){


}

void Observable::SetInput(FloatStorage* in){

  _in=in;

}

void Observable::SetIsUpperLimit(bool isUpperLimit, bool isHardLimit){

  if (isUpperLimit && _isLowerLimit)
    throw std::runtime_error("Already set to lower limit");

  _isUpperLimit = isUpperLimit;
  _isHardLimit = isHardLimit;

}

void Observable::SetIsLowerLimit(bool isLowerLimit, bool isHardLimit){

  if (_isUpperLimit && isLowerLimit)
    throw std::runtime_error("Already set to upper limit");

  _isLowerLimit = isLowerLimit;
  _isHardLimit = isHardLimit;

}

void  Observable::Calculate(){

  _predictedValue = _in->Get( _name );

  
  if ( _isUpperLimit && ( _predictedValue <= _measuredValue ) ) {

    _pull = 0;

  }
  else if ( _isLowerLimit && ( _predictedValue >= _measuredValue ) ) {

    _pull = 0;
    
  }
  else if ( _isHardLimit && _isUpperLimit  ) {

    _pull =  1e6;

  }
  else if ( _isHardLimit && _isLowerLimit  ) {

    _pull = -1e6;
    
  }
  else {

    _pull = ( _measuredValue - _predictedValue ) / TMath::Sqrt(_unc2); 

  }

  _out->Set("pull_"+_name, _pull);
  _chi2 = _pull*_pull;
  
}

// void Observable::UpdateMeasuredValue(){

//   _measuredValue = _predictionTree->Get(_name);

// }


// void Observable::UpdatePredictedValue(){

//   _predictedValue = _predictionTree->Get(_name);

// }


void Observable::Print(){

  std::cout<<_name<<" = "<<_measuredValue;

  for (unsigned int i=0; i< _expUnc.size(); i++ )
    std::cout<<" +- "<<_expUnc[i];

  for (unsigned int i=0; i< _theoUnc.size(); i++ )
    std::cout<< "+- "<<_theoUnc[i];

  std::cout<<std::endl;
  
  std::cout<<"Total Unc = "<<TMath::Sqrt(_unc2)<<std::endl;
  std::cout<<"IsUpperLimit = "<<_isUpperLimit<<", IsLowerLimit = "<<_isLowerLimit<<", IsHardLimit = "<<_isHardLimit<<std::endl;
  std::cout<<std::endl;

}

std::string Observable::PrintValUnc(){

  std::ostringstream ss;
  ss.precision(_precision);
  ss.setf(std::ios::fixed);

  ss << _measuredValue/_unit;

  for (unsigned int i=0; i< _expUnc.size(); i++ )
    ss<<" +- "<<_expUnc[i]/_unit;

  for (unsigned int i=0; i< _theoUnc.size(); i++ )
    ss<< "+- "<<_theoUnc[i]/_unit;

  
  std::string s(ss.str());

  return s;

}

std::string Observable::PrintTheo(){

 std::ostringstream ss;
  ss.precision(_precision);
  ss.setf(std::ios::fixed);

  ss << _predictedValue/_unit;

  std::string s(ss.str());

  return s;


}

double Observable::GetPull(){

  return _pull;


}
