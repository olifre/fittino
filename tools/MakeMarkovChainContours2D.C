
// This ROOT macro plots the markov chains produced by Fittino 
// in the projections of the mSUGRA high-scale parameters. 
// The asymed statistics is bayesian. Shame on me. An alternative 
// frequentist interpretation will follow soon. 

//    variables[fVariable] = P_TanBeta    variables[sVariable] = P_M12    icomb = 0
//    variables[fVariable] = P_TanBeta    variables[sVariable] = P_M0    icomb = 1
//    variables[fVariable] = P_TanBeta    variables[sVariable] = P_A0    icomb = 2
//    variables[fVariable] = P_M12    variables[sVariable] = P_M0    icomb = 3
//    variables[fVariable] = P_M12    variables[sVariable] = P_A0    icomb = 4
//    variables[fVariable] = P_M0    variables[sVariable] = P_A0    icomb = 5

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

void MakeMarkovChainContours2D (bool bayes = false, 
			       int maxevents = -1,
			       string contourOutputFileName = "markovHists.root",
			       bool doAlsoSM = false,
			       string model = "mSUGRA",
			       bool requireNeut1LSP = true,
			       int fixComb = 3 ) 
{

  //gROOT->SetStyle("MyStyle");
  //gROOT->ForceStyle();

  gStyle->SetOptStat(0);
  // enforce a palette with 6 levels:
  //  gStyle->SetPalette(1);
  Int_t colors[7] = {kBlue+1,kBlue+2,kBlue+3,kBlue+4,kRed,kRed+1,kRed+2};
  gStyle->SetPalette(7,colors);
  gStyle->SetNumberContours(7);

  bool doublelogplot = false;

  TChain markovChain("markovChain");
//  markovChain.Add("MarkovChainNtupFile*.root");
  markovChain.Add("MarkovChainNtupFile.sum.root");
  // markovChain.Add("MarkovTestRosenbrockNTupel.root");
  markovChain.Print();

  // open text file
  ofstream markovFitsFile ("markovFitsResults.txt",ios::out);
  //  markovFitsFile.open ("markovFitsResults.txt",ofstream::out);

  int nEntries = markovChain.GetEntries();
  if ( maxevents >= 0 ) {
    if (nEntries > maxevents) nEntries = maxevents;
  }
  int nBins = 29;

  std::cout << "number of entries " << nEntries << std::endl;

  TCanvas* canvas = new TCanvas();
  canvas->SetRightMargin(0.05);
  canvas->SetBorderMode(0);
  //  canvas->SetFillStyle(4000);
  //  canvas->SetFrameFillColor(4000);

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
  else if (model=="Pheno") {
    variables.push_back("af_direct");
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
  else if( model == "XMSUGRA" ){
    // XMSUGRA
    variables.push_back("P_M0");
    variables.push_back("P_M1");
    variables.push_back("P_M2");
    variables.push_back("P_M3");
    variables.push_back("P_A0");
    variables.push_back("P_TanBeta");
  }
  else if( model == "NONUNIVSIMPLIFIED" ){
    // NONUNIVSIMPLIFIED
    variables.push_back("P_TanBeta");
    variables.push_back("P_A0");
    variables.push_back("P_M1");
    variables.push_back("P_M2");
    variables.push_back("P_M3");
    variables.push_back("P_M0H");
    variables.push_back("P_M05");
    variables.push_back("P_M010");
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
  float globalIter;
  float chi2;

  vector<bool> varThere;


  // look if all the branches are there
  const Int_t nLeaves = markovChain.GetListOfLeaves()->GetEntriesFast();
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
    TLeafD* leaf = (TLeafD*)markovChain.GetListOfLeaves()->At(iLeaf);
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

  int iNeut1Var = -1;
  int iStau1Var = -1;

  // attach variables to ntuple
  if (!bayes) {
    for (unsigned int i = 0; i < variables.size(); i++) {
      if (varThere[i]) {
	markovChain.SetBranchAddress(variables[i].c_str(),&varValues[i]);
	if (variables[i]=="O_massNeutralino1_nofit") iNeut1Var = i;
	if (variables[i]=="O_massStau1_nofit")       iStau1Var = i;
      }
    }
    markovChain.SetBranchAddress("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne);
    markovChain.SetBranchAddress("n",&nStep);
    markovChain.SetBranchAddress("globalIter",&globalIter);
    markovChain.SetBranchAddress("chi2",&chi2);
  }

  float massNeut1Local;
  float massStau1Local;

  if (requireNeut1LSP) {
    if (iNeut1Var == -1) {
      markovChain.SetBranchAddress("O_massNeutralino1_nofit",&massNeut1Local);
    }
    if (iStau1Var == -1) {
      markovChain.SetBranchAddress("O_massStau1_nofit",&massStau1Local);
    }
  }


  double minChi2 = 1e33;
  if (!bayes) {
    for (Int_t i=0; i<nEntries; i++) {
      markovChain.GetEntry(i);
      if (chi2<0.) continue;
      if (requireNeut1LSP) {
	float thisMassNeut1 = 0.;
	float thisMassStau1 = 0.;
	if (iNeut1Var == -1) {
	  thisMassNeut1 = massNeut1Local;
	} else {
	  thisMassNeut1 = varValues[iNeut1Var];
	}
	if (iStau1Var == -1) {
	  thisMassStau1 = massStau1Local;
	} else {
	  thisMassStau1 = varValues[iStau1Var];
	}
	if (thisMassStau1<thisMassNeut1) continue;
      }
      if (chi2 < minChi2) {
	if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {		
	  minChi2 = chi2;
	}
      }
    }
  }

  std::cout << "Minimal chi2 = " << minChi2 << std::endl;

  // open output file for the contours
  TFile* contourOutputFile = new TFile (contourOutputFileName.c_str(), "RECREATE");

  // control histograms
  int icomb = -1;

  for (unsigned int fVariable = 0; fVariable < variables.size(); fVariable++)
    {
      for (unsigned int sVariable = fVariable+1; sVariable < variables.size(); sVariable++)
	{
	  icomb++;
	  if (!varThere[sVariable] || !varThere[fVariable]) continue;

	  if (fixComb>=0) {
	    if (icomb!=fixComb) continue;
	  }
	  
	  TH2D *thisHist; // hist for 1D 68 % CL contour
	  TH2D *thisHist2; // hist for 2D 95 % CL contour

	  double s1sigmaUpperBound = -100000000.;
	  double s1sigmaLowerBound =  100000000.;
	  double f1sigmaUpperBound = -100000000.;
	  double f1sigmaLowerBound =  100000000.;
	  double s2sigmaUpperBound = -100000000.;
	  double s2sigmaLowerBound =  100000000.;
	  double f2sigmaUpperBound = -100000000.;
	  double f2sigmaLowerBound =  100000000.;
	  // Point with minimum likelihood
	  double sBestFit = 0.;
	  double fBestFit = 0.;
	  double chi2BestFit = 0.;

	  // Bayesian Interpretation
	  if (bayes) 
	    {
	      string plotCommand = variables[fVariable] + 
		":" +
		variables[sVariable] +
		">>thisHist";
	      markovChain.Draw(plotCommand.c_str(),"globalIter>20000 && haveAcceptedAtLeastOne == 1 && accpoint==1");
	      //	      markovChain.Draw(plotCommand.c_str(),"n>2000");
	      thisHist = (TH2D*)gDirectory->Get("thisHist");
	    }
	  // Frequentist Interpretation
	  else
	    {
	      // find extensions
	      double fVarMax = -1000000000.;
	      double fVarMin =  1000000000.;
	      double sVarMax = -1000000000.;
	      double sVarMin =  1000000000.;	      
	      double valMin = 100000000.;
	      
	      if ( ( variables[fVariable] == "O_massNeutralino1_nofit" &&
		     variables[sVariable] == "af_direct" ) ||
		   ( variables[fVariable] == "af_direct" &&
		     variables[sVariable] == "O_massNeutralino1_nofit" ) ) {
		doublelogplot = true;
	      }

	      for (int i = 0; i < nEntries; i++) {
		markovChain.GetEntry(i);
		if (chi2<0.) continue;
		if (requireNeut1LSP) {
		  float thisMassNeut1 = 0.;
		  float thisMassStau1 = 0.;
		  if (iNeut1Var == -1) {
		    thisMassNeut1 = massNeut1Local;
		  } else {
		    thisMassNeut1 = varValues[iNeut1Var];
		  }
		  if (iStau1Var == -1) {
		    thisMassStau1 = massStau1Local;
		  } else {
		    thisMassStau1 = varValues[iStau1Var];
		  }
		  if (thisMassStau1<thisMassNeut1) continue;
		}
		if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {		

		  double val = chi2 - minChi2;

		  if (varValues[fVariable]>fVarMax && val<6.01) {
		    fVarMax = varValues[fVariable];
		  }
		  if (varValues[fVariable]<fVarMin && val<6.01) {
		    fVarMin = varValues[fVariable];
		  }
		  if (varValues[sVariable]>sVarMax && val<6.01) {
		    sVarMax = varValues[sVariable];
		  }
		  if (varValues[sVariable]<sVarMin && val<6.01) {
		    sVarMin = varValues[sVariable];
		  }
		  
		  if (val<1.) {
		    //		    cout << "found point within 1s at " << val << endl;
		    if (val<valMin) {
		      valMin = val;
		      chi2BestFit = chi2;
		      //		      cout << "found new minimum at " << val << endl;
		      if (variables[sVariable]=="P_TanBeta") {
			if (varValues[sVariable]>100.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M12") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_A0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<-10000.)   continue;
		      }
		      // cout << "setting new minimum at " << varValues[sVariable] << " " << varValues[fVariable] << endl;
		      sBestFit = varValues[sVariable];
		      fBestFit = varValues[fVariable];
		    }
		    if (varValues[sVariable]<s1sigmaLowerBound) {
		      if (variables[sVariable]=="P_TanBeta") {
			if (varValues[sVariable]>100.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M12") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_A0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<-10000.)   continue;
		      }
		      s1sigmaLowerBound = varValues[sVariable];
		    }
		    if (varValues[sVariable]>s1sigmaUpperBound) {
		      if (variables[sVariable]=="P_TanBeta") {
			if (varValues[sVariable]>100.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M12") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_A0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<-10000.)   continue;
		      }
		      s1sigmaUpperBound = varValues[sVariable];
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
		    if (varValues[sVariable]<s2sigmaLowerBound) {
		      if (variables[sVariable]=="P_TanBeta") {
			if (varValues[sVariable]>100.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M12") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_A0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<-10000.)   continue;
		      }
		      s2sigmaLowerBound = varValues[sVariable];
		    }
		    if (varValues[sVariable]>s2sigmaUpperBound) {
		      if (variables[sVariable]=="P_TanBeta") {
			if (varValues[sVariable]>100.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_M12") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<0.)   continue;
		      }
		      if (variables[sVariable]=="P_A0") {
			if (varValues[sVariable]>10000.) continue;
			if (varValues[sVariable]<-10000.)   continue;
		      }
		      s2sigmaUpperBound = varValues[sVariable];
		    }
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
		   << minChi2
		   << endl;
	      cout << "One Dimensional 1 sigma environment of " << variables[sVariable] 
		   << " = "
		   << sBestFit
		   << " - "
		   << sBestFit - s1sigmaLowerBound
		   << " + "
		   << s1sigmaUpperBound - sBestFit
		   << " at min chi2 = " 
		   << minChi2
		   << endl;
	      markovFitsFile << "One Dimensional 1 sigma environment of " << variables[fVariable] 
			     << " = "
			     << fBestFit
			     << " - "
			     << fBestFit - f1sigmaLowerBound
			     << " + "
			     << f1sigmaUpperBound - fBestFit
			     << " at min chi2 = " 
			     << minChi2
			     << endl;
	      markovFitsFile << "One Dimensional 1 sigma environment of " << variables[sVariable] 
			     << " = "
			     << sBestFit
			     << " - "
			     << sBestFit - s1sigmaLowerBound
			     << " + "
			     << s1sigmaUpperBound - sBestFit
			     << " at min chi2 = " 
			     << minChi2
			     << endl;
	      
	      cout << "One Dimensional 1 sigma environment from 2Dres of " << variables[fVariable] 
		   << " = "
		   << fBestFit
		   << " - "
		   << (fBestFit - f2sigmaLowerBound)/2.
		   << " + "
		   << (f2sigmaUpperBound - fBestFit)/2.
		   << " at min chi2 = " 
		   << minChi2
		   << endl;
	      cout << "One Dimensional 1 sigma environment from 2Dres of " << variables[sVariable] 
		   << " = "
		   << sBestFit
		   << " - "
		   << (sBestFit - s2sigmaLowerBound)/2.
		   << " + "
		   << (s2sigmaUpperBound - sBestFit)/2.
		   << " at min chi2 = " 
		   << minChi2
		   << endl;
	      markovFitsFile << "One Dimensional 1 sigma environment from 2Dres of " << variables[fVariable] 
			     << " = "
			     << fBestFit
			     << " - "
			     << (fBestFit - f2sigmaLowerBound)/2.
			     << " + "
			     << (f2sigmaUpperBound - fBestFit)/2.
			     << " at min chi2 = " 
			     << minChi2
			     << endl;
	      markovFitsFile << "One Dimensional 1 sigma environment from 2Dres of " << variables[sVariable] 
			     << " = "
			     << sBestFit
			     << " - "
			     << (sBestFit - s2sigmaLowerBound)/2.
			     << " + "
			     << (s2sigmaUpperBound - sBestFit)/2.
			     << " at min chi2 = " 
			     << minChi2
			     << endl;
	      
	  
	      if (variables[fVariable]=="P_TanBeta") {
		if (fVarMax>100.) fVarMax=100.;
		if (fVarMin<0.  ) fVarMin=0.;   
	      }
	      if (variables[fVariable]=="P_M0") {
		if (fVarMax>10000.) fVarMax=10000.;	
		if (fVarMin<0.    ) fVarMin=0.;     
	      }
	      if (variables[fVariable]=="P_M12") {
		if (fVarMax>10000.) fVarMax=10000.;	
		if (fVarMin<0.    ) fVarMin=0.;     
	      }
	      if (variables[fVariable]=="P_A0") {
		if (fVarMax>10000. ) fVarMax=10000.;	
		if (fVarMin<-10000.) fVarMin=-10000.;   
	      }

	      if (variables[sVariable]=="P_TanBeta") {
		if (sVarMax>100.) sVarMax=100.;
		if (sVarMin<0.)   sVarMin=0.;
	      }
	      if (variables[sVariable]=="P_M0") {
		if (sVarMax>10000.) sVarMax=10000.;	
		if (sVarMin<0.    ) sVarMin=0.;     
	      }
	      if (variables[sVariable]=="P_M12") {
		if (sVarMax>10000.) sVarMax=10000.;	
		if (sVarMin<0.    ) sVarMin=0.;     
	      }
	      if (variables[sVariable]=="P_A0") {
		if (sVarMax>10000. ) sVarMax=10000.;	
		if (sVarMin<-10000.) sVarMin=-10000.;   
	      }
	      
	      cout << variables[fVariable] << " " << variables[sVariable] << " " 
		   << fVarMax << " " << fVarMin << " " << sVarMax << " " << sVarMin << endl;


	      // loop over bins in the variables
	      if (doublelogplot) {
		sVarMin = TMath::Log10(sVarMin);
		fVarMin = TMath::Log10(fVarMin);
		sVarMax = TMath::Log10(sVarMax);
		fVarMax = TMath::Log10(fVarMax);
	      }
	      double sWidth = TMath::Abs(-sVarMin+sVarMax);
	      double fWidth = TMath::Abs(-fVarMin+fVarMax);
	      sVarMin = sVarMin-3./(double)(nBins-6)*sWidth;
	      sVarMax = sVarMax+3./(double)(nBins-6)*sWidth;
	      fVarMin = fVarMin-3./(double)(nBins-6)*fWidth;
	      fVarMax = fVarMax+3./(double)(nBins-6)*fWidth;

	      string thisHistName = "thisHist_";
	      thisHistName = thisHistName + variables[sVariable] + "_" + variables[fVariable];
	      thisHist = new TH2D(thisHistName.c_str(),"",
				  nBins,sVarMin,sVarMax,
				  nBins,fVarMin,fVarMax);

	      string thisHist2Name = "thisHist2_";
	      thisHist2Name = thisHist2Name + variables[sVariable] + "_" + variables[fVariable];
	      thisHist2 = new TH2D(thisHist2Name.c_str(),"",
				   nBins,sVarMin,sVarMax,
				   nBins,fVarMin,fVarMax);

	      // Value of chi2 stored in a matrix for each 2D bin
	      Float_t chi2Array[nBins][nBins];
	      for (int fbin = 0; fbin < nBins; fbin++)
		for (int sbin = 0; sbin < nBins; sbin++) chi2Array[sbin][fbin] = 1e33;

	      // Loop on events
	      for (int i = 0; i < nEntries; i++) {
		markovChain.GetEntry(i);

		// Keep events with neutral LSP
		if (requireNeut1LSP) {
		  float thisMassNeut1 = 0.;
		  float thisMassStau1 = 0.;
		  if (iNeut1Var == -1) {
		    thisMassNeut1 = massNeut1Local;
		  } else {
		    thisMassNeut1 = varValues[iNeut1Var];
		  }
		  if (iStau1Var == -1) {
		    thisMassStau1 = massStau1Local;
		  } else {
		    thisMassStau1 = varValues[iStau1Var];
		  }
		  if (thisMassStau1<thisMassNeut1) continue;
		}
		// Reject pathological events
		if (chi2<0.) continue;
		

		// Loop on bins
		for (int fbin = 1; fbin <= nBins; fbin++)
		  {
		    // Upper and lower bounds of the bin
		    //		    double fVarValueLow = (double)fbin/(double)nBins*(-fVarMin+fVarMax)+fVarMin;
		    //		    double fVarValueHig = (double)(fbin+1)/(double)nBins*(-fVarMin+fVarMax)+fVarMin;
		    double fVarValueLow = thisHist->GetYaxis()->GetBinLowEdge(fbin);
		    double fVarValueHig = thisHist->GetYaxis()->GetBinUpEdge(fbin);

		    for (int sbin = 1; sbin <= nBins; sbin++) 
		      {
			// Upper and lower bounds of the bin
			//			double sVarValueLow = (double)sbin/(double)nBins*(-sVarMin+sVarMax)+sVarMin;
			//			double sVarValueHig = (double)(sbin+1)/(double)nBins*(-sVarMin+sVarMax)+sVarMin;
			double sVarValueLow = thisHist->GetXaxis()->GetBinLowEdge(sbin);
			double sVarValueHig = thisHist->GetXaxis()->GetBinUpEdge(sbin);

			if (!doublelogplot) {
			  // If the event falls in the bin
			  if( fVarValueLow < varValues[fVariable] && varValues[fVariable] <= fVarValueHig &&
			      sVarValueLow < varValues[sVariable] && varValues[sVariable] <= sVarValueHig &&
											     nStep > 0 && haveAcceptedAtLeastOne > 0.5)
			    {
			      // If chi2 smaller than smallest chi2 in that bin, update chi2Array[][]
			      if( chi2 < chi2Array[sbin-1][fbin-1] && chi2 - minChi2 < 6.01 ) chi2Array[sbin-1][fbin-1] = chi2;
			    }
			}
			else {
			  if( fVarValueLow < TMath::Log10(varValues[fVariable]) && TMath::Log10(varValues[fVariable]) <= fVarValueHig &&
			      sVarValueLow < TMath::Log10(varValues[sVariable]) && TMath::Log10(varValues[sVariable]) <= sVarValueHig &&
											     nStep > 0 && haveAcceptedAtLeastOne > 0.5)
			    {
			      // If chi2 smaller than smallest chi2 in that bin, update chi2Array[][]
			      if( chi2 < chi2Array[sbin-1][fbin-1] && chi2 - minChi2 < 6.01 ) chi2Array[sbin-1][fbin-1] = chi2;
			    }
			  
			}
		      }
		  }
	      }

	      // Fill the histo with the matrix (+1 as bin Nb starts at 1)
	      for (int fbin = 0; fbin < nBins; fbin++){
		for (int sbin = 0; sbin < nBins; sbin++){
		  if( chi2Array[sbin][fbin] - minChi2 < 1.000001 ) thisHist->SetBinContent( sbin+1, fbin+1,  chi2Array[sbin][fbin] - minChi2 );
		  else thisHist->SetBinContent( sbin+1, fbin+1, 2.);
		  if( chi2Array[sbin][fbin] < 1e32 ) thisHist2->SetBinContent( sbin+1, fbin+1,  chi2Array[sbin][fbin] - minChi2 );
		  else thisHist2->SetBinContent( sbin+1, fbin+1, 7);
		}
	      }
	      
	      thisHist->Draw("box");
	      canvas->Print("test.eps");
	    }

	  // common plotting for frequentist and bayesian interpretation

	  string emptyHistName = "emptyHist_";
	  emptyHistName = emptyHistName + variables[sVariable] + "_" + variables[fVariable];
	  TH2D *emptyhist = new TH2D(emptyHistName.c_str(), emptyHistName.c_str(), thisHist->GetNbinsX(),
				     thisHist->GetXaxis()->GetXmin(),
				     thisHist->GetXaxis()->GetXmax(),
				     thisHist->GetNbinsY(),
				     thisHist->GetYaxis()->GetXmin(),
				     thisHist->GetYaxis()->GetXmax());

	  emptyhist->SetStats(kFALSE);
	  emptyhist->GetXaxis()->CenterTitle(1);
	  emptyhist->GetYaxis()->CenterTitle(1);
	  double thisHistIntegral = thisHist->GetEntries();
	  if (bayes) {
	    thisHist->Scale(1./thisHistIntegral);
	  }
	      
	  cout << "starting to draw the plot" << endl;

	  // draw the plot
	  thisHist->SetTitle("");
	  if (!strcmp(variables[sVariable].c_str(), "P_A0")) {
	    thisHist->SetXTitle("A_{0} (GeV)");
	    emptyhist->SetXTitle("A_{0} (GeV)");
	  }

	  else if (!strcmp(variables[sVariable].c_str(), "P_M0H")) {
	    thisHist->SetXTitle("M_{0,H} (GeV)");
	    emptyhist->SetXTitle("M_{0,H} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_M05")) {
	    thisHist->SetXTitle("M_{0,5} (GeV)");
	    emptyhist->SetXTitle("M_{0,5} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_M010")) {
	    thisHist->SetXTitle("M_{0,10} (GeV)");
	    emptyhist->SetXTitle("M_{0,10} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_M0")) {
	    thisHist->SetXTitle("M_{0} (GeV)");
	    emptyhist->SetXTitle("M_{0} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_TanBeta")) {
	    thisHist->SetXTitle("tan(#beta)");
	    emptyhist->SetXTitle("tan(#beta)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_M12")) {
	    thisHist->SetXTitle("M_{1/2} (GeV)");
	    emptyhist->SetXTitle("M_{1/2} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_alphas")) {
	    thisHist->SetXTitle("#alpha_{s}");
	    emptyhist->SetXTitle("#alpha_{s}");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_alphaem")) {
	    thisHist->SetXTitle("#alpha_{em}");
	    emptyhist->SetXTitle("#alpha_{em}");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_massZ")) {
	    thisHist->SetXTitle("m_{Z} (Gev)");
	    emptyhist->SetXTitle("m_{Z} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_massTop")) {
	    thisHist->SetXTitle("m_{t} (GeV)");
	    emptyhist->SetXTitle("m_{t} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_G_F")) {
	    thisHist->SetXTitle("G_F (Gev^{-2})");
	    emptyhist->SetXTitle("G_F (GeV^{-2})");
	  }
	  // MSSM
	  else if (!strcmp(variables[sVariable].c_str(), "P_Mu")) { 
	    thisHist->SetXTitle("#mu (GeV)"); 
	    emptyhist->SetXTitle("#mu (GeV)"); 
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MuEff")) { 
	    thisHist->SetXTitle("#mu_{eff} (GeV)");
	    emptyhist->SetXTitle("#mu_{eff} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_Xtau")) { 
	    thisHist->SetXTitle("X_{#tau} (GeV)");
	    emptyhist->SetXTitle("X_{#tau} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MSelectronR")) { 
	    thisHist->SetXTitle("M_{#tilde{e}_{R}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{e}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MStauR")) { 
	    thisHist->SetXTitle("M_{#tilde{#tau}_{R}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{#tau}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MSelectronL")) { 
	    thisHist->SetXTitle("M_{#tilde{e}_{L}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{e}_{L}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MStauL")) { 
	    thisHist->SetXTitle("M_{#tilde{#tau}_{L}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{#tau}_{L}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_Xtop")) { 
	    thisHist->SetXTitle("X_{t} (GeV)");
	    emptyhist->SetXTitle("X_{t} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_Xbottom")) { 
	    thisHist->SetXTitle("X_{b} (GeV)");
	    emptyhist->SetXTitle("X_{b} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MSdownR")) { 
	    thisHist->SetXTitle("M_{#tilde{d}_{R}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{d}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MSbottomR")) { 
	    thisHist->SetXTitle("M_{#tilde{b}_{R}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{b}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MSupR")) { 
	    thisHist->SetXTitle("M_{#tilde{u}_{R}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{u}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MStopR")) { 
	    thisHist->SetXTitle("M_{#tilde{t}_{R}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{t}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MSupL")) { 
	    thisHist->SetXTitle("M_{#tilde{u}_{L}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{u}_{L}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_MStopL")) { 
	    thisHist->SetXTitle("M_{#tilde{t}_{L}} (GeV)");
	    emptyhist->SetXTitle("M_{#tilde{t}_{L}} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_M1")) { 
	    thisHist->SetXTitle("M_{1} (GeV)");
	    emptyhist->SetXTitle("M_{1} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_M2")) { 
	    thisHist->SetXTitle("M_{2} (GeV)");
	    emptyhist->SetXTitle("M_{2} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_M3")) { 
	    thisHist->SetXTitle("M_{3} (GeV)");
	    emptyhist->SetXTitle("M_{3} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_massA0")) { 
	    thisHist->SetXTitle("m_{A} (GeV)");
	    emptyhist->SetXTitle("m_{A} (GeV)");
	  }


	  // fVariables
	  if (!strcmp(variables[fVariable].c_str(), "P_A0")) {
	    thisHist->SetYTitle("A_{0} (GeV)");
	    emptyhist->SetYTitle("A_{0} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_M0")) {
	    thisHist->SetYTitle("M_{0} (GeV)");
	    emptyhist->SetYTitle("M_{0} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_TanBeta")) {
	    thisHist->SetYTitle("tan(#beta)");
	    emptyhist->SetYTitle("tan(#beta)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_M12")) {
	    thisHist->SetYTitle("M_{1/2} (GeV)");
	    emptyhist->SetYTitle("M_{1/2} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_alphas")) {
	    thisHist->SetYTitle("#alpha_{s}");
	    emptyhist->SetYTitle("#alpha_{s}");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_alphaem")) {
	    thisHist->SetYTitle("#alpha_{em}");
	    emptyhist->SetYTitle("#alpha_{em}");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_massZ")) {
	    thisHist->SetYTitle("m_{Z} (Gev)");
	    emptyhist->SetYTitle("m_{Z} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_massTop")) {
	    thisHist->SetYTitle("m_{t} (GeV)");
	    emptyhist->SetYTitle("m_{t} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_G_F")) {
	    thisHist->SetYTitle("G_F (Gev^{-2})");
	    emptyhist->SetYTitle("G_F (GeV^{-2})");
	  }
	  // MSSM
	  else if (!strcmp(variables[fVariable].c_str(), "P_Mu")) { 
	    thisHist->SetYTitle("#mu (GeV)"); 
	    emptyhist->SetYTitle("#mu (GeV)"); 
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MuEff")) { 
	    thisHist->SetYTitle("#mu_{eff} (GeV)");
	    emptyhist->SetYTitle("#mu_{eff} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_Xtau")) { 
	    thisHist->SetYTitle("X_{#tau} (GeV)");
	    emptyhist->SetYTitle("X_{#tau} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MSelectronR")) { 
	    thisHist->SetYTitle("M_{#tilde{e}_{R}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{e}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MStauR")) { 
	    thisHist->SetYTitle("M_{#tilde{#tau}_{R}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{#tau}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MSelectronL")) { 
	    thisHist->SetYTitle("M_{#tilde{e}_{L}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{e}_{L}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MStauL")) { 
	    thisHist->SetYTitle("M_{#tilde{#tau}_{L}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{#tau}_{L}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_Xtop")) { 
	    thisHist->SetYTitle("X_{t} (GeV)");
	    emptyhist->SetYTitle("X_{t} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_Xbottom")) { 
	    thisHist->SetYTitle("X_{b} (GeV)");
	    emptyhist->SetYTitle("X_{b} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MSdownR")) { 
	    thisHist->SetYTitle("M_{#tilde{d}_{R}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{d}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MSbottomR")) { 
	    thisHist->SetYTitle("M_{#tilde{b}_{R}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{b}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MSupR")) { 
	    thisHist->SetYTitle("M_{#tilde{u}_{R}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{u}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MStopR")) { 
	    thisHist->SetYTitle("M_{#tilde{t}_{R}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{t}_{R}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MSupL")) { 
	    thisHist->SetYTitle("M_{#tilde{u}_{L}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{u}_{L}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_MStopL")) { 
	    thisHist->SetYTitle("M_{#tilde{t}_{L}} (GeV)");
	    emptyhist->SetYTitle("M_{#tilde{t}_{L}} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_M1")) { 
	    thisHist->SetYTitle("M_{1} (GeV)");
	    emptyhist->SetYTitle("M_{1} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_M2")) { 
	    thisHist->SetYTitle("M_{2} (GeV)");
	    emptyhist->SetYTitle("M_{2} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_M3")) { 
	    thisHist->SetYTitle("M_{3} (GeV)");
	    emptyhist->SetYTitle("M_{3} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_massA0")) { 
	    thisHist->SetYTitle("m_{A} (GeV)");
	    emptyhist->SetYTitle("m_{A} (GeV)");
	  }


	  thisHist->GetXaxis()->SetTitleOffset(1.2);
	  thisHist->GetYaxis()->SetTitleOffset(1.1);
	  emptyhist->GetXaxis()->SetTitleOffset(1.2);
	  emptyhist->GetYaxis()->SetTitleOffset(1.1);
	  //	  thisHist->GetXaxis()->SetTitleSize(0.04);
	  //	  thisHist->GetYaxis()->SetTitleSize(0.04);
	  // gStyle->SetPalette(1,0);


	  cout << "just write the histograms to the file, do not draw contours" << endl;
	  thisHist->Write();
	  thisHist2->Write();
	  emptyhist->Write();
	  cout << "Delete the Histograms" << endl;
	  thisHist->Delete();
	  thisHist2->Delete();
	  emptyhist->Delete();
	  // add the cross at the best fit point
	  const double xVec1[2] = {sBestFit-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80., 
				   sBestFit+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.};
	  const double yVec1[2] = {fBestFit-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
				   fBestFit+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.};
	  TGraph* lineGraph1 = new TGraph(2,xVec1,yVec1);
	  const double xVec2[2] = {sBestFit-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80., 
				   sBestFit+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.};
	  const double yVec2[2] = {fBestFit+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
				   fBestFit-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.};
	  TGraph* lineGraph2 = new TGraph(2,xVec2,yVec2);	  
	  lineGraph1->SetLineWidth(3);
	  lineGraph2->SetLineWidth(3);
	  string lineName = "";
	  lineName = "bestFitPointLine_" + variables[sVariable] + "_" + variables[fVariable] + "_1";
	  lineGraph1->SetName(lineName.c_str());
	  lineName = "bestFitPointLine_" + variables[sVariable] + "_" + variables[fVariable] + "_2";
	  lineGraph2->SetName(lineName.c_str());
	  lineGraph1->Write();
	  lineGraph2->Write();
	  lineGraph1->Draw();
	  lineGraph2->Draw();
	  cout << "Start new Variables" << endl;

	  string fileName = variables[fVariable] + variables[sVariable] + "Markov";
	  if (bayes) {
	    fileName = fileName + "Bayes.eps";
	  } else {
	    fileName = fileName + "Freq.eps";
	  }
	  canvas->Print(fileName.c_str());
	  //canvas->SetLogz();
	  //thisHist->Draw("cont1z");
	  //fileName = variables[fVariable] + 
	  //   variables[sVariable] +
	  //   "TestMarkov.eps";
	  //canvas->Print(fileName.c_str());	  
	  canvas->SetLogz(0);
	}
    }
    
  contourOutputFile->Close();
  markovFitsFile.close();

}
