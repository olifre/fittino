#include "ToyLHCChi2Provider.h"
#include "TRandom3.h"


int main( int argc, char **argv ) {


	TH1D* h_chi2_dist = new TH1D("h_chi2", "h_chi2", 100, 0., 20. );


	TRandom3 rndm(atoi(argv[3]));
	ToyLHCChi2Provider prov(argv[1], argv[2], 400., 600. );
	vector<float> nExpS = prov.GetSignalExpectationBF();
	vector<float> uncS = prov.GetSignalUncertaintyBF();
	vector<float> nExpBG;
	nExpBG.push_back( 10.*20./0.165);
	nExpBG.push_back( 6.*20./0.165);
	nExpBG.push_back( 4.*20./0.165);

	vector<float> nExp;
	for( unsigned int iCh = 0; iCh < 3; ++iCh ) {nExp.push_back(nExpBG[iCh]+nExpS[iCh]);}
	for( unsigned int i = 0; i < 3; ++i ) {
		cout << "got nExp[" << i << "] = " << nExp[i] << endl;
	}
	vector<float> nObs;
	int nToys = 100000;
	for( int iToy = 0; iToy < nToys; ++iToy ) {
		nObs.clear();
		nObs.push_back( rndm.Poisson(nExpBG[0]*rndm.Gaus(1.,0.02)+nExpS[0]*rndm.Gaus(1.,uncS[0])));
		nObs.push_back( rndm.Poisson(nExpBG[1]*rndm.Gaus(1.,0.1)+nExpS[1]*rndm.Gaus(1.,uncS[1])));
		nObs.push_back( rndm.Poisson(nExpBG[2]*rndm.Gaus(1.,0.1)+nExpS[2]*rndm.Gaus(1.,uncS[2])));
		//cout << "nObs is " << nObs[0] << " " << nObs[1] << " " << nObs[2] << " ";
		//cout << "this is toy experiment #" << iToy << " with nObs = " << nObs[0] << " " << nObs[1] << " " << nObs[2] << endl;
		for( float M0 = 200; M0 < 210; M0 += 100) {
			for( float M12 = 550; M12 < 555; M12 += 10 ) {
				//cout << "for M0 = " << M0 << " and M12 = " << M12 << " I get a chi2 contribution of " << prov.GetChi2Contribution( M0, M12, nObs, nExp ) << endl;
				h_chi2_dist -> Fill( prov.GetChi2Contribution( M0, M12, nObs, nExp ) );
				//cout << "gives a chi2 of " << prov.GetChi2Contribution( M0, M12, nObs, nExp) << endl;
			}
		}
		//cout << "-----------------------------------------" << endl;
	}
	TCanvas c("c","c");
	c.SetBorderMode(0);
	h_chi2_dist->Draw();
	c.Print("chi.png");
}
