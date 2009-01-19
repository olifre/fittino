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

Double_t chi2Function(Double_t *x, Double_t *par) {

    Double_t retval = 0;

    if ( TMath::Power(2, 0.5*par[1]) * TMath::Gamma(0.5*par[1]) ) {
      retval = (par[0]*(TMath::Power(x[0], 0.5*par[1] - 1) * TMath::Exp(-0.5*x[0]) /
			(TMath::Power(2, 0.5*par[1]) * TMath::Gamma(0.5*par[1]))));
    }

    return retval;
}

void DrawParDistsMulti(const char* filename1 = "file1",
                       const Int_t nbins1 = 50,
                       const char* filename2 = "file2",
                       const Int_t nbins2 = 50,
                       const char* filename3 = "file3",
                       const Int_t nbins3 = 50,
                       const char* treename = "tree",
		       const Double_t chi2cut = -1) {

   gStyle->SetOptStat(0);
   gStyle->SetOptFit(111111);

   // ----- open input files and make trees accessible -----

   //   const char* filename_arr[2];
   const char* filename_arr[3];
   filename_arr[0] = filename1;
   filename_arr[1] = filename2;
   filename_arr[2] = filename3;

   TFile** file = new TFile[3];
   //TFile** file = new TFile[2];
   TTree** tree = new TTree[3];
   //TTree** tree = new TTree[2];

   Int_t nEntries[3];
   //Int_t nEntries[2];

   //   for (unsigned int iFile=0; iFile<2; iFile++) {
   for (unsigned int iFile=0; iFile<3; iFile++) {

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

   Double_t* par   = new Double_t[nLeaves];
   Double_t* sum   = new Double_t[nLeaves];
   Double_t* sum2  = new Double_t[nLeaves];
   TH1F**    histo = new TH1F[3];
   //TH1F**    histo = new TH1F[2];
   TF1**     gauss = new TF1[3];
   //TF1**     gauss = new TF1[2];
   TF1**     chi2  = new TF1[3];
   //TF1**     chi2  = new TF1[2];
   Color_t   color[3] = {kRed, kGreen, kBlue};
   //Color_t   color[3] = {kRed, kBlue};
   Double_t  nbins[3] = {nbins1, nbins2, nbins3};
   //Double_t  nbins[2] = {nbins1, nbins2};

   // ----- loop over leaves in tree -----

   for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {

      TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 700, 700);
      c->SetBorderMode(0);
      c->SetTopMargin(0.05);
      c->SetBottomMargin(0.15);
      c->SetLeftMargin(0.15);
      c->SetRightMargin(0.05);

      //      for (unsigned int iFile=0; iFile<2; iFile++) {
      for (unsigned int iFile=0; iFile<3; iFile++) {

	 TLeafD* leaf = (TLeafD*)tree[iFile]->GetListOfLeaves()->At(iLeaf);
	//	 TLeafD* leaf = (TLeafD*)tree[iFile]->GetListOfLeaves()->FindObject("A0");
	 if ( ! (!strcmp(leaf->GetName(), "M0") || !strcmp(leaf->GetName(), "M12") ||
		 !strcmp(leaf->GetName(), "A0") || !strcmp(leaf->GetName(), "TanBeta")) ) continue;
	 leaf->SetAddress(&par[iLeaf]);

	 Double_t mintree = tree[1]->GetMinimum(leaf->GetName());
	 Double_t maxtree = tree[1]->GetMaximum(leaf->GetName());
	 Double_t min = mintree - 0.15 * (maxtree - mintree);
	 Double_t max = maxtree + 0.15 * (maxtree - mintree);

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
	    histo[iFile]->Fill(par[iLeaf]);
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

	 if ( iFile == 0 ) histo[iFile]->Draw("ep");
	 else histo[iFile]->Draw("epsame");

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
      legend->AddEntry(gauss[0],"  300 fb^{-1}", "L");
      legend->AddEntry(gauss[1],"   10 fb^{-1}", "L");
      legend->AddEntry(gauss[2],"    1 fb^{-1}", "L");
      legend->Draw();

      if ( ! (!strcmp(leaf->GetName(), "M0") || !strcmp(leaf->GetName(), "M12") ||
	      !strcmp(leaf->GetName(), "A0") || !strcmp(leaf->GetName(), "TanBeta")) ) continue;

      char epsfilename[256];
      sprintf(epsfilename, "%s.eps", leaf->GetName());
      c->Print(epsfilename);

   }

}
