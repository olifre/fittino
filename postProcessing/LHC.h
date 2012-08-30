#ifndef LHC_H
#define LHC_H

#include "ToyLHCChi2Provider.h"

vector<float> nExpBG;
vector<float> nExpS;
vector<float> nExp;
vector<float> uncS;
vector<float> nObs;
ToyLHCChi2Provider* prov;

// ===================================================================
void setLHCchi2Tools( int PP_or_Toys, string StatTestHisto, string SignalGrid, float bestFitM0, float bestFitM12, bool verb ){
	
   if( verb ) cout << "   > Set up LHC tools.." << endl;

  // setup the LCH Toy Chi2 provider: it takes 4 arguments:
  // 1st argument: name of the file holding the histograms of the statistical test distributions - get these with CreateTestStatisticsHistogramsForLHCToys
  // 2nd argument: name of the file holding the signal grids
  // 3rd argument: m0 at the best fit point
  // 4th argument: m12 at the best fit point
  prov = new ToyLHCChi2Provider( StatTestHisto, SignalGrid, bestFitM0, bestFitM12 );
  //ToyLHCChi2Provider prov( StatTestHisto, SignalGrid, bestFitM0, bestFitM12 );
  
  // get the signal expectation in the 3 signal regions for the best fit point
  // also get the systematics on the signal expectation in the three signal regions for the best fit point
  nExpS = prov->GetSignalExpectationBF();
  uncS = prov->GetSignalUncertaintyBF();
  
  // setup the background expectation in the 3 signal regions:
  float lumi = 2.;// /fb
  nExpBG.push_back( 10.*lumi/0.165);
  nExpBG.push_back( 6.*lumi/0.165);
  nExpBG.push_back( 4.*lumi/0.165);
  
  // add signal expectation at best fit point and background expectation to get the total expecation in the three signal regions:
  for( unsigned int iCh = 0; iCh < 3; ++iCh ) {nExp.push_back(nExpBG[iCh]+nExpS[iCh]);}
  
  // for each toy, get a new set of observed events in the signal region
  // these are random numbers thrown according to the signal + background expectation at the best fit point!
  float bkgRelUnc = 0.23;
  float sigRelUnc = 0.30;
  TRandom3 rndm(0);	
  nObs.clear();
  if( PP_or_Toys == 0 ){//toys
    nObs.push_back( rndm.Poisson(nExpBG[0]*rndm.Gaus(1.,0.02)+nExpS[0]*rndm.Gaus(1.,uncS[0])));
    nObs.push_back( rndm.Poisson(nExpBG[1]*rndm.Gaus(1.,0.1)+nExpS[1]*rndm.Gaus(1.,uncS[1])));
    nObs.push_back( rndm.Poisson(nExpBG[2]*rndm.Gaus(1.,0.1)+nExpS[2]*rndm.Gaus(1.,uncS[2])));
  }
  if( PP_or_Toys == 1 ){//real data
    nObs.push_back( nExpBG[0] + nExpS[0] );
    nObs.push_back( nExpBG[1] + nExpS[1] );
    nObs.push_back( nExpBG[2] + nExpS[2] );
  }
 return;
}

// ===================================================================
// == Fonction to be called for each point of each toy
// get the chi2 contribution for this toy at this point: M0 = m0 at the current point, M12 = m12 at the current point in the ntuple
// nObs and nExp have been defined before!
float LHCchi2( float M0, float M12 ){
  //cout << M0 << "   " << M12 << endl;
  //for( int i = 0; i < nObs.size(); i++ ) cout << " obs = " << nObs[i] << "   Exp = "<< nExp[i] << endl;
  //cout <<  "prov = " << prov << endl;
  return prov->GetChi2Contribution( M0, M12, nObs, nExp );
}





#endif
