// example program for getting the LHC chi2 contribution at each point in the markovChain ntuple for toy experiments
// this program only calculates the chi2 for exactly _one_ point!

#include "ToyLHCChi2Provider.h"
#include "TRandom3.h"

int main( int argc, char **argv ) {
	
	if( argc < 2 ) { 
		cout << "usage: ./runTest <signalGrids.root> <randomSeed>" << endl;
	}

	// this is for documentation only: create a histogram which will hold the chi2 distribution for the tested point
	TH1D* h_chi2_dist = new TH1D("h_chi2", "h_chi2", 100, 0., 20. );
	

	// setup the random number generator
	TRandom3 rndm(atoi(argv[2]));	
	
	// setup the LCH Toy Chi2 provider: it takes 4 arguments:
	// 1st argument: name of the file holding the signal grids
	// 2nd argument: m0 at the best fit point
	// 3rd argument: m12 at the best fit point
	ToyLHCChi2Provider prov( argv[1], 1000., 500. );
	
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

	// setup the vector holding the number of observed events - this will be a random number thrown once per toy!
	vector<float> nObs;

	// define the number of toy experiments:
	int nToys = 1000;

	// loop over the toy experiments
	for( int iToy = 0; iToy < nToys; ++iToy ) {
		// for each toy, get a new set of observed events in the signal region
		// these are random numbers thrown according to the signal + background expectation at the best fit point!
		nObs.clear();
		nObs.push_back( rndm.Poisson(nExpBG[0]*rndm.Gaus(1.,uncBG[0])+nExpS[0]*rndm.Gaus(1.,uncS[0])));
		nObs.push_back( rndm.Poisson(nExpBG[1]*rndm.Gaus(1.,uncBG[1])+nExpS[1]*rndm.Gaus(1.,uncS[1])));
		nObs.push_back( rndm.Poisson(nExpBG[2]*rndm.Gaus(1.,uncBG[2])+nExpS[2]*rndm.Gaus(1.,uncS[2])));

		//cout << "this is toy experiment #" << iToy << " with nObs = " << nObs[0] << " " << nObs[1] << " " << nObs[2] << endl;
		// loop over all points in the markov chain. in this example program, only a single point is tested!!! replace the loops over m0 and m12 with one loop over all points in the markovChain ntuple\

		for( float M0 = 1000; M0 < 1010; M0 += 100) {
			for( float M12 = 500; M12 < 505; M12 += 10 ) {
				// get the chi2 contribution for this toy at this point: M0 = m0 at the current point, M12 = m12 at the current point in the ntuple
				// nObs and nExp have been defined before!
				float ToyChi2AtPoint = prov.GetChi2Contribution( M0, M12, nObs, nExp );
				cout << "got ToyChi2 " << ToyChi2AtPoint << endl;
				h_chi2_dist -> Fill( ToyChi2AtPoint );
			}
		}
		//cout << "-----------------------------------------" << endl;
	}

	// print the chi2 distribution
	TCanvas c("c","c");
	c.SetBorderMode(0);
	h_chi2_dist->Draw();
	c.Print("chi2.png");
}
