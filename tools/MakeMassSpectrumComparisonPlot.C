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
#include <string>
#include <vector>
#include <map>
using namespace std;

void MakeMassSpectrumComparisonPlot (const char* filename1 = "PullDistributions.sum.root",
				     const char* filename2 = "PullDistributions.sum.root",
				     const char* filename3 = "PullDistributions.sum.root",
				     const char* filename4 = "PullDistributions.sum.root",
				     const char* filename5 = "PullDistributions.sum.root",
				     const double minHist = 0.,
				     const double maxHist = 100000000.,
				     const int nbins = 1000,
				     const int minEvents = 5,
				     const char* treename = "tree",
				     const string tag = "",
				     const string predicted = "Derived",
				     const string logoPath = "./logo/fittinologo.eps" ) {


  // set style
  gStyle->SetPalette(1);
  gStyle->SetOptStat(0);
  gStyle->SetFrameFillColor(10);
  gStyle->SetPadColor(10);
  gStyle->SetCanvasColor(10); // light grey: 18
  TCanvas* canvas = new TCanvas();
  canvas->SetBorderMode(0);
  canvas->SetTopMargin(0.08);
  canvas->SetBottomMargin(0.12);
  canvas->SetLeftMargin(0.15);
  canvas->SetRightMargin(0.05);
  // get the fittino logo
  TImage *fittinoLogo = TImage::Open(logoPath.c_str());
  if (!fittinoLogo) {
    printf("Could not open the fittino logo at %s\n exit\n",logoPath.c_str());
    return;
  }
  fittinoLogo->SetConstRatio(1);
  fittinoLogo->SetImageQuality(TAttImage::kImgBest);


  TH1D*  h0histo[5];
  
  // and finally really start...
  for (int iFile = 0; iFile<5; iFile++) {

    string filename;
    if (iFile==0) filename = filename1;
    else if (iFile==1) filename = filename2;
    else if (iFile==2) filename = filename3;
    else if (iFile==3) filename = filename4;
    else if (iFile==4) filename = filename5;

    TFile* file = new TFile(filename.c_str(), "read");
    if ( !file ) {
      printf("Problem accessing file %s\n", filename.c_str());
      return;
    }
    
    TTree* tree = (TTree*)file->Get(treename);
    if ( !tree ) {
      printf("Problem accessing tree %s\n", treename);
      return;
    }
    
    int nEntries = tree->GetEntries();
    int nLeaves = tree->GetListOfLeaves()->GetEntriesFast();
    double* par   = new Double_t[nLeaves];
    
    vector<string> name;
    vector<string> binName;

    name.push_back ("h0");
    name.push_back ("A0");
    name.push_back ("H0");
    name.push_back ("Hplus");

    name.push_back ("Neutralino1");
    name.push_back ("Neutralino2");
    name.push_back ("Neutralino3");
    name.push_back ("Neutralino4");
      
    name.push_back ("Chargino1");
    name.push_back ("Chargino2");
      
    name.push_back ("SelectronR");
    name.push_back ("SelectronL");
    //  name.push_back ("SmuL");
    //  name.push_back ("SmuR");
    name.push_back ("Stau1");
    name.push_back ("Stau2");
      
    //  name.push_back ("SdownL");
    //  name.push_back ("SdownR");
    name.push_back ("SupR");
    name.push_back ("SupL");
    //  name.push_back ("SstrangeL");
    //  name.push_back ("SstrangeR");
    //  name.push_back ("ScharmL");
    //  name.push_back ("ScharmR");
    name.push_back ("Sbottom1");
    name.push_back ("Sbottom2");
    name.push_back ("Stop1");
    name.push_back ("Stop2");
      
    name.push_back ("Gluino");
      
    binName.push_back ("h^{0}");
    binName.push_back ("A^{0}");
    binName.push_back ("H^{0}");
    binName.push_back ("H^{+}");
    binName.push_back ("#chi^{0}_{1}");
    binName.push_back ("#chi^{0}_{2}");
    binName.push_back ("#chi^{0}_{3}");
    binName.push_back ("#chi^{0}_{4}");
    binName.push_back ("#chi^{+}_{1}");
    binName.push_back ("#chi^{+}_{2}");
    binName.push_back ("#tilde{l}_{R}");
    binName.push_back ("#tilde{l}_{L}");
    binName.push_back ("#tilde{#tau}_{1}");
    binName.push_back ("#tilde{#tau}_{2}");
    binName.push_back ("#tilde{q}_{R}");
    binName.push_back ("#tilde{q}_{L}");
    binName.push_back ("#tilde{b}_{1}");
    binName.push_back ("#tilde{b}_{2}");
    binName.push_back ("#tilde{t}_{1}");
    binName.push_back ("#tilde{t}_{2}");
    binName.push_back ("#tilde{g}");
      
    const int nameSize = name.size();
      
    bool nofitFound[nameSize];
    bool alreadyFound[nameSize];
    int leafPosition[nameSize];
    double meanValues[nameSize];
    for (int i = 0; i < nameSize; i++) {
      nofitFound[i] = false;
      alreadyFound[i] = false;
      leafPosition[i] = 0;
    }
    double mintree = 1000000.;
    double maxtree = -1000000.;
      

    // find the correct leaves and figure out maximum and minimum of the histograms
    for (int iname = 0; iname < nameSize; iname++) {
      for (int iLeaf = 0; iLeaf < nLeaves; iLeaf++) {
	const TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
	//      leaf->SetAddress(&par[iLeaf]);
	if (!strncmp("mass",leaf->GetName(),4)) {
	  char fullParticleName[256];
	  strcpy(fullParticleName,leaf->GetName());
	  char* particleName = &fullParticleName[4];
	  int particleNameLength = strcspn(particleName,"_");
	  int totalParticleNameLength = strcspn(particleName,"\0");
	  particleName[particleNameLength] = '\0';
	  if (!strncmp(name[iname].c_str(),particleName,name[iname].size())) {
	    const double thisMin = tree->GetMinimum(leaf->GetName());
	    const double thisMax = tree->GetMaximum(leaf->GetName());
	    // cout << "leaf name = " << particleName  << " " << leaf->GetName() << " " << particleNameLength << " " << name[iname].c_str() << " " << name[iname].size() <<   endl;
	    if (alreadyFound[iname]==true) {
	      if (nofitFound[iname]==true) {
		continue;
	      } else {
		if (particleNameLength > 0) {
		  nofitFound[iname] = true;
		  leafPosition[iname] = iLeaf;
		} else {
		  continue;
		}
	      }
	    } else {
	      alreadyFound[iname] = true;
	      leafPosition[iname] = iLeaf;
	      if (particleNameLength < totalParticleNameLength) {
		nofitFound[iname] = true;
	      } else {
		nofitFound[iname] = false;
	      }
	    }
	    cout << "found " << name[iname] << " " << leaf->GetName() << " " << thisMin << " " << thisMax << endl;
	    if (thisMin<mintree) mintree = thisMin;
	    if (thisMax>maxtree) maxtree = thisMax;
	  }
	}
      }
    }

    double min = mintree - 0.1 * (maxtree - mintree);
    double max = maxtree + 0.1 * (maxtree - mintree);
    if (min < minHist) min = minHist;
    if (max > maxHist) max = maxHist;
      
    TH2D* massHistBeforeCleanup = new TH2D("massHistBeforeCleanup","Mass Spectrum of SUSY Particles",
					   nameSize,
					   0.,(double)nameSize,
					   nbins,
					   min,max);
    TH1D*  histo[nameSize];
    TH1D*  histoSmoothed[nameSize];
    // now loop over the leaves again and get the histograms
    cout << "now loop over the leaves again and get the histograms" << endl;
    for (int iname = 0; iname < nameSize; iname++) {
      if (alreadyFound[iname]) {
	TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(leafPosition[iname]);
	leaf->SetAddress(&par[leafPosition[iname]]);
	cout << "looping over events of " << name[iname] << endl;
	string histoName = name[iname]+"RawHisto";
	histo[iname] = new TH1D(histoName.c_str(), "", nbins, min, max);
	if (name[iname]=="h0") {
	  char iNumber[256];
	  sprintf(iNumber,"%i",iFile);
	  string h0histoName = name[iname]+"RawHisto"+iNumber;
	  h0histo[iFile] = new TH1D(h0histoName.c_str(), "", nbins, min, max);
	}
	for (Int_t i=0; i<nEntries; i++) {
	  tree->GetEntry(i);
	  double mass = 0.;
	  if (par[leafPosition[iname]]>0) mass = par[leafPosition[iname]];
	  else mass = -par[leafPosition[iname]];
	  massHistBeforeCleanup->Fill((double)iname,mass);
	  histo[iname]->Fill(mass);
	  if (name[iname]=="h0") {
	    h0histo[iFile]->Fill(mass);
	  }
	}
      }
    }
  }

  Color_t   color[5] = {46,38,41,42,43};
  for (int iFile = 0; iFile<5; iFile++) {
    h0histo[iFile]->SetMarkerStyle(8);
    h0histo[iFile]->SetMarkerSize(1.2);
    h0histo[iFile]->SetMarkerColor(color[iFile]);
    h0histo[iFile]->SetLineColor(color[iFile]);
    h0histo[iFile]->SetOption("marker");
    h0histo[iFile]->SetStats(kFALSE); // disable fit statistics display
    h0histo[iFile]->SetXTitle("Predicted m_{h} (GeV)");
    h0histo[iFile]->GetXaxis()->CenterTitle();
    h0histo[iFile]->GetXaxis()->SetTitleSize(0.05);
    h0histo[iFile]->GetXaxis()->SetTitleOffset(1.2);
    h0histo[iFile]->GetXaxis()->SetLabelSize(0.05);
    h0histo[iFile]->SetYTitle("Toy fits");
    h0histo[iFile]->GetYaxis()->SetLabelSize(0.05);
    h0histo[iFile]->GetYaxis()->CenterTitle();
    h0histo[iFile]->GetYaxis()->SetTitleSize(0.05);
    h0histo[iFile]->GetYaxis()->SetTitleOffset(1.3);
    if (iFile==0) h0histo[iFile]->Draw("e0");
    else h0histo[iFile]->Draw("e0same");
  }  
  canvas->Print("text.eps");

  return;

}
