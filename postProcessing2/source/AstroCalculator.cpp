#include "AstroCalculator.h"
#include "TMath.h"
#include "TSystem.h"
#include <stdexcept>
#include <iostream>

AstroCalculator::AstroCalculator( std::string obsSet ){

  _obsSet = obsSet;
  _xs_observed = 0;
  _xs_relTheoUnc = 0.5;
  _graph = 0;
  _in =0;
  _out =0;


  if ( _obsSet == "225d" ){

  TString path = "$FITTINO/postProcessing/dd_xenon100_2012.dat";
  gSystem->ExpandPathName(path);
  _graph = new TGraph(path.Data());

  }
  else if ( _obsSet == "100d" ){

    _graph = new TGraph();

    _graph->SetPoint(0, 1.0110e+1, 5.3470e-7);
    _graph->SetPoint(1, 1.0330e+1, 4.4710e-7);
    _graph->SetPoint(2, 1.0550e+1, 3.7390e-7);
    _graph->SetPoint(3, 1.0770e+1, 3.1970e-7);
    _graph->SetPoint(4, 1.1060e+1, 2.6740e-7);
    _graph->SetPoint(5, 1.1420e+1, 2.1860e-7);
    _graph->SetPoint(6, 1.1790e+1, 1.7880e-7);
    _graph->SetPoint(7, 1.2110e+1, 1.4950e-7);
    _graph->SetPoint(8, 1.2640e+1, 1.1180e-7);
    _graph->SetPoint(9, 1.2980e+1, 9.3510e-8);
    _graph->SetPoint(10,1.3400e+1, 8.1770e-8);
    _graph->SetPoint(11,1.3980e+1, 6.9920e-8);
    _graph->SetPoint(12,1.4590e+1, 5.9790e-8);
    _graph->SetPoint(13,1.5060e+1, 5.2290e-8);
    _graph->SetPoint(14,1.5630e+1, 4.3720e-8);
    _graph->SetPoint(15,1.6310e+1, 3.6560e-8);
    _graph->SetPoint(16,1.6930e+1, 3.1270e-8);
    _graph->SetPoint(17,1.7570e+1, 2.6740e-8);
    _graph->SetPoint(18,1.8140e+1, 2.3380e-8);
    _graph->SetPoint(19,1.8830e+1, 2.1380e-8);
    _graph->SetPoint(20,1.9340e+1, 1.9550e-8);
    _graph->SetPoint(21,2.0070e+1, 1.7100e-8);
    _graph->SetPoint(22,2.0950e+1, 1.5290e-8);
    _graph->SetPoint(23,2.2090e+1, 1.3670e-8);
    _graph->SetPoint(24,2.3430e+1, 1.2500e-8);
    _graph->SetPoint(25,2.4570e+1, 1.1180e-8);
    _graph->SetPoint(26,2.6060e+1, 1.0220e-8);
    _graph->SetPoint(27,2.7340e+1, 9.7780e-9);
    _graph->SetPoint(28,2.8680e+1, 9.1440e-9);
    _graph->SetPoint(29,2.9930e+1, 8.3620e-9);
    _graph->SetPoint(30,3.1400e+1, 8.1770e-9);
    _graph->SetPoint(31,3.3470e+1, 7.8190e-9);
    _graph->SetPoint(32,3.5490e+1, 7.8190e-9);
    _graph->SetPoint(33,3.7840e+1, 7.6470e-9);
    _graph->SetPoint(34,4.0120e+1, 7.3120e-9);
    _graph->SetPoint(35,4.5360e+1, 7.1510e-9);
    _graph->SetPoint(36,4.8870e+1, 6.8380e-9);
    _graph->SetPoint(37,5.3790e+1, 6.9920e-9);
    _graph->SetPoint(38,5.6740e+1, 6.9920e-9);
    _graph->SetPoint(39,5.9210e+1, 7.1510e-9);
    _graph->SetPoint(40,6.2120e+1, 7.3120e-9);
    _graph->SetPoint(41,6.5870e+1, 7.6470e-9);
    _graph->SetPoint(42,6.9850e+1, 7.8190e-9);
    _graph->SetPoint(43,7.7300e+1, 8.3620e-9);
    _graph->SetPoint(44,8.3730e+1, 8.7440e-9);
    _graph->SetPoint(45,8.9740e+1, 8.9420e-9);
    _graph->SetPoint(46,9.6700e+1, 9.3510e-9);
    _graph->SetPoint(47,1.0200e+2, 1.0220e-8);
    _graph->SetPoint(48,1.0810e+2, 1.0690e-8);
    _graph->SetPoint(49,1.1400e+2, 1.1180e-8);
    _graph->SetPoint(50,1.2090e+2, 1.1430e-8);
    _graph->SetPoint(51,1.3030e+2, 1.1950e-8);
    _graph->SetPoint(52,1.4270e+2, 1.2780e-8);
    _graph->SetPoint(53,1.5130e+2, 1.3370e-8);
    _graph->SetPoint(54,1.5960e+2, 1.3980e-8);
    _graph->SetPoint(55,1.7200e+2, 1.4950e-8);
    _graph->SetPoint(56,1.8140e+2, 1.5630e-8);
    _graph->SetPoint(57,1.9230e+2, 1.6350e-8);
    _graph->SetPoint(58,2.0510e+2, 1.7100e-8);
    _graph->SetPoint(59,2.2100e+2, 1.8280e-8);
    _graph->SetPoint(60,2.3180e+2, 1.9120e-8);
    _graph->SetPoint(61,2.5250e+2, 2.0440e-8);
    _graph->SetPoint(62,2.6630e+2, 2.1860e-8);
    _graph->SetPoint(63,2.7940e+2, 2.3380e-8);
    _graph->SetPoint(64,2.9310e+2, 2.5000e-8);
    _graph->SetPoint(65,3.1090e+2, 2.6150e-8);
    _graph->SetPoint(66,3.2790e+2, 2.7340e-8);
    _graph->SetPoint(67,3.4770e+2, 2.8590e-8);
    _graph->SetPoint(68,3.6480e+2, 2.9900e-8);
    _graph->SetPoint(69,3.9100e+2, 3.1270e-8);
    _graph->SetPoint(70,4.5150e+2, 3.5760e-8);
    _graph->SetPoint(71,4.9180e+2, 3.8240e-8);
    _graph->SetPoint(72,5.1870e+2, 3.9980e-8);
    _graph->SetPoint(73,5.4420e+2, 4.1810e-8);
    _graph->SetPoint(74,5.7400e+2, 4.3720e-8);
    _graph->SetPoint(75,6.0220e+2, 4.5720e-8);
    _graph->SetPoint(76,6.3190e+2, 4.8900e-8);
    _graph->SetPoint(77,6.7000e+2, 5.2290e-8);
    _graph->SetPoint(78,7.0670e+2, 5.5920e-8);
    _graph->SetPoint(79,7.4940e+2, 5.8470e-8);
    _graph->SetPoint(80,8.1180e+2, 6.1150e-8);
    _graph->SetPoint(81,8.6090e+2, 6.3940e-8);
    _graph->SetPoint(82,9.0800e+2, 6.6870e-8);
    _graph->SetPoint(83,9.6290e+2, 7.3120e-8);
    _graph->SetPoint(84,9.9960e+2, 7.6470e-8);

  }
  else{
    std::cout<<"Obsset="<<_obsSet<<std::endl;
    throw std::runtime_error("Unknown obsset");

  }



}

AstroCalculator::~AstroCalculator(){

  delete _graph;  

}

void AstroCalculator::SetInput( FloatStorage* in ) {

  _in = in;

}

void AstroCalculator::SetOutput( FloatStorage* out ) {

  _out = out;

  if (! _out->Contains("af_chi2_direct"))
    _out->Add("af_chi2_direct");

}



double AstroCalculator::GetChi2() {

  return _chi2;
  
}


void AstroCalculator::Calculate(){


  _xs_predicted = _in->Get("af_direct");
  _mass_predicted = _in->Get("O_massNeutralino1");

  if ( _xs_predicted < _xs_observed ) {

    _chi2 = 0;
    return;

  }

  double upperLimit = _graph->Eval( _mass_predicted );
  double width = upperLimit / TMath::Sqrt( 1.64 );
  double theo = _xs_relTheoUnc * _xs_predicted;
  double unc2 = width*width + theo*theo;

  _chi2 = TMath::Power( _xs_observed - _xs_predicted, 2 ) / unc2;

  if (_chi2<1.64 && _obsSet =="100d" )
    _chi2=0;

  _out->Set("af_chi2_direct", _chi2); 

}


