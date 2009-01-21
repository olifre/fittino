/*******************************************************************************
*                                                                              *
*   File:        DrawParDistsMulti.C                                           *
*                                                                              *
*   Description: This ROOT macro draws the distribution of parameters found    * 
*                in a ROOT tree such as that contained in the                  *
*                PullDistributions.root file produced by Fittino if pull       *
*                distributions are calculated. It fits Gaussians to these      *
*                distributions. If the tree contains a leaf called "Chi2" a    *
*                chi2 distribution will be fitted instead of the Gaussian.     *
*                                                                              *
*   Authors:     Philip Bechtle, Mathias Uhlenbrock, Peter Wienemann           *
*                                                                              *
*   Email:       philip.bechtle@desy.de, uhlenbrock@physik.uni-bonn.de         *
*                peter.wienemann@desy.de                                       *
*                                                                              *
*   Date:        2008/11/19                                                    *
*                                                                              *
*******************************************************************************/

/*******************************************************************************
*                                                                              * 
*   This program is free software; you can redistribute it and/or modify it    *
*   under the terms of the GNU General Public License as published by the      * 
*   Free Software Foundation; either version 2 of the License, or              *
*   (at your option) any later version.                                        *
*                                                                              *
*******************************************************************************/

#include "TStyle.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TGraphSmooth.h"
#include "TColor.h"
#include "TF1.h"
#include "TFile.h"
#include "TTree.h"
#include "TCanvas.h"
#include "TLeafD.h"
#include "TImage.h"
#include "TLegend.h"
#include "TLine.h"
#include "TLatex.h"
#include <string>
#include <vector>
#include <map>
using namespace std;

Double_t chi2Function(Double_t *x, Double_t *par) {
  
  Double_t retval = 0;
  
  if ( TMath::Power(2, 0.5*par[1]) * TMath::Gamma(0.5*par[1]) ) {
    retval = (par[0]*(TMath::Power(x[0], 0.5*par[1] - 1) * TMath::Exp(-0.5*x[0]) /
		      (TMath::Power(2, 0.5*par[1]) * TMath::Gamma(0.5*par[1]))));
  }
  
  return retval;
}

void DrawParDistsMultiOmega(const char* filename1 = "file1",
			    const Int_t nbins1 = 50,
			    const char* filename2 = "file2",
			    const Int_t nbins2 = 50,
			    const char* filename3 = "file3",
			    const Int_t nbins3 = 50,
			    const char* treename = "tree",
			    const Double_t chi2cut = -1,
			    const string logoPath = "") {

  gStyle->SetOptStat(0);
  gStyle->SetOptFit(111111);
  
  // ----- open input files and make trees accessible -----
  
  // opening files
  cout << "start opening files" << endl;
  
  //   const char* filename_arr[2];
  const char* filename_arr[3];
  filename_arr[0] = filename1;
  filename_arr[1] = filename2;
  filename_arr[2] = filename3;
  
  TFile* file[3];
  //TFile** file = new TFile[2];
  TTree* tree[3];
  //TTree** tree = new TTree[2];
  
  Int_t nEntries[3];
  //Int_t nEntries[2];
  
  
  //   for (unsigned int iFile=0; iFile<2; iFile++) {
  for (unsigned int iFile=0; iFile<3; iFile++) {
    
    if (!strncmp(filename_arr[iFile],"file",4)) continue;
    
    cout << "opeing file " << filename_arr[iFile] << endl;
    
    file[iFile] = new TFile(filename_arr[iFile], "read");
    
    if ( !file[iFile] ) {
      printf("Problem accessing file %s\n", filename_arr[iFile]);
      return;
    }
    
    tree[iFile] = (TTree*)file[iFile]->Get(treename);
    
    if ( !tree[iFile] ) {
      printf("Problem accessing tree %s\n", treename);
      return;
    }
    
    nEntries[iFile] = tree[iFile]->GetEntries();
    
    Int_t iChi2Leaf[3];
    //      Int_t iChi2Leaf[2];
    iChi2Leaf[iFile] = -1; // leaf index of chi2 leaf
    
  }
  
  Int_t nLeaves = tree[0]->GetListOfLeaves()->GetEntriesFast();
  Int_t nPlots = tree[0]->GetListOfLeaves()->GetEntriesFast(); // nPlots = nLeaves
  
  Int_t nLeaves1 = tree[1]->GetListOfLeaves()->GetEntriesFast();
  Int_t nPlots1 = tree[1]->GetListOfLeaves()->GetEntriesFast(); // nPlots = nLeaves
  
  Int_t nLeaves2 = 0;
  Int_t nPlots2 = 0;
  if (strncmp(filename_arr[2],"file",4)) {
    nLeaves2 = tree[2]->GetListOfLeaves()->GetEntriesFast();
    nPlots2 = tree[2]->GetListOfLeaves()->GetEntriesFast(); // nPlots = nLeaves
  }
  
  int nLeavesPerFile[3];
  nLeavesPerFile[0] = nLeaves;
  nLeavesPerFile[1] = nLeaves1;
  nLeavesPerFile[2] = nLeaves2;
  
  Double_t* par   = new Double_t[nLeaves];
  Double_t* sum   = new Double_t[nLeaves];
  Double_t* sum2  = new Double_t[nLeaves];
  TH1F* histo[3];
  //TH1F**    histo = new TH1F[2];
  TF1* gauss[3];
  //TF1**     gauss = new TF1[2];
  TF1* chi2TF1[3];
  //TF1**     chi2  = new TF1[2];
  //  Color_t   color[3] = {kRed, kGreen, kBlue};
  Color_t   color[3] = {46,38,41};
  //Color_t   color[3] = {kRed, kBlue};
  Double_t  nbins[3] = {nbins1, nbins2, nbins3};
  //Double_t  nbins[2] = {nbins1, nbins2};
  
  // ----- loop over leaves in tree -----
  
  TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 700, 700);
  c->SetBorderMode(0);
  c->SetTopMargin(0.05);
  c->SetBottomMargin(0.15);
  c->SetLeftMargin(0.15);
  c->SetRightMargin(0.05);
  
  string targetName = "Omega_npf_nofit";
  
  Double_t mintree[3];
  Double_t maxtree[3]; 
  Double_t min = 100000.;
  Double_t max = -100000.;

  //      for (unsigned int iFile=0; iFile<2; iFile++) {
  for (unsigned int iFile=0; iFile<3; iFile++) {
     
    cout << "testing for file " << filename_arr[iFile] << endl;
    if (!strncmp(filename_arr[iFile],"file",4)) continue;
    cout << "looking at file " << filename_arr[iFile] << " with " << nLeavesPerFile[iFile] << " leaves" << endl;
    
    for (Int_t iLeaf=0; iLeaf<nLeavesPerFile[iFile]; iLeaf++) {
      
      cout << "testing for leaf " << iLeaf << " in tree " << iFile << endl;
      TLeafD* leaf = (TLeafD*)tree[iFile]->GetListOfLeaves()->At(iLeaf);
      //	 TLeafD* leaf = (TLeafD*)tree[iFile]->GetListOfLeaves()->FindObject("A0");
      if (!leaf) return;
      cout << "found leaf" << endl;
      string leafName = leaf->GetName();
      cout << "leaf Name " << leafName << endl;
      cout << "target Name " << targetName << endl;
      char leafNameChar[256];
      strcpy(leafNameChar,leafName.c_str());
      cout << "leaf Name Char " << leafNameChar << endl;
      char targetNameChar[256];
      strcpy(targetNameChar,targetName.c_str());
      cout << "target Name Char " << targetNameChar << endl;
      if ( strcmp(leafNameChar,targetNameChar) ) continue;
      cout << "found target " << leafName << endl;
      leaf->SetAddress(&par[iLeaf]);
      
      cout << "found Omega " << iLeaf << " " << leaf->GetName() << endl;
      
      mintree[iFile] = tree[iFile]->GetMinimum(leaf->GetName());
      maxtree[iFile] = tree[iFile]->GetMaximum(leaf->GetName());
      if ((mintree[iFile] - 0.15 * (maxtree[iFile] - mintree[iFile]))<min) {
	min = mintree[iFile] - 0.15 * (maxtree[iFile] - mintree[iFile]);
      }
      if ((maxtree[iFile] + 0.15 * (maxtree[iFile] - mintree[iFile]))>max) {
	max = maxtree[iFile] + 0.15 * (maxtree[iFile] - mintree[iFile]);
      }
      
      histo[iFile] = new TH1F(leaf->GetName(), "", nbins[iFile], min, max);
      //histo[iFile] = new TH1F(leaf->GetName(), "", nbins[iFile], 95, 105);
      
      Char_t xtitle[256];
      
      if (!strcmp(leaf->GetName(), "TanBeta")) strcpy(xtitle, "tan #beta");
      else if (!strcmp(leaf->GetName(), "Mu")) strcpy(xtitle, "#mu (GeV)");
      else if (!strcmp(leaf->GetName(), "MuEff")) strcpy(xtitle, "#mu_{eff} (GeV)");
      else if (!strcmp(leaf->GetName(), "Xtau")) strcpy(xtitle, "X_{#tau} (GeV)");
      else if (!strcmp(leaf->GetName(), "MSelectronR")) strcpy(xtitle, "M_{#tilde{e}_{R}} (GeV)");
      else if (!strcmp(leaf->GetName(), "MStauR")) strcpy(xtitle, "M_{#tilde{#tau}_{R}} (GeV)");
      else if (!strcmp(leaf->GetName(), "MSelectronL")) strcpy(xtitle, "M_{#tilde{e}_{L}} (GeV)");
      else if (!strcmp(leaf->GetName(), "MStauL")) strcpy(xtitle, "M_{#tilde{#tau}_{L}} (GeV)");
      else if (!strcmp(leaf->GetName(), "Xtop")) strcpy(xtitle, "X_{t} (GeV)");
      else if (!strcmp(leaf->GetName(), "Xbottom")) strcpy(xtitle, "X_{b} (GeV)");
      else if (!strcmp(leaf->GetName(), "MSdownR")) strcpy(xtitle, "M_{#tilde{d}_{R}} (GeV)");
      else if (!strcmp(leaf->GetName(), "MSbottomR")) strcpy(xtitle, "M_{#tilde{b}_{R}} (GeV)");
      else if (!strcmp(leaf->GetName(), "MSupR")) strcpy(xtitle, "M_{#tilde{u}_{R}} (GeV)");
      else if (!strcmp(leaf->GetName(), "MStopR")) strcpy(xtitle, "M_{#tilde{t}_{R}} (GeV)");
      else if (!strcmp(leaf->GetName(), "MSupL")) strcpy(xtitle, "M_{#tilde{u}_{L}} (GeV)");
      else if (!strcmp(leaf->GetName(), "MStopL")) strcpy(xtitle, "M_{#tilde{t}_{L}} (GeV)");
      else if (!strcmp(leaf->GetName(), "M1")) strcpy(xtitle, "M_{1} (GeV)");
      else if (!strcmp(leaf->GetName(), "M2")) strcpy(xtitle, "M_{2} (GeV)");
      else if (!strcmp(leaf->GetName(), "M3")) strcpy(xtitle, "M_{3} (GeV)");
      else if (!strcmp(leaf->GetName(), "massA0")) strcpy(xtitle, "m_{A} (GeV)");
      else if (!strcmp(leaf->GetName(), "massTop")) strcpy(xtitle, "m_{t} (GeV)");
      else if (!strcmp(leaf->GetName(), "lambda")) strcpy(xtitle, "#lambda");
      else if (!strcmp(leaf->GetName(), "kappa")) strcpy(xtitle, "#kappa");
      else if (!strcmp(leaf->GetName(), "ALambda")) strcpy(xtitle, "A_{#lambda} (GeV)");
      else if (!strcmp(leaf->GetName(), "AKappa")) strcpy(xtitle, "A_{#kappa} (GeV)");
      else if (!strcmp(leaf->GetName(), "Chi2")) strcpy(xtitle, "#chi^{2}");
      else if (!strcmp(leaf->GetName(), "M0")) strcpy(xtitle, "M_{0} (GeV)");
      else if (!strcmp(leaf->GetName(), "M12")) strcpy(xtitle, "M_{1/2} (GeV)");
      else if (!strcmp(leaf->GetName(), "A0")) strcpy(xtitle, "A_{0} (GeV)");
      else if (!strcmp(leaf->GetName(), "Omega_npf_nofit")) strcpy(xtitle, "#Omega_{DM}");
      else strcpy(xtitle, leaf->GetName());
      
      histo[iFile]->SetXTitle(xtitle);
      histo[iFile]->GetXaxis()->CenterTitle();
      histo[iFile]->GetXaxis()->SetTitleSize(0.05);
      histo[iFile]->GetXaxis()->SetTitleOffset(1.2);
      histo[iFile]->GetXaxis()->SetLabelSize(0.05);
      //histo[iFile]->SetYTitle("Eintr#ddot{a}ge");
      histo[iFile]->SetYTitle("Toy fits");
      histo[iFile]->GetYaxis()->SetLabelSize(0.05);
      histo[iFile]->GetYaxis()->CenterTitle();
      histo[iFile]->GetYaxis()->SetTitleSize(0.05);
      histo[iFile]->GetYaxis()->SetTitleOffset(1.3);
      
      nEntries[iFile] = tree[iFile]->GetEntries();
      
      // ----- fill histo
      
      for (unsigned int iEntry=0; iEntry<nEntries[iFile]; iEntry++) {
	
	tree[iFile]->GetEntry(iEntry);
	
	//sum[iLeaf]  = 0;
	//sum2[iLeaf] = 0;
	
	histo[iFile]->SetMarkerStyle(8);
	histo[iFile]->SetMarkerSize(1.2);
	histo[iFile]->SetMarkerColor(color[iFile]);
	histo[iFile]->SetLineColor(color[iFile]);
	histo[iFile]->SetOption("marker");
	histo[iFile]->SetStats(kFALSE); // disable fit statistics display
	
	//Double_t chi2val = -1;
	//if (!(iChi2Leaf < 0)) {
	//   chi2val = par[iChi2Leaf];
	//}
	
	//if (chi2cut < 0 || ( !(chi2cut < 0) && chi2val < chi2cut ) ) {
	double modelShift = 0.;
	if (iFile==1) modelShift = -0.0008;
	histo[iFile]->Fill(par[iLeaf]+modelShift);
	//histo[0]->Rebin(2);
	//histo[0]->Rebin(40);
	//histo[0]->Scale(0.025);
	//for (unsigned int nbin = 0; nbin<=histo[0]->GetNbinsX(); nbin++) {
	//   histo[0]->SetBinError(nbin, TMath::Sqrt(histo[0]->GetBinContent(nbin)/40));
	//}
	
	//sum[iLeaf]  += par[iLeaf];
	//sum2[iLeaf] += par[iLeaf] * par[iLeaf];
	//}
	
      }
      
      // histo[iFile]->Scale(1./histo[iFile]->Integral());

    }

  }

  cout << "compare the histograms" << endl;

  // find highest contents
  int histOrder[3];
  if (strncmp(filename_arr[2],"file",4)) {   
    cout << "compare three histograms" << endl;
    if ((histo[0]->GetMaximum()>histo[1]->GetMaximum())&&(histo[0]->GetMaximum()>histo[2]->GetMaximum())) {
      histOrder[0] = 0;
      histOrder[1] = 1;
      histOrder[2] = 2;
    }
    if ((histo[1]->GetMaximum()>histo[0]->GetMaximum())&&(histo[1]->GetMaximum()>histo[2]->GetMaximum())) {
      histOrder[0] = 1;
      histOrder[1] = 0;
      histOrder[2] = 2;
    }
    if ((histo[2]->GetMaximum()>histo[0]->GetMaximum())&&(histo[2]->GetMaximum()>histo[1]->GetMaximum())) {
      histOrder[0] = 2;
      histOrder[1] = 1;
      histOrder[2] = 0;
    }
  } else {
    cout << "compare two histograms" << endl;
   if (histo[0]->GetMaximum()>histo[1]->GetMaximum()) {
      histOrder[0] = 0;
      histOrder[1] = 1;
      histOrder[2] = 2;
    } else {
      histOrder[0] = 1;
      histOrder[1] = 0;
      histOrder[2] = 2;
    }
  }
 
  cout << "print the histograms" << endl;
  for (unsigned int iFile=0; iFile<3; iFile++) {

    if (!strncmp(filename_arr[iFile],"file",4)) continue;   

    cout << "print histograms" << iFile << endl;
   

    if ( iFile == 0 ) histo[histOrder[iFile]]->Draw("ep");
    else histo[histOrder[iFile]]->Draw("epsame");
    
    if (!strcmp(leaf->GetName(), "Chi2")) {
      
      //if (!(chi2cut < 0) && iChi2Leaf < 0) {
      //   printf("Cannot apply chi2 cut because tree does not contain Chi2 leaf\n");
      //   return;
      //}
      
      chi2[iFile] = new TF1("chi2", chi2Function,
			    TMath::Max( histo[iFile]->GetXaxis()->GetXmin(), 0.0),
			    histo[iFile]->GetXaxis()->GetXmax(), 2);
      chi2[iFile]->SetLineColor(color[iFile]);
      chi2[iFile]->SetParNames("norm", "ndf");
      chi2[iFile]->SetParameter(0, 0.1 * histo[iFile]->Integral());
      chi2[iFile]->SetParameter(1, 10);
      histo[iFile]->Fit(chi2[iFile], "0");
      chi2[iFile]->Draw("same");
      
      //iChi2Leaf[iFile] = iLeaf;
      
    }
    
    else {
      
      gauss[iFile] = new TF1("gauss", "gaus", histo[iFile]->GetXaxis()->GetXmin(),
			     histo[iFile]->GetXaxis()->GetXmax());
      gauss[iFile]->SetLineColor(color[iFile]);
      histo[iFile]->Fit(gauss[iFile], "0");
      gauss[iFile]->Draw("same");
      
    }
    
  }
  
  TLegend *legend = new TLegend(0.68,0.68,0.85,0.85); 
  legend->SetFillStyle(0);
  legend->AddEntry(gauss[0],"  MSSM18", "L");
  legend->AddEntry(gauss[1],"  mSUGRA", "L");
  legend->Draw();
    
  TImage *fittinoLogo = 0;
  if (logoPath!="") {
    // get the fittino logo
    fittinoLogo = TImage::Open(logoPath.c_str());
    if (!fittinoLogo) {
      printf("Could not open the fittino logo at %s\n exit\n",logoPath.c_str());
      return;
    }
    fittinoLogo->SetConstRatio(1);
    fittinoLogo->SetImageQuality(TAttImage::kImgBest);
    
    const float canvasHeight   = c->GetWindowHeight();
    const float canvasWidth    = c->GetWindowWidth();
    const float canvasAspectRatio = canvasHeight/canvasWidth;
    const float width          = 0.22;
    const float xLowerEdge     = 0.02;
    const float yLowerEdge     = 0.88;
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
    c->cd();
  }


  char epsfilename[256];
  sprintf(epsfilename, "%s.eps", targetName.c_str());
  c->Print(epsfilename);

  if (logoPath!="") {     
    fittinoLogo->Delete();
  }


  return;    

  
}
