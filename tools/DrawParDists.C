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


void DrawParDists(const Int_t nbins = 50, const char* filename = "TreeSum.root",
		  const char* treename = "tree")
{
    TFile* file = new TFile(filename, "read");
    TTree* tree = (TTree*)file->Get(treename);

    Int_t nEntries = tree->GetEntries();

    Int_t nLeaves = tree->GetListOfLeaves()->GetEntriesFast();

    Double_t* par   = new Double_t[nLeaves];
    Double_t* sum   = new Double_t[nLeaves];
    Double_t* sum2  = new Double_t[nLeaves];
    TH1F**    histo = new TH1F[nLeaves];
    TF1**     gauss = new TF1[nLeaves];
    TF1*      chi2  = 0;

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

	histo[iLeaf] = new TH1F(leaf->GetName(), leaf->GetTitle(), nbins, min, max);

	histo[iLeaf]->SetMarkerStyle(8);
	histo[iLeaf]->SetMarkerSize(1.2);
	histo[iLeaf]->SetOption("marker");
	if (!strcmp(leaf->GetName(), "TanBeta")) strcpy(xtitle, "tan #beta");
	else if (!strcmp(leaf->GetName(), "Mu")) strcpy(xtitle, "#mu (GeV)");
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
	else if (!strcmp(leaf->GetName(), "Chi2")) strcpy(xtitle, "#chi^{2}");
	else strcpy(xtitle, leaf->GetName());
	histo[iLeaf]->SetXTitle(xtitle);
	histo[iLeaf]->GetXaxis()->CenterTitle();
	histo[iLeaf]->GetXaxis()->SetTitleSize(0.05);
	histo[iLeaf]->GetXaxis()->SetTitleOffset(1.2);
	histo[iLeaf]->GetXaxis()->SetLabelSize(0.05);
	histo[iLeaf]->SetYTitle("Entries");
	histo[iLeaf]->GetYaxis()->SetLabelSize(0.05);
	histo[iLeaf]->GetYaxis()->CenterTitle();
	histo[iLeaf]->GetYaxis()->SetTitleSize(0.05);
	histo[iLeaf]->GetYaxis()->SetTitleOffset(1.3);

	gauss[iLeaf] = new TF1("gauss", "gaus", histo[iLeaf]->GetXaxis()->GetXmin(),
			       histo[iLeaf]->GetXaxis()->GetXmax());

	gauss[iLeaf]->SetLineColor(kRed);

	if (!strcmp(leaf->GetName(), "Chi2")) {
	    chi2 = new TF1("chi2", chi2Function,  histo[iLeaf]->GetXaxis()->GetXmin(),
			   histo[iLeaf]->GetXaxis()->GetXmax(), 2);

	    chi2->SetParNames("Norm", "ndof");
	    chi2->SetParameter(0, 0.1 * histo[iLeaf]->Integral());
	    chi2->SetParameter(1, 10);
	    chi2->SetLineColor(kRed);
	}
    }

    for (Int_t i=0; i<nEntries; i++) {
        tree->GetEntry(i);

	for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
            TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);

	    histo[iLeaf]->Fill(par[iLeaf]);

	    sum[iLeaf]  += par[iLeaf];
	    sum2[iLeaf] += par[iLeaf] * par[iLeaf];
	}

    }

    TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 700, 700);
    char epsfilename[256];

    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {

        TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);

	if (!strcmp(leaf->GetName(), "Chi2")) histo[iLeaf]->Fit(chi2, "r");
	else {
	    histo[iLeaf]->Fit(gauss[iLeaf], "r");
	    Double_t rms = TMath::Sqrt((sum2[iLeaf] - sum[iLeaf] * sum[iLeaf] 
                           / nEntries ) / nEntries);
	    Double_t sigma = gauss[iLeaf]->GetParameter(2);
	    printf("%s: (RMS - Sigma) / Sigma = %f\n", leaf->GetName(),
		   (rms - sigma) / sigma);
	}

	sprintf(epsfilename, "%s.eps", leaf->GetName());
	c->Print(epsfilename);

    }

    delete[] par;
    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
        delete histo[iLeaf];
    }
    delete c;
}
