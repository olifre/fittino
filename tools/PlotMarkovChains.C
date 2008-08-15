
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

void PlotMarkovChains () 
{
  //gROOT->SetStyle("MyStyle");
  //gROOT->ForceStyle();

  TChain markovChain("markovChain");
  markovChain.Add("MarkovChainNtupFile*.root");
  markovChain.Print();

  int nEntries = markovChain.GetEntries();

  std::cout << "number of entries " << nEntries << std::endl;

  TCanvas* canvas = new TCanvas();
  canvas->SetRightMargin(0.15);
  canvas->SetBorderMode(0);
  canvas->SetFillStyle(4000);
  canvas->SetFrameFillColor(4000);

  // control histograms
  

  // markov chains
  vector<string> variables; 
  variables.push_back("TanBeta");
  variables.push_back("M0");
  variables.push_back("M12");
  variables.push_back("A0");

  for (int fVariable = 0; fVariable < 4; fVariable++)
    {
      for (int sVariable = fVariable+1; sVariable < 4; sVariable++)
	{
	  string plotCommand = variables[fVariable] + 
	    ":" +
	    variables[sVariable] +
	    ">>thisHist";
	  markovChain.Draw(plotCommand.c_str(),"n>2000");
	  TH2F *thisHist = (TH2F*)gDirectory->Get("thisHist");
          TH2F *loghist = new TH2F("loghist", "", thisHist->GetNbinsX(),
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
	  thisHist->Scale(1./thisHistIntegral);

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
	  gStyle->SetPalette(1,0);
	  loghist->Draw("cont1z");
	  string fileName = variables[fVariable] + 
	     variables[sVariable] +
	     "Markov.eps";
	  canvas->Print(fileName.c_str());
	  thisHist->Delete();
	  loghist->Delete();
	}
    }


}
