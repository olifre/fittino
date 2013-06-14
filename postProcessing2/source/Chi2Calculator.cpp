#include "Chi2Calculator.h"
#include "TRandom.h"
#include <algorithm>
#include <iostream>
#include <boost/bind.hpp>

Chi2Calculator::Chi2Calculator() {
  
  _in = 0;
  _out = 0;
  _higgs = 0;
  _lhc = 0;
  _chi2 = 0;
  _astro = 0;
  _maxChi2 = -1;
  _minChi2=-1;
  
}

Chi2Calculator::~Chi2Calculator() {

  delete _higgs;

}

double Chi2Calculator::GetMaxChi2(){

  return _maxChi2;

}

double Chi2Calculator::GetMinChi2(){

  return _minChi2;

}


std::vector<std::string> Chi2Calculator::GetChi2Contributions(){

  return _chi2Contribution;

}


std::vector<Observable>* Chi2Calculator::GetObservables(){

  return &_observableVector;

}

void   Chi2Calculator::SetLHCCalculator(LHCCalculator* lhc){

  _lhc = lhc;

}


void   Chi2Calculator::SetAstroCalculator(AstroCalculator* astro){

  _astro = astro;

}



void   Chi2Calculator::SetHiggsCalculator(HiggsCalculator* higgs){

  _higgs = higgs;

}


void Chi2Calculator::SetMaxChi2(double chi2){

  _maxChi2 = chi2;

}

void Chi2Calculator::SetMinChi2(double chi2){

  _minChi2 = chi2;

}


void Chi2Calculator::AddChi2Contribution( std::string name ){

  _chi2Contribution.push_back( name );

}

void Chi2Calculator::AddObservable( Observable obs ) {

  _observableVector.push_back(obs);

}

void Chi2Calculator::RemoveObservable( std::string name ) {

  _observableVector.erase( std::remove_if(_observableVector.begin(),
					  _observableVector.end(),
					  bind(&Observable::GetName, _1) == name ),
			   _observableVector.end() );

}

void Chi2Calculator::SetInput( FloatStorage* in ) {

  _in = in;

  for ( unsigned int i=0; i<_observableVector.size(); i++ ) {

    _observableVector[i].SetInput( _in );

  }

  if ( _lhc )
    _lhc->SetInput( _in );

  if ( _higgs )
    _higgs->SetInput( _in );

  if ( _astro )
    _astro->SetInput( _in );
  
  
}

void Chi2Calculator::SetOutput( FloatStorage* out ) {

  _out = out;

  if (! _out->Contains("chi2") )
    _out->Add( "chi2" );

  for ( unsigned int i=0; i<_observableVector.size(); i++ ) {

    _observableVector[i].SetOutput( _out );

  }

  if ( _higgs )
    _higgs->SetOutput( _out );

  if ( _astro )
    _astro->SetOutput( _out );

  if ( _lhc )
    _lhc->SetOutput( _out );

  
}


double Chi2Calculator::GetChi2(){

  return _chi2;

}


bool Chi2Calculator::Calculate() {


    double chi2=0;

    for (unsigned int i=0; i<_observableVector.size(); i++){
      
      _observableVector[i].Calculate();
      chi2 += _observableVector[i].GetChi2();
      
    }

    if ( _higgs ) {

      _higgs->Calculate();
      chi2 += _higgs->GetChi2();

    }



    if ( _lhc ) {

      _lhc->Calculate();
      chi2 += _lhc->GetChi2();

    }

    if ( _astro ) {

      _astro->Calculate();
      chi2 += _astro->GetChi2();

    }


    for ( unsigned int i = 0 ; i< _chi2Contribution.size(); i++ ) {
      
      chi2 += _in->Get( _chi2Contribution[i] );

    }

    _chi2 = chi2;
    _out->Set("chi2", _chi2);

    if (_maxChi2>0 && _chi2>_maxChi2){

      return false;

    }
    else {

      return true;

    }

   
}
  




void Chi2Calculator::Print() {


  //  std::cout<<"Chi2 calculator "<<_name<<" is setup as follows."<<std::endl;

  std::cout<<"Using "<<_observableVector.size()<<" observables."<<std::endl;

  for (unsigned int i=0; i<_observableVector.size(); i++){

    _observableVector[i].Print();

  }

//   std::cout<<"Using HiggsBounds = "<<_useHiggsBounds<<std::endl;
//   std::cout<<"Using HiggsSignals = "<<_useHiggsBounds<<std::endl;
//   std::cout<<"Using LHC = "<<_useLHC<<std::endl;
//   _lhc.Print();
//   std::cout<<"Using AstroFit = "<<_useAstroFit<<std::endl;
  
  


}


LHCCalculator* Chi2Calculator::GetLHCCalculator() {


  return _lhc;

}

AstroCalculator* Chi2Calculator::GetAstroCalculator() {

  return _astro;

}

HiggsCalculator* Chi2Calculator::GetHiggsCalculator() {

  return _higgs;

}
