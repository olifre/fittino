/***************************************************************************
                           ModelComparison.C
                           -----------------
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

#include "TROOT.h"
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
#include "TLeafI.h"
#include "TImage.h"
#include "TLegend.h"
#include "TLine.h"
#include "TLatex.h"
#include <string>
#include <vector>
#include <map>
using namespace std;

void DrawParDistDifferentInterpretatons (const Int_t nbins = 50, 
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

  if (nLeaves1 != nLeaves2) {
    cout << "Number of leaves in the two files not identical." << endl;
    //    return;
  }

  Int_t iChi2Leaf = -1; // vector index of chi2
  Int_t iRandSeed = -1; // vector index of randSeed
  // Int_t iToy = -1; // vector index of nToy leaf

  Char_t xtitle[256];
  Char_t ytitle[256];

  int nPoints = 0;
  int nInverted = 0;

  vector<string> commonLeaves;
  if (nLeaves1 >= nLeaves2) {
    for (Int_t iLeaf=0; iLeaf<nLeaves1; iLeaf++) {    
      TLeafD* leaf1 = (TLeafD*)tree1->GetListOfLeaves()->At(iLeaf);
      TLeafD* leaf2 = (TLeafD*)tree2->GetListOfLeaves()->FindObject(leaf1->GetName());
      if (leaf2) {
	if (!strcmp(leaf1->GetName(), leaf2->GetName())) {
	  commonLeaves.push_back(leaf1->GetName());
	}
      }
    }
  }
  else {
    for (Int_t iLeaf=0; iLeaf<nLeaves2; iLeaf++) {    
      TLeafD* leaf2 = (TLeafD*)tree2->GetListOfLeaves()->At(iLeaf);
      TLeafD* leaf1 = (TLeafD*)tree1->GetListOfLeaves()->FindObject(leaf2->GetName());
      if (leaf1) {
	if (!strcmp(leaf1->GetName(), leaf2->GetName())) {
	  commonLeaves.push_back(leaf1->GetName());
	}
      }
    }
  }

  Int_t nCommonLeaves = commonLeaves.size();

  Double_t* par1  = new Double_t[nCommonLeaves];
  Double_t* par2  = new Double_t[nCommonLeaves];
  Double_t* minSave  = new Double_t[nCommonLeaves];
  Double_t* maxSave  = new Double_t[nCommonLeaves];
  Double_t* sum   = new Double_t[nCommonLeaves];
  Double_t* sum2  = new Double_t[nCommonLeaves];
  TH2D*    histo[nCommonLeaves];
  TH1D*    histo1D[nCommonLeaves];
  Int_t ntoy1;
  Int_t ntoy2;

  //   TF1**     gauss = new TF1[nCommonLeaves];
  //    TF1*      chi2  = 0;

  /*
  cout << "List of common leaves:" << endl;
  for (int iLeaf=0 ; iLeaf < nCommonLeaves; iLeaf++ ) {
    cout << "    " << commonLeaves[iLeaf] << endl;
  }
  */

  map<int,int> iLeafToInternalIndexMap;

  char leaf1name[256];
  char leaf2name[256];
  
  for (unsigned int iLeaf=0; iLeaf<commonLeaves.size(); iLeaf++) {

    TLeafD* leaf1 = 0;
    TLeafD* leaf2 = 0;
    TLeafI* leafi1 = 0;
    TLeafI* leafi2 = 0;

    if ( commonLeaves[iLeaf].compare("nToy") ) {

      leaf1 = (TLeafD*)tree1->GetListOfLeaves()->FindObject(commonLeaves[iLeaf].c_str());
      leaf2 = (TLeafD*)tree2->GetListOfLeaves()->FindObject(commonLeaves[iLeaf].c_str());

      if (!leaf1) {
	cerr << "Did not find leaf1 in tree" << endl;
	return;
      }

      if (!leaf2) {
	cerr << "Did not find leaf2 in tree" << endl;
	return;
      }

      leaf1->SetAddress(&par1[iLeaf]);
      leaf2->SetAddress(&par2[iLeaf]);

      strcpy(leaf1name, leaf1->GetName());
      strcpy(leaf2name, leaf2->GetName());
    }
    else {
      leafi1 = (TLeafI*)tree1->GetListOfLeaves()->FindObject(commonLeaves[iLeaf].c_str());
      leafi2 = (TLeafI*)tree2->GetListOfLeaves()->FindObject(commonLeaves[iLeaf].c_str());

      leafi1->SetAddress(&ntoy1);
      leafi2->SetAddress(&ntoy2);

      strcpy(leaf1name, leafi1->GetName());
      strcpy(leaf2name, leafi2->GetName());
    }

    sum[iLeaf]  = 0;
    sum2[iLeaf] = 0;
      
    if (strcmp(leaf1name,leaf2name)) {
      cout << "Names of leaves are not identical. Something is going wrong." << endl;
      return;
    }

    Double_t mintree = tree1->GetMinimum(leaf1name);
    Double_t maxtree = tree1->GetMaximum(leaf1name);
    if (tree2->GetMinimum(leaf2name)<mintree) {
      mintree = tree2->GetMinimum(leaf2name);
    }
    if (tree2->GetMaximum(leaf2name)>maxtree) {
      maxtree = tree2->GetMaximum(leaf2name);
    }
    Double_t min = mintree - 0.15 * (maxtree - mintree);
    Double_t max = maxtree + 0.15 * (maxtree - mintree);

    minSave[iLeaf] = min;
    maxSave[iLeaf] = max;
      
    histo[iLeaf] = new TH2D(leaf1name, "", nbins, min, max, nbins, min, max );
    histo1D[iLeaf] = new TH1D(leaf1name, "", nbins, min, max, nbins, min, max );
      
    histo[iLeaf]->SetMarkerStyle(8);
    histo[iLeaf]->SetMarkerSize(1.2);
    histo[iLeaf]->SetOption("marker");
    histo[iLeaf]->SetStats(kFALSE); // disable fit statistics display
    if (!strcmp(leaf1name, "TanBeta")) strcpy(xtitle, "tan #beta");
    else if (!strcmp(leaf1name, "Mu")) strcpy(xtitle, "#mu (GeV)");
    else if (!strcmp(leaf1name, "MuEff")) strcpy(xtitle, "#mu_{eff} (GeV)");
    else if (!strcmp(leaf1name, "Xtau")) strcpy(xtitle, "X_{#tau} (GeV)");
    else if (!strcmp(leaf1name, "MSelectronR")) strcpy(xtitle, "M_{#tilde{e}_{R}} (GeV)");
    else if (!strcmp(leaf1name, "MStauR")) strcpy(xtitle, "M_{#tilde{#tau}_{R}} (GeV)");
    else if (!strcmp(leaf1name, "MSelectronL")) strcpy(xtitle, "M_{#tilde{e}_{L}} (GeV)");
    else if (!strcmp(leaf1name, "MStauL")) strcpy(xtitle, "M_{#tilde{#tau}_{L}} (GeV)");
    else if (!strcmp(leaf1name, "Xtop")) strcpy(xtitle, "X_{t} (GeV)");
    else if (!strcmp(leaf1name, "Xbottom")) strcpy(xtitle, "X_{b} (GeV)");
    else if (!strcmp(leaf1name, "MSdownR")) strcpy(xtitle, "M_{#tilde{d}_{R}} (GeV)");
    else if (!strcmp(leaf1name, "MSbottomR")) strcpy(xtitle, "M_{#tilde{b}_{R}} (GeV)");
    else if (!strcmp(leaf1name, "MSupR")) strcpy(xtitle, "M_{#tilde{u}_{R}} (GeV)");
    else if (!strcmp(leaf1name, "MStopR")) strcpy(xtitle, "M_{#tilde{t}_{R}} (GeV)");
    else if (!strcmp(leaf1name, "MSupL")) strcpy(xtitle, "M_{#tilde{u}_{L}} (GeV)");
    else if (!strcmp(leaf1name, "MStopL")) strcpy(xtitle, "M_{#tilde{t}_{L}} (GeV)");
    else if (!strcmp(leaf1name, "M1")) strcpy(xtitle, "M_{1} (GeV)");
    else if (!strcmp(leaf1name, "M2")) strcpy(xtitle, "M_{2} (GeV)");
    else if (!strcmp(leaf1name, "M3")) strcpy(xtitle, "M_{3} (GeV)");
    else if (!strcmp(leaf1name, "massA0")) strcpy(xtitle, "m_{A} (GeV)");
    else if (!strcmp(leaf1name, "massTop")) strcpy(xtitle, "m_{t} (GeV)");
    else if (!strcmp(leaf1name, "lambda")) strcpy(xtitle, "#lambda");
    else if (!strcmp(leaf1name, "kappa")) strcpy(xtitle, "#kappa");
    else if (!strcmp(leaf1name, "ALambda")) strcpy(xtitle, "A_{#lambda} (GeV)");
    else if (!strcmp(leaf1name, "AKappa")) strcpy(xtitle, "A_{#kappa} (GeV)");
    else if (!strcmp(leaf1name, "Chi2")) strcpy(xtitle, "#chi^{2}");
    else if (!strcmp(leaf1name, "M0")) strcpy(xtitle, "M_{0} (GeV)");
    else if (!strcmp(leaf1name, "M12")) strcpy(xtitle, "M_{1/2} (GeV)");
    else if (!strcmp(leaf1name, "A0")) strcpy(xtitle, "A_{0} (GeV)");
    else if (!strcmp(leaf1name, "Mmess")) strcpy(xtitle, "M_{mess} (GeV)");
    else if (!strcmp(leaf1name, "Lambda")) strcpy(xtitle, "#lambda (GeV)");
    else if (!strcmp(leaf1name, "cGrav")) strcpy(xtitle, "C_{Grav}");
    else strcpy(xtitle, leaf1name);
    sprintf(xtitle,"%s (%s)",xtitle,tag1);
    if (!strcmp(leaf2name, "TanBeta")) strcpy(ytitle, "tan #beta");
    else if (!strcmp(leaf2name, "Mu")) strcpy(ytitle, "#mu (GeV)");
    else if (!strcmp(leaf2name, "MuEff")) strcpy(ytitle, "#mu_{eff} (GeV)");
    else if (!strcmp(leaf2name, "Xtau")) strcpy(ytitle, "X_{#tau} (GeV)");
    else if (!strcmp(leaf2name, "MSelectronR")) strcpy(ytitle, "M_{#tilde{e}_{R}} (GeV)");
    else if (!strcmp(leaf2name, "MStauR")) strcpy(ytitle, "M_{#tilde{#tau}_{R}} (GeV)");
    else if (!strcmp(leaf2name, "MSelectronL")) strcpy(ytitle, "M_{#tilde{e}_{L}} (GeV)");
    else if (!strcmp(leaf2name, "MStauL")) strcpy(ytitle, "M_{#tilde{#tau}_{L}} (GeV)");
    else if (!strcmp(leaf2name, "Xtop")) strcpy(ytitle, "X_{t} (GeV)");
    else if (!strcmp(leaf2name, "Xbottom")) strcpy(ytitle, "X_{b} (GeV)");
    else if (!strcmp(leaf2name, "MSdownR")) strcpy(ytitle, "M_{#tilde{d}_{R}} (GeV)");
    else if (!strcmp(leaf2name, "MSbottomR")) strcpy(ytitle, "M_{#tilde{b}_{R}} (GeV)");
    else if (!strcmp(leaf2name, "MSupR")) strcpy(ytitle, "M_{#tilde{u}_{R}} (GeV)");
    else if (!strcmp(leaf2name, "MStopR")) strcpy(ytitle, "M_{#tilde{t}_{R}} (GeV)");
    else if (!strcmp(leaf2name, "MSupL")) strcpy(ytitle, "M_{#tilde{u}_{L}} (GeV)");
    else if (!strcmp(leaf2name, "MStopL")) strcpy(ytitle, "M_{#tilde{t}_{L}} (GeV)");
    else if (!strcmp(leaf2name, "M1")) strcpy(ytitle, "M_{1} (GeV)");
    else if (!strcmp(leaf2name, "M2")) strcpy(ytitle, "M_{2} (GeV)");
    else if (!strcmp(leaf2name, "M3")) strcpy(ytitle, "M_{3} (GeV)");
    else if (!strcmp(leaf2name, "massA0")) strcpy(ytitle, "m_{A} (GeV)");
    else if (!strcmp(leaf2name, "massTop")) strcpy(ytitle, "m_{t} (GeV)");
    else if (!strcmp(leaf2name, "lambda")) strcpy(ytitle, "#lambda");
    else if (!strcmp(leaf2name, "kappa")) strcpy(ytitle, "#kappa");
    else if (!strcmp(leaf2name, "ALambda")) strcpy(ytitle, "A_{#lambda} (GeV)");
    else if (!strcmp(leaf2name, "AKappa")) strcpy(ytitle, "A_{#kappa} (GeV)");
    else if (!strcmp(leaf2name, "Chi2")) strcpy(ytitle, "#chi^{2}");
    else if (!strcmp(leaf2name, "M0")) strcpy(ytitle, "M_{0} (GeV)");
    else if (!strcmp(leaf2name, "M12")) strcpy(ytitle, "M_{1/2} (GeV)");
    else if (!strcmp(leaf2name, "A0")) strcpy(ytitle, "A_{0} (GeV)");
    else if (!strcmp(leaf2name, "Mmess")) strcpy(ytitle, "M_{mess} (GeV)");
    else if (!strcmp(leaf2name, "Lambda")) strcpy(ytitle, "#lambda (GeV)");
    else if (!strcmp(leaf2name, "cGrav")) strcpy(ytitle, "C_{Grav}");
    else strcpy(ytitle, leaf2name);
    sprintf(ytitle,"%s (%s)",ytitle,tag2);
    histo[iLeaf]->SetXTitle(xtitle);
    histo[iLeaf]->SetYTitle(ytitle);
    histo[iLeaf]->GetXaxis()->CenterTitle();
    histo[iLeaf]->GetYaxis()->CenterTitle();
    histo[iLeaf]->GetXaxis()->SetTitleSize(0.05);
    histo[iLeaf]->GetXaxis()->SetTitleOffset(1.2);
    histo[iLeaf]->GetXaxis()->SetLabelSize(0.05);
    histo[iLeaf]->GetYaxis()->SetLabelSize(0.05);
    histo[iLeaf]->GetYaxis()->CenterTitle();
    histo[iLeaf]->GetYaxis()->SetTitleSize(0.05);
    histo[iLeaf]->GetYaxis()->SetTitleOffset(1.3);

    if (!strcmp(leaf1name, "Chi2") || !strcmp(leaf2name, "Chi2")) {
      iChi2Leaf = iLeaf;
    }
    if (!strcmp(leaf1name, "randSeed") || !strcmp(leaf2name, "randSeed")) {
      iRandSeed = iLeaf;
    }

  }

  if (!(chi2cut < 0) && iChi2Leaf < 0) {
    printf("Cannot apply chi2 cut because tree(s) do(es) not contain Chi2 leaf\n");
    return;
  }

  cout << "Start to loop over the entries " << nEntries1
       << " " << nEntries2 << endl;

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

      if (par1[iRandSeed]==par2[iRandSeed]) {

	cout << "Corresponding entry found " << par1[iRandSeed] 
	     << " " << par2[iRandSeed] << endl;
	Double_t chi2val1 = -1; 
	Double_t chi2val2 = -1; 
	if (!(iChi2Leaf < 0)) {
	  chi2val1 = par1[iChi2Leaf];
	}
	if (!(iChi2Leaf < 0)) {
	  chi2val2 = par2[iChi2Leaf];
	}

	if ( chi2val1<0. || chi2val2<0. ) {
	  continue;
	}

	nPoints++;
	  
	if (chi2val2<chi2val1) {
	  nInverted++;
	}
	  
	for (Int_t iLeaf=0; iLeaf<nCommonLeaves; iLeaf++) {
	  if (chi2cut < 0 || ( !(chi2cut < 0) && chi2val1 < chi2cut ) ) {
	    histo[iLeaf]->Fill(par1[iLeaf],par2[iLeaf]);
	      
	    sum[iLeaf]  += par1[iLeaf];
	    sum2[iLeaf] += par1[iLeaf] * par1[iLeaf];
	  }
	}
      }
    }
  }

  cout << "Draw the plot of the pairs" << endl;

  TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 700, 700);
  c->SetBorderMode(0);
  c->SetTopMargin(0.05);
  c->SetBottomMargin(0.15);
  c->SetLeftMargin(0.15);
  c->SetRightMargin(0.05);
    
  char epsfilename[256];

  cout << "Calculating and plotting results" << endl;

  double wrongEff      = (double)nInverted/(double)nPoints;
  double deltaWrongEff = sqrt(wrongEff*(1-wrongEff)/nPoints);

  char effLine1[512];
  char effLine2[512];
  //  char effLine3[512];
  char effLine4[512];
  sprintf(effLine1,"Probability to prefer");
  //  sprintf(effLine2,"%s over",tag2);
  //  sprintf(effLine3,"%s:",tag1);
  sprintf(effLine2,"%s over %s:",tag2, tag1);
  sprintf(effLine4,"%.3f #pm %.3f",wrongEff,deltaWrongEff);

  for (Int_t iLeaf=0; iLeaf<nCommonLeaves; iLeaf++) {

    TLine*  line  = new TLine(minSave[iLeaf],minSave[iLeaf],maxSave[iLeaf],maxSave[iLeaf]); 
    line->SetLineColor(kRed);

    histo[iLeaf]->Draw("box");
    line->Draw("same");
    histo[iLeaf]->Draw("boxsame");

    if (!strcmp(commonLeaves[iLeaf].c_str(),"Chi2")) {
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

    sprintf(epsfilename, "%s_2DPlot.eps", commonLeaves[iLeaf].c_str());
    c->Print(epsfilename);

    if (logoPath!="") {     
      fittinoLogo->Delete();
    }


  }

  cout << "probability to prefer " << tag2 << " over " << tag1 << " = " << wrongEff << " +- " << deltaWrongEff << endl;

  delete[] par1;
  delete[] par2;
  for (Int_t iLeaf=0; iLeaf<nCommonLeaves; iLeaf++) {
    delete histo[iLeaf];
  }
  delete c;
}
