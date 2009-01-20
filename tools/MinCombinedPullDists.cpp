/***************************************************************************
                           CombinedPullDists.cpp
                           ---------------------
    This ROOT macro draws the distribution of parameters
    found in a ROOT tree such as that contained in the
    PullDistributions.root file produced by Fittino if
    pull distributions are calculated. It fits Gaussians
    to these distributions. If the tree contains a leaf
    called "Chi2" a chi2 distribution will be fitted instead
    of the Gaussian.
                             -------------------
    $Id: CombinedPullDists.cpp 223 2008-04-03 12:43:22Z uhlenbrock $
    $Name$
                             -------------------
    begin                : April 18, 2008
    authors              : Philip Bechtle, Peter Wienemann
    email                : philip.bechtle@desy.de, peter.wienemann@desy.de
***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

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

void MinCombinedPullDists (const Int_t nbins = 50, 
			   const char* filename1 = "PullDistributions1.sum.root",
			   const char* filename2 = "PullDistributions2.sum.root",
			   const char* tag1      = "#mu > 0",
			   //			const char* tag1      = "Modell korrekt",
			   const char* tag2      = "#mu < 0",
			   //			const char* tag2      = "Modell falsch",
			   const char* treename1 = "tree", 
			   const char* treename2 = "tree", 
			   const Double_t chi2cut = -1,
			   const string logoPath = "" )
{
  // gROOT->SetStyle("ATLAS");
  // gROOT->ForceStyle();
  gStyle->SetOptStat(111111);
  gStyle->SetOptFit(0);

  TFile* file1 = new TFile(filename1, "read");
  TFile* file2 = new TFile(filename2, "read");

  if ( !file1 ) {
    printf("Problem accessing file %s\n", filename1);
    return;
  }
  if ( !file2 ) {
    printf("Problem accessing file %s\n", filename2);
    return;
  }

  TTree* tree1 = (TTree*)file1->Get(treename1);
  TTree* tree2 = (TTree*)file2->Get(treename2);

  if ( !tree1 ) {
    printf("Problem accessing tree %s\n", treename1);
    return;
  }
  if ( !tree2 ) {
    printf("Problem accessing tree %s\n", treename2);
    return;
  }

  Int_t nEntries1 = tree1->GetEntries();
  Int_t nEntries2 = tree2->GetEntries();

  Int_t nLeaves1 = tree1->GetListOfLeaves()->GetEntries();
  Int_t nLeaves2 = tree2->GetListOfLeaves()->GetEntries();

  TLeafD* leaf_chi1 = (TLeafD*)tree1->GetListOfLeaves()->FindObject("Chi2");
  TLeafD* leaf_chi2 = (TLeafD*)tree2->GetListOfLeaves()->FindObject("Chi2");

  TLeafD* leaf_seed1 = (TLeafD*)tree1->GetListOfLeaves()->FindObject("randSeed");
  TLeafD* leaf_seed2 = (TLeafD*)tree2->GetListOfLeaves()->FindObject("randSeed");

  TLeafD* leaf_ntoy1 = (TLeafD*)tree1->GetListOfLeaves()->FindObject("nToy");
  TLeafD* leaf_ntoy2 = (TLeafD*)tree2->GetListOfLeaves()->FindObject("nToy");

  Double_t chi1;
  Double_t chi2;
  Double_t seed1;
  Double_t seed2;
  Double_t ntoy1;
  Double_t ntoy2;

  leaf_chi1->SetAddress(&chi1);
  leaf_chi2->SetAddress(&chi2);
  leaf_seed1->SetAddress(&seed1);
  leaf_seed2->SetAddress(&seed2);
  leaf_ntoy1->SetAddress(&ntoy1);
  leaf_ntoy2->SetAddress(&ntoy2);

  Double_t mintree = tree1->GetMinimum(leaf_chi1->GetName());
  Double_t maxtree = tree1->GetMaximum(leaf_chi1->GetName());
  if (tree2->GetMinimum(leaf_chi2->GetName())<mintree) {
    mintree = tree2->GetMinimum(leaf_chi2->GetName());
  }
  if (tree2->GetMaximum(leaf_chi2->GetName())>maxtree) {
    maxtree = tree2->GetMaximum(leaf_chi2->GetName());
  }

  Double_t min = mintree - 0.15 * (maxtree - mintree);
  Double_t max = maxtree + 0.15 * (maxtree - mintree);

  Char_t xtitle[256];
  Char_t ytitle[256];

  TH2D* histoChi2 = new TH2D(leaf1->GetName(), "", nbins, min, max, nbins, min, max);

  histoChi2->SetMarkerStyle(8);
  histoChi2->SetMarkerSize(1.2);
  histoChi2->SetOption("marker");
  histoChi2->SetStats(kFALSE); // disable fit statistics display
  strcpy(xtitle, leaf1->GetName());
  sprintf(xtitle,"%s (%s)",xtitle,tag1);
  strcpy(ytitle, leaf2->GetName());
  sprintf(ytitle,"%s (%s)",ytitle,tag2);
  histoChi2->SetXTitle(xtitle);
  histoChi2->SetYTitle(ytitle);
  histoChi2->GetXaxis()->CenterTitle();
  histoChi2->GetYaxis()->CenterTitle();
  histoChi2->GetXaxis()->SetTitleSize(0.05);
  histoChi2->GetXaxis()->SetTitleOffset(1.2);
  histoChi2->GetXaxis()->SetLabelSize(0.05);
  histoChi2->GetYaxis()->SetLabelSize(0.05);
  histoChi2->GetYaxis()->CenterTitle();
  histoChi2->GetYaxis()->SetTitleSize(0.05);
  histoChi2->GetYaxis()->SetTitleOffset(1.3);

  int nPoints = 0;
  int nInverted = 0;
      
  cout << "start to loop over the entries " << nEntries1 << " " << nEntries2 << endl;

  for (Int_t i1=0; i1<nEntries1; i1++) {
    tree1->GetEntry(i1);
    // check nToy
    if (ntoy1>1) {
      continue;
    }
    // find corresponding entry in the other tree
    for (Int_t i2=0; i2<nEntries2; i2++) {
      tree2->GetEntry(i2);
      // check nToy
      if (ntoy2>1) {
	continue;
      }
	
      if (seed1==seed2) {

	cout << "corresponding entry found " << seed1 << " " << seed2 << endl;

	nPoints++;
	  
	histo[iLeaf]->Fill(par1[iLeaf],par2[iLeaf]);

      }
    }
  }

  cout << "draw the plot of the pairs" << endl;

  TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 700, 700);
  c->SetBorderMode(0);
  c->SetTopMargin(0.05);
  c->SetBottomMargin(0.15);
  c->SetLeftMargin(0.15);
  c->SetRightMargin(0.05);
    
  char epsfilename[256];

  cout << "calculating and plotting results" << endl;

  //  double wrongEff      = (double)nInverted/(double)nPoints;
  //  double deltaWrongEff = sqrt(wrongEff*(1-wrongEff)/nPoints);

  char effLine1[512];
  char effLine2[512];
  //  char effLine3[512];
  char effLine4[512];
  sprintf(effLine1,"probability to prefer");
  //  sprintf(effLine2,"%s over",tag2);
  //  sprintf(effLine3,"%s:",tag1);
  //  sprintf(effLine2,"%s over %s:",tag2, tag1);
  //  sprintf(effLine4,"%.3f #pm %.3f",wrongEff,deltaWrongEff);

  for (Int_t iLeaf=0; iLeaf<nLeaves1; iLeaf++) {

    TLeafD* leaf  = (TLeafD*)tree1->GetListOfLeaves()->At(iLeaf);
    TLine*  line  = new TLine(minSave[iLeaf],minSave[iLeaf],maxSave[iLeaf],maxSave[iLeaf]); 
    line->SetLineColor(kRed);

    histo[iLeaf]->Draw("box");
    line->Draw("same");
    histo[iLeaf]->Draw("boxsame");

    if (!strcmp(leaf->GetName(),"Chi2")) {
//      TLatex* text1 = new TLatex((0.3*maxSave[iLeaf]+minSave[iLeaf]),(0.21*maxSave[iLeaf]+minSave[iLeaf]),effLine1);
//      TLatex* text2 = new TLatex((0.3*maxSave[iLeaf]+minSave[iLeaf]),(0.16*maxSave[iLeaf]+minSave[iLeaf]),effLine2);
//      TLatex* text3 = new TLatex((0.3*maxSave[iLeaf]+minSave[iLeaf]),(0.10*maxSave[iLeaf]+minSave[iLeaf]),effLine3);
//      TLatex* text4 = new TLatex((0.3*maxSave[iLeaf]+minSave[iLeaf]),(0.05*maxSave[iLeaf]+minSave[iLeaf]),effLine4);
      TLatex* text1 = new TLatex((0.4*maxSave[iLeaf]+minSave[iLeaf]),(0.18*maxSave[iLeaf]+minSave[iLeaf]),effLine1);
      TLatex* text2 = new TLatex((0.4*maxSave[iLeaf]+minSave[iLeaf]),(0.115*maxSave[iLeaf]+minSave[iLeaf]),effLine2);
      TLatex* text4 = new TLatex((0.4*maxSave[iLeaf]+minSave[iLeaf]),(0.04*maxSave[iLeaf]+minSave[iLeaf]),effLine4);
      text1->Draw("same");
      text2->Draw("same");
      //      text3->Draw("same");
      text4->Draw("same");
    }

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

    sprintf(epsfilename, "%s2DPlot.eps", leaf->GetName());
    c->Print(epsfilename);

    if (logoPath!="") {     
      fittinoLogo->Delete();
    }


  }

  cout << "probability to prefer " << tag2 << " over " << tag1 << " = " << wrongEff << " +- " << deltaWrongEff << endl;

  delete[] par1;
  delete[] par2;
  for (Int_t iLeaf=0; iLeaf<nLeaves1; iLeaf++) {
    delete histo[iLeaf];
  }
  delete c;
}
