
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

  TChain markovChain("markovChain");
  markovChain.Add("MarkovChainNtupFile*.root");
  markovChain.Print();

  int nEntries = markovChain.GetEntries();

  std::cout << "number of entries " << nEntries << std::endl;

  TCanvas* canvas = new TCanvas();

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
	  double thisHistIntegral = thisHist->Integral();
	  thisHist->Scale(1./thisHistIntegral);
	  thisHist->SetTitle("");
	  thisHist->SetXTitle(variables[sVariable].c_str());
	  thisHist->SetYTitle(variables[fVariable].c_str());
	  thisHist->GetXaxis()->SetTitleOffset(0.04);
	  thisHist->GetYaxis()->SetTitleOffset(0.04);
	  thisHist->GetXaxis()->SetTitleSize(0.04);
	  thisHist->GetYaxis()->SetTitleSize(0.04);
	  thisHist->Draw("colz");
	  string fileName = variables[fVariable] + 
	    variables[sVariable] +
	    "Markov.eps";
	  canvas->Print(fileName.c_str());
          thisHist->Delete();
	}
    }


}
