#include "FloatStorage.h"
#include "TH1D.h"
#include "TCanvas.h"
#include "TStyle.h"
#include "TLatex.h"
#include "TImage.h"
#include "TPad.h"
#include "Chi2CalculatorDataBase2013.h"
#include "TreeUtil.h"
#include "TMath.h"
#include <iostream>
#include <sstream>

int main( int arc, char* argv[]) {

  std::string HS="category";
  Chi2CalculatorDataBase2013 db;
  Chi2Calculator calc = db.GetChi2Calculator("allObs", HS);
  calc.RemoveObservable("O_massChargino1");

  std::string inFileName = argv[1];
  
  TFile inFile( inFileName.c_str(), "READ" );
  TTree* inTree = (TTree*) inFile.Get( "markovChain" );
  if (!inTree)   
    std::cout<<"Could not get input tree"<<std::endl;

  TTree* outTree = new TTree( inTree->GetName(), inTree->GetTitle() );

  FloatStorage data( outTree );

  FloatStorage dataout( outTree );

  data.Connect( inTree );
  calc.SetInput( &data );

  calc.SetOutput( &dataout );

  //    int index = GetMinimumIndex(inTree, "chi2");
    int index=0;

  //FIXME
  double minChi2=1e12;
  for (unsigned int i=0; i<inTree->GetEntries(); i++){
    
    if ( i%10000==0 ){

      std::cout<<"entry "<<i<<std::endl;

    }

    inTree->GetEntry(i);
    if (data.Get("chi2")<minChi2 && data.Get("P_M0")<100){
      std::cout<<"found point"<<std::endl;
      minChi2=data.Get("chi2");
      index=i;
      
    }
  }





  inTree->GetEntry(index);

  calc.Calculate();

  ostringstream title;
  title.setf(std::ios::fixed);
  title.precision(0);
//   title<<"CMSSM   ";
//   title<<"all Obs ";
//   title<<"#Delta m_{h}=3.0GeV   ";
  title<<"M_{0}=";
  title<<data.Get("P_M0");
  title<<"GeV, M_{1/2}=";
  title<<data.Get("P_M12");
  title<<"GeV, A_{0}=";
  title<<data.Get("P_A0");
//   title<<"GeV, M_{H}^{2}=";
//   title<<data.Get("P_M0H");
  // title<<"GeV^{2}, m_{t}=";
  title<<"GeV, m_{t}=";
  title<<data.Get("P_massTop");
  title<<"GeV, tan #beta=";
  title<<data.Get("P_TanBeta");
  
  std::string histTitle = title.str();
  

  
  

  std::vector<Observable>* observables = calc.GetObservables();
  std::vector<string> chi2Contributions = calc.GetChi2Contributions();

  std::cout<<"Number of chi2 contributions "<<chi2Contributions.size()<<std::endl;

  int totalobs= observables->size()+4; // HS mass + HS rate + LHC + AF

  gStyle->SetTitleAlign(23);
  TH1D* residualHist = new TH1D("residualHist",histTitle.c_str(),totalobs,0, totalobs);


  for (UInt_t i = 0; i<observables->size(); i++) {
    residualHist->SetBinContent(totalobs-i,TMath::Abs(observables->at(i).GetPull()));
    residualHist->GetXaxis()->SetBinLabel(i+1," ");
  }

  residualHist->SetBinContent(4, TMath::Sqrt(calc.GetAstroCalculator()->GetChi2()));
  residualHist->SetBinContent(3, TMath::Sqrt(calc.GetLHCCalculator()->GetChi2()));
  residualHist->SetBinContent(2, TMath::Sqrt(data.Get("HS_Chisq_mh"))/4.);
  residualHist->SetBinContent(1, TMath::Sqrt(data.Get("HS_Chisq_mu"))/45);

  std::cout<<calc.GetAstroCalculator()->GetChi2()<<std::endl;

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
    for (UInt_t i=0;i<observables->size();i++) {
      //      t->DrawLatex(-6.50,0.2+(double)observables->size()-1-i,observables->at(i).GetTitle().c_str());
      t->DrawLatex(-6.50,0.4+totalobs-1-i,observables->at(i).GetTitle().c_str());
      t->DrawLatex(-4.50,0.4+totalobs-1-i,observables->at(i).PrintValUnc().c_str());  
      t->DrawLatex(-1.00,0.2+totalobs-1-i,observables->at(i).PrintTheo().c_str());  

      //            t->DrawLatex(-5.70,0.2+(double)_observables.size()-1-i,_observables[i].GetTitle().c_str());
	    //	    t->DrawLatex(-4.00,0.2+(double)_observables.size()-1-i,_observables[i].PrintValUnc().c_str());
	    //	    t->DrawLatex(-1.50,0.2+(double)_observables.size()-1-i,_observables[i].PrintTheo().c_str());
    }


    double af_direct = data.Get("af_direct");
    ostringstream direct_os;
    direct_os.precision(2);

    direct_os<<af_direct;
    std::string direct_string=direct_os.str();

    double mh = data.Get("O_massh0");
    ostringstream mh_os;
    mh_os.setf(std::ios::fixed);
    mh_os.precision(1);
    mh_os<<mh;
    std::string mh_string=mh_os.str();


    t->DrawLatex(-1.00,0.2+3, direct_string.c_str());
    t->DrawLatex(-1.00,0.2+1, mh_string.c_str());

    t->DrawLatex(-6.50,0.4+(double)3,"#sigma^{SI} / pb");
    t->DrawLatex(-6.50,0.4+(double)2, "LHC");
    t->DrawLatex(-6.50,0.4+(double)1,"m_{h} / GeV");
    t->DrawLatex(-6.50,0.4+(double)0,"#mu_{h} ");

    // get the fittino logo
    TImage *fittinoLogo = 0;
    std::string logo;
    logo="../../logo/fittinologo_PREL.png"; 

    if (logo!="") {
      fittinoLogo = TImage::Open(logo.c_str());
    }
    // add the fittino logo
    if (fittinoLogo) {
      const float canvasHeight   = c->GetWindowHeight();
      const float canvasWidth    = c->GetWindowWidth();
      const float canvasAspectRatio = canvasHeight/canvasWidth;
      const float width          = 0.16;
      const float xLowerEdge     = 0.83;
      const float yLowerEdge     = 0.83;
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
    
    
    c->SaveAs("pull.png");
    c->SaveAs("pull.eps");

}


