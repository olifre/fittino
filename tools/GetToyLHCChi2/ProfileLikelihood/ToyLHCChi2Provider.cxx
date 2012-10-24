#include "ToyLHCChi2Provider.h"

void ToyLHCChi2Provider::CreateChi2Histograms( float nmin, float nmax ) {

	TFile *fOut = new TFile( "chi2_histograms.root", "RECREATE" );
	vector<float> vExpS = GetSignalExpectationBF();
	vector<float> vExpBG = GetBackgroundExpectation();
	vector<float> vExp;
  for( unsigned int iCh = 0; iCh < 3; ++iCh ) {vExp.push_back(vExpBG[iCh]+vExpS[iCh]);}

	vector<TH2D*> vHistograms;
	for( float nObs = nmin; nObs <= nmax; nObs += 1. ) {
		vector<float> vObs(3,nObs);
		char histname[20];
		sprintf( histname, "chi2_nObs_%i", (int)nObs );
		TH2D *h = new TH2D( histname, histname, 249, 15., 2505., 221, 97.5, 1202.5); 
		for( int binx = 1; binx <= 249; ++binx ) {
			for( int biny = 1; biny <= 221; ++biny ) {
				h -> SetBinContent(binx, biny, GetChi2ContributionFit( h->GetXaxis()->GetBinCenter(binx), h->GetYaxis()->GetBinCenter(biny), vObs, vExp ) );
			}
		}
		vHistograms.push_back(h);
		fflush(stdout);
	}
	
	for( unsigned iHist = 0; iHist < vHistograms.size(); ++iHist ) {
		vHistograms.at(iHist)->Write();
	}
	fOut->Write();
	fOut->Close();
}

vector<TH1D*> ToyLHCChi2Provider::GetChi2Histograms( string chi2FileName, int nmin, int nmax ) {

	vector<TH1D*> vHist; 
	TFile *fHist = new TFile( chi2FileName.c_str() );
	char histname[20];
	for( int i = nmin; i <= nmax; ++i ) {
		sprintf(histname, "chi2_nObs_%i", i );
		vHist.push_back( (TH1D*)fHist->Get(histname)->Clone("") );
	}
	return vHist;
}

float ToyLHCChi2Provider::GetChi2ContributionFix( float M0, float M12, TH1D* hChi2 ) {
	return hChi2->Interpolate(M0,M12);
}


float ToyLHCChi2Provider::GetChi2ContributionToy( float M0, float M12, int nObs, int nmin, int nmax, vector<TH1D*> *vChi2 ) {
	if( nmax - nmin + 1 != (int)vChi2->size()) {
		cout << "FATAL: provided vector of chi2 histograms does not correspond to the numbers nmin and nmax given! Returning negative value!" << endl;
		return -1;
	}
	return vChi2->at(nObs-nmin)->Interpolate(M0, M12);
}

float ToyLHCChi2Provider::GetChi2ContributionFit( float M0, float M12, vector<float> nObs, vector<float> nExp ) {
	//first: find best expected limit - best search channel
	if( M0 > 2500. ) M0 = 2500.;
	unsigned int channel = 0;
	//float chi2_max = -10.;
	float lumi = 50.;
	float lumi_ref = 1.;
	//RooRandom::randomGenerator()->SetSeed(1823571939);
	//cout << "using nExp = " << nExp[0] << ", " << nExp[1] << ", " << nExp[2] << endl;
	/*
	for( unsigned int iCh = 0; iCh < 3; ++iCh ) {
		n->setVal(nExp[iCh]);
		if( data ) delete data;
		data = new RooDataSet("data", "data", RooArgSet(*n));
		data->add(*n);
		b->setVal(backgroundExpectation[iCh]);
		
		if( nll ) delete nll;
		nll = model->createNLL(*data);
		
		if( pll ) delete pll;
		pll = nll->createProfile(*POI);
		double nS = lumi/lumi_ref*h_grids[iCh]->Interpolate(M0,M12);
		if (M0<400)  nS=nS-0.9*nS*(400-M0)/400;
		else if (M0<1800 && M0>1000)  nS=nS-nS*(1000-M0)/1000*(1800-M0)/1800;
		else if (M0>1800)  nS=nS+nS*(1800-M0)/1800;
		s->setVal(nS);
		double chi2 = 2.*pll->getVal();
		//cout << " in channel " << iCh << " the expected chi2 is " << chi2 << endl;
		if( chi2 > chi2_max ) { chi2_max = chi2; channel = iCh; }
	}
	*/

	//cout << "chose region " << channel << " with " << chi2_max << endl;	
	
	channel = 1;
	if( data ) delete data;
	if( nll ) delete nll;
	if( pll ) delete pll;

	n->setVal(nObs[channel]);
	data = new RooDataSet("data","data", RooArgSet(*n));
	data->add(*n);
	b->setVal(backgroundExpectation[channel]);
	nll = model->createNLL(*data);
	pll = nll->createProfile(*POI);
	double nS = lumi/lumi_ref*h_grids[channel]->Interpolate(M0,M12);
	if (M0<400.)  nS=nS-0.9*nS*(400.-M0)/400.;
	else if (M0<1800. && M0>1000.)  nS=nS-nS*(1000.-M0)/1000.*(1800.-M0)/1800.;
	else if (M0>1800.)  nS=nS+nS*(1800.-M0)/1800.;
	//cout << "signal expectation is " << nS << endl;
	s->setVal(nS);
	double chi2 = 2.*pll->getVal(); 
	return (isnan(chi2) || isinf(chi2)) ? 1000. : ( (chi2 < 0.) ? 0. : chi2); 
}


ToyLHCChi2Provider::ToyLHCChi2Provider() {
	f_grids = NULL;

}

ToyLHCChi2Provider::ToyLHCChi2Provider( string gridFileName, float M0BF, float M12BF ) {

	if( M0BF > 2500. ) M0BF = 2500.;

	RooMsgService::instance().setStreamStatus(0, kFALSE);
  RooMsgService::instance().setStreamStatus(1, kFALSE);
	// Open Signal Grids File and get Signal Expectation in each region for the Best Fit Point
	f_grids = new TFile( gridFileName.c_str() );
	h_grids.push_back( (TH2D*)f_grids->Get("signalA") );
	h_grids.push_back( (TH2D*)f_grids->Get("signalB") );
	h_grids.push_back( (TH2D*)f_grids->Get("signalC") );
	cout << "opened file and read histograms" << endl;

	float lumi = 50.;
	float lumi_ref = 1.;
	
	backgroundExpectation.push_back( 5./0.165*lumi );
	backgroundExpectation.push_back( 1./0.165*lumi );
	backgroundExpectation.push_back( 7./0.165*lumi );
	backgroundUncertainty.push_back( 0.03 );
	backgroundUncertainty.push_back( 0.03 );
	backgroundUncertainty.push_back( 0.03 );

	for( unsigned int iCh = 0; iCh < 3; ++iCh ) {
		float nExpSignal = lumi/lumi_ref*h_grids[iCh]->Interpolate(M0BF, M12BF);
		if( M0BF < 400. ) nExpSignal = nExpSignal - 0.9*nExpSignal*(400.-M0BF)/400.;
		else if( M0BF < 1800. && M0BF > 1000. ) nExpSignal = nExpSignal - nExpSignal*(1000.-M0BF)/1000.*(1800.-M0BF)/1800.;
		else if( M0BF > 1800. ) nExpSignal = nExpSignal+nExpSignal*(1800.-M0BF)/1800.;
		signalExpectationBF.push_back( nExpSignal );
		signalUncertaintyBF.push_back( 0.1 );
		
		cout << "In SR " << iCh << " the signal expectation at the best fit has been determined to " << signalExpectationBF[iCh] << " with a relative uncertainty of " << signalUncertaintyBF[iCh] << endl;

	}
	
	wspace = new RooWorkspace();
	wspace->factory("Poisson::pois(n[50,0,1e10], sum(s[1,0,10000]*theta_s[1,0,100],b[1]*theta_b[1.,0.,100]))");
	wspace->factory("Gaussian::sig(1,theta_s, sigma_s[0.1,0,1])");
	wspace->factory("Gaussian::bkg(1, theta_b, sigma_b[0.1,0,1])");
	wspace->factory("PROD::model(pois, sig, bkg)");
	model = wspace->pdf("model");
	s = wspace->var("s");
	b = wspace->var("b");
	n = wspace->var("n");
	sigma_s = wspace->var("sigma_s");
	sigma_b = wspace->var("sigma_b");
	theta_s = wspace->var("theta_s");
	theta_b = wspace->var("theta_b");
	POI = new RooArgSet(*s);
	b->setConstant();
	sigma_s->setConstant();
	sigma_s->setVal(0.1);
	sigma_b->setConstant();
	sigma_b->setVal(0.03);
	data = NULL;
	nll = NULL;
	pll = NULL;
}

ToyLHCChi2Provider::~ToyLHCChi2Provider( ) {
	
	if( f_grids->IsOpen() ) f_grids->Close();
	if( f_grids) delete f_grids;
	if( wspace ) delete wspace;
	if( POI ) delete POI;
}

vector<float> ToyLHCChi2Provider::GetSignalExpectationBF() {
	return signalExpectationBF; 
}

vector<float> ToyLHCChi2Provider::GetSignalUncertaintyBF() {
	return signalUncertaintyBF;
}

vector<float> ToyLHCChi2Provider::GetBackgroundExpectation() {
	return backgroundExpectation; 
}

vector<float> ToyLHCChi2Provider::GetBackgroundUncertainty() {
	return backgroundUncertainty;
}