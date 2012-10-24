// example program for getting the LHC chi2 contribution at each point in the markovChain ntuple for toy experiments
// this program only calculates the chi2 for exactly _one_ point!

#include "ToyLHCChi2Provider.h"
#include "TRandom3.h"

int main( int argc, char **argv ) {

	if( argc < 2 ) { 
		cout << "usage: ./createHistograms <signalGrids.root> <randomSeed>" << endl;
	}

	// setup the random number generator
	TRandom3 rndm(atoi(argv[2]));	
	
	// setup the LCH Toy Chi2 provider: it takes 4 arguments:
	// 1st argument: name of the file holding the signal grids
	// 2nd argument: m0 at the best fit point
	// 3rd argument: m12 at the best fit point
	ToyLHCChi2Provider prov( argv[1], 5000., 5000. );
	
	// get the signal expectation in the 3 signal regions for the best fit point
	// also get the systematics on the signal expectation in the three signal regions for the best fit point
	vector<float> nExpS = prov.GetSignalExpectationBF();
	vector<float> uncS = prov.GetSignalUncertaintyBF();

	// setup the background expectation in the 3 signal regions:
	vector<float> nExpBG = prov.GetBackgroundExpectation();
	vector<float> uncBG = prov.GetBackgroundUncertainty();

	// add signal expectation at best fit point and background expectation to get the total expecation in the three signal regions:
	vector<float> nExp;
	for( unsigned int iCh = 0; iCh < 3; ++iCh ) {nExp.push_back(nExpBG[iCh]+nExpS[iCh]);}
	for( unsigned int i = 0; i < 3; ++i ) {
		cout << "got nExp[" << i << "] = " << nExp[i] << endl;
	}

	// now create the histograms	
	cout << "have argc = " << argc << endl;
	int nmin = (argc > 4 ) ? atoi(argv[3]) : (int)(nExp[1] - 5.* sqrt(nExp[1]) +0.5);
	int nmax = (argc > 4 ) ? atoi(argv[4]) : (int)(nExp[1] + 5.* sqrt(nExp[2]) +0.5);

	cout << "got nmin = " << nmin << " and nmax = " << nmax << endl;
	prov.CreateChi2Histograms((float)nmin,(float)nmax);

}
