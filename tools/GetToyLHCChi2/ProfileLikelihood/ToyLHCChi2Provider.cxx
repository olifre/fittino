#include "ToyLHCChi2Provider.h"

float ToyLHCChi2Provider::GetChi2Contribution( float M0, float M12, vector<float> nObs, vector<float> nExp ) {
	//first: find best expected limit - best search channel
	unsigned int channel = 0;
	//float chi2_max = -10.;
	float lumi = 50.;
	float lumi_ref = 1.;
	
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
	if (M0<400)  nS=nS-0.9*nS*(400-M0)/400;
	else if (M0<1800 && M0>1000)  nS=nS-nS*(1000-M0)/1000*(1800-M0)/1800;
	else if (M0>1800)  nS=nS+nS*(1800-M0)/1800;
	//cout << "signal expectation is " << nS << endl;
	s->setVal(nS);
	return 2.*pll->getVal();
}


ToyLHCChi2Provider::ToyLHCChi2Provider() {
	f_grids = NULL;

}

ToyLHCChi2Provider::ToyLHCChi2Provider( string gridFileName, float M0BF, float M12BF ) {

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
		if( M0BF < 400. ) nExpSignal = nExpSignal - 0.9*(400.-M0BF)/400.;
		else if( M0BF < 1800. && M0BF > 1000. ) nExpSignal = nExpSignal - nExpSignal*(1000.-M0BF)/1000.*(1800.-M0BF)/1800.;
		else if( M0BF > 1800. ) nExpSignal = nExpSignal+nExpSignal*(1800.-M0BF)/1800.;
		signalExpectationBF.push_back( nExpSignal );
		signalUncertaintyBF.push_back( 0.1 );
		
		cout << "In SR " << iCh << " the signal expectation at the best fit has been determined to " << signalExpectationBF[iCh] << " with a relative uncertainty of " << signalUncertaintyBF[iCh] << endl;

	}
	
	wspace = new RooWorkspace();
	wspace->factory("Poisson::pois(n[50,0,1e10], sum(s[1,0,10000]*theta_s[1,0,10000],b[1]*theta_b[1.,0.,10000]))");
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
