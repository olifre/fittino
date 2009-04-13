
// This ROOT macro plots the markov chains produced by Fittino 
// in the projections of the mSUGRA high-scale parameters. 
// The asymed statistics is bayesian. Shame on me. An alternative 
// frequentist interpretation will follow soon. 

#include "TStyle.h"
#include "TROOT.h"
#include "TLegend.h"
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
#include "TImage.h"
#include "iostream"
#include "fstream"
#include "string"
#include "vector"
using namespace std;

void Plot2SigmaMarkovContours (const string model = "mSUGRA",
			       const bool   doAlsoSM = false,
			       const int    drawCross = 0,
			       const string file1="file1",
			       const string fileTag1="Tag1",
			       const string file2="file2",
			       const string fileTag2="Tag2",
			       const string file3="file3",
			       const string fileTag3="Tag3",
			       const string file4="file4",
			       const string fileTag4="Tag4",
			       const string file5="file5",
			       const string fileTag5="Tag5",
			       const string file6="file6",
			       const string fileTag6="Tag6",
			       const string logoPath = "" ) 
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
  
  // get the fittino logo
  TImage *fittinoLogo = TImage::Open(logoPath.c_str());
  if (!(logoPath=="")) {
    if (!fittinoLogo) {
      printf("Could not open the fittino logo at %s\n exit\n",logoPath.c_str());
      return;
    }
    fittinoLogo->SetConstRatio(1);
    fittinoLogo->SetImageQuality(TAttImage::kImgBest);
  }

  // sort files
  vector<string> fileNames;
  vector<string> fileNameTags;
  for (int i = 0; i < 6; i++) {
    string thisFile;
    if (i==0 && file1!="file1") {
      fileNames.push_back(file1);
      fileNameTags.push_back(fileTag1);
    }
    if (i==1 && file2!="file2") { 
      fileNames.push_back(file2);
      fileNameTags.push_back(fileTag2);
    }
    if (i==2 && file3!="file3") { 
      fileNames.push_back(file3);
      fileNameTags.push_back(fileTag3);
    }
    if (i==3 && file4!="file4") { 
      fileNames.push_back(file4);
      fileNameTags.push_back(fileTag4);
    }
    if (i==4 && file5!="file5") { 
      fileNames.push_back(file5);
      fileNameTags.push_back(fileTag5);
    }
    if (i==5 && file6!="file6") { 
      fileNames.push_back(file6);
      fileNameTags.push_back(fileTag6);
    }
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
    variables.push_back("P_TanBeta");
    variables.push_back("P_M12");
    variables.push_back("P_M0");
    variables.push_back("P_A0");
    variableNames.push_back("tan#beta");
    variableNames.push_back("M_{12} (GeV)");
    variableNames.push_back("M_{0} (GeV)");
    variableNames.push_back("A_{0} (GeV)");
  } else if (model == "GMSB") {
    variables.push_back("P_TanBeta");
    variables.push_back("P_Lambda"); 
    variables.push_back("P_Mmess");
    variables.push_back("P_Cgrav");
    variableNames.push_back("tan#beta");
    variableNames.push_back("#Lambda (GeV)");
    variableNames.push_back("M_{mess} (GeV)");
    variableNames.push_back("C_{grav} (GeV)");
  } else if (model == "MSSM18") {
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
    variableNames.push_back("M_{#tilde{e}_{L}} (GeV)");
    variableNames.push_back("M_{#tilde{e}_{R}} (GeV)");
    variableNames.push_back("M_{#tilde{#tau}_{L}} (GeV)");
    variableNames.push_back("M_{#tilde{#tau}_{R}} (GeV)");
    variableNames.push_back("M_{#tilde{u}_{L}} (GeV)");
    variableNames.push_back("M_{#tilde{u}_{R}} (GeV)");
    variableNames.push_back("M_{#tilde{b}_{R}} (GeV)");
    variableNames.push_back("M_{#tilde{t}_{L}} (GeV)");
    variableNames.push_back("M_{#tilde{t}_{R}} (GeV)");
    variableNames.push_back("tan#beta");
    variableNames.push_back("#mu (GeV)"); 
    variableNames.push_back("X_{#tau} (GeV)");
    variableNames.push_back("X_{t} (GeV)");
    variableNames.push_back("X_{b} (GeV)");
    variableNames.push_back("M_{1} (GeV)");
    variableNames.push_back("M_{2} (GeV)");
    variableNames.push_back("M_{3} (GeV)");
    variableNames.push_back("m_{A} (GeV)");
    //    variableNames.push_back("M_{#tilde{d}_{R}} (GeV)");
  } else {
    cout << "model " << model << " unknown" << endl; 
    return;
  }

  if (doAlsoSM) {
    variables.push_back("P_alphas");
    variables.push_back("P_alphaem");
    variables.push_back("P_massZ"); 
    variables.push_back("P_massTop");
    variables.push_back("P_G_F");    
    variableNames.push_back("#alpha_{s}");
    variableNames.push_back("#alpha_{em}");
    variableNames.push_back("m_{Z} (Gev)");
    variableNames.push_back("m_{t} (GeV)");
    variableNames.push_back("G_F (Gev^{-2})");
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

      // Create a legend
      //      TLegend *legend = new TLegend(0.60,0.95,0.7,0.95,"");
      TLegend *legend = new TLegend(0.62,0.84,0.96,0.99,"");
      legend->SetTextSize(0.03);

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
	  TGraph* contour = (TGraph*)files[iFile]->Get(contourName.c_str());
	  if (!contour) {
	    break;
	  }
	  contour->SetLineWidth(2);
	  contour->SetLineStyle(styles[iFile]);
	  contour->SetLineColor(colors1[iFile]);
	  if (contour->GetN()>7) {
	    contour->Draw("same");
	  }
	  if (iContour == 0) {
	    string legendEntry = "1D 68% CL " + fileNameTags[iFile];
	    legend->AddEntry(contour, legendEntry.c_str(), "l");
	  }
	  iContour++;
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
	  TGraph* contour = (TGraph*)files[iFile]->Get(contourName.c_str());
	  if (!contour) {
	    break;
	  }
	  contour->SetLineWidth(2);
	  contour->SetLineStyle(styles[iFile]);
	  contour->SetLineColor(colors2[iFile]);
	  if (contour->GetN()>7) {
	    contour->Draw("same");
	  }
	  if (iContour == 0) {
	    string legendEntry = "2D 95% CL " + fileNameTags[iFile];
	    legend->AddEntry(contour, legendEntry.c_str(), "l");
	  }
	  iContour++;
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
      
      // add the fittino logo
      if (!(logoPath=="")) {
	const float canvasHeight   = canvas->GetWindowHeight();
	const float canvasWidth    = canvas->GetWindowWidth();
	const float canvasAspectRatio = canvasHeight/canvasWidth;
	const float width          = 0.19;
	const float xLowerEdge     = 0.02;
	const float yLowerEdge     = 0.853;
	const float xUpperEdge     = xLowerEdge+width;
	const float yUpperEdge     = yLowerEdge+width*fittinoLogo->GetHeight()/fittinoLogo->GetWidth()/canvasAspectRatio;
	cout << " xLowerEdge  = " << xLowerEdge << "\n"
	     << " yLowerEdge  = " << yLowerEdge << "\n"
	     << " xUpperEdge  = " << xUpperEdge << "\n"
	     << " yUpperEdge  = " << yUpperEdge << "\n"
	     << " Imagewidth  = " << fittinoLogo->GetWidth() << "\n"
	     << " Imageheight = " << fittinoLogo->GetHeight() << "\n"
	     << " canvasHeight= " << canvasHeight << "\n"
	     << " canvasWidth = " << canvasWidth  << "\n"
	     << endl;
	//  TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.85, 0.85, 0.98, 0.85+d*fittinoLogo->GetHeight()/fittinoLogo->GetWidth());
	TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", xLowerEdge, yLowerEdge, xUpperEdge, yUpperEdge);
	fittinoLogoPad->Draw("same");
	fittinoLogoPad->cd();
	fittinoLogo->Draw("xxx");
	canvas->cd();
      }

      // Draw the legend
      legend->Draw("same");      

      // write output histogram
      string outputName = "markovChain2D2sContours_" 
	+ variables[iVariable2] + "_" 
	+ variables[iVariable1] + ".eps";
      canvas->Print(outputName.c_str());

      canvas->Clear();
      
    }
  }
  


  for (int i = 0; i < nFiles; i++) {
    files[i]->Close();
  }



  return;

}
