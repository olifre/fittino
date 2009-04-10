
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

void MakeMarkovChainContour2D (bool bayes = true, 
			       int maxevents = -1,
			       string contourOutputFileName = "markovContours.root",
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

  TChain markovChain("markovChain");
  markovChain.Add("MarkovChainNtupFile*.root");
  // markovChain.Add("MarkovTestRosenbrockNTupel.root");
  markovChain.Print();

  // open text file
  ofstream markovFitsFile ("markovFitsResults.txt",ios::out);
  //  markovFitsFile.open ("markovFitsResults.txt",ofstream::out);

  int nEntries = markovChain.GetEntries();
  if ( maxevents >= 0 ) {
    if (nEntries > maxevents) nEntries = maxevents;
  }
  int nBins = 27;

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

  // attach variables to ntuple
  if (!bayes) {
    for (unsigned int i = 0; i < variables.size(); i++) {
      markovChain.SetBranchAddress(variables[i].c_str(),&varValues[i]);
    }
    markovChain.SetBranchAddress("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne);
    markovChain.SetBranchAddress("n",&nStep);
    markovChain.SetBranchAddress("likelihood",&likelihood);
    markovChain.SetBranchAddress("chi2",&chi2);
  }


  double absHighestL = 0.;
  for (Int_t i=0; i<nEntries; i++) {
    markovChain.GetEntry(i);
    if (chi2<0.) continue;
    if (likelihood > absHighestL) {
      if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {		
	absHighestL = likelihood;
      }
    }
  }


  // open output file for the contours
  TFile* contourOutputFile = new TFile (contourOutputFileName.c_str(), "RECREATE");

  // control histograms
  

  for (unsigned int fVariable = 0; fVariable < variables.size(); fVariable++)
    {
      for (unsigned int sVariable = fVariable+1; sVariable < variables.size(); sVariable++)
	{

	  TH2D *thisHist;

	  double s1sigmaUpperBound = -100000000.;
	  double s1sigmaLowerBound =  100000000.;
	  double f1sigmaUpperBound = -100000000.;
	  double f1sigmaLowerBound =  100000000.;
	  double s2sigmaUpperBound = -100000000.;
	  double s2sigmaLowerBound =  100000000.;
	  double f2sigmaUpperBound = -100000000.;
	  double f2sigmaLowerBound =  100000000.;
	  double sBestFit = 0.;
	  double fBestFit = 0.;

	  // Bayesian Interpretation
	  if (bayes) 
	    {
	      string plotCommand = variables[fVariable] + 
		":" +
		variables[sVariable] +
		">>thisHist";
	      markovChain.Draw(plotCommand.c_str(),"n>2000 && haveAcceptedAtLeastOne == 1 && accpoint==1");
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
	      for (int i = 0; i < nEntries; i++) {
		markovChain.GetEntry(i);
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
		  if (varValues[sVariable]>sVarMax && val<6.01) {
		    sVarMax = varValues[sVariable];
		  }
		  if (varValues[sVariable]<sVarMin && val<6.01) {
		    sVarMin = varValues[sVariable];
		  }
		  
//		  cout << "minimal chi2 = " << - 2 * TMath::Log(absHighestL) 
//		       << " this chi2 = " << - 2 * TMath::Log(likelihood)
//		       << " val = " << val 
//		       << endl;
		  if (val<1.) {
		    //		    cout << "found point within 1s at " << val << endl;
		    if (val<valMin) {
		      valMin = val;
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
		   << - 2 * TMath::Log(absHighestL)
		   << endl;
	      cout << "One Dimensional 1 sigma environment of " << variables[sVariable] 
		   << " = "
		   << sBestFit
		   << " - "
		   << sBestFit - s1sigmaLowerBound
		   << " + "
		   << s1sigmaUpperBound - sBestFit
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
	      markovFitsFile << "One Dimensional 1 sigma environment of " << variables[sVariable] 
			     << " = "
			     << sBestFit
			     << " - "
			     << sBestFit - s1sigmaLowerBound
			     << " + "
			     << s1sigmaUpperBound - sBestFit
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
	      cout << "One Dimensional 1 sigma environment from 2Dres of " << variables[sVariable] 
		   << " = "
		   << sBestFit
		   << " - "
		   << (sBestFit - s2sigmaLowerBound)/2.
		   << " + "
		   << (s2sigmaUpperBound - sBestFit)/2.
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
	      markovFitsFile << "One Dimensional 1 sigma environment from 2Dres of " << variables[sVariable] 
			     << " = "
			     << sBestFit
			     << " - "
			     << (sBestFit - s2sigmaLowerBound)/2.
			     << " + "
			     << (s2sigmaUpperBound - sBestFit)/2.
			     << " at min chi2 = " 
			     << - 2 * TMath::Log(absHighestL)
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

	      sVarMin = sVarMin-3./(double)(nBins-4)*(-sVarMin+sVarMax);
	      sVarMax = sVarMax+1./(double)(nBins-4)*(-sVarMin+sVarMax);
	      fVarMin = fVarMin-3./(double)(nBins-4)*(-fVarMin+fVarMax);
	      fVarMax = fVarMax+1./(double)(nBins-4)*(-fVarMin+fVarMax);

	      thisHist = new TH2D("thisHist","",
				  nBins,sVarMin,sVarMax,
				  nBins,fVarMin,fVarMax);
	      for (int fbin = 0; fbin < nBins; fbin++) {
		double fVarValueLow = (double)fbin/(double)nBins*(-fVarMin+fVarMax)+fVarMin;
		double fVarValueHig = (double)(fbin+1)/(double)nBins*(-fVarMin+fVarMax)+fVarMin;
		for (int sbin = 0; sbin < nBins; sbin++) {
		  double sVarValueLow = (double)sbin/(double)nBins*(-sVarMin+sVarMax)+sVarMin;
		  double sVarValueHig = (double)(sbin+1)/(double)nBins*(-sVarMin+sVarMax)+sVarMin;
		  // loop over the ntuple
		  double highestL = -100000000.;
		  bool foundAPoint = false;
		  for (int i = 0; i < nEntries; i++) {
		    markovChain.GetEntry(i);
		    if (chi2<0.) continue;
		    // find the highest likelihood
		    if (fVarValueLow<varValues[fVariable] && varValues[fVariable]<=fVarValueHig &&
			sVarValueLow<varValues[sVariable] && varValues[sVariable]<=sVarValueHig &&
			nStep > 0 && haveAcceptedAtLeastOne > 0.5) {
		      foundAPoint = true;
		      if (likelihood>highestL) {
			highestL=likelihood;
		      }
		    }
		  }
		  if (foundAPoint) {
//		    if ((sVarValueHig+sVarValueLow)/2.> 700.) { 
//		      cout << "filling thisHist at " << (sVarValueHig+sVarValueLow)/2. 
//			   << " " << (fVarValueHig+fVarValueLow)/2. 
//			   << " " << highestL << endl;
//		    }
		    thisHist->Fill((sVarValueHig+sVarValueLow)/2.,(fVarValueHig+fVarValueLow)/2.,highestL);
		    if (highestL>absHighestL) {
		      cout << "seeing new best point" << endl;
		      absHighestL=highestL;
		      sBestFit = (sVarValueHig+sVarValueLow)/2.;
		      fBestFit = (fVarValueHig+fVarValueLow)/2.;
		    }
		  } else {
		    //		    cout << "No valid point at   " << (sVarValueHig+sVarValueLow)/2. 
		    //			 << " " << (fVarValueHig+fVarValueLow)/2. << endl;
		  }
		}
	      }
	    }

	  
	  thisHist->Draw("box");
	  canvas->Print("test.eps");

	  // common plotting for frequentist and bayesian interpretation

	  TH2D *loghist = new TH2D("loghist", "", thisHist->GetNbinsX(),
				   thisHist->GetXaxis()->GetXmin(),
				   thisHist->GetXaxis()->GetXmax(),
				   thisHist->GetNbinsY(),
				   thisHist->GetYaxis()->GetXmin(),
				   thisHist->GetYaxis()->GetXmax());

	  string emptyHistName = "emptyHist_";
	  emptyHistName = emptyHistName + variables[sVariable] + "_" + variables[fVariable];
	  TH2D *emptyhist = new TH2D(emptyHistName.c_str(), emptyHistName.c_str(), thisHist->GetNbinsX(),
				     thisHist->GetXaxis()->GetXmin(),
				     thisHist->GetXaxis()->GetXmax(),
				     thisHist->GetNbinsY(),
				     thisHist->GetYaxis()->GetXmin(),
				     thisHist->GetYaxis()->GetXmax());
	  loghist->SetStats(kFALSE);
	  loghist->GetXaxis()->CenterTitle(1);
	  loghist->GetYaxis()->CenterTitle(1);
	  //loghist->GetXaxis()->SetRangeUser(-2500,3000);
	  //loghist->GetXaxis()->SetRangeUser(-1000,2000);
	  //loghist->GetYaxis()->SetRangeUser(0,50);
	  double thisHistIntegral = thisHist->GetEntries();
	  if (bayes) {
	    thisHist->Scale(1./thisHistIntegral);
	  }

	  double minF = 0.;
	  double minS = 0.;
	  double minVal = 100000000.;

	  double thisHistMax = thisHist->GetMaximum();
	  double maxval = -1;
	  for (Int_t ix=1; ix<=thisHist->GetNbinsX(); ix++) {
	    for (Int_t iy=1; iy<=thisHist->GetNbinsY(); iy++) {
	      if ( thisHist->GetBinContent(ix, iy)>0. ) {
		double val = 2 * TMath::Log(thisHistMax)
		  - 2 * TMath::Log( thisHist->GetBinContent(ix, iy) );

//		if (ix > thisHist->GetNbinsX()*2./3.) { 
//		  cout << "filling logHist at " << ix
//		       << " " << iy
//		       << " " << val << endl;
//		}
		
		if (val > maxval) maxval = val;
		if (val < minVal) {
		  minVal = val;
		  minF = ((double)ix-0.5)/(double)thisHist->GetNbinsX()*(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())+thisHist->GetXaxis()->GetXmin();
		  minS = ((double)iy-0.5)/(double)thisHist->GetNbinsY()*(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())+thisHist->GetYaxis()->GetXmin();
		}
		loghist->SetBinContent(ix, iy, val);
	      }
	      else {
		loghist->SetBinContent(ix, iy, 1e99);
	      }
	    }
	  }

	  cout << "found minimum at " << minF << " " << minS << " with value " << minVal << endl;

	  // maxval = 10.;
	  
	  // make sure a contour line is drawn exactly at min+1,
	  // provided the palette has 20 levels!!! How can we check that?
//	  int contourLineNo = 0;
//	  if (maxval>20.) {
//	    maxval = 20.;
//	  } else {
//	    int bestFit = 1;
//	    double bestDiff = 10000000.;
//	    for (int iFit = 1; iFit < 10; iFit++) {
//	      double thisDiff = TMath::Abs(20./TMath::Power(2,iFit-1)-maxval);
//	      if (thisDiff<bestDiff) {
//		bestDiff = thisDiff;
//		bestFit = iFit;
//		contourLineNo = (int)TMath::Abs(TMath::Power(2,iFit-1)-1);
//	      }
//	    }
//	    maxval = 20./TMath::Power(2,bestFit-1);
//	  }
//	  if (maxval<6.) { 
//	    maxval = 6.;
//	    contourLineNo = 6;
//	  }
//          loghist->SetMaximum(maxval);

	  if (maxval<6.) {
	    cout << "WARNING: Incomplete chain, 95percent CL in 2D was reached nowhere!" << endl;
	  }
	  maxval = 7.;
	  const int contourLineNo1D1s = 0;
	  const int contourLineNo2D2s = 5;
	  loghist->SetMaximum(maxval);

	  // draw the plot
	  loghist->SetTitle("");

	  if (!strcmp(variables[sVariable].c_str(), "P_A0")) {
	     loghist->SetXTitle("A_{0} (GeV)");
	     emptyhist->SetXTitle("A_{0} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_M0")) {
	     loghist->SetXTitle("M_{0} (GeV)");
	     emptyhist->SetXTitle("M_{0} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_TanBeta")) {
	     loghist->SetXTitle("tan(#beta)");
	     emptyhist->SetXTitle("tan(#beta)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_M12")) {
	     loghist->SetXTitle("M_{1/2} (GeV)");
	     emptyhist->SetXTitle("M_{1/2} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_alphas")) {
	     loghist->SetXTitle("#alpha_{s}");
	     emptyhist->SetXTitle("#alpha_{s}");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_alphaem")) {
	     loghist->SetXTitle("#alpha_{em}");
	     emptyhist->SetXTitle("#alpha_{em}");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_massZ")) {
	     loghist->SetXTitle("m_{Z} (Gev)");
	     emptyhist->SetXTitle("m_{Z} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_massTop")) {
	     loghist->SetXTitle("m_{t} (GeV)");
	     emptyhist->SetXTitle("m_{t} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "P_G_F")) {
	     loghist->SetXTitle("G_F (Gev^{-2})");
	     emptyhist->SetXTitle("G_F (GeV^{-2})");
	  }
	  if (!strcmp(variables[fVariable].c_str(), "P_A0")) {
	     loghist->SetYTitle("A_{0} (GeV)");
	     emptyhist->SetYTitle("A_{0} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_M0")) {
	     loghist->SetYTitle("M_{0} (GeV)");
	     emptyhist->SetYTitle("M_{0} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_TanBeta")) {
	     loghist->SetYTitle("tan(#beta)");
	     emptyhist->SetYTitle("tan(#beta)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_M12")) {
	     loghist->SetYTitle("M_{1/2} (GeV)");
	     emptyhist->SetYTitle("M_{1/2} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_alphas")) {
	     loghist->SetYTitle("#alpha_{s}");
	     emptyhist->SetYTitle("#alpha_{s}");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_alphaem")) {
	     loghist->SetYTitle("#alpha_{em}");
	     emptyhist->SetYTitle("#alpha_{em}");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_massZ")) {
	     loghist->SetYTitle("m_{Z} (Gev)");
	     emptyhist->SetYTitle("m_{Z} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_massTop")) {
	     loghist->SetYTitle("m_{t} (GeV)");
	     emptyhist->SetYTitle("m_{t} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "P_G_F")) {
	     loghist->SetYTitle("G_F (Gev^{-2})");
	     emptyhist->SetYTitle("G_F (GeV^{-2})");
	  }
	  loghist->GetXaxis()->SetTitleOffset(1.2);
	  loghist->GetYaxis()->SetTitleOffset(1.1);
	  emptyhist->GetXaxis()->SetTitleOffset(1.2);
	  emptyhist->GetYaxis()->SetTitleOffset(1.1);
	  //	  loghist->GetXaxis()->SetTitleSize(0.04);
	  //	  loghist->GetYaxis()->SetTitleSize(0.04);
	  // gStyle->SetPalette(1,0);
	  loghist->Draw("CONTLIST");
	  canvas->Update();
	  loghist->Draw("cont1");
	  // draw a cross at the global minimum
	  cout << "global minimum at " << fBestFit << " " << sBestFit << endl;
//	  TLine* line1 = new TLine(sBestFit-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
//				   fBestFit-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
//				   sBestFit+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
//				   fBestFit+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.);
//	  TLine* line2 = new TLine(sBestFit-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
//				   fBestFit+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
//				   sBestFit+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
//				   fBestFit-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.);
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
	  // draw a hatched contour line at min+1
	  //double levels = 1.;
	  //loghist->SetContour(1,&levels);
	  //loghist->Draw("CONTLIST");
	  TObjArray *contours = (TObjArray*)gROOT->GetListOfSpecials()->FindObject("contours");
	  if (contours) {
	    int ncontours = contours->GetSize();
	    int theContourNumber = 0;
	    theContourNumber = contourLineNo1D1s;
	    cout << "plotting contour no. " << theContourNumber << endl; 
	    if (theContourNumber<ncontours) {
	      // get correct contour line
	      TList *contourList = (TList*)contours->At(theContourNumber);
	      int nGraphsPerContour = contourList->GetSize();
	      for (int iGraph = 0; iGraph<nGraphsPerContour; iGraph++) {
		cout << "drawing graph no. " << iGraph << endl;
		TGraph* graph = (TGraph*)contourList->At(iGraph);
		graph->SetLineColor(kBlack);
		graph->SetLineWidth(3);
		graph->SetLineStyle(3);
		graph->Draw("");
		string contourName = "contour_";
		char number[256];
		sprintf(number,"%i",iGraph);
		contourName = contourName + variables[sVariable] + "_" + variables[fVariable] + "_" + number + "_1D1s";
		graph->SetName(contourName.c_str());
		//		if (graph->GetN()>2) {
		graph->Write();
		//		}
	      }
	    }
	    theContourNumber = contourLineNo2D2s;
	    cout << "plotting contour no. " << theContourNumber << endl; 
	    if (theContourNumber<ncontours) {
	      // get correct contour line
	      TList *contourList = (TList*)contours->At(theContourNumber);
	      int nGraphsPerContour = contourList->GetSize();
	      for (int iGraph = 0; iGraph<nGraphsPerContour; iGraph++) {
		cout << "drawing graph no. " << iGraph << endl;
		TGraph* graph = (TGraph*)contourList->At(iGraph);
		graph->SetLineColor(kRed+3);
		graph->SetLineWidth(3);
		graph->SetLineStyle(3);
		graph->Draw("");
		string contourName = "contour_";
		char number[256];
		sprintf(number,"%i",iGraph);
		contourName = contourName + variables[sVariable] + "_" + variables[fVariable] + "_" + number + "_2D2s";
		graph->SetName(contourName.c_str());
		//		if (graph->GetN()>2) {
		graph->Write();
		//		}
	      }
	    } else {
	      cout << "Error in contour counting" << endl;
	    }
	  } else {
	    cout << "No Contour lines found!" << endl;
	  }
	  
	  string fileName = variables[fVariable] + 
	     variables[sVariable] +
	     "Markov";
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
	  thisHist->Delete();
	  loghist->Delete();
	  emptyhist->Write();
	  emptyhist->Delete();
	}
    }

  contourOutputFile->Close();
  markovFitsFile.close();


}
