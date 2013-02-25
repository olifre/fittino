#include "ToyLHCChi2Provider.h"

float ToyLHCChi2Provider::GetChi2Contribution( float M0, float M12, vector<float> nObs, vector<float> nExp ) {
	//first: find best expected limit - best search channel
	unsigned int channel = 0;
	float CLsb_best = 10.;
	for( unsigned int iCh = 0; iCh < 3; ++iCh ) {
		float tobs = h_median_tobs_2D[iCh]->Interpolate(M0, M12);
		float t = h_median_t_2D[iCh]->Interpolate(M0,M12);
		float sigma_t = 0.5*(h_medianPlus1Sigma_t_2D[iCh]->Interpolate(M0,M12)-h_medianMinus1Sigma_t_2D[iCh]->Interpolate(M0,M12));
		float CLsb = 0.5*(1.-erf((tobs-t)/sqrt(2)/sigma_t));
		if( CLsb < CLsb_best ) { CLsb_best = CLsb; channel = iCh; }
	}
	// found best expected limit -> know which channel to use
	// now get t_obs according to the gaussian number given:
	float nSignal = h_grids[channel]->Interpolate(M0,M12)*20.;
	float tobs = 2.*nSignal - 2.*log(1.+nSignal/(nExp[channel]-signalExpectationBF[channel]))*nObs[channel];
	float t = h_median_t_2D[channel]->Interpolate(M0,M12);
	float sigma_t = 0.5*(h_medianPlus1Sigma_t_2D[channel]->Interpolate(M0,M12)-h_medianMinus1Sigma_t_2D[channel]->Interpolate(M0,M12));
	float CLsb = 0.5*(1.-erf((tobs-t)/sqrt(2.)/sigma_t));
	return (CLsb > 1.e-10 && 1. - CLsb > 1.e-10) ? 2*(TMath::ErfInverse(1.-2.*CLsb)*TMath::ErfInverse(1.-2.*CLsb)) : 1000.;  
}


ToyLHCChi2Provider::ToyLHCChi2Provider() {
	f_histograms = NULL;
	f_grids = NULL;
}

ToyLHCChi2Provider::ToyLHCChi2Provider( string histogramFileName, string gridFileName, float M0BF, float M12BF ) {
	f_histograms = new TFile( histogramFileName.c_str() );

	h_median_t_2D.push_back( (TH2F*)f_histograms->Get("h_median_t_2D_1") ); 
	h_median_t_2D.push_back( (TH2F*)f_histograms->Get("h_median_t_2D_2")); 
	h_median_t_2D.push_back( (TH2F*)f_histograms->Get("h_median_t_2D_3")); 
	h_median_tobs_2D.push_back( (TH2F*)f_histograms->Get("h_median_tobs_2D_1")); 
	h_median_tobs_2D.push_back( (TH2F*)f_histograms->Get("h_median_tobs_2D_2"));
	h_median_tobs_2D.push_back( (TH2F*)f_histograms->Get("h_median_tobs_2D_3"));
	h_medianPlus1Sigma_t_2D.push_back( (TH2F*)f_histograms->Get("h_medianPlus1Sigma_t_2D_1"));
	h_medianPlus1Sigma_t_2D.push_back( (TH2F*)f_histograms->Get("h_medianPlus1Sigma_t_2D_2"));
	h_medianPlus1Sigma_t_2D.push_back( (TH2F*)f_histograms->Get("h_medianPlus1Sigma_t_2D_3"));
	h_medianPlus1Sigma_tobs_2D.push_back( (TH2F*)f_histograms->Get("h_medianPlus1Sigma_tobs_2D_1"));
	h_medianPlus1Sigma_tobs_2D.push_back( (TH2F*)f_histograms->Get("h_medianPlus1Sigma_tobs_2D_2"));
	h_medianPlus1Sigma_tobs_2D.push_back( (TH2F*)f_histograms->Get("h_medianPlus1Sigma_tobs_2D_3"));
	h_medianMinus1Sigma_t_2D.push_back( (TH2F*)f_histograms->Get("h_medianMinus1Sigma_t_2D_1"));
	h_medianMinus1Sigma_t_2D.push_back( (TH2F*)f_histograms->Get("h_medianMinus1Sigma_t_2D_2"));
	h_medianMinus1Sigma_t_2D.push_back( (TH2F*)f_histograms->Get("h_medianMinus1Sigma_t_2D_3"));
	h_medianMinus1Sigma_tobs_2D.push_back( (TH2F*)f_histograms->Get("h_medianMinus1Sigma_tobs_2D_1"));
	h_medianMinus1Sigma_tobs_2D.push_back( (TH2F*)f_histograms->Get("h_medianMinus1Sigma_tobs_2D_2"));
	h_medianMinus1Sigma_tobs_2D.push_back( (TH2F*)f_histograms->Get("h_medianMinus1Sigma_tobs_2D_3"));

	f_grids = new TFile( gridFileName.c_str() );
	h_grids.push_back( (TH2D*)f_grids->Get("signalA") );
	h_grids.push_back( (TH2D*)f_grids->Get("signalB") );
	h_grids.push_back( (TH2D*)f_grids->Get("signalC") );


	float lumi = 20.;
	float lumi_ref = 1.;
	for( unsigned int iCh = 0; iCh < 3; ++iCh ) {
		signalExpectationBF.push_back( lumi/lumi_ref*h_grids[iCh]->Interpolate(M0BF,M12BF) );
		signalUncertaintyBF.push_back( (M0BF>=1000.) ? 0.15 : 0.1 );
		cout << "In SR " << iCh << " the signal expectation at the best fit has been determined to " << signalExpectationBF[iCh] << " with a relative uncertainty of " << signalUncertaintyBF[iCh] << endl;
	}
	
}

ToyLHCChi2Provider::~ToyLHCChi2Provider( ) {
	for( unsigned int i = 0; i < h_median_t_2D.size(); ++i ) {
		delete h_median_t_2D[i];
		delete h_median_tobs_2D[i];
		delete h_medianPlus1Sigma_t_2D[i];
		delete h_medianPlus1Sigma_tobs_2D[i];
		delete h_medianMinus1Sigma_t_2D[i];
		delete h_medianMinus1Sigma_tobs_2D[i];
		delete h_grids[i];
	}
	if( f_histograms->IsOpen() ) f_histograms->Close();
	if( f_histograms) delete f_histograms;
	if( f_grids->IsOpen() ) f_grids->Close();
	if( f_grids) delete f_grids;
}

vector<float> ToyLHCChi2Provider::GetSignalExpectationBF() {
	return signalExpectationBF; 
}

vector<float> ToyLHCChi2Provider::GetSignalUncertaintyBF() {
	return signalUncertaintyBF;
}
