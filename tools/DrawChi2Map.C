#include <TFile.h>
#include <TTree.h>
#include <TH2.h>

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

  float massNeutralino1;
  float massStau1;

  tree->SetBranchAddress( xvarname.c_str(), &xvar);
  tree->SetBranchAddress( yvarname.c_str(), &yvar);
  tree->SetBranchAddress("haveAcceptedAtLeastOne", &haveAcceptedAtLeastOne);
  tree->SetBranchAddress("n",&nStep);
  tree->SetBranchAddress("chi2",&chi2);

  tree->SetBranchAddress("O_massNeutralino1_nofit", &massNeutralino1);
  tree->SetBranchAddress("O_massStau1_nofit", &massStau1);

  // get minimal chi2
  float minChi2 = 1e33;
  for (int i=0; i<nentries; i++) {
    tree->GetEntry(i);

    if (chi2<0.) continue;

    if (massStau1 < massNeutralino1) continue;

    if (chi2 < minChi2) {
      if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {                
	minChi2 = chi2;
      }
    }
  }

  std::cout << "Minimal chi2: " << minChi2 << std::endl;

  // open output file for the contours
  TFile* outfile = new TFile(outfilename, "RECREATE");

  float xmin =  1e10;
  float xmax = -1e10;
  float ymin =  1e10;
  float ymax = -1e10;

  for (int i=0; i<nentries; i++) {
    tree->GetEntry(i);

    if (chi2<0.) continue;

    if (massStau1 < massNeutralino1) continue;

    if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {

      double val = chi2 - minChi2;

      if (val < 6.01) {
	if (xvar < xmin) xmin = xvar;
	if (xvar > xmax) xmax = xvar;
	if (yvar < ymin) ymin = yvar;
	if (yvar > ymax) ymax = yvar;
      }

    }

  }

  //  std::cout << "Axis ranges: xmin = " << xmin << " xmax = " << xmax
  //	    << " ymin = " << ymin << " ymax = " << ymax << std::endl;

  int nbinsx = 100;
  int nbinsy = 100;

  TH2F* hist = new TH2F("hist", "",
			nbinsx, xmin, xmax,
			nbinsy, ymin, ymax);

  for (int i=0; i<nbinsx; i++) {
    for (int j=0; j<nbinsy; j++) {
      hist->SetBinContent(i+1, j+1, 1.1e10);
    }
  }

  for (int i=0; i<nentries; i++) {
    tree->GetEntry(i);
    
    if (chi2<0.) continue;

    if (massStau1 < massNeutralino1) continue;

    if (nStep > 0 && haveAcceptedAtLeastOne > 0.5) {

      float val = chi2 - minChi2;

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

      if (val < 6.01 && val < hist->GetBinContent(xbin, ybin)) {
	//	std::cout << "xar = " << xvar << " yvar = " << yvar
	//		  << " val = " << val << std::endl;
	hist->SetBinContent(xbin, ybin, val);
      }

    }

  }

  hist->SetMaximum(6.01);
  hist->Draw("cont1z");
  hist->Write();
  outfile->Close();
}
