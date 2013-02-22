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
vector<TH2D*> vCorr;

// ===================================================================
void setLHCchi2Tools( int PP_or_Toys, int randomSeed, bool verb, float bestFitM0, float bestFitM12, TString fit, int useObs ){

	 vector<int> M0Values;
	 M0Values.push_back(680);
	 M0Values.push_back(860);
	 M0Values.push_back(1080);
	 M0Values.push_back(1200);
	 M0Values.push_back(1400);
	 M0Values.push_back(1500);
	 M0Values.push_back(1962);
	 M0Values.push_back(2500);
	 int nM0Values = M0Values.size();


   if( verb ) cout << "   > Set up LHC tools.." << endl;

   if( PP_or_Toys == 1 )
     {
       // ATLAS 0lepton analysis 5.8/fb, 8TeV
       if( useObs != 17 ){
	 				fChi2 = new TFile( "AllChi2Maps.root" );
					hChi2 = (TH2D*) fChi2->Get("h_chi2");
	 				for( uint iM0 = 0; iM0 < nM0Values; ++iM0 ) {
						char histname[30];
						sprintf(histname, "h_chi2_corr_M0%i", M0Values[iM0]);
						vCorr.push_back( (TH2D*)fChi2->Get(histname) );
					}
					hChi2_corr = (TH2D*) fChi2->Get("h_chi2_corr_offgrid");
       }
       // ATLAS 0lepton analysis 4.7/fb, 7TeV
       if( useObs == 17 ){
	 fChi2 = new TFile( "LHCChi2Histogram_2011_7TeV_4.7ifb.root" );
	 hChi2 = (TH2D*) fChi2->Get("hist" );
       }
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


float LHCchi2_fast( float M0, float M12, float A0, float TanBeta ){
	return prov->GetChi2ContributionFix( M0, M12, A0, TanBeta, hChi2, vCorr );
}

float LHCchi2_fast_nocorr( float M0, float M12 ){
	return hChi2 -> Interpolate( M0, M12 );
}
#endif
