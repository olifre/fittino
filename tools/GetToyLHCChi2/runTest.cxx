#include "ToyLHCChi2Provider.h"
#include "TRandom3.h"


int main( int argc, char **argv ) {

	TRandom3 rndm(atoi(argv[3]));
	ToyLHCChi2Provider prov(argv[1], argv[2] );
	vector<float> nExp;
	nExp.push_back( 10.*20./0.165);
	nExp.push_back( 6.*20./0.165);
	nExp.push_back( 4.*20./0.165);
	vector<float> nObs;
	for( int nToy = 0; nToy < 10; ++nToy ) {
		nObs.clear();
		nObs.push_back( rndm.Poisson(nExp[0]));
		nObs.push_back( rndm.Poisson(nExp[1]));
		nObs.push_back( rndm.Poisson(nExp[2]));
		cout << "this is toy experiment #" << nToy << " with nObs = " << nObs[0] << " " << nObs[1] << " " << nObs[2] << endl;
		for( float M0 = 200; M0 < 2500; M0 += 100 ) {
			for( float M12 = 200; M12 < 800; M12 += 100 ) {
				cout << "for M0 = " << M0 << " and M12 = " << M12 << " I get a chi2 contribution of " << prov.GetChi2Contribution( M0, M12, nObs, nExp ) << endl;
			}
		}
		cout << "-----------------------------------------" << endl;
	}

}
