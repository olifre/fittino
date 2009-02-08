void DrawParDistTest(const Int_t  nbins = 50, const char* filename = "PullDistributions.sum.root",
		     const char*  treename = "tree", const Double_t chi2cut = -1, const bool twoChi2Fit = false,
		     const bool   doFit = true,
		     const string logoPath = "" )
{
    gROOT->SetStyle("ATLAS");
    gROOT->ForceStyle();
    if (doFit) {
      gStyle->SetOptStat(0);
      gStyle->SetOptFit(111111);
    } else {
      gStyle->SetOptStat(1111);
      gStyle->SetOptFit(0);
    }


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

    TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 700, 700);
    c->SetBorderMode(0);
    c->SetTopMargin(0.05);
    c->SetBottomMargin(0.15);
    c->SetLeftMargin(0.15);
    c->SetRightMargin(0.05);

    thisHist = new TH1F("massA0", "m_{A}", nbins, 352.,374.);
    
    thisHist->SetMarkerStyle(8);
    thisHist->SetMarkerSize(1.2);
    thisHist->SetOption("marker");
    thisHist->SetXTitle("m_{A}");
    thisHist->GetXaxis()->CenterTitle();
    thisHist->GetXaxis()->SetTitleSize(0.05);
    thisHist->GetXaxis()->SetTitleOffset(1.2);
    thisHist->GetXaxis()->SetLabelSize(0.05);
    thisHist->SetYTitle("Toy fits");
    thisHist->GetYaxis()->SetLabelSize(0.05);
    thisHist->GetYaxis()->CenterTitle();
    thisHist->GetYaxis()->SetTitleSize(0.05);
    thisHist->GetYaxis()->SetTitleOffset(1.3);
  
    tree->Draw("massA0>>thisHist");
    thisHist->Print();
    thisHist->Draw();
    return;

    gauss = new TF1("gauss", "gaus", 352., 374.);
    gauss->SetLineColor(kRed);
    thisHist->Fit(gauss, "rem");
     



}
