
// This ROOT macro plots the markov chains produced by Fittino 
// in the projections of the mSUGRA high-scale parameters. 
// The asymed statistics is bayesian. Shame on me. An alternative 
// frequentist interpretation will follow soon. 

#include "TStyle.h"
#include "TROOT.h"
#include "TLegend.h"
#include "TFile.h"
#include "TMath.h"
#include "TDirectory.h"
#include "TChain.h"
#include "TCanvas.h"
#include "TLeafD.h"
#include "TH1D.h"
#include "TF1.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TList.h"
#include "TLine.h"
#include "TObjArray.h"
#include "TImage.h"
#include "iostream"
#include "fstream"
#include "string"
#include "vector"
using namespace std;

void MakeMarkovMassDistPlot (const char* filename = "MarkovChainNtupFile.root",
			     const double minHist = 0.,
			     const double maxHist = 100000000.,
			     const int nbins = 500,
			     const char* treename = "markovChain",
			     const string tag = "",
			     const string predicted = "Derived",
			     const string logoPath = "./logo/fittinologo.jpg",
			     const bool smooth = false ) 
{

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

  // dummy colors
  const int deepColor1 = kBlue+2;
  const int deepColor2 = kBlue;
  // important colors
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
  float* par   = new float[nLeaves];
  vector<string> parNames;

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

  vector<double> overflow;

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

  // bind the parameters and observables
  int iChi2 = -1;
  for (int iLeaf = 0; iLeaf < nLeaves; iLeaf++) {
    TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
    leaf->SetAddress(&par[iLeaf]);
    parNames.push_back(leaf->GetName());
    if (!strcmp("chi2",leaf->GetName())) {
      iChi2 = iLeaf;
    }
  }
  if (iChi2<0) return;

  //  nEntries = 10000;
  cout << "looping over " << nEntries << " entries" << endl;

  // find the chi2 minimum
  float chi2 = 0.;
  double minChi2 = 100000000.;
  for (int i = 0; i < nEntries; i++) {
    tree->GetEntry(i);
    if (par[iChi2]<minChi2) {
      minChi2 = par[iChi2];
    }
  }
  cout << "found minimal chi2 = " << minChi2 << endl;
  

  // find the 2sigma envelope
  vector<int> obsPosition(name.size());
  for (int iname = 0; iname < nameSize; iname++) {
    for (int iLeaf = 0; iLeaf < nLeaves; iLeaf++) {
      if (!strncmp("O_mass",parNames[iLeaf].c_str(),4)) {
	char fullParticleName[256];
	sprintf(fullParticleName,"%s",parNames[iLeaf].c_str());
	//	cout << "trying to find " << fullParticleName << endl; 
	char* particleName = &fullParticleName[6];
	int particleNameLength = strcspn(particleName,"_");
	int totalParticleNameLength = strcspn(particleName,"\0");
	particleName[particleNameLength] = '\0';
	if (!strncmp(name[iname].c_str(),particleName,name[iname].size())) {
	  cout << "found observable " << name[iname] << " " <<  fullParticleName << endl;
	  obsPosition[iname] = iLeaf;
	}
      }
    }
  }
  for (int i = 0; i < nEntries; i++) {
    tree->GetEntry(i);
    if (par[iChi2]-minChi2<4.01) {
      for (int iname = 0; iname < nameSize; iname++) {
	if (par[obsPosition[iname]]<0.) { 
	  par[obsPosition[iname]] = -par[obsPosition[iname]];
	}
	if (par[obsPosition[iname]]<mintree) {
	  mintree = par[obsPosition[iname]];
	}
	if (par[obsPosition[iname]]>maxtree) {
	  maxtree = par[obsPosition[iname]];
	}
      }
    }
  }
  double min = mintree - 0.1 * (maxtree - mintree);
  double max = maxtree + 0.1 * (maxtree - mintree);
  if (min < minHist) min = minHist;
  if (max > maxHist) max = maxHist;
  cout << "found envelope " << mintree << " " << maxtree << endl;

  // book one histogram for each observable
  TH1F* oneDHistBestFit[name.size()];
  TH1F* oneDHistOneSigma[name.size()];
  TH1F* oneDHistTwoSigma[name.size()];
  for (int iname = 0; iname < nameSize; iname++) {
    overflow.push_back(0.);
    string histNameBestFit = "bestFit_" + binName[iname];
    oneDHistBestFit[iname] = new TH1F(histNameBestFit.c_str(),"",nbins,min,max);
    string histNameOneSigma = "oneSigma_" + binName[iname];
    oneDHistOneSigma[iname] = new TH1F(histNameOneSigma.c_str(),"",nbins,min,max);
    string histNameTwoSigma = "twoSigma_" + binName[iname];
    oneDHistTwoSigma[iname] = new TH1F(histNameTwoSigma.c_str(),"",nbins,min,max);
  }

  // fill the oneD histos
  for (int i = 0; i < nEntries; i++) {
    tree->GetEntry(i);
    if (par[iChi2]-minChi2<=4.0) {
      for (int iname = 0; iname < nameSize; iname++) {
	if (par[obsPosition[iname]]>max && par[obsPosition[iname]]>overflow[iname]) overflow[iname]=par[obsPosition[iname]];
	oneDHistTwoSigma[iname]->Fill(TMath::Abs(par[obsPosition[iname]]));
      }
    }
    if (par[iChi2]-minChi2<=1.0) {
      for (int iname = 0; iname < nameSize; iname++) {
	oneDHistOneSigma[iname]->Fill(TMath::Abs(par[obsPosition[iname]]));
      }
    }
    if (par[iChi2]==minChi2) {
      for (int iname = 0; iname < nameSize; iname++) {
	oneDHistBestFit[iname]->Fill(TMath::Abs(par[obsPosition[iname]]));
      }
    }
  }  

  // flatten the histograms
  for (int iname = 0; iname < nameSize; iname++) {
    for (int iBin = 0; iBin < nbins; iBin++) {
      if (oneDHistTwoSigma[iname]->GetBinContent(iBin+1)>0.) {
	oneDHistTwoSigma[iname]->SetBinContent(iBin+1,2.);
      } else {
	oneDHistTwoSigma[iname]->SetBinContent(iBin+1,0.);
      }
      if (oneDHistOneSigma[iname]->GetBinContent(iBin+1)>0.) {
	oneDHistOneSigma[iname]->SetBinContent(iBin+1,4.);
      } else {
	oneDHistOneSigma[iname]->SetBinContent(iBin+1,0.);
      }
      if (oneDHistBestFit[iname]->GetBinContent(iBin+1)>0.) {
	oneDHistBestFit[iname]->SetBinContent(iBin+1,5.);
      } else {
	oneDHistBestFit[iname]->SetBinContent(iBin+1,0.);
      }
    }    
  }

  // if desired: smooth 1 and 2sigma env
  if (smooth) {
    for (int iname = 0; iname < nameSize; iname++) {
      // get 2 sigma boundaries
      int lowest2sBin  =  100000;
      int highest2sBin = -100000; 
      int bestFitBin   = 0;
      for (int iBin = 0; iBin < nbins; iBin++) {
	if (oneDHistBestFit[iname]->GetBinContent(iBin+1)>0.) {
	  bestFitBin = iBin;
	  break;
	}
      }
      for (int iBin = 0; iBin < nbins; iBin++) {
	if (oneDHistTwoSigma[iname]->GetBinContent(iBin+1)>0.) {
	  if (lowest2sBin==100000) {
	    lowest2sBin = iBin;
	  }
	}
	if (oneDHistTwoSigma[iname]->GetBinContent(iBin+1)>0.) {
	  highest2sBin = iBin;
	}
      }
      // check for overflow
      if (overflow[iname]>max) {
	// calculate virtual bin of the overflow
	int iOverflowBin = (int)((overflow[iname]-min)/((max-min)/(double)nbins));
	if (iOverflowBin>highest2sBin && highest2sBin>=nbins-1) highest2sBin = iOverflowBin;
      }
      // determine new boundaries
      int lowest1sBin  = (int)((double)(bestFitBin + lowest2sBin)/2.);
      int highest1sBin = (int)((double)(bestFitBin + highest2sBin)/2.);
      cout << "lowest and highest " << name[iname] << " 1s bins " << lowest1sBin << " " << highest1sBin << endl;
      cout << "lowest and highest " << name[iname] << " 2s bins " << lowest2sBin << " " << highest2sBin << endl;
      // loop over the histogram again and set bin contents
      for (int iBin = 0; iBin < nbins; iBin++) {
	if (iBin<lowest1sBin) {
	  oneDHistOneSigma[iname]->SetBinContent(iBin+1,0.);
	} else if (iBin>=lowest1sBin && iBin<=highest1sBin) {
	  oneDHistOneSigma[iname]->SetBinContent(iBin+1,4.);
	} else {
	  oneDHistOneSigma[iname]->SetBinContent(iBin+1,0.);
	}
	if (iBin<lowest2sBin) {
	  oneDHistTwoSigma[iname]->SetBinContent(iBin+1,0.);
	} else if (iBin>=lowest2sBin && iBin<=highest2sBin) {
	  oneDHistTwoSigma[iname]->SetBinContent(iBin+1,2.);
	} else {
	  oneDHistTwoSigma[iname]->SetBinContent(iBin+1,0.);
	}
      }
    }
  }

  // plot the histograms for debug reasons
  for (int iname = 0; iname < nameSize; iname++) {
    oneDHistBestFit[iname]->SetLineColor(kRed);
    oneDHistOneSigma[iname]->SetLineColor(kBlue);
    oneDHistTwoSigma[iname]->SetLineColor(kBlue+3);
    oneDHistBestFit[iname]->Draw();    
    oneDHistTwoSigma[iname]->Draw("same");
    oneDHistOneSigma[iname]->Draw("same");
    oneDHistBestFit[iname]->Draw("same");
    string debugFile = "oneDHists_" + name[iname] + ".eps";
    canvas->Print(debugFile.c_str());
  }  
  
  // fill the 2D histo
  string histTitle = predicted + " Mass Spectrum of SUSY Particles " + tag; 
  TH2D* massHistAll = new TH2D("massHistAll", histTitle.c_str(),
			       nameSize,
			       0.,(double)nameSize,
			       nbins,
			       min,max);

  string yAxisTitle = predicted + " Particle Mass [GeV]";
  massHistAll->SetYTitle(yAxisTitle.c_str());
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

  massHistAll->SetMinimum(0.);
  massHistAll->SetMaximum(7.);

  // make the best fit line a bit thicker
  if (nbins>300) {
    for (int iname = 0; iname < nameSize; iname++) {
      for (int iBin = 0; iBin < nbins; iBin++) {
	if (oneDHistBestFit[iname]->GetBinContent(iBin+1)>0.) {
	  oneDHistBestFit[iname]->SetBinContent(iBin,oneDHistBestFit[iname]->GetBinContent(iBin+1));
	  oneDHistBestFit[iname]->SetBinContent(iBin+2,oneDHistBestFit[iname]->GetBinContent(iBin+1));
	  break;
	}
      }
    }  
  }

  // fill the oneD histos into the 2D histo
  for (int iname = 0; iname < nameSize; iname++) {
    for (int iBin = 0; iBin < nbins; iBin++) {
      if (oneDHistTwoSigma[iname]->GetBinContent(iBin+1)>0.) {
	massHistAll->SetBinContent(iname+1,iBin+1,oneDHistTwoSigma[iname]->GetBinContent(iBin+1));
      }
      if (oneDHistOneSigma[iname]->GetBinContent(iBin+1)>0.) {
	massHistAll->SetBinContent(iname+1,iBin+1,oneDHistOneSigma[iname]->GetBinContent(iBin+1));
      }
      if (oneDHistBestFit[iname]->GetBinContent(iBin+1)>0.) {
	massHistAll->SetBinContent(iname+1,iBin+1,oneDHistBestFit[iname]->GetBinContent(iBin+1));
      }
    }    
  }  
  massHistAll->Draw("col");

  // add a legend
  TLegend *legend = new TLegend(0.33,0.65,0.63,0.9,"");
  TF1* dummyFunc1s = new TF1("gaus1s","gaus",0.,1.);
  dummyFunc1s->SetFillColor(env1sColor);
  dummyFunc1s->SetLineColor(env1sColor);
  dummyFunc1s->SetFillStyle(1001);  
  TF1* dummyFunc2s = new TF1("gaus2s","gaus",0.,1.);
  dummyFunc2s->SetFillColor(env3sColor);
  dummyFunc2s->SetLineColor(env3sColor);
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
  //  legend->AddEntry(dummyFunc3s,  "3#sigma Environment", "F");
  legend->AddEntry(dummyFuncHighest, "Best Fit Value", "l");
  //  legend->AddEntry(dummyFuncMean,    "Mean Value", "l");
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
  
  string outFile = "markovMassDist.eps";
  canvas->Print(outFile.c_str());
  

  return;

}
