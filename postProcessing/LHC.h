#ifndef LHC_H
#define LHC_H

#include "ToyLHCChi2Provider.h"
vector<float> nExpBG;
vector<float> nExpS;
vector<float> nExp;
vector<float> uncS;
vector<float> nObs;
ToyLHCChi2Provider* prov;

TFile *fChi2;
TH2D *hChi2;
TH2D *hChi2_corr;

// ===================================================================
void setLHCchi2Tools( int PP_or_Toys, int randomSeed, bool verb, float bestFitM0, float bestFitM12, TString fit ){

	
   if( verb ) cout << "   > Set up LHC tools.." << endl;

   if( PP_or_Toys == 1 ){
     fChi2 = new TFile( "AllChi2Maps.root" );
     hChi2 = (TH2D*) fChi2->Get("h_chi2");
     hChi2_corr = (TH2D*) fChi2->Get("h_chi2_corr_offgrid");
   }
   if( PP_or_Toys == 0 || PP_or_Toys == 2 ){
     
     // setup the LCH Toy Chi2 provider: it takes 4 arguments:
     // 1st argument: name of the file holding the signal grids
     // 2nd argument: m0 at the best fit point
     // 3rd argument: m12 at the best fit point
     prov = new ToyLHCChi2Provider( "signalGrids.root", bestFitM0, bestFitM12 );
  
     // get the signal expectation in the 3 signal regions for the best fit point
     // also get the systematics on the signal expectation in the three signal regions for the best fit point
     nExpS = prov->GetSignalExpectationBF();
     uncS = prov->GetSignalUncertaintyBF();
  
     // setup the background expectation in the 3 signal regions:
     float lumi = 50.;// /fb
     nExpBG.push_back( 5.*lumi/0.165);
     nExpBG.push_back( 1.*lumi/0.165);
     nExpBG.push_back( 7.*lumi/0.165);
     
     // add signal expectation at best fit point and background expectation to get the total expecation in the three signal regions:
     for( unsigned int iCh = 0; iCh < 3; ++iCh ) nExp.push_back( nExpBG[iCh] + nExpS[iCh] );
     
     // for each toy, get a new set of observed events in the signal region
     // these are random numbers thrown according to the signal + background expectation at the best fit point!
     TRandom3 rndm( randomSeed );	
     nObs.clear();
     nObs.push_back( rndm.Poisson(nExpBG[0]*rndm.Gaus(1.,0.03)+nExpS[0]*rndm.Gaus(1.,uncS[0])));
     nObs.push_back( rndm.Poisson(nExpBG[1]*rndm.Gaus(1.,0.03)+nExpS[1]*rndm.Gaus(1.,uncS[1])));
     nObs.push_back( rndm.Poisson(nExpBG[2]*rndm.Gaus(1.,0.03)+nExpS[2]*rndm.Gaus(1.,uncS[2])));     

     //nObs.push_back( nExpBG[0] + nExpS[0] );// test the toys
     //     nObs.push_back( nExpBG[1] + nExpS[1] );
     //     nObs.push_back( nExpBG[2] + nExpS[2] );

     // Use the region B, fewer background and tuned to the ATLAS analysis
     TString histoName = Form( "chi2_nObs_%i", int(nObs[1]) );
     TString fileName = "/scratch/hh/dust/naf/atlas/user/prudent/postProcessing_2012/outputs/toys/LHC_histos/";
     if( fit.Contains("CMSSM") ) fileName += "CMSSM_all.root";
     if( fit.Contains("NUHM1") ) fileName += "NUHM1_all.root";
     if( fit.Contains("NUHM2") ) fileName += "NUHM2_all.root";
     cout << "   > LHC chi2 histogram.." << endl << fileName << " -> " << histoName << endl;
     fChi2 = new TFile( fileName );
     hChi2 = (TH2D*)fChi2->Get( histoName );
   }
         
     return;
}

// ===================================================================
// == Fonction to be called for each point of each toy
// get the chi2 contribution for this toy at this point: M0 = m0 at the current point, M12 = m12 at the current point in the ntuple
// nObs and nExp have been defined before!

//float LHCchi2( float M0, float M12 ){
//  return prov->GetChi2ContributionFit( M0, M12, nObs, nExp );
//}

// ===================================================================
// == Fonction to be called for each point of each toy
// get the chi2 contribution for this toy at this point: M0 = m0 at the current point, M12 = m12 at the current point in the ntuple
// Idem as the function LHCchi2, but the chi2 is now taken from an histogram to speed up the procedure
// A correction is applied to take the dependancy to A0 and TanBeta into account, the scaling factor is linear between 1200 and 1962 GeV then constant

float LHCchi2_fast( float M0, float M12, float A0, float TanBeta ){

  float myA0 = A0;
  float myTanBeta = TanBeta;

  // Without A0-TanBeta corrections
  //return hChi2->Interpolate(M0,M12);  

  // With A0-TanBeta corrections for M0 > 1200 GeV
  if( M0 > 0. && M0 <= 1200. ) return hChi2->Interpolate( M0, M12 );
  else{
    if( A0 > 5499. ) myA0 = 5499.;
    if( A0 < -4499. ) myA0 = -4499.;
    if( TanBeta > 44.9) myTanBeta = 44.9;
    float scaleFac = (M0 < 2000. ) ? ( M0 - 1200. ) / 762. : 1.;
    float chi2_uncorr = hChi2->Interpolate( M0, M12 );
    float chi2_correction = hChi2_corr->Interpolate( myA0, myTanBeta ); // the histogram hChi2_corr shows the DIFFERENCE in chi2: chi2(A0,tb)-chi2(0,10) !!!
    return (chi2_uncorr + scaleFac*chi2_correction );
  }

}

// ===================================================================
// == Fonction to be called for each point of each toy
// get the chi2 contribution for this toy at this point: M0 = m0 at the current point, M12 = m12 at the current point in the ntuple
// Idem as the function LHCchi2, but the chi2 is now taken from an histogram to speed up the procedure
// No correction to the A0-TanBeta dependancy is applied

float LHCchi2_fast_nocorr( float M0, float M12 ){

  // Without A0-TanBeta corrections
  return hChi2->Interpolate(M0,M12);

}





#endif
