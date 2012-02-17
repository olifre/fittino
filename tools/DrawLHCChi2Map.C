#include <TFile.h>
#include <TTree.h>
#include <TH2.h>
#include <TCanvas.h>

#include <string>
#include <iostream>

void DrawChi2Map(const char* infilename,
		 const char* outfilename,
		 std::string xvarname,
		 std::string yvarname,
		 int maxevents = -1)
{
  TFile* infile = new TFile(infilename);
  TTree* tree = (TTree*)infile->Get("markovChain");

  int nentries = tree->GetEntries();
  if ( maxevents >= 0 ) {
    if (nentries > maxevents) nentries = maxevents;
  }

  std::cout << "Number of tree entries: " << tree->GetEntries() << std::endl;
  std::cout << "Number of entries to be used: " << nentries << std::endl;

  float xvar;
  float yvar;
  float haveAcceptedAtLeastOne;
  float nStep;
  float chi2;
  float LHC_chi2;

  float massNeutralino1;
  float massStau1;

  tree->SetBranchAddress( xvarname.c_str(), &xvar);
  tree->SetBranchAddress( yvarname.c_str(), &yvar);
  tree->SetBranchAddress("haveAcceptedAtLeastOne", &haveAcceptedAtLeastOne);
  tree->SetBranchAddress("n",&nStep);
  tree->SetBranchAddress("chi2",&chi2);
  tree->SetBranchAddress("LHC_chi2", &LHC_chi2 );
  tree->SetBranchAddress("O_massNeutralino1_nofit", &massNeutralino1);
  tree->SetBranchAddress("O_massStau1_nofit", &massStau1);

  // get minimal chi2
  float minLHCChi2 = 1e33;
  std::cout << "getting minimal LHC_chi2 . . . " << std::endl;
  for (int i=0; i<nentries; i++) {
    tree->GetEntry(i);
    std::cout << "progress: " << float((i+1))/(float)nentries*100 << "%                \r";
    fflush(stdout);
    if (LHC_chi2<0.) continue;
    if( LHC_chi2 > 99. ) LHC_chi2 -= 100.;
    if (massStau1 < massNeutralino1) continue;

    if (LHC_chi2 < minLHCChi2) {
      if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {                
	      minLHCChi2 = LHC_chi2;
      }
    }
  }
    
  std::cout << std::endl << "Minimal LHC_chi2: " << minLHCChi2 << std::endl;

  // open output file for the contours
  TFile* outfile = new TFile(outfilename, "RECREATE");

  float xmin =  1e10;
  float xmax = -1e10;
  float ymin =  1e10;
  float ymax = -1e10;
  std::cout << "Getting Histogram Axis Range . . . " << std::endl;
  if( !strcmp(xvarname.c_str(), "P_M0") && !strcmp(yvarname.c_str(), "P_M12") ) {
    xmin = 0.;
    ymin = 50.;
    xmax = 2600.;
    ymax = 1250.;
  }
  else {
    for (int i=0; i<nentries; i++) {
      tree->GetEntry(i);
      std::cout << "progress: " << float((i+1))/(float)nentries*100 << "%                \r";
      fflush(stdout);
      if (LHC_chi2<0.) continue;
      if( LHC_chi2 > 99. ) LHC_chi2 -= 100.;

      if (massStau1 < massNeutralino1) continue;

      if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {

        double val = LHC_chi2 - minLHCChi2;

        if (val < 7.0) {
	        if (xvar < xmin) xmin = xvar;
	        if (xvar > xmax) xmax = xvar;
	        if (yvar < ymin) ymin = yvar;
	        if (yvar > ymax) ymax = yvar;
        }

      }

    }
  }
  std::cout << endl;
  //  std::cout << "Axis ranges: xmin = " << xmin << " xmax = " << xmax
  //	    << " ymin = " << ymin << " ymax = " << ymax << std::endl;

  int nbinsx = 100;
  int nbinsy = 100;

  TH2F* hist = new TH2F("hist", "",
			nbinsx, xmin, xmax,
			nbinsy, ymin, ymax);

  TH2F *hExcl = new TH2F( "excl", "excl", nbinsx, xmin, xmax, nbinsy, ymin, ymax );
  
  for (int i=0; i<nbinsx; i++) {
    for (int j=0; j<nbinsy; j++) {
      hist->SetBinContent(i+1, j+1, 1.1e10);
      hExcl->SetBinContent(i+1,j+1, -10.);
    }
  }
  std::cout << "Fill histogram with LHC_chi2 profile " << std::endl;
  for (int i=0; i<nentries; i++) {
    tree->GetEntry(i);
    std::cout << "progress: " << float((i+1))/(float)nentries*100 << "%                \r";
    fflush(stdout);
    if (LHC_chi2<0.) continue;
    if( LHC_chi2 > 99. ) LHC_chi2 -= 100.;

    if (massStau1 < massNeutralino1) continue;

    if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {

      double val = LHC_chi2 - minLHCChi2;

      int xbin = -1;
      int ybin = -1;

      for (int ibin=0; ibin<nbinsx; ibin++) {
	float xlow = hist->GetXaxis()->GetBinLowEdge(ibin+1);
	float xhigh = hist->GetXaxis()->GetBinUpEdge(ibin+1);

	if (xvar > xlow && xvar < xhigh) xbin = ibin + 1;

	for (int jbin=0; jbin<nbinsy; jbin++) {
	  float ylow = hist->GetYaxis()->GetBinLowEdge(jbin+1);
	  float yhigh = hist->GetYaxis()->GetBinUpEdge(jbin+1);

	  if (yvar > ylow && yvar < yhigh) ybin = jbin + 1;
	}
      }

      if (val < 7.0 && val < hist->GetBinContent(xbin, ybin)) {
	//	std::cout << "xar = " << xvar << " yvar = " << yvar
	//		  << " val = " << val << std::endl;
	hist->SetBinContent(xbin, ybin, val);
      }
      if( val < 5.99 ) {
        hExcl->SetBinContent(xbin,ybin, 5.);
      }

    }

  }
  std::cout << std::endl;
  TCanvas canvas("canvas","canvas");
  canvas.SetBorderMode(0);
  hist->SetMaximum(7.0);
  hist->Draw("cont1z");
  hExcl->Draw("cont2same");
  canvas.Print("LHC_chi2.pdf");
  canvas.Print("LHC_chi2.eps");
  canvas.Print("LHC_chi2.png");
  hist->Write();
  hExcl->Write();
  outfile->Close();
}
