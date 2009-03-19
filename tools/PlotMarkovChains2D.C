
// This ROOT macro plots the markov chains produced by Fittino 
// in the projections of the mSUGRA high-scale parameters. 
// The asymed statistics is bayesian. Shame on me. An alternative 
// frequentist interpretation will follow soon. 

#include "TStyle.h"
#include "TROOT.h"
#include "TMath.h"
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
#include "fstream"
#include "string"
#include "vector"
using namespace std;

void PlotMarkovChains2D (bool bayes = true, int maxevents = -1);

void PlotMarkovChains2D (bool bayes, int maxevents) 
{
  //gROOT->SetStyle("MyStyle");
  //gROOT->ForceStyle();

  gStyle->SetPalette(1);

  TChain markovChain("markovChain");
  markovChain.Add("MarkovChainNtupFile*.root");
  // markovChain.Add("MarkovTestRosenbrockNTupel.root");
  markovChain.Print();

  // open text file
  fstream markovFitsFile;
  markovFitsFile.open ("markovFitsResults.txt",ofstream::out);

  int nEntries = markovChain.GetEntries();
  if ( maxevents >= 0 ) {
    if (nEntries > maxevents) nEntries = maxevents;
  }
  int nBins = 25;

  std::cout << "number of entries " << nEntries << std::endl;

  TCanvas* canvas = new TCanvas();
  canvas->SetRightMargin(0.15);
  canvas->SetBorderMode(0);
  //  canvas->SetFillStyle(4000);
  //  canvas->SetFrameFillColor(4000);

  // markov chains
  vector<string> variables; 
  // variables.push_back("X");
  // variables.push_back("Y");

  // mSUGRA
  variables.push_back("TanBeta");
  variables.push_back("M0");
  variables.push_back("M12"); 
  variables.push_back("A0");

  // MSSM
//  variables.push_back("MSelectronL");
//  variables.push_back("MSelectronR");
//  variables.push_back("MStauL");
//  variables.push_back("MStauR");
//  variables.push_back("MSupL");
//  variables.push_back("MSupR");
//  variables.push_back("MSbottomR");
//  variables.push_back("MStopL");
//  variables.push_back("MStopR");
//  variables.push_back("TanBeta");
//  variables.push_back("Mu");
//  variables.push_back("Xtau");
//  variables.push_back("Xtop");
//  variables.push_back("Xbottom");
//  variables.push_back("M1");
//  variables.push_back("M2");
//  variables.push_back("M3");
//  variables.push_back("massA0");

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

	  double s1sigmaUpperBound = -100000000.;
	  double s1sigmaLowerBound =  100000000.;
	  double f1sigmaUpperBound = -100000000.;
	  double f1sigmaLowerBound =  100000000.;
	  double sBestFit = 0.;
	  double fBestFit = 0.;
	  double absHighestL = 0.;

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
	      for (int i = 0; i < nEntries; i++) {
		markovChain.GetEntry(i);
		if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {		
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
	      if (variables[fVariable]=="TanBeta") {
		if (fVarMax>100.) fVarMax=100.;
		if (fVarMin<0.  ) fVarMin=0.;   
	      }
	      if (variables[fVariable]=="M0") {
		if (fVarMax>10000.) fVarMax=10000.;	
		if (fVarMin<0.    ) fVarMin=0.;     
	      }
	      if (variables[fVariable]=="M12") {
		if (fVarMax>10000.) fVarMax=10000.;	
		if (fVarMin<0.    ) fVarMin=0.;     
	      }
	      if (variables[fVariable]=="A0") {
		if (fVarMax>10000. ) fVarMax=10000.;	
		if (fVarMin<-10000.) fVarMin=-10000.;   
	      }

	      if (variables[sVariable]=="TanBeta") {
		if (sVarMax>100.) sVarMax=100.;
		if (sVarMin<0.)   sVarMin=0.;
	      }
	      if (variables[fVariable]=="M0") {
		if (sVarMax>10000.) sVarMax=10000.;	
		if (sVarMin<0.    ) sVarMin=0.;     
	      }
	      if (variables[fVariable]=="M12") {
		if (sVarMax>10000.) sVarMax=10000.;	
		if (sVarMin<0.    ) sVarMin=0.;     
	      }
	      if (variables[fVariable]=="A0") {
		if (sVarMax>10000. ) sVarMax=10000.;	
		if (sVarMin<-10000.) sVarMin=-10000.;   
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
			nStep > 0 && haveAcceptedAtLeastOne > 0.5) {
		      foundAPoint = true;
		      if (likelihood>highestL) {
			highestL=likelihood;
		      }
		    }
		  }
		  if (foundAPoint) {
//		    cout << "filling thisHist at " << (sVarValueHig+sVarValueLow)/2. 
//			 << " " << (fVarValueHig+fVarValueLow)/2. 
//			 << " " << highestL << endl;
		    thisHist->Fill((sVarValueHig+sVarValueLow)/2.,(fVarValueHig+fVarValueLow)/2.,highestL);
		    if (highestL>absHighestL) {
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

	  // find 1D 1sigma uncertainties
	  if (bayes==false) {
	    for (int i = 0; i < nEntries; i++) {
	      markovChain.GetEntry(i);
	      if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {
		double val = 2 * TMath::Log(absHighestL)
		  - 2 * TMath::Log(likelihood);
		if (val<1.) {
		  if (varValues[sVariable]<s1sigmaLowerBound) {
		    if (variables[sVariable]=="TanBeta") {
		      if (varValues[sVariable]>100.) continue;
		      if (varValues[sVariable]<0.)   continue;
		    }
		    if (variables[sVariable]=="M0") {
		      if (varValues[sVariable]>10000.) continue;
		      if (varValues[sVariable]<0.)   continue;
		    }
		    if (variables[sVariable]=="M12") {
		      if (varValues[sVariable]>10000.) continue;
		      if (varValues[sVariable]<0.)   continue;
		    }
		    if (variables[sVariable]=="A0") {
		      if (varValues[sVariable]>10000.) continue;
		      if (varValues[sVariable]<-10000.)   continue;
		    }
		    s1sigmaLowerBound = varValues[sVariable];
		  }
		  if (varValues[sVariable]>s1sigmaUpperBound) {
		    if (variables[sVariable]=="TanBeta") {
		      if (varValues[sVariable]>100.) continue;
		      if (varValues[sVariable]<0.)   continue;
		    }
		    if (variables[sVariable]=="M0") {
		      if (varValues[sVariable]>10000.) continue;
		      if (varValues[sVariable]<0.)   continue;
		    }
		    if (variables[sVariable]=="M12") {
		      if (varValues[sVariable]>10000.) continue;
		      if (varValues[sVariable]<0.)   continue;
		    }
		    if (variables[sVariable]=="A0") {
		      if (varValues[sVariable]>10000.) continue;
		      if (varValues[sVariable]<-10000.)   continue;
		    }
		    s1sigmaUpperBound = varValues[sVariable];
		  }
		  if (varValues[fVariable]<f1sigmaLowerBound) {
		    if (variables[fVariable]=="TanBeta") {
		      if (varValues[fVariable]>100.) continue;
		      if (varValues[fVariable]<0.)   continue;
		    }
		    if (variables[fVariable]=="M0") {
		      if (varValues[fVariable]>10000.) continue;
		      if (varValues[fVariable]<0.)   continue;
		    }
		    if (variables[fVariable]=="M12") {
		      if (varValues[fVariable]>10000.) continue;
		      if (varValues[fVariable]<0.)   continue;
		    }
		    if (variables[fVariable]=="A0") {
		      if (varValues[fVariable]>10000.) continue;
		      if (varValues[fVariable]<-10000.)   continue;
		    }
		    f1sigmaLowerBound = varValues[fVariable];
		  }
		  if (varValues[fVariable]>f1sigmaUpperBound) {
		    if (variables[fVariable]=="TanBeta") {
		      if (varValues[fVariable]>100.) continue;
		      if (varValues[fVariable]<0.)   continue;
		    }
		    if (variables[fVariable]=="M0") {
		      if (varValues[fVariable]>10000.) continue;
		      if (varValues[fVariable]<0.)   continue;
		    }
		    if (variables[fVariable]=="M12") {
		      if (varValues[fVariable]>10000.) continue;
		      if (varValues[fVariable]<0.)   continue;
		    }
		    if (variables[fVariable]=="A0") {
		      if (varValues[fVariable]>10000.) continue;
		      if (varValues[fVariable]<-10000.)   continue;
		    }
		    f1sigmaUpperBound = varValues[fVariable];
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
		 << "at min chi2 = " 
		 << - 2 * TMath::Log(absHighestL)
		 << endl;
	    cout << "One Dimensional 1 sigma environment of " << variables[sVariable] 
		 << " = "
		 << sBestFit
		 << " - "
		 << sBestFit - s1sigmaLowerBound
		 << " + "
		 << s1sigmaUpperBound - sBestFit
		 << "at min chi2 = " 
		 << - 2 * TMath::Log(absHighestL)
		 << endl;
	    markovFitsFile << "One Dimensional 1 sigma environment of " << variables[fVariable] 
			   << " = "
			   << fBestFit
			   << " - "
			   << fBestFit - f1sigmaLowerBound
			   << " + "
			   << f1sigmaUpperBound - fBestFit
			   << "at min chi2 = " 
			   << - 2 * TMath::Log(absHighestL)
			   << endl;
	    markovFitsFile << "One Dimensional 1 sigma environment of " << variables[sVariable] 
			   << " = "
			   << sBestFit
			   << " - "
			   << sBestFit - s1sigmaLowerBound
			   << " + "
			   << s1sigmaUpperBound - sBestFit
			   << "at min chi2 = " 
			   << - 2 * TMath::Log(absHighestL)
			   << endl;
	  }

	  // common plotting for frequentist and bayesian interpretation

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

	  double minF = 0.;
	  double minS = 0.;
	  double minVal = 100000000.;

	  double thisHistMax = thisHist->GetMaximum();
	  double maxval = -1;
	  for (Int_t ix=1; ix<=thisHist->GetNbinsX(); ix++) {
	    for (Int_t iy=1; iy<=thisHist->GetNbinsY(); iy++) {
	      if ( thisHist->GetBinContent(ix, iy) ) {
		double val = 2 * TMath::Log(thisHistMax)
		  - 2 * TMath::Log( thisHist->GetBinContent(ix, iy) );
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

	  cout << "found minimum at " << minF << " " << minS << endl;

	  // maxval = 10.;
	  
	  // make sure a contour line is drawn exactly at min+1,
	  // provided the palette has 20 levels!!! How can we check that?
	  int contourLineNo = 0;
	  if (maxval>20.) {
	    maxval = 20.;
	  } else {
	    int bestFit = 1;
	    double bestDiff = 10000000.;
	    for (int iFit = 1; iFit < 10; iFit++) {
	      double thisDiff = TMath::Abs(20./TMath::Power(2,iFit-1)-maxval);
	      if (thisDiff<bestDiff) {
		bestDiff = thisDiff;
		bestFit = iFit;
		contourLineNo = (int)TMath::Abs(TMath::Power(2,iFit-1)-1);
	      }
	    }
	    maxval = 20./TMath::Power(2,bestFit-1);
	  }
          loghist->SetMaximum(maxval);

	  // draw the plot
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
	  loghist->GetXaxis()->SetTitleOffset(1.2);
	  loghist->GetYaxis()->SetTitleOffset(1.1);
	  //	  loghist->GetXaxis()->SetTitleSize(0.04);
	  //	  loghist->GetYaxis()->SetTitleSize(0.04);
	  // gStyle->SetPalette(1,0);
	  loghist->Draw("CONTLIST");
	  canvas->Update();
	  loghist->Draw("cont1z");
	  // draw a cross at the global minimum
	  TLine* line1 = new TLine(minF-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
				   minS-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
				   minF+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
				   minS+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.);
	  TLine* line2 = new TLine(minF-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
				   minS+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
				   minF+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
				   minS-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.);
	  line1->SetLineWidth(3);
	  line2->SetLineWidth(3);
	  line1->Draw();
	  line2->Draw();
	  // draw a hatched contour line at min+1
	  //double levels = 1.;
	  //loghist->SetContour(1,&levels);
	  //loghist->Draw("CONTLIST");
	  TObjArray *contours = (TObjArray*)gROOT->GetListOfSpecials()->FindObject("contours");
	  if (contours) {
	    int ncontours = contours->GetSize();
	    int theContourNumber = 0;
	    if (maxval>15.) theContourNumber = 0;
	    else theContourNumber = contourLineNo;
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
	}
    }

    markovFitsFile.close();


}
