#include "TStyle.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TColor.h"
#include "TF1.h"
#include "TCanvas.h"
#include <string>
#include <vector>
using namespace std;

void MakeMassDistPlot () {

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
