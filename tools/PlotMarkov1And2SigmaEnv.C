
// This ROOT macro plots the markov chains produced by Fittino 
// in the projections of the mSUGRA high-scale parameters. 
// The asymed statistics is bayesian. Shame on me. An alternative 
// frequentist interpretation will follow soon. 

#include "TStyle.h"
#include "TROOT.h"
#include "TFile.h"
#include "TDirectory.h"
#include "TChain.h"
#include "TCanvas.h"
#include "TLeafD.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TList.h"
#include "TLine.h"
#include "TMath.h"
#include "TObjArray.h"
#include "iostream"
#include "fstream"
#include "string"
#include "vector"
using namespace std;

// void PlotMarkovChains2D (bool bayes = true, int maxevents = -1);

void PlotMarkov1And2SigmaEnv ( int maxevents = -1,
			       string inputFileName = "markovContours.root")
{
  //gROOT->SetStyle("MyStyle");
  //gROOT->ForceStyle();

  gStyle->SetOptStat(0);
  // enforce a palette with 6 levels:
  //  gStyle->SetPalette(1);
  Int_t colors[7] = {kBlue+1,kBlue+2,kBlue+3,kBlue+4,kRed,kRed+1,kRed+2};
  gStyle->SetPalette(7,colors);
  gStyle->SetNumberContours(7);

  // open root file
  TFile* inputRootFile = new TFile(inputFileName.c_str(), "read");
  
  if ( !inputRootFile ) {
    printf("Problem accessing file %s\n", inputFileName.c_str());
    return;
  }
  
  TTree* markovChain = (TTree*)inputRootFile->Get("markovChain");
  
  if ( !markovChain ) {
    printf("Problem accessing tree markovChain\n");
    return;
  }



  // open text file
  ofstream markovFitsFile ("markovFitsResults.txt",ios::out);

  int nEntries = markovChain->GetEntries();
  if ( maxevents >= 0 ) {
    if (nEntries > maxevents) nEntries = maxevents;
  }

  std::cout << "number of entries " << nEntries << std::endl;

  // create and initialize variables
  int nbins = 200;

  Int_t iChi2Leaf = -1; // leaf index of chi2 leaf

  // look if all the branches are there
  const Int_t nLeaves = markovChain->GetListOfLeaves()->GetEntriesFast();
  TH1F*    histo[nLeaves];
  float par[nLeaves];
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
    TLeafD* leaf = (TLeafD*)markovChain->GetListOfLeaves()->At(iLeaf);
    leaf->SetAddress(&par[iLeaf]);
    
    cout << "attaching leave " << leaf->GetName() << endl;

    // find extensions
    Double_t mintree = 100.;//markovChain->GetMinimum(leaf->GetName());
    Double_t maxtree = 1000.;//markovChain->GetMaximum(leaf->GetName());
    Double_t min = mintree - 0.15 * (maxtree - mintree);
    Double_t max = maxtree + 0.15 * (maxtree - mintree);
    histo[iLeaf] = new TH1F(leaf->GetName(), "" /*leaf->GetTitle()*/, nbins, min, max);

    if (!strcmp(leaf->GetName(), "chi2")) {
      iChi2Leaf = iLeaf;
    }
    
  }

  std::cout << "attached " << nLeaves << " leaves" << std::endl;

  double lowestChi2 = 10000000000000.;
  for (Int_t i=0; i<nEntries; i++) {
    markovChain->GetEntry(i);
    if (par[iChi2Leaf]<0.) continue;
    lowestChi2 = par[iChi2Leaf];
  }

  cout << "lowest chi2 = " << lowestChi2 << endl;

  double f1sigmaUpperBound[nLeaves];
  double f1sigmaLowerBound[nLeaves];
  double f2sigmaUpperBound[nLeaves];
  double f2sigmaLowerBound[nLeaves];
  double fBestFit[nLeaves];
  string varNames[nLeaves];

  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
    TLeafD* leaf = (TLeafD*)markovChain->GetListOfLeaves()->At(iLeaf);
    
    f1sigmaUpperBound[iLeaf] = -100000000.;
    f1sigmaLowerBound[iLeaf] =  100000000.;
    f2sigmaUpperBound[iLeaf] = -100000000.;
    f2sigmaLowerBound[iLeaf] =  100000000.;
    fBestFit[iLeaf] = 0.;
    varNames[iLeaf] = leaf->GetName();
    
  }

  for (int i = 0; i < nEntries; i++) {
    markovChain->GetEntry(i);
    if (par[iChi2Leaf]<0.) continue;
    
    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
      if (par[iChi2Leaf]<lowestChi2+1.) {
	if (f1sigmaUpperBound[iLeaf]<par[iLeaf]) f1sigmaUpperBound[iLeaf] = par[iLeaf];
	if (f1sigmaLowerBound[iLeaf]>par[iLeaf]) f1sigmaLowerBound[iLeaf] = par[iLeaf];
      }
      if (par[iChi2Leaf]<lowestChi2+4.) {
	if (f2sigmaUpperBound[iLeaf]<par[iLeaf]) f2sigmaUpperBound[iLeaf] = par[iLeaf];
	if (f2sigmaLowerBound[iLeaf]>par[iLeaf]) f2sigmaLowerBound[iLeaf] = par[iLeaf];
      }
      if (par[iChi2Leaf]<=lowestChi2+0.000000001) fBestFit[iLeaf] = par[iLeaf];
    }

  }
  
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
    cout << varNames[iLeaf] 
	 << " = " << fBestFit[iLeaf] 
	 << " + " << f1sigmaUpperBound[iLeaf] - fBestFit[iLeaf]
	 << " - " << fBestFit[iLeaf] - f1sigmaLowerBound[iLeaf]
	 << " ( + " << f2sigmaUpperBound[iLeaf] - fBestFit[iLeaf]
	 << " - " << fBestFit[iLeaf] - f2sigmaLowerBound[iLeaf]
	 << " ) " << endl;
    markovFitsFile << varNames[iLeaf] 
	 << "\t = " << fBestFit[iLeaf] 
	 << "\t + " << f1sigmaUpperBound[iLeaf] - fBestFit[iLeaf]
	 << "\t - " << fBestFit[iLeaf] - f1sigmaLowerBound[iLeaf]
	 << "\t ( + " << f2sigmaUpperBound[iLeaf] - fBestFit[iLeaf]
	 << " - " << fBestFit[iLeaf] - f2sigmaLowerBound[iLeaf]
	 << " ) " << endl;

  }

  inputRootFile->Close();
  markovFitsFile.close();

  return;

}
