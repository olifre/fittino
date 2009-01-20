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
    $Id$
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


void DrawParDists(const Int_t nbins = 50, const char* filename = "PullDistributions.sum.root",
		  const char* treename = "tree", const Double_t chi2cut = -1, const bool twoChi2Fit = false)
{
    gStyle->SetOptStat(0);
    gStyle->SetOptFit(111111);

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

    Int_t nEntries = tree->GetEntries();

    Int_t nLeaves = tree->GetListOfLeaves()->GetEntriesFast();

    Int_t iChi2Leaf = -1; // leaf index of chi2 leaf

    Double_t* par   = new Double_t[nLeaves];
    Double_t* sum   = new Double_t[nLeaves];
    Double_t* sum2  = new Double_t[nLeaves];
    TH1F**    histo = new TH1F[nLeaves];
    TF1**     gauss = new TF1[nLeaves];
    TF1*      chi2  = 0;

    // open text file
    fstream pullFitsFile;
    pullFitsFile.open ("pullFitsResults.txt",ofstream::out);


    Char_t xtitle[256];

    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
        TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
        leaf->SetAddress(&par[iLeaf]);

	sum[iLeaf]  = 0;
	sum2[iLeaf] = 0;

	Double_t mintree = tree->GetMinimum(leaf->GetName());
	Double_t maxtree = tree->GetMaximum(leaf->GetName());
	Double_t min = mintree - 0.15 * (maxtree - mintree);
	Double_t max = maxtree + 0.15 * (maxtree - mintree);

	histo[iLeaf] = new TH1F(leaf->GetName(), "" /*leaf->GetTitle()*/, nbins, min, max);

	histo[iLeaf]->SetMarkerStyle(8);
	histo[iLeaf]->SetMarkerSize(1.2);
	histo[iLeaf]->SetOption("marker");
	//histo[iLeaf]->SetStats(kFALSE); // disable fit statistics display
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
	else strcpy(xtitle, leaf->GetName());
	histo[iLeaf]->SetXTitle(xtitle);
	histo[iLeaf]->GetXaxis()->CenterTitle();
	histo[iLeaf]->GetXaxis()->SetTitleSize(0.05);
	histo[iLeaf]->GetXaxis()->SetTitleOffset(1.2);
	histo[iLeaf]->GetXaxis()->SetLabelSize(0.05);
	//	histo[iLeaf]->SetYTitle("Eintr#ddot{a}ge");
	histo[iLeaf]->SetYTitle("Toy fits");
	histo[iLeaf]->GetYaxis()->SetLabelSize(0.05);
	histo[iLeaf]->GetYaxis()->CenterTitle();
	histo[iLeaf]->GetYaxis()->SetTitleSize(0.05);
	histo[iLeaf]->GetYaxis()->SetTitleOffset(1.3);

	gauss[iLeaf] = new TF1("gauss", "gaus", histo[iLeaf]->GetXaxis()->GetXmin(),
			       histo[iLeaf]->GetXaxis()->GetXmax());

	gauss[iLeaf]->SetLineColor(kRed);

	if (!strcmp(leaf->GetName(), "Chi2")) {
	  if (!twoChi2Fit) {
	    chi2 = new TF1("chi2", chi2Function,
			   TMath::Max( histo[iLeaf]->GetXaxis()->GetXmin(), 0.0),
			   histo[iLeaf]->GetXaxis()->GetXmax(), 2);
	    
	    chi2->SetParNames("norm", "ndf");
	    chi2->SetParameter(0, 0.1 * histo[iLeaf]->Integral());
	    chi2->SetParameter(1, 10);
	  } else {
	    chi2 = new TF1("chi2", chi2Function2,
			   TMath::Max( histo[iLeaf]->GetXaxis()->GetXmin(), 0.0),
			   histo[iLeaf]->GetXaxis()->GetXmax(), 4);
	    
	    chi2->SetParNames("norm1", "ndf1", "norm2", "ndf2" );
	    chi2->SetParameter(0, 0.1 * histo[iLeaf]->Integral());
	    chi2->SetParameter(1, 30);	    
	    chi2->SetParameter(0, 0.01 * histo[iLeaf]->Integral());
	    chi2->SetParameter(1, 60);	    
	  }
	  
	  chi2->SetLineColor(kRed);
	  
	  iChi2Leaf = iLeaf;
	}
    }
    
    if (!(chi2cut < 0) && iChi2Leaf < 0) {
        printf("Cannot apply chi2 cut because tree does not contain Chi2 leaf\n");
	return;
    }

    for (Int_t i=0; i<nEntries; i++) {
        tree->GetEntry(i);

	Double_t chi2val = -1; 
	if (!(iChi2Leaf < 0)) {
	    chi2val = par[iChi2Leaf];
	}

	for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
            TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);

	    if (chi2cut < 0 || ( !(chi2cut < 0) && chi2val < chi2cut ) ) {
	        histo[iLeaf]->Fill(par[iLeaf]);

		sum[iLeaf]  += par[iLeaf];
		sum2[iLeaf] += par[iLeaf] * par[iLeaf];
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

    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
      
      TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
      
      if (!strcmp(leaf->GetName(), "Chi2")) {
	histo[iLeaf]->Fit(chi2, "rem");
	histo[iLeaf]->Draw("ep");
	if (twoChi2Fit) {
	  const double norm1 = chi2->GetParameter(0);
	  const double norm2 = chi2->GetParameter(2);
	  const double ndf1  = chi2->GetParameter(1);
	  const double ndf2  = chi2->GetParameter(3);
	  cout << norm1 << norm2 << ndf1 << ndf2 << endl;
	  TF1* chi2draw1 = new TF1("chi2draw1", chi2Function,
				   TMath::Max( histo[iLeaf]->GetXaxis()->GetXmin(), 0.0),
				   histo[iLeaf]->GetXaxis()->GetXmax(), 2);
	  chi2draw1->SetParNames("norm1", "ndf1");
	  chi2draw1->SetParameter(0, norm1);
	  chi2draw1->SetParameter(1, ndf1);
	  chi2draw1->SetLineColor(kRed);
	  chi2draw1->SetLineStyle(2);
	  chi2draw1->SetLineWidth(1);
	  chi2draw1->Draw("same");
	  TF1* chi2draw2 = new TF1("chi2draw2", chi2Function,
				   TMath::Max( histo[iLeaf]->GetXaxis()->GetXmin(), 0.0),
				   histo[iLeaf]->GetXaxis()->GetXmax(), 2);
	  chi2draw2->SetParNames("norm2", "ndf2");
	  chi2draw2->SetParameter(0, norm2);
	  chi2draw2->SetParameter(1, ndf2);
	  chi2draw2->SetLineColor(kBlue);
	  chi2draw2->SetLineStyle(2);
	  chi2draw2->SetLineWidth(1);
	  chi2draw2->Draw("same");
	}
      }
      else {
	if (strcmp(leaf->GetName(), "Kppinn_npf")) {
	  histo[iLeaf]->Fit(gauss[iLeaf], "rem");
	  histo[iLeaf]->Draw("ep");
	  Double_t mean = sum[iLeaf] / nEntries;
	  Double_t mu = gauss[iLeaf]->GetParameter(1);
	  Double_t rms = TMath::Sqrt((sum2[iLeaf] - sum[iLeaf] * sum[iLeaf]
				      / nEntries ) / nEntries);
	  Double_t sigma = gauss[iLeaf]->GetParameter(2);
	  double rmsSigmaRatio = 100000.;
	  if (sigma>0.) rmsSigmaRatio = (rms - sigma) / sigma;
	  printf("mean = %f             mu    = %f\n", mean, mu);
	  printf("RMS  = %f             sigma = %f\n", rms, sigma);
	  printf("%s: (RMS - Sigma) / Sigma = %f\n", leaf->GetName(),
		 rmsSigmaRatio);
	  // write ot the fit result to a file
	  pullFitsFile << leaf->GetName() << " = " << mu << " +- " << sigma << " (Mean+-Var: " << mean << "+-" << rms << ") deviation from gaussian: " << rmsSigmaRatio << endl;
	}
      }
      
      sprintf(epsfilename, "%s.eps", leaf->GetName());
      c->Print(epsfilename);
      
    }
    
    delete[] par;
    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
       delete histo[iLeaf];
    }
    delete c;

    pullFitsFile.close();
    
}
