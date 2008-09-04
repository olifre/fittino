
// This ROOT macro plots the markov chains produced by Fittino 
// in the projections of the mSUGRA high-scale parameters. 
// The asymed statistics is bayesian. Shame on me. An alternative 
// frequentist interpretation will follow soon. 

#include "TChain.h"
#include "TCanvas.h"
#include "TH1D.h"
#include "TH2D.h"
#include "iostream"
#include "string"
#include "vector"
using namespace std;

void PlotMarkovChains2D (bool bayes = true);

void PlotMarkovChains2D (bool bayes) 
{
  //gROOT->SetStyle("MyStyle");
  //gROOT->ForceStyle();

  TChain markovChain("markovChain");
  markovChain.Add("MarkovChainNtupFile*.root");
  // markovChain.Add("MarkovTestRosenbrockNTupel.root");
  markovChain.Print();

  int nEntries = markovChain.GetEntries();
  // if (nEntries > 100000) nEntries = 100000;
  int nBins = 25;

  std::cout << "number of entries " << nEntries << std::endl;

  TCanvas* canvas = new TCanvas();
  canvas->SetRightMargin(0.15);
  canvas->SetBorderMode(0);
  canvas->SetFillStyle(4000);
  canvas->SetFrameFillColor(4000);

  // markov chains
  vector<string> variables; 
  //  variables.push_back("X");
  //  variables.push_back("Y");
  variables.push_back("TanBeta");
  variables.push_back("M0");
  variables.push_back("M12");
  variables.push_back("A0");

  // create and initialize variables
  vector<float> varValues;
  for (int i = 0; i < variables.size(); i++) {
    varValues.push_back(0.);
  }
  float haveAcceptedAtLeastOne;
  float nStep;
  float likelihood;

  // attach variables to ntuple
  if (!bayes) {
    for (int i = 0; i < variables.size(); i++) {
      markovChain.SetBranchAddress(variables[i].c_str(),&varValues[i]);
    }
    markovChain.SetBranchAddress("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne);
    markovChain.SetBranchAddress("n",&nStep);
    markovChain.SetBranchAddress("likelihood",&likelihood);
  }

  // control histograms
  

  for (int fVariable = 0; fVariable < variables.size(); fVariable++)
    {
      for (int sVariable = fVariable+1; sVariable < variables.size(); sVariable++)
	{

	  TH2D *thisHist;
	  // Bayesian Interpretation
	  if (bayes) 
	    {
	      string plotCommand = variables[fVariable] + 
		":" +
		variables[sVariable] +
		">>thisHist";
	      markovChain.Draw(plotCommand.c_str(),"n>2000 && haveAcceptedAtLeastOne == 1");
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
	      for (int i = 0; i < nEntries; i++) {
		markovChain.GetEntry(i);
		if (nStep > 2000 && haveAcceptedAtLeastOne > 0.5) {		
		  if (varValues[fVariable]>fVarMax) {
		    fVarMax = varValues[fVariable];
		  }
		  if (varValues[fVariable]<fVarMin) {
		    fVarMin = varValues[fVariable];
		  }
		  if (varValues[sVariable]>sVarMax) {
		    sVarMax = varValues[sVariable];
		  }
		  if (varValues[sVariable]<sVarMin) {
		    sVarMin = varValues[sVariable];
		  }
		}
	      }
	      cout << variables[fVariable] << " " << variables[sVariable] << " " 
		   << fVarMax << " " << fVarMin << " " << sVarMax << " " << sVarMin << endl;
	      // loop over bins in the variables
	      thisHist = new TH2D("thisHist","",
				  nBins+2,sVarMin-1./(double)nBins*(-sVarMin+sVarMax),sVarMax+1./(double)nBins*(-sVarMin+sVarMax),
				  nBins+2,fVarMin-1./(double)nBins*(-fVarMin+fVarMax),fVarMax+1./(double)nBins*(-fVarMin+fVarMax));
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
		    // find the highest likelihood
		    if (fVarValueLow<varValues[fVariable] && varValues[fVariable]<=fVarValueHig &&
			sVarValueLow<varValues[sVariable] && varValues[sVariable]<=sVarValueHig &&
			nStep > 2000 && haveAcceptedAtLeastOne > 0.5) {
		      foundAPoint = true;
		      if (likelihood>highestL) {
			highestL=likelihood;
		      }
		    }
		  }
		  if (foundAPoint) {
		    cout << "filling thisHist at " << (sVarValueHig+sVarValueLow)/2. 
			 << " " << (fVarValueHig+fVarValueLow)/2. 
			 << " " << highestL << endl;
		    thisHist->Fill((sVarValueHig+sVarValueLow)/2.,(fVarValueHig+fVarValueLow)/2.,highestL);
		  } else {
		    cout << "No valid point at   " << (sVarValueHig+sVarValueLow)/2. 
			 << " " << (fVarValueHig+fVarValueLow)/2. << endl;
		  }
		}
	      }
	    }
	  TH2D *loghist = new TH2D("loghist", "", thisHist->GetNbinsX(),
				   thisHist->GetXaxis()->GetXmin(),
				   thisHist->GetXaxis()->GetXmax(),
				   thisHist->GetNbinsY(),
				   thisHist->GetYaxis()->GetXmin(),
				   thisHist->GetYaxis()->GetXmax());
	  loghist->SetStats(kFALSE);
	  //loghist->GetXaxis()->SetRangeUser(-2500,3000);
	  //loghist->GetXaxis()->SetRangeUser(-1000,2000);
	  //loghist->GetYaxis()->SetRangeUser(0,50);
	  double thisHistIntegral = thisHist->GetEntries();
	  if (bayes) {
	    thisHist->Scale(1./thisHistIntegral);
	  }
	  
	  double thisHistMax = thisHist->GetMaximum();
	  double maxval = -1;
	  for (Int_t ix=1; ix<=thisHist->GetNbinsX(); ix++) {
	    for (Int_t iy=1; iy<=thisHist->GetNbinsY(); iy++) {
	      if ( thisHist->GetBinContent(ix, iy) ) {
		double val = 2 * TMath::Log(thisHistMax)
		  - 2 * TMath::Log( thisHist->GetBinContent(ix, iy) );
		if (val > maxval) maxval = val;
		loghist->SetBinContent(ix, iy, val);
	      }
	      else {
		loghist->SetBinContent(ix, iy, 1e99);
	      }
	    }
	  }
	  
          loghist->SetMaximum(maxval);

	  loghist->SetTitle("");

	  if (!strcmp(variables[sVariable].c_str(), "A0")) {
	     loghist->SetXTitle("A_{0} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "M0")) {
	     loghist->SetXTitle("M_{0} (GeV)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "TanBeta")) {
	     loghist->SetXTitle("tan(#beta)");
	  }
	  else if (!strcmp(variables[sVariable].c_str(), "M12")) {
	     loghist->SetXTitle("M_{1/2} (GeV)");
	  }
	  if (!strcmp(variables[fVariable].c_str(), "A0")) {
	     loghist->SetYTitle("A_{0} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "M0")) {
	     loghist->SetYTitle("M_{0} (GeV)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "TanBeta")) {
	     loghist->SetYTitle("tan(#beta)");
	  }
	  else if (!strcmp(variables[fVariable].c_str(), "M12")) {
	     loghist->SetYTitle("M_{1/2} (GeV)");
	  }
	  loghist->GetXaxis()->SetTitleOffset(0.04);
	  loghist->GetYaxis()->SetTitleOffset(0.04);
	  loghist->GetXaxis()->SetTitleSize(0.04);
	  loghist->GetYaxis()->SetTitleSize(0.04);
	  // gStyle->SetPalette(1,0);
	  loghist->Draw("cont1z");
	  string fileName = variables[fVariable] + 
	     variables[sVariable] +
	     "Markov.eps";
	  canvas->Print(fileName.c_str());
	  canvas->SetLogz();
	  thisHist->Draw("cont1z");
	  fileName = variables[fVariable] + 
	     variables[sVariable] +
	     "TestMarkov.eps";
	  canvas->Print(fileName.c_str());	  
	  thisHist->Delete();
	  loghist->Delete();
	}
    }


}
