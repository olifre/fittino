
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

void MakeMarkovMassDistPlot (const string filename1 = "",
			     const string filetag1 = "",
			     const string filename2 = "",
			     const string filetag2 = "",
			     const string filename3 = "",
			     const string filetag3 = "",
			     const string filename4 = "",
			     const string filetag4 = "",
			     const string filename5 = "",
			     const string filetag5 = "",
			     const string variableName = "",
			     const string logoPath = "./logo/fittinologo.jpg",
			     const double minHist = 0.,
			     const double maxHist = 100000000.,
			     const int nbins = 500,
			     const string treename = "markovChain",
			     const string tag = "",
			     const string predicted = "Derived",
			     const bool smooth = false,
			     const bool requireNeut1LSP = false ) 
{

  const int maxFiles = 5;

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
  const int highestColor = kRed+2;
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


  // check filenames
  int nFiles = 0;
  if (filename1=="") {
    cout << "at least one input file has to be specified" << endl;
    return;
  }
  else if (filename2=="") nFiles = 1;
  else if (filename3=="") nFiles = 2;
  else if (filename4=="") nFiles = 3;
  else if (filename5=="") nFiles = 4;
  else  nFiles = maxFiles;

  

  // and finally really start...

  TFile* file[maxFiles];
  TTree* tree[maxFiles];
  int nEntries[maxFiles];
  int nLeaves[maxFiles];
  string filename[maxFiles];
  string filetag[maxFiles];
  for (int iFile = 0; iFile < nFiles; iFile++) {
    if (iFile == 0) filename[iFile] = filename1;
    else if (iFile == 1) filename[iFile] = filename2;
    else if (iFile == 2) filename[iFile] = filename3;
    else if (iFile == 3) filename[iFile] = filename4;
    else if (iFile == 4) filename[iFile] = filename5;
    if (iFile == 0) filetag[iFile] = filetag1;
    else if (iFile == 1) filetag[iFile] = filetag2;
    else if (iFile == 2) filetag[iFile] = filetag3;
    else if (iFile == 3) filetag[iFile] = filetag4;
    else if (iFile == 4) filetag[iFile] = filetag5;
  }

  // open files and get trees
  for (int iFile = 0; iFile < nFiles; iFile++) {
    file[iFile] = new TFile(filename[iFile].c_str(), "read");
    if ( !file[iFile] ) {
      printf("Problem accessing file %s\n", filename[iFile].c_str());
      return;
    }
    tree[iFile] = (TTree*)file[iFile]->Get(treename.c_str());
    if ( !tree[iFile] ) {
      printf("Problem accessing tree %s\n", treename.c_str());
      return;
    }
  
    nEntries[iFile] = tree[iFile]->GetEntries();
    nLeaves[iFile] = tree[iFile]->GetListOfLeaves()->GetEntriesFast();
    if (iFile>0) {
      if (nLeaves[iFile]!=nLeaves[iFile-1]) {
	cout << "structure of input ntuples not identical" << endl;
	return;
      }
    }
  }



  float* par   = new float[nLeaves[0]];
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

  bool foundVariable = false;
  for (int iname = 0; iname < name.size(); iname++) {
    if (name[iname]==variableName) {
      foundVariable = true;
      break;
    }
  }
  if (!foundVariable) {
    cout << "variable " << variableName << " not found" << endl;
    return;
  }

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

  // book one histogram for each observable
  TH1F* oneDHistBestFit[2][maxFiles];
  TH1F* oneDHistOneSigma[2][maxFiles];
  TH1F* oneDHistTwoSigma[2][maxFiles];

  //==================================================================
  // now loop over the files and select the relevant observable
  double mintree = 1000000.;
  double maxtree = -1000000.;

  for (int iFile = 0; iFile < nFiles; iFile++) {

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
    
    int neut1Position = -1;
    int stau1Position = -1;
    
    
    // bind the parameters and observables
    int iChi2 = -1;
    for (int iLeaf = 0; iLeaf < nLeaves[0]; iLeaf++) {
      TLeafD* leaf = (TLeafD*)tree[iFile]->GetListOfLeaves()->At(iLeaf);
      leaf->SetAddress(&par[iLeaf]);
      parNames.push_back(leaf->GetName());
      if (!strcmp("chi2",leaf->GetName())) {
	iChi2 = iLeaf;
      }
      if (!strncmp("O_massNeutralino1",leaf->GetName(),17)) {
	neut1Position = iLeaf;
      }
      if (!strncmp("O_massStau1",leaf->GetName(),11)) {
	stau1Position = iLeaf;
      }
    }
    if (iChi2<0) return;
    
    if (requireNeut1LSP) {
      if ( neut1Position == -1 || stau1Position == -1) {
	cout << "stau1 or neutralino1 not found" << neut1Position << " " << stau1Position << endl;
	return;
      }
    }


    //  nEntries = 10000;
    cout << "looping over " << nEntries[iFile] << " entries" << endl;
    
    // find the chi2 minimum
    float chi2 = 0.;
    double minChi2 = 100000000.;
    for (int i = 0; i < nEntries[iFile]; i++) {
      tree[iFile]->GetEntry(i);
      if (requireNeut1LSP) {
	if (par[stau1Position]<par[neut1Position]) {
	  continue;
	}
      }    
      if (par[iChi2]<minChi2) {
	minChi2 = par[iChi2];
      }
    }
    cout << "found minimal chi2 = " << minChi2 << endl;
    
    // find the 2sigma envelope
    vector<int> obsPosition(name.size());
    for (int iname = 0; iname < nameSize; iname++) {
      for (int iLeaf = 0; iLeaf < nLeaves[0]; iLeaf++) {
	if (!strncmp("O_mass",parNames[iLeaf].c_str(),6)) {
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
    
    for (int i = 0; i < nEntries[0]; i++) {
      tree[iFile]->GetEntry(i);
      if (requireNeut1LSP) {
	if (par[stau1Position]<par[neut1Position]) {
	  continue;
	}
      }
      if (par[iChi2]-minChi2<4.01) {
	for (int iname = 0; iname < nameSize; iname++) {
	  if (name[iname]==variableName) {
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
    }
  }  

  
  double min = mintree - 0.05 * (maxtree - mintree);
  double max = maxtree + 0.05 * (maxtree - mintree);
  if (min < minHist) min = minHist;
  if (max > maxHist) max = maxHist;
  //  min = minHist;
  //  max = maxHist;
  cout << "found envelope " << min << " " << max << endl;

  for (int iFile = 0; iFile < nFiles; iFile++) {

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
    
    int neut1Position = -1;
    int stau1Position = -1;
    
    
    // bind the parameters and observables
    int iChi2 = -1;
    for (int iLeaf = 0; iLeaf < nLeaves[0]; iLeaf++) {
      TLeafD* leaf = (TLeafD*)tree[iFile]->GetListOfLeaves()->At(iLeaf);
      leaf->SetAddress(&par[iLeaf]);
      parNames.push_back(leaf->GetName());
      if (!strcmp("chi2",leaf->GetName())) {
	iChi2 = iLeaf;
      }
      if (!strncmp("O_massNeutralino1",leaf->GetName(),17)) {
	neut1Position = iLeaf;
      }
      if (!strncmp("O_massStau1",leaf->GetName(),11)) {
	stau1Position = iLeaf;
      }
    }
    if (iChi2<0) return;
    
    if (requireNeut1LSP) {
      if ( neut1Position == -1 || stau1Position == -1) {
	cout << "stau1 or neutralino1 not found" << neut1Position << " " << stau1Position << endl;
	return;
      }
    }


    //  nEntries = 10000;
    cout << "looping over " << nEntries[iFile] << " entries" << endl;
    
    // find the chi2 minimum
    float chi2 = 0.;
    double minChi2 = 100000000.;
    for (int i = 0; i < nEntries[iFile]; i++) {
      tree[iFile]->GetEntry(i);
      if (requireNeut1LSP) {
	if (par[stau1Position]<par[neut1Position]) {
	  continue;
	}
      }    
      if (par[iChi2]<minChi2) {
	minChi2 = par[iChi2];
      }
    }
    cout << "found minimal chi2 = " << minChi2 << endl;
 
   vector<int> obsPosition(name.size());
    for (int iname = 0; iname < nameSize; iname++) {
      for (int iLeaf = 0; iLeaf < nLeaves[0]; iLeaf++) {
	if (!strncmp("O_mass",parNames[iLeaf].c_str(),6)) {
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
     
    for (int iname = 0; iname < nameSize; iname++) {
      if (name[iname]==variableName) {
	overflow.push_back(0.);
	string histNameBestFit = "bestFit_" + binName[iname] + filename[iFile];
	oneDHistBestFit[0][iFile] = new TH1F(histNameBestFit.c_str(),"",nbins,min,max);
	string histNameOneSigma = "oneSigma_" + binName[iname] + filename[iFile];
	oneDHistOneSigma[0][iFile] = new TH1F(histNameOneSigma.c_str(),"",nbins,min,max);
	string histNameTwoSigma = "twoSigma_" + binName[iname] + filename[iFile];
	oneDHistTwoSigma[0][iFile] = new TH1F(histNameTwoSigma.c_str(),"",nbins,min,max);
      }
    }
    
    // fill the oneD histos
    for (int i = 0; i < nEntries[iFile]; i++) {
      tree[iFile]->GetEntry(i);
      if (requireNeut1LSP) {
	if (par[stau1Position]<par[neut1Position]) {
	  continue;
	}
      }
      if (par[iChi2]-minChi2<=4.0) {
	for (int iname = 0; iname < nameSize; iname++) {
	  if (name[iname]==variableName) {
	    if (par[obsPosition[iname]]>max && par[obsPosition[iname]]>overflow[iname]) overflow[iname]=par[obsPosition[iname]];
	    oneDHistTwoSigma[0][iFile]->Fill(TMath::Abs(par[obsPosition[iname]]));
	  }
	}
      }
      if (par[iChi2]-minChi2<=1.0) {
	  for (int iname = 0; iname < nameSize; iname++) {
	    if (name[iname]==variableName) {
	    oneDHistOneSigma[0][iFile]->Fill(TMath::Abs(par[obsPosition[iname]]));
	  }
	}
      }
      if (par[iChi2]==minChi2) {
	for (int iname = 0; iname < nameSize; iname++) {
	  if (name[iname]==variableName) {
	    oneDHistBestFit[0][iFile]->Fill(TMath::Abs(par[obsPosition[iname]]));
	  }
	}
      }
    }  
    
    // flatten the histograms
    for (int iname = 0; iname < nameSize; iname++) {
      for (int iBin = 0; iBin < nbins; iBin++) {
	if (oneDHistTwoSigma[0][iFile]->GetBinContent(iBin+1)>0.) {
	  oneDHistTwoSigma[0][iFile]->SetBinContent(iBin+1,2.);
	} else {
	  oneDHistTwoSigma[0][iFile]->SetBinContent(iBin+1,0.);
	}
	if (oneDHistOneSigma[0][iFile]->GetBinContent(iBin+1)>0.) {
	  oneDHistOneSigma[0][iFile]->SetBinContent(iBin+1,4.);
	} else {
	  oneDHistOneSigma[0][iFile]->SetBinContent(iBin+1,0.);
	}
	if (oneDHistBestFit[0][iFile]->GetBinContent(iBin+1)>0.) {
	  oneDHistBestFit[0][iFile]->SetBinContent(iBin+1,5.);
	} else {
	  oneDHistBestFit[0][iFile]->SetBinContent(iBin+1,0.);
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
	  if (oneDHistBestFit[0][iFile]->GetBinContent(iBin+1)>0.) {
	    bestFitBin = iBin;
	    break;
	  }
	}
	for (int iBin = 0; iBin < nbins; iBin++) {
	  if (oneDHistTwoSigma[0][iFile]->GetBinContent(iBin+1)>0.) {
	    if (lowest2sBin==100000) {
	      lowest2sBin = iBin;
	    }
	  }
	  if (oneDHistTwoSigma[0][iFile]->GetBinContent(iBin+1)>0.) {
	    highest2sBin = iBin;
	  }
	}
	// check for overflow
	if (overflow[iname]>max) {
	  cout << "variable " << name[iname] << " has upper 2s boundary outside histogram range" << endl;
	  // calculate virtual bin of the overflow
	  int iOverflowBin = (int)((overflow[iname]-min)/((max-min)/(double)nbins));
	  cout << "virtual upper 2s bin is at " << iOverflowBin << endl;
	  cout << "previous highest2sBin = " << highest2sBin << endl;
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
	    oneDHistOneSigma[0][iFile]->SetBinContent(iBin+1,0.);
	  } else if (iBin>=lowest1sBin && iBin<=highest1sBin) {
	    oneDHistOneSigma[0][iFile]->SetBinContent(iBin+1,4.);
	  } else {
	    oneDHistOneSigma[0][iFile]->SetBinContent(iBin+1,0.);
	  }
	  if (iBin<lowest2sBin) {
	    oneDHistTwoSigma[0][iFile]->SetBinContent(iBin+1,0.);
	  } else if (iBin>=lowest2sBin && iBin<=highest2sBin) {
	    oneDHistTwoSigma[0][iFile]->SetBinContent(iBin+1,2.);
	  } else {
	    oneDHistTwoSigma[0][iFile]->SetBinContent(iBin+1,0.);
	  }
	}
      }
    }
    
    // plot the histograms for debug reasons
    for (int iname = 0; iname < nameSize; iname++) {
      oneDHistBestFit[0][iFile]->SetLineColor(kRed);
      oneDHistOneSigma[0][iFile]->SetLineColor(kBlue);
      oneDHistTwoSigma[0][iFile]->SetLineColor(kBlue+3);
      oneDHistBestFit[0][iFile]->Draw();    
      oneDHistTwoSigma[0][iFile]->Draw("same");
      oneDHistOneSigma[0][iFile]->Draw("same");
      oneDHistBestFit[0][iFile]->Draw("same");
      string debugFile = "oneDHists_" + name[iname] + ".eps";
      canvas->Print(debugFile.c_str());
    }  
    
  }


  //========================================================================
  // after looping over the files, make one plot

  // fill the 2D histo
  string histTitle = predicted + " Mass Spectrum of SUSY Particles " + tag; 
  TH2D* massHistAll = new TH2D("massHistAll", histTitle.c_str(),
			       nFiles,
			       0.,(double)nFiles,
			       nbins,
			       min,max);

  string thisvarname;
  for (int iname=0; iname<name.size(); iname++) {
    if (name[iname]==variableName) {
      thisvarname = binName[iname];
    }
  }

  string yAxisTitle = "predicted range for m_{" + thisvarname + "} [GeV]";
  massHistAll->SetYTitle(yAxisTitle.c_str());
  massHistAll->GetYaxis()->SetLabelSize(0.05);
  massHistAll->GetYaxis()->CenterTitle();
  massHistAll->GetYaxis()->SetTitleSize(0.05);
  massHistAll->GetYaxis()->SetTitleOffset(1.3);
  
  TAxis* theXAxisAll = massHistAll->GetXaxis();
  theXAxisAll->SetLabelSize(0.07);
  theXAxisAll->SetLabelOffset(0.01);
  for (int i = 1; i <= nFiles; i++) {
    theXAxisAll->SetBinLabel(i,filetag[i-1].c_str());
  }  

  massHistAll->SetMinimum(0.);
  massHistAll->SetMaximum(7.);

  // make the best fit line a bit thicker
  if (nbins>300) {
    for (int iFile = 0; iFile < nFiles; iFile++) {
      for (int iBin = 0; iBin < nbins; iBin++) {
	if (oneDHistBestFit[0][iFile]->GetBinContent(iBin+1)>0.) {
	  oneDHistBestFit[0][iFile]->SetBinContent(iBin,oneDHistBestFit[0][iFile]->GetBinContent(iBin+1));
	  oneDHistBestFit[0][iFile]->SetBinContent(iBin+2,oneDHistBestFit[0][iFile]->GetBinContent(iBin+1));
	  oneDHistBestFit[0][iFile]->SetBinContent(iBin-1,oneDHistBestFit[0][iFile]->GetBinContent(iBin+1));
	  oneDHistBestFit[0][iFile]->SetBinContent(iBin+3,oneDHistBestFit[0][iFile]->GetBinContent(iBin+1));
	  break;
	}
      }
    }  
  }

  // fill the oneD histos into the 2D histo
  for (int iFile = 0; iFile < nFiles; iFile++) {
    for (int iBin = 0; iBin < nbins; iBin++) {
      if (oneDHistTwoSigma[0][iFile]->GetBinContent(iBin+1)>0.) {
	massHistAll->SetBinContent(iFile+1,iBin+1,oneDHistTwoSigma[0][iFile]->GetBinContent(iBin+1));
      }
      if (oneDHistOneSigma[0][iFile]->GetBinContent(iBin+1)>0.) {
	massHistAll->SetBinContent(iFile+1,iBin+1,oneDHistOneSigma[0][iFile]->GetBinContent(iBin+1));
      }
      if (oneDHistBestFit[0][iFile]->GetBinContent(iBin+1)>0.) {
	massHistAll->SetBinContent(iFile+1,iBin+1,oneDHistBestFit[0][iFile]->GetBinContent(iBin+1));
      }
    }    
  }  
  massHistAll->Draw("col");

  // add a legend
  TLegend *legend = new TLegend(0.33,0.55,0.6,0.72,"");
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
