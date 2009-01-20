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

void MakeMassDistPlot (const char* filename = "PullDistributions.sum.root",
		       const double minHist = 0.,
		       const double maxHist = 100000000.,
		       const int nbins = 1000,
		       const int minEvents = 5,
		       const char* treename = "tree",
		       const string tag = "",
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

  // set color scheme
//  const Int_t NRGBs = 5;
//  const Int_t NCont = 7;  
////  Double_t stops[NRGBs] = { 0.00, 0.34, 0.61, 0.84, 1.00 };
////  Double_t red[NRGBs]   = { 0.00, 0.00, 0.87, 1.00, 0.51 };
////  Double_t green[NRGBs] = { 0.00, 0.81, 1.00, 0.20, 0.00 };
////  Double_t blue[NRGBs]  = { 0.51, 1.00, 0.12, 0.00, 0.00 };
//  Double_t red[NRGBs] = { 1.00, 0.00, 0.00};
//  Double_t green[NRGBs] = { 0.00, 1.00, 0.00};
//  Double_t blue[NRGBs] = { 0.00, 0.00, 1.00};
//  Double_t stops[NRGBs] = { 0.50, 0.00, 0.00 };
//
////  Double_t stops[NRGBs] = { 0.00, 0.34, 0.61, 0.84, 1.00 };
////  Double_t red[NRGBs]   = { 0.00, 0.00, 0.87, 1.00, 0.51 };
////  Double_t green[NRGBs] = { 0.00, 0.81, 1.00, 0.20, 0.00 };
////  Double_t blue[NRGBs]  = { 0.51, 1.00, 0.12, 0.00, 0.00 };
//  TColor::CreateGradientColorTable(NRGBs, stops, red, green, blue, NCont);
//  gStyle->SetNumberContours(NCont);

  // dummy colors
  const int deepColor1 = kBlue+2;
  const int deepColor2 = kBlue;
  // important colors
//  // magenta scheme
//  const int env3sColor = kMagenta-10;
//  const int env2sColor = kMagenta-8;
//  const int env1sColor = kMagenta-6;
//  const int highestColor = kRed+1;
//  const int meanColor = kRed+4;
//  // red scheme
//  const int env3sColor = kRed-7;
//  const int env2sColor = kRed-3;
//  const int env1sColor = kRed+2;
//  const int highestColor = kBlue+0;
//  const int meanColor = kBlue+4;
  // red scheme
  const int env3sColor = kBlue-9;
  const int env2sColor = kBlue-6;
  const int env1sColor = kBlue-2;
  const int highestColor = kRed+0;
  const int meanColor = kRed+4;

  Int_t colors[7] = {deepColor1, deepColor2,
		     env3sColor,
		     env2sColor, 
		     env1sColor, 
		     highestColor, 
		     meanColor};
  gStyle->SetPalette(7,colors);
  
  // get the fittino logo
  TImage *fittinoLogo = TImage::Open(logoPath.c_str());
  if (!fittinoLogo) {
    printf("Could not open the fittino logo at %s\n exit\n",logoPath.c_str());
    return;
  }
  fittinoLogo->SetConstRatio(1);
  fittinoLogo->SetImageQuality(TAttImage::kImgBest);

  // and finally really start...

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
      for (Int_t i=0; i<nEntries; i++) {
	tree->GetEntry(i);
	double mass = 0.;
	if (par[leafPosition[iname]]>0) mass = par[leafPosition[iname]];
	else mass = -par[leafPosition[iname]];
	massHistBeforeCleanup->Fill((double)iname,mass);
	histo[iname]->Fill(mass);
      }
    } else {
      if (name[iname]=="H0" || name[iname]=="Hplus") {
	for (int jname = 0; jname < nameSize; jname++) {
	  if (alreadyFound[jname]) {
	    if (name[jname]=="A0") {
	      TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(leafPosition[jname]);
	      leaf->SetAddress(&par[leafPosition[jname]]);
	      cout << "looping over events of " << name[iname] << endl;
	      string histoName = name[iname]+"RawHisto";
	      histo[iname] = new TH1D(histoName.c_str(), histoName.c_str(), nbins, min, max);
	      for (Int_t i=0; i<nEntries; i++) {
		tree->GetEntry(i);
		double massA0 = 0.;
		double mass = 0.;
		if (par[leafPosition[jname]]>0) massA0 = par[leafPosition[jname]];
		else massA0 = -par[leafPosition[iname]];
		if (name[iname]=="H0") {
		  mass = sqrt(massA0*massA0+91.2*91.2);
		} else if (name[iname]=="Hplus") {
		  mass = sqrt(80.*80.+massA0*massA0);
		}
		massHistBeforeCleanup->Fill((double)iname,mass);
		histo[iname]->Fill(mass);
		alreadyFound[iname] = true;
	      }	      
	    }
	  }
	}
      }
    }
  }

  // smooth the oneD histograms
  cout << "smooth the oneD histograms" << endl;
  for (int iname = 0; iname < nameSize; iname++) {
    if (alreadyFound[iname]) {
      const double oneDHistNorm = histo[iname]->Integral();
      histo[iname]->Scale(1./oneDHistNorm);
      double xValues[nbins];
      double yValues[nbins];
      for (int i = 1; i <= nbins; i++) {
	xValues[i-1] = min+(double)(i-1)*(max-min)/(double)nbins;
	yValues[i-1] = histo[iname]->GetBinContent(i);
      }
      TGraph* thisGraph = new TGraph(nbins,xValues,yValues);
      TGraphSmooth* smoother = new TGraphSmooth("normal");
      double smoothFactor = 1.;
      if (histo[iname]->GetRMS()/5.>1.) smoothFactor = histo[iname]->GetRMS()/5.;
      TGraph* smoothedGraph = smoother->SmoothKern(thisGraph,"normal",smoothFactor);
      string smoothedHistoName = name[iname]+"SmoothedHisto";
      histoSmoothed[iname] = new TH1D(smoothedHistoName.c_str(), smoothedHistoName.c_str(), nbins, min, max);
      cout << " transferrring " << name[iname] << " with " << histo[iname]->GetRMS() << " " << (max-min)/(double)nbins << endl;
      if (histo[iname]->GetRMS()>(max-min)/(double)nbins && histo[iname]->GetRMS()>1.) {
	cout << "copying smoothed histogram" << endl;
	for (int i = 1; i <= nbins; i++) {
	  histoSmoothed[iname]->SetBinContent(i,smoothedGraph->Eval(min+(double)(i-1)*(max-min)/(double)nbins));
	}
      } else {
	cout << "copying original histogram" << endl;
	for (int i = 1; i <= nbins; i++) {	
	  histoSmoothed[iname]->SetBinContent(i,histo[iname]->GetBinContent(i));
	}
      }
    }
  }
  
  // compare histograms 
  for (int iname = 0; iname < nameSize; iname++) {
    if (alreadyFound[iname]) {
      if (histo[iname]->GetRMS()>(max-min)/(double)nbins && histo[iname]->GetRMS()>1.) {
      } else {
	cout << "comparing " << name[iname] << " in detail " << endl;
	for (int i = 1; i <= nbins; i++) {	
	  if (!(histoSmoothed[iname]->GetBinContent(i)==histo[iname]->GetBinContent(i))) {
	    cout << "difference! " << i << " " << histoSmoothed[iname]->GetBinContent(i) << " " << histo[iname]->GetBinContent(i) << endl;
	  }
	}	
      }
    }   
  }  


  cout << "check that RMS doesnt change and plot control histograms" << endl;
  for (int iname = 0; iname < nameSize; iname++) {
    if (alreadyFound[iname]) {
      cout << name[iname] << " original RMS = " << histo[iname]->GetRMS() 
	   << " smoothed RMS = " << histoSmoothed[iname]->GetRMS() << endl;
      histo[iname]->Draw();
      histoSmoothed[iname]->SetLineColor(kRed);
      histoSmoothed[iname]->Draw("same");
      string plotName = name[iname] + "OneDSmoothed.eps";
      canvas->Print(plotName.c_str());
    }
  }  

  // now make the final histogram
  cout << "now make the final 2D histograms of the distributions" << endl;
  TH2D* massHist = new TH2D("massHist","Derived Mass Spectrum of SUSY Particles",
			    nameSize,
			    0.,(double)nameSize,
			    nbins,
			    min,max);

  TH2D* massHistAll = new TH2D("massHistAll","Derived Mass Spectrum of SUSY Particles",
			       nameSize,
			       0.,(double)nameSize,
			       nbins,
			       min,max);

  massHist->SetYTitle("Derived Particle Mass [GeV]");
  massHist->GetYaxis()->SetLabelSize(0.05);
  massHist->GetYaxis()->CenterTitle();
  massHist->GetYaxis()->SetTitleSize(0.05);
  massHist->GetYaxis()->SetTitleOffset(1.3);

  TAxis* theXAxis = massHist->GetXaxis();
  theXAxis->SetLabelSize(0.07);
  theXAxis->SetLabelOffset(0.01);
  for (int i = 1; i <= nameSize; i++) {
    theXAxis->SetBinLabel(i,binName[i-1].c_str());
  }  
  
  massHistAll->SetYTitle("Derived Particle Mass [GeV]");
  massHistAll->GetYaxis()->SetLabelSize(0.05);
  massHistAll->GetYaxis()->CenterTitle();
  massHistAll->GetYaxis()->SetTitleSize(0.05);
  massHistAll->GetYaxis()->SetTitleOffset(1.3);

  TAxis* theXAxisAll = massHistAll->GetXaxis();
  theXAxisAll->SetLabelSize(0.07);
  theXAxisAll->SetLabelOffset(0.01);
  for (int i = 1; i <= nameSize; i++) {
    theXAxisAll->SetBinLabel(i,binName[i-1].c_str());
  }  
  

  for (int iname = 1; iname <= nameSize; iname++) {
    if (alreadyFound[iname-1]) {
      for (int j = 1; j <= nbins; j++) {
	//      massHistAll->SetBinContent(iname,j,massHistBeforeCleanup->GetBinContent(iname,j));
	massHistAll->SetBinContent(iname,j,histoSmoothed[iname-1]->GetBinContent(j));
	if (massHistBeforeCleanup->GetBinContent(iname,j)>=minEvents) {
	  massHist->SetBinContent(iname,j,massHistBeforeCleanup->GetBinContent(iname,j));
	}
      }
    }
  }

  // normalize
  const double massHistNorm = massHist->Integral();
  massHist->Scale((double)nameSize/massHistNorm);
  // massHistAll->Scale((double)nameSize/massHistNorm);

  // plot
  canvas->SetLogz(1);
  massHist->Draw("col");
  canvas->Print("predictedSUSYMassSpectrumLog.eps");
  massHistAll->Draw("col");
  canvas->Print("predictedSUSYMassAllSpectrumLog.eps");
  canvas->SetLogz(0);
  massHist->Draw("col");
  canvas->Print("predictedSUSYMassSpectrumLin.eps");
  massHistAll->Draw("col");
  canvas->Print("predictedSUSYMassAllSpectrumLin.eps");



  // find the 1,2,3,all sigma contours
  
  cout << "plot 1,2,3 sigma contours" << endl;


  TH1D*  histo0s[nameSize];
  TH1D*  histo1s[nameSize];
  TH1D*  histo2s[nameSize];
  TH1D*  histo3s[nameSize];
  TH1D*  histoAs[nameSize];
  
  for (int iname = 0; iname < nameSize; iname++) {
    if (alreadyFound[iname]) {
      const double oneDHistNorm = histoSmoothed[iname]->Integral();
      cout << "integral of " << name[iname] << " " << oneDHistNorm << endl;
      histoSmoothed[iname]->Scale(1./oneDHistNorm);
      meanValues[iname] = histoSmoothed[iname]->GetMean();
      map<int,double> binmap;
      string histo0sName = name[iname]+"0s";
      histo0s[iname] = new TH1D(histo0sName.c_str(), histo0sName.c_str(), nbins, min, max);
      string histo1sName = name[iname]+"1s";
      histo1s[iname] = new TH1D(histo1sName.c_str(), histo1sName.c_str(), nbins, min, max);
      string histo2sName = name[iname]+"2s";
      histo2s[iname] = new TH1D(histo2sName.c_str(), histo2sName.c_str(), nbins, min, max);
      string histo3sName = name[iname]+"3s";
      histo3s[iname] = new TH1D(histo3sName.c_str(), histo3sName.c_str(), nbins, min, max);
      string histoAsName = name[iname]+"As";
      histoAs[iname] = new TH1D(histoAsName.c_str(), histoAsName.c_str(), nbins, min, max);
      for (int i = 1; i <= nbins; i++) {
	binmap[i] = histoSmoothed[iname]->GetBinContent(i);
      }    
      double largest = -1.;
      double lastLargest = 2.;
      int largestI = 0;
      double sum1s = 0.;
      double sum2s = 0.;
      double sum3s = 0.;
      double sumAs = 0.;    
      bool first = true;
      bool stopCount1s = false;
      bool stopCount2s = false;
      bool stopCount3s = false;
      for (int iBin = 1; iBin <= nbins; iBin++) {
	largest = -1.;
	for (int i = 1; i <= nbins; i++) {
	  if (binmap[i]>largest && binmap[i]<lastLargest) {
	    largestI = i;
	    largest = binmap[i];
	  }
	}
	if (sum1s+binmap[largestI]<0.68 && !stopCount1s) {
	  sum1s+=binmap[largestI];
	  histo1s[iname]->SetBinContent(largestI,4.);
	} else {
	  stopCount1s = true;
	}
	if (sum2s+binmap[largestI]<0.95 && !stopCount2s) { 
	  sum2s+=binmap[largestI];
	  histo2s[iname]->SetBinContent(largestI,3.);
	} else {
	  stopCount2s = true;
	}
	if (sum3s+binmap[largestI]<0.99 && !stopCount3s) { 
	  sum3s+=binmap[largestI];
	  histo3s[iname]->SetBinContent(largestI,2.);
	} else {
	  stopCount3s = true;
	}
	sumAs+=binmap[largestI];
	histoAs[iname]->SetBinContent(largestI,1.);
	if (first)  { 
	  histo0s[iname]->SetBinContent(largestI,5.);
	  histo0s[iname]->SetBinContent(largestI-1,5.);
	  histo0s[iname]->SetBinContent(largestI+1,5.);	
	}
	lastLargest = largest;
	first = false;
      }
      cout << "test of sumAs for " << name[iname] << " " << sumAs << endl;
      histo0s[iname]->Draw();
      histo1s[iname]->SetLineColor(kRed);
      histo1s[iname]->Draw("same");
      histo2s[iname]->SetLineColor(kGreen);
      histo2s[iname]->Draw("same");
      histo3s[iname]->SetLineColor(kBlue);
      histo3s[iname]->Draw("same");
      histoAs[iname]->SetLineColor(kYellow);
      histoAs[iname]->Draw("same");
      string plotName = name[iname] + "OneDSigmas.eps";
      canvas->Print(plotName.c_str());    
    }
  }  
  
  string histTitle = "Derived Mass Spectrum of SUSY Particles " + tag; 
  TH2D* massHistSigmaRanges1s = new TH2D("massHistSigmaRanges1s", histTitle.c_str(),
					 nameSize,
					 0.,(double)nameSize,
					 nbins,
					 min,max);
  TH2D* massHistSigmaRanges2s = new TH2D("massHistSigmaRanges2s", histTitle.c_str(),
					 nameSize,
					 0.,(double)nameSize,
					 nbins,
					 min,max);
  TH2D* massHistSigmaRanges3s = new TH2D("massHistSigmaRanges3s", histTitle.c_str(),
					 nameSize,
					 0.,(double)nameSize,
					 nbins,
					 min,max);

  TH2D* massHistMostProbable = new TH2D("massHistMostProbable", histTitle.c_str(),
					nameSize,
					0.,(double)nameSize,
					nbins,
					min,max);
  
  TH2D* massHistMean = new TH2D("massHistMean", histTitle.c_str(),
				nameSize,
				0.,(double)nameSize,
				nbins,
				min,max);
  
  massHistSigmaRanges3s->SetYTitle("Derived Particle Mass [GeV]");
  massHistSigmaRanges3s->GetYaxis()->SetLabelSize(0.05);
  massHistSigmaRanges3s->GetYaxis()->CenterTitle();
  massHistSigmaRanges3s->GetYaxis()->SetTitleSize(0.05);
  massHistSigmaRanges3s->GetYaxis()->SetTitleOffset(1.3);
  
  TAxis* theXAxisSigmaRanges3s = massHistSigmaRanges3s->GetXaxis();
  theXAxisSigmaRanges3s->SetLabelSize(0.07);
  theXAxisSigmaRanges3s->SetLabelOffset(0.01);
  for (int i = 1; i <= nameSize; i++) {
    theXAxisSigmaRanges3s->SetBinLabel(i,binName[i-1].c_str());
  }  
  
  for (int iname = 1; iname <= nameSize; iname++) {
    if (alreadyFound[iname-1]) {
      for (int j = 1; j <= nbins; j++) {
	massHistMostProbable->SetBinContent (iname,j,histo0s[iname-1]->GetBinContent(j));
	massHistSigmaRanges1s->SetBinContent(iname,j,histo1s[iname-1]->GetBinContent(j));
	massHistSigmaRanges2s->SetBinContent(iname,j,histo2s[iname-1]->GetBinContent(j));
	massHistSigmaRanges3s->SetBinContent(iname,j,histo3s[iname-1]->GetBinContent(j));
	// massHistSigmaRanges->SetBinContent(iname,j,massHistSigmaRanges->GetBinContent(iname,j)+histoAs[iname-1]->GetBinContent(j));
      }
      massHistMean->Fill(iname-1,meanValues[iname-1],6.);
    }
  }
  for (int iname = 1; iname <= nameSize; iname++) {
    for (int j = 1; j <= nbins; j++) {
      if (massHistSigmaRanges1s->GetBinContent(iname,j)<0.5) massHistSigmaRanges1s->SetBinContent(iname,j,0.);
      if (massHistSigmaRanges2s->GetBinContent(iname,j)<0.5) massHistSigmaRanges2s->SetBinContent(iname,j,0.);
      if (massHistSigmaRanges3s->GetBinContent(iname,j)<0.5) massHistSigmaRanges3s->SetBinContent(iname,j,0.);
      if (massHistMostProbable->GetBinContent(iname,j)<0.5) massHistMostProbable->SetBinContent(iname,j,0.);
      if (massHistMean->GetBinContent(iname,j)<0.5) massHistMean->SetBinContent(iname,j,0.);
    }
  }
  

  // finally really draw the final plot:
  canvas->SetLogz(0);
  massHistSigmaRanges3s->SetMaximum(7.);
  massHistSigmaRanges3s->SetMinimum(0.);
  massHistSigmaRanges2s->SetMaximum(7.);
  massHistSigmaRanges2s->SetMinimum(0.);
  massHistSigmaRanges1s->SetMaximum(7.);
  massHistSigmaRanges1s->SetMinimum(0.);
  massHistMostProbable->SetMaximum(7.);
  massHistMostProbable->SetMinimum(0.);
  massHistMean->SetMaximum(7.);
  massHistMean->SetMinimum(0.);
  massHistSigmaRanges3s->Draw("col");
  massHistSigmaRanges2s->Draw("colsame");
  massHistSigmaRanges1s->Draw("colsame");
  massHistMostProbable->Draw("colsame");
  massHistMean->Draw("colsame");
  // add a legend
  TLegend *legend = new TLegend(0.35,0.65,0.65,0.9,"");
  TF1* dummyFunc1s = new TF1("gaus1s","gaus",0.,1.);
  dummyFunc1s->SetFillColor(env1sColor);
  dummyFunc1s->SetLineColor(env1sColor);
  dummyFunc1s->SetFillStyle(1001);  
  TF1* dummyFunc2s = new TF1("gaus2s","gaus",0.,1.);
  dummyFunc2s->SetFillColor(env2sColor);
  dummyFunc2s->SetLineColor(env2sColor);
  dummyFunc2s->SetFillStyle(1001);  
  TF1* dummyFunc3s = new TF1("gaus3s","gaus",0.,1.);
  dummyFunc3s->SetFillColor(env3sColor);
  dummyFunc3s->SetLineColor(env3sColor);
  dummyFunc3s->SetFillStyle(1001);  
  TF1* dummyFuncHighest = new TF1("gausHighest","gaus",0.,1.);
  dummyFuncHighest->SetFillColor(highestColor);
  dummyFuncHighest->SetLineColor(highestColor);
  TF1* dummyFuncMean = new TF1("gausMean","gaus",0.,1.);
  dummyFuncMean->SetFillColor(meanColor);
  dummyFuncMean->SetLineColor(meanColor);
  legend->AddEntry(dummyFunc1s,  "1#sigma Environment", "F");
  legend->AddEntry(dummyFunc2s,  "2#sigma Environment", "F");
  legend->AddEntry(dummyFunc3s,  "3#sigma Environment", "F");
  legend->AddEntry(dummyFuncHighest, "Most Probable Value", "l");
  legend->AddEntry(dummyFuncMean,    "Mean Value", "l");
  legend->Draw("same");
  // add the fittino logo
  const float canvasHeight   = canvas->GetWindowHeight();
  const float canvasWidth    = canvas->GetWindowWidth();
  const float canvasAspectRatio = canvasHeight/canvasWidth;
  const float width          = 0.19;
  const float xLowerEdge     = 0.78;
  const float yLowerEdge     = 0.853;
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
  canvas->cd();
  canvas->Print("predictedSUSYMassSigmaRangesSpectrum.eps");
  canvas->SetLogz(0);
  
  return;
  
}

































void MakeMassDistPlotTemplate () {

  TCanvas* canvas = new TCanvas();

  vector<string> name;
  vector<double> mass;
  vector<double> error;

  /////////////////////////////////////////////////////////

  name.push_back ("Neutralino1");
  mass.push_back (97.);
  error.push_back(3.);
  name.push_back ("Neutralino2");
  mass.push_back (180.);
  error.push_back(10.);
  name.push_back ("Neutralino3");
  mass.push_back (380.);
  error.push_back(15.);
  name.push_back ("Neutralino4");
  mass.push_back (400.);
  error.push_back(30.);

  name.push_back ("Chargino1");
  mass.push_back (175.);
  error.push_back(5.);
  name.push_back ("Chargino2");
  mass.push_back (390.);
  error.push_back(15.);

  name.push_back ("SelectronL");
  mass.push_back (150.);
  error.push_back(10.);

  name.push_back ("SupR");
  mass.push_back (550.);
  error.push_back(50.);

  name.push_back ("h0");
  mass.push_back (115.);
  error.push_back(1.);



  ////////////////////////////////////////////////////////////////
  // Use the dummy data above to fill histograms 
  ////////////////////////////////////////////////////////////////

  vector<int> nXbin(name.size());
  const int nMass = mass.size();

  // find the lowest and highest values
  double lowestMass = 100000.;
  double highestMass = 0.;
  for (int iMass = 0; iMass < nMass; iMass++) {
    if (mass[iMass]-4.*error[iMass]<lowestMass) {
      lowestMass = mass[iMass]-4.*error[iMass];
    }
    if (mass[iMass]+4.*error[iMass]>highestMass) {
      highestMass = mass[iMass]+4.*error[iMass];
    }
  }  

  TH2D* massHist[nMass];

  for (int iMass = 0; iMass < nMass; iMass++) {

    massHist[iMass] = new TH2D(name[iMass].c_str(),"",
			       28,
			       0.,28.,
			       1000,
			       lowestMass,highestMass);
    TF1* func  = new TF1("func","gaus",mass[iMass]-2.*error[iMass],mass[iMass]+2.*error[iMass]);
    TH1D* hist = new TH1D("hist","",1000,
			  lowestMass,highestMass);
    func->SetParameter(0,1.);
    func->SetParameter(1,mass[iMass]);
    func->SetParameter(2,error[iMass]);
    for (int i = 0; i < 1000000; i++) {
      hist->Fill(func->GetRandom());
    }




    int nFineXbin = -1;

    if (name[iMass]=="h0" || name[iMass]=="A0" || name[iMass]=="H0" || name[iMass]=="Hplus" ) nXbin[iMass] = 1;
    else if (name[iMass]=="Neutralino1" || name[iMass]=="Neutralino2" || name[iMass]=="Neutralino3" || 
	     name[iMass]=="Neutralino4" || name[iMass]=="Chargino1" || name[iMass]=="Chargino2") nXbin[iMass] = 2;    
    else if (name[iMass]=="SelectronL" || name[iMass]=="SelectronR" || name[iMass]=="SmuL" || name[iMass]=="SmuR" || 
	     name[iMass]=="Stau1" || name[iMass]=="Stau2" ) nXbin[iMass] = 3;
    else if (name[iMass]=="SupL" || name[iMass]=="SupR" || name[iMass]=="SdownL" || name[iMass]=="SdownR" || 
	     name[iMass]=="SstrangeL" || name[iMass]=="SstrangeR" || name[iMass]=="ScharmL" || name[iMass]=="ScharmR" || 
	     name[iMass]=="Sbottom1" || name[iMass]=="Sbottom2" || name[iMass]=="Stop1" || name[iMass]=="Stop2") nXbin[iMass] = 4;

    if (name[iMass]=="h0")           nFineXbin = 1;
    else if (name[iMass]=="A0")      nFineXbin = 2; 
    else if (name[iMass]=="H0")      nFineXbin = 3; 
    else if (name[iMass]=="Hplus" )  nFineXbin = 4;
    
    else if (name[iMass]=="Neutralino1") nFineXbin = 5;
    else if (name[iMass]=="Neutralino2") nFineXbin = 6;
    else if (name[iMass]=="Neutralino3") nFineXbin = 7;
    else if (name[iMass]=="Neutralino4") nFineXbin = 8;
    else if (name[iMass]=="Chargino1")   nFineXbin = 9;
    else if (name[iMass]=="Chargino2")   nFineXbin = 10;

    else if (name[iMass]=="SelectronL") nFineXbin = 11;
    else if (name[iMass]=="SelectronR") nFineXbin = 12;
    else if (name[iMass]=="SmuL")       nFineXbin = 13;
    else if (name[iMass]=="SmuR")       nFineXbin = 14;
    else if (name[iMass]=="Stau1")      nFineXbin = 15;
    else if (name[iMass]=="Stau2")      nFineXbin = 16;

    else if (name[iMass]=="SupL")       nFineXbin = 17;
    else if (name[iMass]=="SupR")       nFineXbin = 18;
    else if (name[iMass]=="SdownL")     nFineXbin = 19;
    else if (name[iMass]=="SdownR")     nFineXbin = 20;
    else if (name[iMass]=="SstrangeL")  nFineXbin = 21;
    else if (name[iMass]=="SstrangeR")  nFineXbin = 22;
    else if (name[iMass]=="ScharmL")    nFineXbin = 23;
    else if (name[iMass]=="ScharmR")    nFineXbin = 24;
    else if (name[iMass]=="Stop1")      nFineXbin = 25;
    else if (name[iMass]=="Stop2")      nFineXbin = 26;
    else if (name[iMass]=="Sbottom1")   nFineXbin = 27;
    else if (name[iMass]=="Sbottom2")   nFineXbin = 28;

    for (int i = 0; i < 1000; i++) {
      massHist[iMass]->SetBinContent(nFineXbin, i, hist->GetBinContent(i));
    }
    func->Delete();
    hist->Delete();
  }
  
  for (int iMass = 0; iMass < nMass; iMass++) {
    massHist[iMass]->Draw("col");
    string thisName = name[iMass];
    thisName = thisName + ".eps";
    canvas->Print(thisName.c_str());
  }  

  ////////////////////////////////////////////////////////////////
  // Make the real plot
  ////////////////////////////////////////////////////////////////
  
  // now define the colors
  TStyle* theStyle = new TStyle();
  theStyle->SetOptStat(0);

  TH2D* theRealPlot = new TH2D("spectrum","Predicted SUSY Spectrum",
			       28,
			       0.,28.,
			       1000,
			       lowestMass,highestMass);

  // make axis labels etc... (still missing)


  theRealPlot->Draw();



  int theColors[5];
  // now overlay the individual distributions
  for (int iMass = 0; iMass < nMass; iMass++) {
    cout << "Observable " << name[iMass] << " nXbin = " << nXbin[iMass]<< endl;
    if (nXbin[iMass]==1) {
      theColors[0] = kBlue+0;
      theColors[1] = kBlue+1;
      theColors[2] = kBlue+2;
      theColors[3] = kBlue+3;
      theColors[4] = kBlue+4;
    } else if (nXbin[iMass]==2) {
      theColors[0] = kMagenta+0;
      theColors[1] = kMagenta+1;
      theColors[2] = kMagenta+2;
      theColors[3] = kMagenta+3;
      theColors[4] = kMagenta+4;      
    } else if (nXbin[iMass]==3) {
      theColors[0] = kGreen+0;
      theColors[1] = kGreen+1;
      theColors[2] = kGreen+2;
      theColors[3] = kGreen+3;
      theColors[4] = kGreen+4;      
    } else if (nXbin[iMass]==4) {
      theColors[0] = kRed+0;
      theColors[1] = kRed+1;
      theColors[2] = kRed+2;
      theColors[3] = kRed+3;
      theColors[4] = kRed+4;      
    }


    theStyle->SetPalette(5,theColors);
    
    massHist[iMass]->DrawCopy("samecol");
    canvas->Update();

  }

  canvas->Print("PredictedSUSYSpectrum.eps");

  return;

}
