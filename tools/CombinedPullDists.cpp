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


void CombinedPullDists (const Int_t nbins = 50, 
			const char* filename1 = "PullDistributions1.sum.root",
			const char* filename2 = "PullDistributions2.sum.root",
			const char* tag1      = "correct model",
			const char* tag2      = "wrong model",
			const char* treename1 = "tree", 
			const char* treename2 = "tree", 
			const Double_t chi2cut = -1)
{
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

  if (nLeaves1!=nLeaves2) {
    cout << "number of leaves in the two files not identical." << endl;
    return;
  }

  Int_t iChi2Leaf1 = -1; // leaf index of chi2 leaf
  Int_t iChi2Leaf2 = -1; // leaf index of chi2 leaf
  Int_t iRandSeed1 = -1; // leaf index of randSeed leaf
  Int_t iRandSeed2 = -1; // leaf index of randSeed leaf
  Int_t iToy1 = -1; // leaf index of nToy leaf
  Int_t iToy2 = -1; // leaf index of nToy leaf

  Double_t* par1  = new Double_t[nLeaves1];
  Double_t* par2  = new Double_t[nLeaves1];
  Double_t* sum   = new Double_t[nLeaves1];
  Double_t* sum2  = new Double_t[nLeaves1];
  TH2D**    histo = new TH2D[nLeaves1];
  //   TF1**     gauss = new TF1[nLeaves];
  //    TF1*      chi2  = 0;

  Char_t xtitle[256];
  Char_t ytitle[256];

  int nPoints = 0;
  int nInverted = 0;

  for (Int_t iLeaf=0; iLeaf<nLeaves1; iLeaf++) {
    TLeafD* leaf1 = (TLeafD*)tree1->GetListOfLeaves()->At(iLeaf);
    TLeafD* leaf2 = (TLeafD*)tree2->GetListOfLeaves()->At(iLeaf);
    leaf1->SetAddress(&par1[iLeaf]);
    leaf2->SetAddress(&par2[iLeaf]);
      
    sum[iLeaf]  = 0;
    sum2[iLeaf] = 0;
      
    if (strcmp(leaf1->GetName(),leaf2->GetName())) {
      cout << "order of the leaves in the two ntuples is not identical." << endl;
      return;
    }
      
    Double_t mintree = tree1->GetMinimum(leaf1->GetName());
    Double_t maxtree = tree1->GetMaximum(leaf1->GetName());
    if (tree2->GetMinimum(leaf2->GetName())<mintree) {
      mintree = tree2->GetMinimum(leaf2->GetName());
    }
    if (tree2->GetMaximum(leaf2->GetName())>maxtree) {
      maxtree = tree2->GetMaximum(leaf2->GetName());
    }
    Double_t min = mintree - 0.15 * (maxtree - mintree);
    Double_t max = maxtree + 0.15 * (maxtree - mintree);
      
    histo[iLeaf] = new TH2D(leaf1->GetName(), "" /*leaf->GetTitle()*/, nbins, min, max, nbins, min, max );
      
    histo[iLeaf]->SetMarkerStyle(8);
    histo[iLeaf]->SetMarkerSize(1.2);
    histo[iLeaf]->SetOption("marker");
    //histo[iLeaf]->SetStats(kFALSE); // disable fit statistics display
    if (!strcmp(leaf1->GetName(), "TanBeta")) strcpy(xtitle, "tan #beta");
    else if (!strcmp(leaf1->GetName(), "Mu")) strcpy(xtitle, "#mu (GeV)");
    else if (!strcmp(leaf1->GetName(), "MuEff")) strcpy(xtitle, "#mu_{eff} (GeV)");
    else if (!strcmp(leaf1->GetName(), "Xtau")) strcpy(xtitle, "X_{#tau} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MSelectronR")) strcpy(xtitle, "M_{#tilde{e}_{R}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MStauR")) strcpy(xtitle, "M_{#tilde{#tau}_{R}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MSelectronL")) strcpy(xtitle, "M_{#tilde{e}_{L}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MStauL")) strcpy(xtitle, "M_{#tilde{#tau}_{L}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "Xtop")) strcpy(xtitle, "X_{t} (GeV)");
    else if (!strcmp(leaf1->GetName(), "Xbottom")) strcpy(xtitle, "X_{b} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MSdownR")) strcpy(xtitle, "M_{#tilde{d}_{R}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MSbottomR")) strcpy(xtitle, "M_{#tilde{b}_{R}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MSupR")) strcpy(xtitle, "M_{#tilde{u}_{R}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MStopR")) strcpy(xtitle, "M_{#tilde{t}_{R}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MSupL")) strcpy(xtitle, "M_{#tilde{u}_{L}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "MStopL")) strcpy(xtitle, "M_{#tilde{t}_{L}} (GeV)");
    else if (!strcmp(leaf1->GetName(), "M1")) strcpy(xtitle, "M_{1} (GeV)");
    else if (!strcmp(leaf1->GetName(), "M2")) strcpy(xtitle, "M_{2} (GeV)");
    else if (!strcmp(leaf1->GetName(), "M3")) strcpy(xtitle, "M_{3} (GeV)");
    else if (!strcmp(leaf1->GetName(), "massA0")) strcpy(xtitle, "m_{A} (GeV)");
    else if (!strcmp(leaf1->GetName(), "massTop")) strcpy(xtitle, "m_{t} (GeV)");
    else if (!strcmp(leaf1->GetName(), "lambda")) strcpy(xtitle, "#lambda");
    else if (!strcmp(leaf1->GetName(), "kappa")) strcpy(xtitle, "#kappa");
    else if (!strcmp(leaf1->GetName(), "ALambda")) strcpy(xtitle, "A_{#lambda} (GeV)");
    else if (!strcmp(leaf1->GetName(), "AKappa")) strcpy(xtitle, "A_{#kappa} (GeV)");
    else if (!strcmp(leaf1->GetName(), "Chi2")) strcpy(xtitle, "#chi^{2}");
    else if (!strcmp(leaf1->GetName(), "M0")) strcpy(xtitle, "M_{0} (GeV)");
    else if (!strcmp(leaf1->GetName(), "M12")) strcpy(xtitle, "M_{1/2} (GeV)");
    else if (!strcmp(leaf1->GetName(), "A0")) strcpy(xtitle, "A_{0} (GeV)");
    else strcpy(xtitle, leaf1->GetName());
    sprintf(xtitle,"%s (%s)",xtitle,tag1);
    if (!strcmp(leaf2->GetName(), "TanBeta")) strcpy(ytitle, "tan #beta");
    else if (!strcmp(leaf2->GetName(), "Mu")) strcpy(ytitle, "#mu (GeV)");
    else if (!strcmp(leaf2->GetName(), "MuEff")) strcpy(ytitle, "#mu_{eff} (GeV)");
    else if (!strcmp(leaf2->GetName(), "Xtau")) strcpy(ytitle, "X_{#tau} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MSelectronR")) strcpy(ytitle, "M_{#tilde{e}_{R}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MStauR")) strcpy(ytitle, "M_{#tilde{#tau}_{R}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MSelectronL")) strcpy(ytitle, "M_{#tilde{e}_{L}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MStauL")) strcpy(ytitle, "M_{#tilde{#tau}_{L}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "Xtop")) strcpy(ytitle, "X_{t} (GeV)");
    else if (!strcmp(leaf2->GetName(), "Xbottom")) strcpy(ytitle, "X_{b} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MSdownR")) strcpy(ytitle, "M_{#tilde{d}_{R}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MSbottomR")) strcpy(ytitle, "M_{#tilde{b}_{R}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MSupR")) strcpy(ytitle, "M_{#tilde{u}_{R}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MStopR")) strcpy(ytitle, "M_{#tilde{t}_{R}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MSupL")) strcpy(ytitle, "M_{#tilde{u}_{L}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "MStopL")) strcpy(ytitle, "M_{#tilde{t}_{L}} (GeV)");
    else if (!strcmp(leaf2->GetName(), "M1")) strcpy(ytitle, "M_{1} (GeV)");
    else if (!strcmp(leaf2->GetName(), "M2")) strcpy(ytitle, "M_{2} (GeV)");
    else if (!strcmp(leaf2->GetName(), "M3")) strcpy(ytitle, "M_{3} (GeV)");
    else if (!strcmp(leaf2->GetName(), "massA0")) strcpy(ytitle, "m_{A} (GeV)");
    else if (!strcmp(leaf2->GetName(), "massTop")) strcpy(ytitle, "m_{t} (GeV)");
    else if (!strcmp(leaf2->GetName(), "lambda")) strcpy(ytitle, "#lambda");
    else if (!strcmp(leaf2->GetName(), "kappa")) strcpy(ytitle, "#kappa");
    else if (!strcmp(leaf2->GetName(), "ALambda")) strcpy(ytitle, "A_{#lambda} (GeV)");
    else if (!strcmp(leaf2->GetName(), "AKappa")) strcpy(ytitle, "A_{#kappa} (GeV)");
    else if (!strcmp(leaf2->GetName(), "Chi2")) strcpy(ytitle, "#chi^{2}");
    else if (!strcmp(leaf2->GetName(), "M0")) strcpy(ytitle, "M_{0} (GeV)");
    else if (!strcmp(leaf2->GetName(), "M12")) strcpy(ytitle, "M_{1/2} (GeV)");
    else if (!strcmp(leaf2->GetName(), "A0")) strcpy(ytitle, "A_{0} (GeV)");
    else strcpy(ytitle, leaf2->GetName());
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

    if (!strcmp(leaf1->GetName(), "Chi2")) {
      iChi2Leaf1 = iLeaf;
    }
    if (!strcmp(leaf2->GetName(), "Chi2")) {
      iChi2Leaf2 = iLeaf;
    }
    if (!strcmp(leaf1->GetName(), "randSeed")) {
      iRandSeed1 = iLeaf;
    }
    if (!strcmp(leaf2->GetName(), "randSeed")) {
      iRandSeed2 = iLeaf;
    }
    if (!strcmp(leaf1->GetName(), "nToy")) {
      iToy1 = iLeaf;
    }
    if (!strcmp(leaf2->GetName(), "nToy")) {
      iToy2 = iLeaf;
    }
  }

  if (!(chi2cut < 0) && iChi2Leaf1 < 0) {
    printf("Cannot apply chi2 cut because tree1 does not contain Chi2 leaf\n");
    return;
  }
  if (!(chi2cut < 0) && iChi2Leaf2 < 0) {
    printf("Cannot apply chi2 cut because tree2 does not contain Chi2 leaf\n");
    return;
  }

  for (Int_t i1=0; i1<nEntries1; i1++) {
    tree1->GetEntry(i1);
    // check nToy
    if (par1[iToy1]>1) {
      continue;
    }
    // find corresponding entry in the other tree
    for (Int_t i2=0; i2<nEntries2; i2++) {
      tree2->GetEntry(i2);
      // check nToy
      if (par2[iToy2]>1) {
	continue;
      }
	
      if (par1[iRandSeed1]==par2[iRandSeed2]) {

	Double_t chi2val1 = -1; 
	Double_t chi2val2 = -1; 
	if (!(iChi2Leaf1 < 0)) {
	  chi2val1 = par1[iChi2Leaf1];
	}
	if (!(iChi2Leaf2 < 0)) {
	  chi2val2 = par1[iChi2Leaf2];
	}

	if ( chi2val1<0. || chi2val2<0. ) {
	  continue;
	}

	nPoints++;
	  
	if (chi2val2<chi2val1) {
	  nInverted++;
	}
	  
	for (Int_t iLeaf=0; iLeaf<nLeaves1; iLeaf++) {
	  TLeafD* leaf1 = (TLeafD*)tree1->GetListOfLeaves()->At(iLeaf);
	  TLeafD* leaf2 = (TLeafD*)tree2->GetListOfLeaves()->At(iLeaf);
	    
	  if (chi2cut < 0 || ( !(chi2cut < 0) && chi2val < chi2cut ) ) {
	    histo[iLeaf]->Fill(par1[iLeaf],par2[iLeaf]);
	      
	    sum[iLeaf]  += par1[iLeaf];
	    sum2[iLeaf] += par1[iLeaf] * par1[iLeaf];
	  }
	}
      }
    }
  }

  TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 700, 700);
  c->SetBorderMode(0);
  c->SetTopMargin(0.05);
  c->SetBottomMargin(0.15);
  c->SetLeftMargin(0.15);
  c->SetRightMargin(0.05);
    
  char epsfilename[256];

  for (Int_t iLeaf=0; iLeaf<nLeaves1; iLeaf++) {

    TLeafD* leaf  = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
    TGraph* line = new TGraph(2);
    line->SetPoint(0,0.,0.);
    line->SetPoint(0,100.,100.);

    histo[iLeaf]->Draw("box");
    line->Draw("same");
 
    sprintf(epsfilename, "%s.eps", leaf->GetName());
    c->Print(epsfilename);

  }

  double wrongEff      = (double)nInverted/(double)nPoints;
  double deltaWrongEff = sqrt(wrongEff*(1-wrongEff)/nPoints);

  cout << "probability to prefer model 2 over model 1 = " << wrongEff << " +- " << deltaWrongEff << endl;

  delete[] par1;
  delete[] par2;
  for (Int_t iLeaf=0; iLeaf<nLeaves1; iLeaf++) {
    delete histo[iLeaf];
  }
  delete c;
}
