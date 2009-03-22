
// This ROOT macro plots the markov chains produced by Fittino 
// in the projections of the mSUGRA high-scale parameters. 
// The asymed statistics is bayesian. Shame on me. An alternative 
// frequentist interpretation will follow soon. 

#include "TStyle.h"
#include "TROOT.h"
#include "TFile.h"
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

void Plot2SigmaMarkovContours (string model = "mSUGRA",
			       int    drawCross = 0,
			       string file1="file1",
			       string file2="file2",
			       string file3="file3",
			       string file4="file4",
			       string file5="file5",
			       string file6="file6" ) 
{
  
  // setups
  gStyle->SetPalette(1);
  gStyle->SetOptStat(0);
  gStyle->SetFrameFillColor(10);
  gStyle->SetPadColor(10);
  gStyle->SetCanvasColor(10); // light grey: 18
  TCanvas* canvas = new TCanvas();
  canvas->SetBorderMode(0);
  canvas->SetTopMargin(0.06);
  canvas->SetBottomMargin(0.12);
  canvas->SetLeftMargin(0.10);
  canvas->SetRightMargin(0.05);
  

  // sort files
  vector<string> fileNames;
  for (int i = 0; i < 6; i++) {
    string thisFile;
    if (i==0 && file1!="file1") fileNames.push_back(file1);
    if (i==1 && file2!="file2") fileNames.push_back(file2);
    if (i==2 && file3!="file3") fileNames.push_back(file3);
    if (i==3 && file4!="file4") fileNames.push_back(file4);
    if (i==4 && file5!="file5") fileNames.push_back(file5);
    if (i==5 && file6!="file6") fileNames.push_back(file6);
  }
  const int nFiles = fileNames.size();

  // set colors and line styles
  vector<int> colors1;
  vector<int> colors2;
  vector<int> styles;
  for (int i = 0; i < nFiles; i++) {
    styles.push_back(i+1);
    colors2.push_back(kBlue-3+i);
    colors1.push_back(kRed-2+i);
  }  

  // open files
  TFile* files[nFiles];
  for (int i = 0; i < nFiles; i++) {
    files[i] = new TFile(fileNames[i].c_str(),"READ");
    if (!files[i]) {
      cout << "file " << fileNames[i] << " not found" << endl;
      return;
    }
  }  
  
  // define model
  vector<string> variables;
  vector<string> variableNames;
  if (model == "mSUGRA") {
    variables.push_back("TanBeta");
    variables.push_back("A0");
    variables.push_back("M0");
    variables.push_back("M12");
    variableNames.push_back("tan#beta");
    variableNames.push_back("A_{0} (GeV)");
    variableNames.push_back("M_{0} (GeV)");
    variableNames.push_back("M_{12} (GeV)");
  } else if (model == "GMSB") {
    cout << "model GMSB not yet implemented, please feel free to do so" << endl;
    return;
  } else if (model == "MSSM18") {
    cout << "model MSSM18 not yet implemented, please feel free to do so" << endl;
    return;
  } else {
    cout << "model " << model << " unknown" << endl; 
    return;
  }



  // assume for the time being that the first file contains the largest uncertainties
  for (unsigned int iVariable1 = 0; iVariable1 < variables.size(); iVariable1++) {
    for (unsigned int iVariable2 = iVariable1 +1; iVariable2 < variables.size(); iVariable2++) {
      // draw the canvas      
      string histName = "emptyHist_" + variables[iVariable2] + "_" + variables[iVariable1];
      TH2D* hist = (TH2D*)files[0]->Get(histName.c_str());
      if (!hist) {
	cout << "histogram " << histName << " not found" << endl;
	continue;
      }
      cout << "drawing histogram " << histName << endl;
      hist->GetXaxis()->CenterTitle(1);
      hist->GetYaxis()->CenterTitle(1);
      hist->SetTitle("");
      //      hist->GetXaxis()->SetTitle(variableNames[iVariable1]);
      hist->Draw();

      // loop over the existing files and draw the contours
      for (int iFile = 0; iFile < nFiles; iFile++) {
	// draw the contours
	int iContour = 0;
	while (1) {
	  char contourNumber[256];
	  sprintf(contourNumber,"%i",iContour);
	  string contourName = "contour_" 
	    + variables[iVariable2] + "_" 
	    + variables[iVariable1] + "_" 
	    + contourNumber + "_1D1s";
	  cout << "drawing contour " << contourName << endl;
	  iContour++;
	  TGraph* contour = (TGraph*)files[iFile]->Get(contourName.c_str());
	  if (!contour) {
	    break;
	  }
	  contour->SetLineWidth(2);
	  contour->SetLineStyle(styles[iFile]);
	  contour->SetLineColor(colors1[iFile]);
	  contour->Draw("same");
	}
	iContour = 0;
	while (1) {
	  char contourNumber[256];
	  sprintf(contourNumber,"%i",iContour);
	  string contourName = "contour_" 
	    + variables[iVariable2] + "_" 
	    + variables[iVariable1] + "_" 
	    + contourNumber + "_2D2s";
	  cout << "drawing contour " << contourName << endl;
	  iContour++;
	  TGraph* contour = (TGraph*)files[iFile]->Get(contourName.c_str());
	  if (!contour) {
	    break;
	  }
	  contour->SetLineWidth(2);
	  contour->SetLineStyle(styles[iFile]);
	  contour->SetLineColor(colors2[iFile]);
	  contour->Draw("same");
	}
	// eventually draw the cross
	if (iFile == drawCross) {
	  string crossName1 = "bestFitPointLine_"
	    + variables[iVariable2] + "_" 
	    + variables[iVariable1] + "_1"; 
	  string crossName2 = "bestFitPointLine_"
	    + variables[iVariable2] + "_" 
	    + variables[iVariable1] + "_2"; 
	  TGraph* crossLine1 = (TGraph*)files[iFile]->Get(crossName1.c_str());
	  TGraph* crossLine2 = (TGraph*)files[iFile]->Get(crossName2.c_str());
	  if (crossLine1 && crossLine2) {
	    crossLine1->Draw("same");
	    crossLine2->Draw("same");
	  }
	}
      }
      
      // write output histogram
      string outputName = "markovChain2D2sContours_" 
	+ variables[iVariable2] + "_" 
	+ variables[iVariable1] + ".eps";
      canvas->Print(outputName.c_str());
      
    }
  }
  


  for (int i = 0; i < nFiles; i++) {
    files[i]->Close();
  }



  return;

}
