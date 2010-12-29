/***************************************************************************
                               DrawParDists.C
                             -------------------
    This ROOT macro draws the distribution of parameters
    found in a ROOT tree such as that contained in the
    PullDistributions.root file produced by Fittino if
    pull distributions are calculated. It fits Gaussians
    to these distributions. If the tree contains a leaf
    called "Chi2" a chi2 distribution will be fitted instead
    of the Gaussian.
                             -------------------
    $Id: DrawParDists.C 410 2009-03-19 13:19:44Z bechtle $
    $Name$
                             -------------------
    begin                : August 19, 2005
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
#include "TROOT.h"
#include "TFile.h"
#include "TDirectory.h"
#include "TChain.h"
#include "TCanvas.h"
#include "TH1D.h"
#include "TF1.h"
#include "TImage.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TList.h"
#include "TLeafD.h"
#include "TLine.h"
#include "TMath.h"
#include "TObjArray.h"
#include "iostream"
#include "fstream"
#include "string"
#include "vector"
using namespace std;

Double_t chi2Function(Double_t *x, Double_t *par)
{
    Double_t retval = 0;

    if ( TMath::Power(2, 0.5*par[1]) * TMath::Gamma(0.5*par[1]) ) {
      retval = (par[0]*(TMath::Power(x[0], 0.5*par[1] - 1) * TMath::Exp(-0.5*x[0]) /
			(TMath::Power(2, 0.5*par[1]) * TMath::Gamma(0.5*par[1]))));
    }

    return retval;
}

Double_t chi2Function2(Double_t *x, Double_t *par)
{
    Double_t retval = 0;

    if ( TMath::Power(2, 0.5*par[1]) * TMath::Gamma(0.5*par[1]) ) {
      retval = (par[0]*(TMath::Power(x[0], 0.5*par[1] - 1) * TMath::Exp(-0.5*x[0]) /
			(TMath::Power(2, 0.5*par[1]) * TMath::Gamma(0.5*par[1]))));
    }

    if ( TMath::Power(2, 0.5*par[3]) * TMath::Gamma(0.5*par[3]) ) {
      retval += (par[2]*(TMath::Power(x[0], 0.5*par[3] - 1) * TMath::Exp(-0.5*x[0]) /
			(TMath::Power(2, 0.5*par[3]) * TMath::Gamma(0.5*par[3]))));
    }

    return retval;
}


void DrawObsDists(const char* filename = "PullDistributions.sum.root",
		  const char*  treename = "markovChain", 
		  const Double_t chi2PlotCut = -1, 
		  const Double_t chi2BugCut  = -1 )
{
    gROOT->SetStyle("ATLAS");
    gROOT->ForceStyle();
    gStyle->SetOptStat(1111);
    gStyle->SetOptFit(0);



    TFile* file = new TFile(filename, "read");

    if ( !file ) {
        printf("Problem accessing file %s\n", filename);
	return;
    }

    TTree* tree = (TTree*)file->Get(treename);

    if ( !tree ) {
        printf("Problem accessing tree %s\n", treename);
        return;
    }

    TCanvas* c = new TCanvas();
    c->SetLogy();

    Int_t nEntries = tree->GetEntries();

    Int_t nLeaves = tree->GetListOfLeaves()->GetEntries();

    //Int_t iChi2Leaf = -1; // leaf index of chi2 leaf

    Double_t* obs   = new Double_t[nLeaves];
    //    TH1F*    histo[nLeaves];
    //TF1*     gauss[nLeaves];
    //TF1*      chi2  = 0;

    // open text file
    fstream pullFitsFile;
    pullFitsFile.open ("ObsMeanDist.txt",ofstream::out);


    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
      TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
      leaf->SetAddress(&obs[iLeaf]);
      
      char cut1[256];
      sprintf(cut1,"chi2<%f",chi2PlotCut);
      char cut2[256];
      sprintf(cut2,"chi2<%f",chi2BugCut);
      //tree->Draw(leaf->GetName(),cut2);
      tree->Draw(leaf->GetName(),cut1);
      tree->Draw(leaf->GetName(),cut2,"same");
      

      char epsfilename[256];
      sprintf(epsfilename, "%s.eps", leaf->GetName());
      c->Print(epsfilename);
      
    }
    
    delete c;

    pullFitsFile.close();
    
}
