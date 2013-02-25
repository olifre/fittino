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

using namespace std;

class ToyLHCChi2Provider {

	public:
	ToyLHCChi2Provider();
	ToyLHCChi2Provider( string histogramFileName, string gridFileName, float M0BF, float M12BF );
	~ToyLHCChi2Provider();
	float GetChi2Contribution( float M0, float M12, vector<float> nObs, vector<float> nExp );
	vector<float> GetSignalExpectationBF();
	vector<float> GetSignalUncertaintyBF();
	private:
	TFile *f_histograms;
	TFile *f_grids;
	vector<TH2F*> h_median_t_2D;
	vector<TH2F*> h_median_tobs_2D;
	vector<TH2F*> h_medianPlus1Sigma_t_2D;
	vector<TH2F*> h_medianPlus1Sigma_tobs_2D;
	vector<TH2F*> h_medianMinus1Sigma_t_2D;
	vector<TH2F*> h_medianMinus1Sigma_tobs_2D;
	vector<TH2D*> h_grids;
	vector<float> signalExpectationBF;
	vector<float> signalUncertaintyBF;
};

#endif
