
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

void PlotMarkovChains1D () 
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

  for (int fVariable = 0; fVariable < 4; fVariable++) {
      string plotCommand;
      double x[1], y[1];
      plotCommand = variables[fVariable] + ">>thisHist(200)";

      markovChain.Draw(plotCommand.c_str(),"n>2000 && haveAcceptedAtLeastOne == 1");
      TH1F *thisHist = (TH1F*)gDirectory->Get("thisHist");
      TH1F *loghist = new TH1F("loghist", "", thisHist->GetNbinsX(),
			       thisHist->GetXaxis()->GetXmin(),
			       thisHist->GetXaxis()->GetXmax());
      loghist->SetStats(kFALSE);
      double thisHistIntegral = thisHist->GetEntries();

      thisHist->Scale(1./thisHistIntegral);

      double thisHistMax = thisHist->GetMaximum();
      double maxval = -1;
      for (Int_t ix=1; ix<=thisHist->GetNbinsX(); ix++) {
	  if ( thisHist->GetBinContent(ix) ) {
	      double val = 2 * TMath::Log(thisHistMax) - 2 * TMath::Log( thisHist->GetBinContent(ix) );
	      if (val > maxval) maxval = val;
	      loghist->SetBinContent(ix, val);
	  }
      }
      //      loghist->SetMaximum(maxval);
      loghist->SetMaximum(3);


//      if (!strcmp(variables[fVariable].c_str(), "TanBeta") ) {
//	  loghist->SetMaximum(8);
//      }

      loghist->SetTitle("");

      // First rough fit
      TF1* parab3 = new TF1("parab3", "[0]*(x-[1])*(x-[1])+[2]");
      parab3->SetParameter(0,1);
      parab3->SetParameter(1,loghist->GetBinCenter(UInt_t(loghist->GetNbinsX()*0.5)));
      parab3->SetParameter(2,0);
      loghist->Fit("parab3");

      double mi = parab3->GetParameter(1) - 1.3 / TMath::Sqrt( parab3->GetParameter(0) );
      double ma = parab3->GetParameter(1) + 1.3 / TMath::Sqrt( parab3->GetParameter(0) );

      // Second rough fit
      TF1* parab2 = new TF1("parab2", "[0]*(x-[1])*(x-[1])+[2]", mi, ma);
      parab2->SetParameter(0,parab3->GetParameter(0));
      parab2->SetParameter(1,parab3->GetParameter(1));
      parab2->SetParameter(2,parab3->GetParameter(2));
      loghist->Fit("parab2", "r");

      mi = parab2->GetParameter(1) - 1.3 / TMath::Sqrt( parab2->GetParameter(0) );
      ma = parab2->GetParameter(1) + 1.3 / TMath::Sqrt( parab2->GetParameter(0) );

      // Now the real fit
      TF1* parab = new TF1("parab", "[0]*(x-[1])*(x-[1])+[2]", mi, ma);
      parab->SetParameter(0,parab2->GetParameter(0));
      parab->SetParameter(1,parab2->GetParameter(1));
      parab->SetParameter(2,parab2->GetParameter(2));
      parab->SetLineColor(kRed);
      loghist->Fit("parab","r");

      double mean = parab->GetParameter(1);
      double error = 1 / TMath::Sqrt( parab->GetParameter(0) );

      printf("Fitted %s value: %f +- %f\n", variables[fVariable].c_str(), mean, error);

      if (!strcmp(variables[fVariable].c_str(), "A0")) {
	  loghist->SetXTitle("A_{0} (GeV)");
      }
      else if (!strcmp(variables[fVariable].c_str(), "M0")) {
	  loghist->SetXTitle("M_{0} (GeV)");
      }
      else if (!strcmp(variables[fVariable].c_str(), "TanBeta")) {
	  loghist->SetXTitle("tan(#beta)");
      }
      else if (!strcmp(variables[fVariable].c_str(), "M12")) {
	  loghist->SetXTitle("M_{1/2} (GeV)");
      }
      loghist->GetXaxis()->SetTitleOffset(0.04);
      loghist->GetYaxis()->SetTitleOffset(0.04);
      loghist->GetXaxis()->SetTitleSize(0.06);
      loghist->GetYaxis()->SetTitleSize(0.06);
      loghist->GetXaxis()->SetLabelSize(0.06);
      loghist->GetYaxis()->SetLabelSize(0.06);
      loghist->Draw("l");

      string fileName = variables[fVariable] + "Markov.eps";
      canvas->Print(fileName.c_str());
      thisHist->Delete();
      loghist->Delete();
    }

}
