
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

void Get1and2sigmaUncertaintiesFromMarkovs ( int maxevents = -1,
					     string inputFileName = "markovContours.root",
					     bool doAlsoSM = false,
					     string model = "mSUGRA" )
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


  // markov chains
  vector<string> variables; 
  // variables.push_back("X");
  // variables.push_back("Y");

  // mSUGRA
  if (model=="mSUGRA") {
    variables.push_back("P_TanBeta");
    variables.push_back("P_M12"); 
    variables.push_back("P_M0");
    variables.push_back("P_A0");
  }
  else if (model=="GMSB") {
    variables.push_back("P_TanBeta");
    variables.push_back("P_Lambda"); 
    variables.push_back("P_Mmess");
    variables.push_back("P_cGrav");
  }
  else if (model=="allLowScale") {
    variables.push_back("P_TanBeta");
    variables.push_back("P_M12"); 
    variables.push_back("P_M0");
    variables.push_back("P_A0");
    variables.push_back("P_Lambda"); 
    variables.push_back("P_Mmess");
    variables.push_back("P_cGrav");
  }  
  else if (model=="Pheno") {
    variables.push_back("O_massNeutralino1_nofit");
    variables.push_back("O_Omega_npf"); 
    variables.push_back("O_massStau1_nofit"); 
    variables.push_back("O_Omega_npf_nofit"); 
  }
  else if (model=="MSSM") {
  // MSSM
    variables.push_back("P_MSelectronL");
    variables.push_back("P_MSelectronR");
    variables.push_back("P_MStauL");
    variables.push_back("P_MStauR");
    variables.push_back("P_MSupL");
    variables.push_back("P_MSupR");
    variables.push_back("P_MSbottomR");
    variables.push_back("P_MStopL");
    variables.push_back("P_MStopR");
    variables.push_back("P_TanBeta");
    variables.push_back("P_Mu");
    variables.push_back("P_Xtau");
    variables.push_back("P_Xtop");
    variables.push_back("P_Xbottom");
    variables.push_back("P_M1");
    variables.push_back("P_M2");
    variables.push_back("P_M3");
    variables.push_back("P_massA0");
  }
  else {
    cout << "unknown model " << model << endl;
    return;
  }

  // SM
  if (doAlsoSM) {
    variables.push_back("P_alphas");
    variables.push_back("P_alphaem");
    variables.push_back("P_massZ"); 
    variables.push_back("P_massTop");
    variables.push_back("P_G_F");    
  }

  // create and initialize variables
  vector<float> varValues;
  for (unsigned int i = 0; i < variables.size(); i++) {
    varValues.push_back(0.);
  }
  float haveAcceptedAtLeastOne;
  float nStep;
  float likelihood;
  float chi2;

  vector<bool> varThere;

  // look if all the branches are there
  const Int_t nLeaves = markovChain->GetListOfLeaves()->GetEntriesFast();
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
    TLeafD* leaf = (TLeafD*)markovChain->GetListOfLeaves()->At(iLeaf);
    for (unsigned int iVar = 0; iVar < variables.size(); iVar++) {
      varThere.push_back(false);
      if (leaf->GetName()==variables[iVar]) {
	varThere[iVar] = true;
	break;
      }
    }
  }
  for (unsigned int iVar = 0; iVar < variables.size(); iVar++) {
    if (!varThere[iVar]) {
      cout << "WARNING: Variable " << variables[iVar] << " not found in the tree" << endl;
    }
  }

  // attach variables to ntuple
  for (unsigned int i = 0; i < variables.size(); i++) {
    if (varThere[i]) {
      markovChain->SetBranchAddress(variables[i].c_str(),&varValues[i]);
    }
  }
  markovChain->SetBranchAddress("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne);
  markovChain->SetBranchAddress("n",&nStep);
  markovChain->SetBranchAddress("likelihood",&likelihood);
  markovChain->SetBranchAddress("chi2",&chi2);



  double absHighestL = 0.;
  for (Int_t i=0; i<nEntries; i++) {
    markovChain->GetEntry(i);
    if (chi2<0.) continue;
    if (likelihood > absHighestL) {
      if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {		
	absHighestL = likelihood;
      }
    }
  }

  cout << "lowest chi2 = " << - 2 * TMath::Log(absHighestL) << endl;

  for (unsigned int fVariable = 0; fVariable < variables.size(); fVariable++)
    {

      if (!varThere[fVariable]) continue;
      
      double f1sigmaUpperBound = -100000000.;
      double f1sigmaLowerBound =  100000000.;
      double f2sigmaUpperBound = -100000000.;
      double f2sigmaLowerBound =  100000000.;
      double fBestFit = 0.;

     // find extensions
      double fVarMax = -1000000000.;
      double fVarMin =  1000000000.;
      double valMin = 100000000.;
      for (int i = 0; i < nEntries; i++) {
	markovChain->GetEntry(i);
	if (chi2<0.) continue;
	if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {		
	  
	  double val = 2 * TMath::Log(absHighestL)
	    - 2 * TMath::Log(likelihood);
	  
	  if (varValues[fVariable]>fVarMax && val<6.01) {
	    fVarMax = varValues[fVariable];
	  }
	  if (varValues[fVariable]<fVarMin && val<6.01) {
	    fVarMin = varValues[fVariable];
	  }
		  
//		  cout << "minimal chi2 = " << - 2 * TMath::Log(absHighestL) 
//		       << " this chi2 = " << - 2 * TMath::Log(likelihood)
//		       << " val = " << val 
//		       << endl;
	  if (val<1.) {
	    //		    cout << "found point within 1s at " << val << endl;
	    if (val<valMin) {
	      valMin = val;
	      fBestFit = varValues[fVariable];
	    }
	    if (varValues[fVariable]<f1sigmaLowerBound) {
	      if (variables[fVariable]=="P_TanBeta") {
		if (varValues[fVariable]>100.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_M0") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_M12") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_A0") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<-10000.)   continue;
	      }
	      f1sigmaLowerBound = varValues[fVariable];
	    }
	    if (varValues[fVariable]>f1sigmaUpperBound) {
	      if (variables[fVariable]=="P_TanBeta") {
		if (varValues[fVariable]>100.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_M0") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_M12") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_A0") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<-10000.)   continue;
	      }
	      f1sigmaUpperBound = varValues[fVariable];
	    }
	  }
	  if (val<4.) {
	    if (varValues[fVariable]<f2sigmaLowerBound) {
	      if (variables[fVariable]=="P_TanBeta") {
		if (varValues[fVariable]>100.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_M0") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_M12") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_A0") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<-10000.)   continue;
	      }
	      f2sigmaLowerBound = varValues[fVariable];
	    }
	    if (varValues[fVariable]>f2sigmaUpperBound) {
	      if (variables[fVariable]=="P_TanBeta") {
		if (varValues[fVariable]>100.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_M0") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_M12") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<0.)   continue;
	      }
	      if (variables[fVariable]=="P_A0") {
		if (varValues[fVariable]>10000.) continue;
		if (varValues[fVariable]<-10000.)   continue;
	      }
	      f2sigmaUpperBound = varValues[fVariable];
	    }
	  }
	}
      }
      
      cout << "One Dimensional 1 sigma environment of " << variables[fVariable] 
	   << " = "
	   << fBestFit
	   << " - "
	   << fBestFit - f1sigmaLowerBound
	   << " + "
	   << f1sigmaUpperBound - fBestFit
	   << " at min chi2 = " 
	   << - 2 * TMath::Log(absHighestL)
	   << endl;
      markovFitsFile << "One Dimensional 1 sigma environment of " << variables[fVariable] 
		     << " = "
		     << fBestFit
		     << " - "
		     << fBestFit - f1sigmaLowerBound
		     << " + "
		     << f1sigmaUpperBound - fBestFit
		     << " at min chi2 = " 
		     << - 2 * TMath::Log(absHighestL)
		     << endl;
      
      cout << "One Dimensional 1 sigma environment from 2Dres of " << variables[fVariable] 
	   << " = "
	   << fBestFit
	   << " - "
	   << (fBestFit - f2sigmaLowerBound)/2.
	   << " + "
	   << (f2sigmaUpperBound - fBestFit)/2.
	   << " at min chi2 = " 
	   << - 2 * TMath::Log(absHighestL)
	   << endl;
       markovFitsFile << "One Dimensional 1 sigma environment from 2Dres of " << variables[fVariable] 
		     << " = "
		     << fBestFit
		     << " - "
		     << (fBestFit - f2sigmaLowerBound)/2.
		     << " + "
		     << (f2sigmaUpperBound - fBestFit)/2.
		     << " at min chi2 = " 
		     << - 2 * TMath::Log(absHighestL)
		     << endl;
 	      
    }
  
  inputRootFile->Close();
  markovFitsFile.close();


}
