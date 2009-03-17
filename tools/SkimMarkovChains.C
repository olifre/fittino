
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
#include "TObjArray.h"
#include "iostream"
#include "string"
#include "vector"
using namespace std;

void SkimMarkovChains ( string outputRootFileName = "MarkovChainNtupFileSkimmed.root", 
			double maxDeltaChi2 = 6.2, 
			int maxevents = -1 ) {

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
  TLeafD* leaf[nLeaves];
  int iChi2 = 0;
  int iLikelihood = 0;
  
  // get leaves
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
    leaf[iLeaf] = (TLeafD*)markovChain.GetListOfLeaves()->At(iLeaf);
    leaf[iLeaf]->SetAddress(&par[iLeaf]);
    if (!strcmp(leaf[iLeaf]->GetName(), "chi2")) {
      iChi2 = iLeaf;
    }
    if (!strcmp(leaf[iLeaf]->GetName(), "likelihood")) {
      iLikelihood = iLeaf;
    }
  } 

  TFile* outputRootFile = new TFile (outputRootFileName.c_str(),"RECREATE");
  TTree* newTree = new TTree ("markovChain","Skimmed MarkovChainTree");
  
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
     string str = leaf[iLeaf]->GetName();
     str.append("/F");
     //cout << "Adding branch " << yyFittedPar[k].name.c_str() << " to tree" << endl;
     newTree->Branch(leaf[iLeaf]->GetName(), &par[iLeaf], str.c_str());
     str.erase();
  }

  cout << "looping over events to find minimal chi2" << endl;

  // find minimal chi2
  float minChi2 = 10000000.;
  for (Int_t i=0; i<nEntries; i++) {
    markovChain.GetEntry(i);	
    double chi2 =  par[iChi2];
    if (chi2<minChi2) {
      minChi2 = chi2;
    }
  }
  
  cout << "minimal chi2 found at " << minChi2 << endl;

  // fill events
  int nNewEvents = 0;
  for (Int_t i=0; i<nEntries; i++) {
    markovChain.GetEntry(i);	
    double chi2 =  par[iChi2];
    //    cout << "chi2 = " << chi2 << endl;
    if (chi2>maxDeltaChi2+minChi2) {
      continue;
    }
    nNewEvents++;
    newTree->Fill();
  }
  
  cout << "found " << nNewEvents << " events after skim" <<  endl;

  newTree->Write();
  outputRootFile->Close();

  return;

}
