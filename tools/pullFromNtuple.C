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
#include "TString.h"
#include "TLegend.h"
#include "TLine.h"
#include "TLatex.h"
#include "TGaxis.h"
#include "TMath.h"
#include <string>
#include <vector>
#include <map>
#include <cmath>
#include <sstream>
using namespace std;

string f2s(float number, string format ){

  char buffer[20];
  sprintf(buffer,  ("%"+format).c_str(), number);
  return string(buffer);
    
}



class Observable{

public:

  Observable(){
  }

  Observable(string title, double exp, double expUnc, double theoUnc, string format, string branch,  string chi2Type="",string chi2Branch=""){
    
    _title=title;
    _exp=exp;
    _expUnc=expUnc;
    _theoUnc=theoUnc;
    _branch=branch;
    _chi2Type=chi2Type;
    _chi2Branch=chi2Branch;
    _theo=new float(666);
    _chi2=new float(666);
    _format=format;
    _unc2=_theoUnc*_theoUnc+_expUnc*_expUnc;

  }

  void SetTree(TTree* tree){

    _tree=tree;
    if (_branch!="")
      _tree->SetBranchAddress(_branch.c_str(), _theo);
    if (_chi2Type=="branch"){
      _tree->SetBranchAddress(_chi2Branch.c_str(), _chi2);
    }
    
  }

  string GetFormat(){
    
    return _format;    

  }
  float GetPull(){
    return _pull;
  }

  string GetTitle(){
    return _title;
  }


  string PrintTheo(){

    if (_branch==""){
      return "";
    }
    else {
      return f2s(*_theo,_format);
    }
    
  }

  string PrintValUnc(){


    if (_exp==0 && _expUnc==0 && _theoUnc==0)
      return "";
    else if (_theoUnc==0)
      return f2s(_exp,_format)+" #pm "+f2s(_expUnc, _format);
    else 
      return f2s(_exp,_format)+" #pm "+f2s(_expUnc, _format)+ " #pm "+f2s(_theoUnc, _format);
	
  }


  void Update(){

    if (_chi2Type=="" || (_chi2Type=="UL" && *_theo>_exp ) || (_chi2Type=="LL" && *_theo<_exp)){
      *_chi2=(*_theo-_exp)*(*_theo-_exp)/_unc2;
    }

    else if ((_chi2Type=="UL" && *_theo<_exp) || (_chi2Type=="LL" && *_theo>_exp) ){
      *_chi2=0;
    }
    
    _pull=TMath::Sqrt(*_chi2);


  }



  //private:

  TTree*  _tree;
  string  _title;
  float   _exp;
  float   _expUnc;
  float   _theoUnc;
  string  _branch;
  string  _chi2Type;
  string  _chi2Branch;
  float*   _theo;
  float*   _chi2;
  float   _unc2;
  float   _pull;
  string _format;
};

class Pull{

public:

  Pull(string file, string logo=""){

    TFile* f=new  TFile(file.c_str());
    _tree=(TTree*) f->Get("markovChain");
    _logo=logo;
    
  }

  void Add(Observable observable){
    
    observable.SetTree(_tree);
    _observables.push_back(observable);
    
  }

  void SetHistTitle(string title){
    _histTitle=title;
  }

  void SaveAs(string file){

    int nEntries=_tree->GetEntriesFast();
    float chi2;
    float minChi2=1e10;
    int minIndex=-1;
    _tree->SetBranchAddress("chi2", &chi2);
  
    for (int i=0;i<nEntries;i++){
      _tree->GetEntry(i);
      if (chi2<minChi2){
	minIndex=i;
	minChi2=chi2;
      }
    }

    _tree->GetEntry(minIndex);

    cout<<"Using minChi2="<<chi2<<endl;

    float totalchi2=0;

    for (int i=0; i<_observables.size(); i++){
            _observables[i].Update();
	    totalchi2+=TMath::Power(_observables[i].GetPull(),2);
    }
    
    cout<<"DIFFERENCE between chi2s: "<<minChi2<<" - "<<totalchi2<<" = "<<minChi2-totalchi2<<endl;
    


    TH1D* residualHist = new TH1D("residualHist",_histTitle.c_str(),_observables.size(),0,(int)_observables.size());
    for (UInt_t i = 0; i<_observables.size(); i++) {
      residualHist->SetBinContent(_observables.size()-i,_observables[i].GetPull());
      residualHist->GetXaxis()->SetBinLabel(i+1," ");
    }
    residualHist->SetMaximum(3.5);
    residualHist->SetMinimum(0.);
    residualHist->SetFillColor(kBlue-2);
    residualHist->SetLineColor(kBlue+2);
    residualHist->GetYaxis()->SetTitle("|Meas.-Fit|/ #sigma");
    residualHist->GetYaxis()->SetTitleOffset(0.8);
    residualHist->GetYaxis()->SetLabelOffset(0.0);
    residualHist->GetYaxis()->CenterTitle();
    residualHist->GetYaxis()->SetNdivisions(5);


    gStyle->SetOptStat(0);
    gStyle->SetOptFit(0);
    gStyle->SetCanvasColor(0);
  
    TCanvas* c = new TCanvas();
    gStyle->SetHistMinimumZero(1);
    c->SetBorderMode(0);
    c->SetTopMargin(0.12);
    c->SetBottomMargin(0.07);
    c->SetLeftMargin(0.64);
    c->SetRightMargin(0.02);
    c->SetGrid(1);
    c->SetFrameBorderMode(0);  
    
    residualHist->Draw("hbar2");
    
    // Draw labels on the y axis
    TLatex *t = new TLatex();  
    // t->SetTextAlign(32);
    t->SetTextSize(0.030);
    // t->SetTextFont(72);
    for (UInt_t i=0;i<_observables.size();i++) {
      t->DrawLatex(-6.50,0.2+(double)_observables.size()-1-i,_observables[i].GetTitle().c_str());
	    t->DrawLatex(-5.00,0.2+(double)_observables.size()-1-i,_observables[i].PrintValUnc().c_str());
	    t->DrawLatex(-1.00,0.2+(double)_observables.size()-1-i,_observables[i].PrintTheo().c_str());

      //            t->DrawLatex(-5.70,0.2+(double)_observables.size()-1-i,_observables[i].GetTitle().c_str());
	    //	    t->DrawLatex(-4.00,0.2+(double)_observables.size()-1-i,_observables[i].PrintValUnc().c_str());
	    //	    t->DrawLatex(-1.50,0.2+(double)_observables.size()-1-i,_observables[i].PrintTheo().c_str());
    }

    // get the fittino logo
    TImage *fittinoLogo = 0;
    if (_logo!="") {
      fittinoLogo = TImage::Open(_logo.c_str());
    }
    // add the fittino logo
    if (fittinoLogo) {
      const float canvasHeight   = c->GetWindowHeight();
      const float canvasWidth    = c->GetWindowWidth();
      const float canvasAspectRatio = canvasHeight/canvasWidth;
      const float width          = 0.19;
      const float xLowerEdge     = 0.80;
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

    }
    c->cd();
    
    
    c->SaveAs(file.c_str());


 
  }


private:
  
  vector<Observable> _observables;
  TTree* _tree;
  string _logo;
  string _histTitle;
    
};


void pullFromNtuple(string file="", string logo=""){

  
//   logo="~/sarrazin/FittinoTrunk/logo/fittinologo.eps";
//   file="~/PP/final/fittino.out.markov.obs2009.smallSet.msugra.0fb.Mastercode.HB.NoAF.root";
//   file="~/PP/final/fittino.out.markov.obs2011.msugra.5fb.NoHB.AFXn.H126.root";
//   file="~/PP/final/fittino.out.markov.obs2011.nonunivverysimplified.5fb.NoHB.AFXn.H126.root";

  Pull thePull(file, logo);
  string fit;

  if (file.find("fittino.out.markov.obs2009.smallSet.msugra.0fb.Mastercode.HB.NoAF.root")!=string::npos){
    
    fit="obs2009.smallSet.msugra.0fb.Mastercode.NoHB.NoAF";

    thePull.Add(Observable("a_{#mu} - a_{#mu}^{SM} ", 30.2e-10, 8.8e-10, 2e-10, ".1e",  "O_gmin2m_npf"));
    
    thePull.Add(Observable("BR(b#rightarrow s#gamma)", 1.117, 0.076, 0.096, ".3f", "O_Bsg_npf" ));

    thePull.Add(Observable("BR(b#rightarrow #tau#nu)", 1.15, 0.4,0, ".2f", "O_Btn_npf"));

    thePull.Add(Observable( "BR(B_{s}#rightarrow #mu^{+}#mu^{-}) <", 4.7e-8, 0.02e-8, 0, ".1e", "O_B_smm_npf","UL"));

    thePull.Add(Observable( "#Delta m_{s}", 1.11, 0.01, 0.32, ".2f", "O_dm_s_npf"));
    
    thePull.Add(Observable( "sin^{2}#theta_{eff}^{l}", 0.2324, 0.0012, 0, ".4f", "O_sin_th_eff_npf"));

    thePull.Add(Observable( "m_{W} [GeV]", 80.398, 0.025, 0.010, ".3f", "O_MassW_npf" ));

    thePull.Add(Observable("m_{h} [GeV] <)", 114.4, 3,0, ".1f", "O_Massh0_npf", "LL"));

    thePull.Add(Observable("#Omega_{CDM}h^{2}",0.1099,0.0062,0.012,".4f","O_Omega_npf"));
    
  }


    
  

  else if (file.find("obs2011")!=string::npos){
    
    fit= file.substr(file.rfind("/")+20,file.rfind(".root")-file.rfind("/")-20);  
    cout<<fit<<endl;
    if (fit.find("NoGmin2")==string::npos)
      thePull.Add(Observable("a_{#mu} - a_{#mu}^{SM} ", 28.7e-10, 8e-10, 2e-10, ".1e",  "O_gmin2m_npf"));
    
    thePull.Add(Observable("BR(b#rightarrow s#gamma)", 3.55e-4, 0.26e-4, 0.23e-4, ".2e", "O_Bsg_npf" ));

    thePull.Add(Observable("BR(b#rightarrow #tau#nu)", 1.67e-4, 0.39e-4,0, ".2e", "O_Btn_npf"));

    thePull.Add(Observable( "BR(B_{s}#rightarrow #mu^{+}#mu^{-} <)", 1.6e-8, 0.02e-8, 0, ".1e", "O_B_smm_npf","UL"));

    thePull.Add(Observable( "#Delta m_{s}", 17.78, 0.12, 5.2, ".2f", "O_dm_s_npf"));
    
    thePull.Add(Observable( "sin^{2}#theta_{eff}^{l}", 0.23113, 0.00021, 0, ".5f", "O_sin_th_eff_npf"));

    thePull.Add(Observable( "m_{W} [GeV]", 80.399, 0.023, 0.010, ".3f", "O_MassW_npf" ));

    if (fit.find("msugratop")!=string::npos)
      thePull.Add(Observable( "m_{t} [GeV]", 173.20, 1.34, 0, ".2f", "O_massTop" ));

    if (fit.find(".HB")!=string::npos || fit.find(".HB1.5.")!=string::npos)
      thePull.Add(Observable("m_{h} [GeV]", 0,0,0, ".1f","O_Massh0_npf", "branch", "globalHiggsChi2" ));
    else if (fit.find(".H126")!=string::npos)
      thePull.Add(Observable("m_{h} [GeV])", 126, 2,3, ".1f", "O_Massh0_npf"));
    else{
      cout<<"higgs setting not yet implemented"<<endl;
      return;
    }

    if (fit.find(".0fb")==string::npos)
      thePull.Add(Observable("LHC", 0,0,0,"","","branch","LHC_Exp_chi2"));


    if (fit.find("NoOmega")==string::npos || fit.find("NoMicroMegas")==string::npos)     
      thePull.Add(Observable("#Omega_{CDM}h^{2}",0.1123,0.0035,0.0123,".4f","O_omega"));


    if (fit.find("NoAF")==string::npos && fit.find("SoftSUSY")==string::npos){
      thePull.Add(Observable("#sigma^{SI}",0,0,0, ".2e","af_direct","branch", "af_chi2_direct"));
      thePull.Add(Observable("Photon flux",0,0,0, ".2e","af_photon","branch", "af_chi2_photon"));
    }

  }

  thePull.SetHistTitle(fit);
  thePull.SaveAs(("pull_"+fit+".eps").c_str());
}
