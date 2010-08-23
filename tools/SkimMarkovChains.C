
// This ROOT macro skims the markov chains produced by Fittino 

#include "TStyle.h"
#include "TLeafD.h"
#include "TFile.h"
#include "TDirectory.h"
#include "TChain.h"
#include "TCanvas.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TList.h"
#include "TLine.h"
#include "TLeaf.h"
#include "TObjArray.h"
#include "iostream"
#include "string"
#include "vector"
using namespace std;

// typical chi2 minima without the points with the bug:
// markov.le_obs.only.4paras: 20.587

void SkimMarkovChains ( string outputRootFileName = "MarkovChainNtupFileSkimmed.root", 
			double maxDeltaChi2 = 6.2, 
			int maxevents = -1,
			double absMinChi2 = 0. ) {

  TChain markovChain("markovChain");
  markovChain.Add("MarkovChainNtupFile*.root");
  // markovChain.Add("MarkovTestRosenbrockNTupel.root");
  markovChain.Print();

  int nEntries = markovChain.GetEntries();
  if ( maxevents >= 0 ) {
    if (nEntries > maxevents) nEntries = maxevents;
  }
  std::cout << "number of entries " << nEntries << std::endl;

  const int nLeaves = markovChain.GetListOfLeaves()->GetEntries();
  std::cout << "number of leaves " << nLeaves << std::endl;

  float* par   = new float[nLeaves];
  //float* par   = new float[10000];
  //float par[10000];
  TLeafD* leaf[nLeaves];
  int iChi2 = -1;
  int iLikelihood = -1;
  int iTanBeta = -1;
  int iM0      = -1;
  int iM12     = -1;
  int iA0      = -1;
  int iCgrav   = -1;
  int iMmess   = -1;
  int iLambda  = -1;

  // get leaves
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
    leaf[iLeaf] = (TLeafD*)markovChain.GetListOfLeaves()->At(iLeaf);
    leaf[iLeaf]->SetAddress(&par[iLeaf]);
    if (!strcmp(leaf[iLeaf]->GetName(), "chi2")) {
      iChi2 = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "likelihood")) {
      iLikelihood = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_TanBeta")) {
      iTanBeta = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_M0")) {
      iM0 = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_M12")) {
      iM12 = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_A0")) {
      iA0 = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_Lambda")) {
      iLambda = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_Mmess")) {
      iMmess = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_cGrav")) {
      iCgrav = iLeaf;
    }
    
  } 

  if (iChi2<0) {
    cout << "input tree incomplete" << endl;
    return;
  }
  if (iLikelihood<0) {
    cout << "input tree incomplete" << endl;
    return;
  }
  

  // create new output tree
  TFile* outputRootFile = new TFile (outputRootFileName.c_str(),"RECREATE");
  TTree* newTree = new TTree ("markovChain","Skimmed MarkovChainTree");
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
     string str = leaf[iLeaf]->GetName();
     str.append("/F");
     //cout << "Adding branch " << yyFittedPar[k].name.c_str() << " to tree" << endl;
     newTree->Branch(leaf[iLeaf]->GetName(), &par[iLeaf], str.c_str());
     str.erase();
  }

  cout << "looping over events to find minimal chi2 at iChi2 = " << iChi2 << " iLikelihood = " << iLikelihood << endl;

  // clean up NPFitter bug
  // absMinChi2 = 31.;

  // find minimal chi2
  float minChi2 = 10000000.;
  for (Int_t i=0; i<nEntries; i++) {
    markovChain.GetEntry(i);	
    float chi2 =  par[iChi2];
    if (chi2<0.) {
      continue;
    }   
    // cout << "chi2 = " << chi2 << " " << par[iChi2] <<  " " << par[0] << endl; 
    if (chi2<minChi2 && chi2>=absMinChi2) {
      minChi2 = chi2;
    }
  }

  cout << "minimal chi2 found at " << minChi2 << " for iChi2 = " << iChi2 << endl;

  // fill events
  int nNewEvents = 0;
  for (Int_t i=0; i<nEntries; i++) {
    markovChain.GetEntry(i);	
    double chi2 =  par[iChi2];
    //    cout << "chi2 = " << chi2 << endl;
    if (chi2>maxDeltaChi2+minChi2) {
      continue;
    }
    if (chi2<absMinChi2) {
      continue;
    }   
//    // clean up NPfitter bug
//    if (chi2<minChi2+1.) {
//      if (iLambda>=0) {
//	if (42400. > par[iLambda] || par[iLambda] > 72800.) {
//	  continue;
//	}
//      }
//      if (iTanBeta>=0) {
//	if (12. > par[iTanBeta] || par[iTanBeta] > 33.5 ) {
//	  continue;
//	}
//      }
//      if (iM0>=0) {
//	if (0. > par[iM0] || par[iM0] > 170. ) {
//	  continue;
//	}
//      }
//      if (iM12>=0) {
//	if (240. > par[iM12] || par[iM12] > 444. ) {
//	  continue;
//	}
//      }
//      if (iA0>=0) {
//	if (-350. > par[iA0] || par[iA0] > 1250. ) {
//	  continue;
//	}
//      }
//    }
//    else if (chi2<minChi2+6.) {
//      if (iTanBeta>=0) {
//	if (3.0 > par[iTanBeta] || par[iTanBeta] > 52. ) {
//	  continue;
//	}
//      }
//      if (iM0>=0) {
//	if (0. > par[iM0] || par[iM0] > 695. ) {
//	  continue;
//	}
//      }
//      if (iM12>=0) {
//	if (185. > par[iM12] || par[iM12] > 890. ) {
//	  continue;
//	}
//      }
//      if (iA0>=0) {
//	if (-1301. > par[iA0] || par[iA0] > 2400. ) {
//	  continue;
//	}
//      }
//    }
    // end clean up
    if (iTanBeta>=0) {
      if (par[iTanBeta]>100. || par[iTanBeta]<0.) {
	continue;
      }
    }
    if (iM0>=0) {
      if (par[iM0]>10000. || par[iM0]<0.) {
	continue;
      }
    }
    if (iM12>=0) {
      if (par[iM12]>10000. || par[iM12]<0.) {
	continue;
      }
    }
    if (iA0>=0) {
      if (par[iA0]>10000. || par[iA0]<-10000.) {
	continue;
      }
    }
    if (iLambda>=0) {
      if (par[iLambda]>1000000000. || par[iLambda]<0.) {
	continue;
      }
    }
    if (iMmess>=0) {
      if (par[iMmess]>1000000000. || par[iMmess]<0.) {
	continue;
      }
    }
    if (iCgrav>=0) {
      if (par[iCgrav]>1000000. || par[iCgrav]<0.) {
	continue;
      }
    }
    nNewEvents++;
    newTree->Fill();
  }
  
  cout << "found " << nNewEvents << " events after skim" <<  endl;

  newTree->Write();
  outputRootFile->Close();

  return;

}
