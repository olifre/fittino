
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

void ConvertMarkovChainHist2DtoContours2D ( string histInputFileName = "markovHists.root",
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


  // open the input file
  TFile* histInputFile = new TFile (histInputFileName.c_str(), "READ");


  // open text file
  ofstream correlationsOutputFile ("correlationsResults.txt",ios::out);

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

  const int contourLineNo1D1s = 0;
  const int contourLineNo2D2s = 5;

  // open output file for the contours
  TFile* contourOutputFile = new TFile (contourOutputFileName.c_str(), "RECREATE");

  // loop over the histograms in the input file
  for (unsigned int fVariable = 0; fVariable < variables.size(); fVariable++) {
    for (unsigned int sVariable = fVariable+1; sVariable < variables.size(); sVariable++) {
      string crossName1 = "bestFitPointLine_" + variables[sVariable] + "_" + variables[fVariable] + "_1";
      TGraph* crossLine1 = (TGraph*)histInputFile->Get(crossName1.c_str());
      if (!crossLine1) {
	cout << "WARNING: crossLine " << crossName1 << " not found" << endl;
      } else {
	crossLine1->Write();
	crossLine1->Delete();
      }
      string crossName2 = "bestFitPointLine_" + variables[sVariable] + "_" + variables[fVariable] + "_2";
      TGraph* crossLine2 = (TGraph*)histInputFile->Get(crossName2.c_str());
      if (!crossLine2) {
	cout << "WARNING: crossLine " << crossName2 << " not found" << endl;
      } else {
	crossLine2->Write();
	crossLine2->Delete();
      }
      string histname = "thisHist_" + variables[sVariable] + "_" + variables[fVariable];
      TH2D* thishist = (TH2D*)histInputFile->Get(histname.c_str());
      if (!thishist) {
	cout << "WARNING: histogram " << histname << " not found" << endl;
      } else {
	cout << "histogram " << histname << " found" << endl;

	// get the correlations
	// first, invert the histogram
	TH2D* inverthist = (TH2D*)thishist->Clone();
	double inverthistMax = -11111111111.;
	double inverthistMin =  11111111111.;
	for (int invHistBinsX = 1; invHistBinsX<=inverthist->GetXaxis()->GetNbins(); invHistBinsX++) {
	  for (int invHistBinsY = 1; invHistBinsY<=inverthist->GetYaxis()->GetNbins(); invHistBinsY++) {
	    //cout << invHistBinsX << " " << invHistBinsY << " " << inverthist->GetBinContent(invHistBinsX,invHistBinsY) << endl;
	    if (inverthist->GetBinContent(invHistBinsX,invHistBinsY)<inverthistMin) {
	      inverthistMin=inverthist->GetBinContent(invHistBinsX,invHistBinsY);
	    }
	    if (inverthist->GetBinContent(invHistBinsX,invHistBinsY)>inverthistMax) {
	      inverthistMax=inverthist->GetBinContent(invHistBinsX,invHistBinsY);
	    }
	  }
	}
	inverthistMax=6.;
	cout << "thishist min " << inverthistMin << " max " << inverthistMax << endl;
	for (int invHistBinsX = 1; invHistBinsX<=inverthist->GetXaxis()->GetNbins(); invHistBinsX++) {
	  for (int invHistBinsY = 1; invHistBinsY<=inverthist->GetYaxis()->GetNbins(); invHistBinsY++) {
	    if (inverthist->GetBinContent(invHistBinsX,invHistBinsY)>inverthistMax) {
	      inverthist->SetBinContent(invHistBinsX,invHistBinsY,0.);
	    }
	    else {
	      inverthist->SetBinContent(invHistBinsX,invHistBinsY,inverthistMax-inverthist->GetBinContent(invHistBinsX,invHistBinsY));
	    }
	  }
	}
	inverthist->Draw("lego");
	canvas->Print("test.eps");
	double correlationFactor = inverthist->GetCorrelationFactor();

	correlationsOutputFile << "correlation factor between " 
			       << variables[fVariable] << " and " 
			       << variables[sVariable] << " = " 
			       << correlationFactor << endl; 

	inverthist->Delete();

	// draw the histogram
	cout << "finished setting the axis, now drawing the contour list" << endl;
	thishist->Draw("CONTLIST");
	cout << "update the canvas to get the lists written" << endl;
	canvas->Update();
	cout << "Draw all the lists again to see them" << endl;
	thishist->Draw("cont1");
//	// draw a cross at the global minimum
//	cout << "global minimum at " << fBestFit << " " << sBestFit << endl;
//	//	  TLine* line1 = new TLine(sBestFit-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
//	//				   fBestFit-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
//	//				   sBestFit+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
//	//				   fBestFit+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.);
//	//	  TLine* line2 = new TLine(sBestFit-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
//	//				   fBestFit+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
//	//				   sBestFit+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.,
//	//				   fBestFit-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.);
//	const double xVec1[2] = {sBestFit-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80., 
//				 sBestFit+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.};
//	const double yVec1[2] = {fBestFit-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
//				 fBestFit+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.};
//	TGraph* lineGraph1 = new TGraph(2,xVec1,yVec1);
//	const double xVec2[2] = {sBestFit-(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80., 
//				 sBestFit+(thisHist->GetXaxis()->GetXmax()-thisHist->GetXaxis()->GetXmin())/80.};
//	const double yVec2[2] = {fBestFit+(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.,
//				 fBestFit-(thisHist->GetYaxis()->GetXmax()-thisHist->GetYaxis()->GetXmin())/80.};
//	TGraph* lineGraph2 = new TGraph(2,xVec2,yVec2);	  
//	lineGraph1->SetLineWidth(3);
//	lineGraph2->SetLineWidth(3);
//	string lineName = "";
//	lineName = "bestFitPointLine_" + variables[sVariable] + "_" + variables[fVariable] + "_1";
//	lineGraph1->SetName(lineName.c_str());
//	lineName = "bestFitPointLine_" + variables[sVariable] + "_" + variables[fVariable] + "_2";
//	lineGraph2->SetName(lineName.c_str());
//	lineGraph1->Write();
//	lineGraph2->Write();
//	lineGraph1->Draw();
//	lineGraph2->Draw();
	// draw a hatched contour line at min+1
	//double levels = 1.;
	//thishist->SetContour(1,&levels);
	//thishist->Draw("CONTLIST");

	double emptyHistXMin =  100000000.;
	double emptyHistYMin =  100000000.;
	double emptyHistXMax = -100000000.;
	double emptyHistYMax = -100000000.;

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
	      TGraph* graph = (TGraph*)contourList->At(iGraph);
	      cout << "drawing graph no. " << iGraph << " with " << graph->GetN() << " points" << endl;
	      graph->SetLineColor(kBlack);
	      graph->SetLineWidth(3);
	      graph->SetLineStyle(3);
	      graph->Draw("");
	      string contourName = "contour_";
	      char number[256];
	      sprintf(number,"%i",iGraph);
	      contourName = contourName + variables[sVariable] + "_" + variables[fVariable] + "_" + number + "_1D1s";
	      graph->SetName(contourName.c_str());
	      graph->Write();
	      if (graph->GetN()>4) {
		// loop over X and Y values and determine max and min
		double x = 0.;
		double y = 0.;
		for (int iPoint = 0; iPoint < graph->GetN(); iPoint++) {
		  int rc = graph->GetPoint(iPoint,x,y);
		  if (rc>=0) {
		    if (x<emptyHistXMin) {
		      emptyHistXMin = x;
		    }
		    if (y<emptyHistYMin) {
		      emptyHistYMin = y;
		    }
		    if (x>emptyHistXMax) {
		      emptyHistXMax = x;
		    }
		    if (y>emptyHistYMax) {
		      emptyHistYMax = y;
		    }
		  }
		}
	      }
	    }
	  }
	  theContourNumber = contourLineNo2D2s;
	  cout << "plotting contour no. " << theContourNumber << endl; 
	  if (theContourNumber<ncontours) {
	    // get correct contour line
	    TList *contourList = (TList*)contours->At(theContourNumber);
	    int nGraphsPerContour = contourList->GetSize();
	    for (int iGraph = 0; iGraph<nGraphsPerContour; iGraph++) {
	      TGraph* graph = (TGraph*)contourList->At(iGraph);
	      cout << "drawing graph no. " << iGraph << " with " << graph->GetN() << " points" << endl;
	      graph->SetLineColor(kRed+3);
	      graph->SetLineWidth(3);
	      graph->SetLineStyle(3);
	      graph->Draw("");
	      string contourName = "contour_";
	      char number[256];
	      sprintf(number,"%i",iGraph);
	      contourName = contourName + variables[sVariable] + "_" + variables[fVariable] + "_" + number + "_2D2s";
	      graph->SetName(contourName.c_str());
	      graph->Write();
	      if (graph->GetN()>4) {
		// loop over X and Y values and determine max and min
		double x = 0.;
		double y = 0.;
		for (int iPoint = 0; iPoint < graph->GetN(); iPoint++) {
		  int rc = graph->GetPoint(iPoint,x,y);
		  if (rc>=0) {
		    if (x<emptyHistXMin) {
		      emptyHistXMin = x;
		    }
		    if (y<emptyHistYMin) {
		      emptyHistYMin = y;
		    }
		    if (x>emptyHistXMax) {
		      emptyHistXMax = x;
		    }
		    if (y>emptyHistYMax) {
		      emptyHistYMax = y;
		    }
		  }
		}
	      }
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
	fileName = fileName + "PostProcess.eps";

	canvas->Print(fileName.c_str());

	if ( emptyHistXMin > 0. && !(emptyHistXMin - 0.05*(emptyHistXMax-emptyHistXMin) > 0.) ) {
	  emptyHistXMin = 0.;
	} else {
	  emptyHistXMin = emptyHistXMin - 0.05*(emptyHistXMax-emptyHistXMin);
	}
	emptyHistXMax = emptyHistXMax + 0.10*(emptyHistXMax-emptyHistXMin);
	if ( emptyHistYMin > 0. && !(emptyHistYMin - 0.05*(emptyHistYMax-emptyHistYMin) > 0.) ) {
	  emptyHistYMin = 0.;
	} else { 
	  emptyHistYMin = emptyHistYMin - 0.05*(emptyHistYMax-emptyHistYMin);
	}
	emptyHistYMax = emptyHistYMax + 0.15*(emptyHistYMax-emptyHistYMin);

	cout << "finished evaluating " << histname << endl;
	cout << "creating new empty hist with envelope " << endl 
	     << "Xmin = " << emptyHistXMin << endl
	     << "Xmax = " << emptyHistXMax << endl
	     << "Ymin = " << emptyHistYMin << endl
	     << "Ymax = " << emptyHistYMax << endl
	     << endl;

	// create empty histogram
	string emptyHistName = "emptyHist_" + variables[sVariable] + "_" + variables[fVariable];
	TH2D *emptyhist = new TH2D(emptyHistName.c_str(), emptyHistName.c_str(), thishist->GetNbinsX(),
				   emptyHistXMin,
				   emptyHistXMax,
				   thishist->GetNbinsY(),
				   emptyHistYMin,
				   emptyHistYMax);
	emptyhist->SetStats(kFALSE);
	emptyhist->GetXaxis()->CenterTitle(1);
	emptyhist->GetYaxis()->CenterTitle(1);
	emptyhist->GetXaxis()->SetTitle(thishist->GetXaxis()->GetTitle());
	emptyhist->GetYaxis()->SetTitle(thishist->GetYaxis()->GetTitle());





	//canvas->SetLogz();
	//thisHist->Draw("cont1z");
	//fileName = variables[fVariable] + 
	//   variables[sVariable] +
	//   "TestMarkov.eps";
	//canvas->Print(fileName.c_str());	  
	canvas->SetLogz(0);
	thishist->Delete();
	emptyhist->Write();
	emptyhist->Delete();
      }
    }
  }
  
  contourOutputFile->Close();
  histInputFile->Close();
  correlationsOutputFile.close();

}
