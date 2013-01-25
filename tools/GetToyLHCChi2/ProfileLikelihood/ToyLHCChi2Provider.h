#ifndef __TOYLHCCHI2PROVIDER__
#define __TOYLHCCHI2PROVIDER__

#include <iostream>
#include <fstream>
#include "TMath.h"
#include "TH2D.h"
#include "fstream"
#include "iostream"
#include <map>

#include <string>
#include <sstream>
#include <iostream>
//#include <stream.h>
#include <vector>
#include <map>
#include <utility>
#include <TVectorD.h>
#include <TMatrixD.h>
#include <TMatrixDSym.h>
#include <TH1.h>
#include <TH2D.h>
#include <TGraph.h>
//##include<leshouches.h>
#include <math.h>
#include<sstream> 
#include<TFile.h> 
#include <TCanvas.h>
#include "TRandom3.h"
#include "TF1.h"
#include "TStyle.h"
#include "RooFit.h"
#include "RooWorkspace.h"
#include "RooDataSet.h"
#include "RooAbsPdf.h"
#include "RooRealVar.h"
#include "RooStats/RooStatsUtils.h"
#include "RooMsgService.h"
#include "RooRandom.h"

using namespace std;
using namespace RooFit;
using namespace RooStats;

class ToyLHCChi2Provider {

	public:
	ToyLHCChi2Provider();
	ToyLHCChi2Provider( string gridFileName, float M0BF, float M12BF );
	~ToyLHCChi2Provider();
	void CreateChi2Histograms(float nmin, float nmax);
	vector<TH1D*> GetChi2Histograms( string hchi2FileName, int nmin, int nmax );
	float GetChi2ContributionFit( float M0, float M12, vector<float> nObs, vector<float> nExp );
	float GetChi2ContributionFit( float M0, float M12, vector<float> nObs, vector<float> nExp, vector<float> nSignal );
	float GetChi2ContributionFix( float M0, float M12, TH2D* hChi2);
	float GetChi2ContributionFix( float M0, float M12, float A0, float tanb, TH2D *hChi2_M0_M12, TH2D *h_Chi2_A0_tanb );
	float GetChi2ContributionToy( float M0, float M12, int nObs, int nmin, int nmax, vector<TH2D*> *vChi2 );
	vector<float> GetSignalExpectationBF();
	vector<float> GetSignalUncertaintyBF();
	vector<float> GetBackgroundExpectation();
	vector<float> GetBackgroundUncertainty();
	private:
	TFile *f_grids;
	vector<TH2D*> h_grids;
	RooWorkspace* wspace;
	RooAbsPdf *model;
	RooRealVar *s, *b, *n, *sigma_s, *sigma_b, *theta_s, *theta_b;
	RooArgSet *POI;
	RooDataSet *data;
	RooAbsReal *nll, *pll;

	vector<float> signalExpectationBF;
	vector<float> signalUncertaintyBF;
	vector<float> backgroundExpectation;
	vector<float> backgroundUncertainty;
};

#endif
