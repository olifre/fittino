#include "TStyle.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TColor.h"
#include "TF1.h"
#include "TCanvas.h"
#include <string>
#include <vector>
using namespace std;

void MakeMassDistPlot (const char* filename = "PullDistributions.sum.root",
		       const double minHist = 0.,
		       const double maxHist = 100000000.,
		       const int nbins = 250,
		       const int minEvents = 5,
		       const char* treename = "tree" ) {

  // set style
  gStyle->SetPalette(1);
  gStyle->SetOptStat(0);
  gStyle->SetFrameFillColor(10);
  gStyle->SetPadColor(10);
  gStyle->SetCanvasColor(18);
  TCanvas* canvas = new TCanvas();
  canvas->SetBorderMode(0);
  canvas->SetTopMargin(0.08);
  canvas->SetBottomMargin(0.12);
  canvas->SetLeftMargin(0.15);
  canvas->SetRightMargin(0.05);

  // set color scheme
  const Int_t NRGBs = 5;
  const Int_t NCont = 255;  
  Double_t stops[NRGBs] = { 0.00, 0.34, 0.61, 0.84, 1.00 };
  Double_t red[NRGBs]   = { 0.00, 0.00, 0.87, 1.00, 0.51 };
  Double_t green[NRGBs] = { 0.00, 0.81, 1.00, 0.20, 0.00 };
  Double_t blue[NRGBs]  = { 0.51, 1.00, 0.12, 0.00, 0.00 };
  TColor::CreateGradientColorTable(NRGBs, stops, red, green, blue, NCont);
  gStyle->SetNumberContours(NCont);
  
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

  name.push_back ("SelectronL");
  name.push_back ("SelectronR");
  //  name.push_back ("SmuL");
  //  name.push_back ("SmuR");
  name.push_back ("Stau1");
  name.push_back ("Stau2");

  //  name.push_back ("SdownL");
  //  name.push_back ("SdownR");
  name.push_back ("SupL");
  name.push_back ("SupR");
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
  binName.push_back ("#tilde{l}_{L}");
  binName.push_back ("#tilde{l}_{R}");
  binName.push_back ("#tilde{#tau}_{1}");
  binName.push_back ("#tilde{#tau}_{2}");
  binName.push_back ("#tilde{q}_{L}");
  binName.push_back ("#tilde{q}_{R}");
  binName.push_back ("#tilde{b}_{1}");
  binName.push_back ("#tilde{b}_{2}");
  binName.push_back ("#tilde{t}_{1}");
  binName.push_back ("#tilde{t}_{2}");
  binName.push_back ("#tilde{g}");

  const int nameSize = name.size();

  bool nofitFound[nameSize];
  bool alreadyFound[nameSize];
  int leafPosition[nameSize];
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
	  cout << "after check found " << name[iname] << " " << leaf->GetName() << " " << thisMin << " " << thisMax << endl;
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

  // now loop over the leaves again and get the histograms
  for (int iname = 0; iname < nameSize; iname++) {
    if (alreadyFound[iname]) {
      const TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(leafPosition[iname]);
      leaf->SetAddress(&par[leafPosition[iname]]);
      cout << "looping over events of " << name[iname] << endl;
      for (Int_t i=0; i<nEntries; i++) {
	tree->GetEntry(i);
	double mass = 0.;
	if (par[leafPosition[iname]]>0) mass = par[leafPosition[iname]];
	else mass = -par[leafPosition[iname]];
	massHistBeforeCleanup->Fill((double)iname,mass);
      }
    } else {
      if (name[iname]=="H0" || name[iname]=="Hplus") {
	for (int jname = 0; jname < nameSize; jname++) {
	  if (alreadyFound[jname]) {
	    if (name[jname]=="A0") {
	      const TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(leafPosition[jname]);
	      leaf->SetAddress(&par[leafPosition[jname]]);
	      cout << "looping over events of " << name[iname] << endl;
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
	      }	      
	    }
	  }
	}
      }
    }
  }

  TH2D* massHist = new TH2D("massHist","Predicted Mass Spectrum of SUSY Particles",
			    nameSize,
			    0.,(double)nameSize,
			    nbins,
			    min,max);

  massHist->SetYTitle("Predicted Particle Mass [GeV]");
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
  

  for (int i = 1; i <= nameSize; i++) {
    for (int j = 1; j <= nbins; j++) {
      if (massHistBeforeCleanup->GetBinContent(i,j)>=minEvents) {
	massHist->SetBinContent(i,j,massHistBeforeCleanup->GetBinContent(i,j));
      }
    }
  }

  canvas->SetLogz(1);
  massHist->Draw("col");

  canvas->Print("predictedSUSYMassSpectrum.eps");

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
