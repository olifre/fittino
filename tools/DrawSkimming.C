#include "TStyle.h"
#include "TROOT.h"
#include "TLegend.h"
#include "TFile.h"
#include "TMath.h"
#include "TDirectory.h"
#include "TChain.h"
#include "TCanvas.h"
#include "TH1D.h"
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
#include "TCutG.h"
using namespace std;

void DrawSkimming(){

  TFile f("../Chi2SkimmedFile.root");
  TFile g("../ParameterSkimmedFile.root");
  TFile Cutfile("../../parameterCuts.root");
  TTree* markovChain=(TTree*) f.Get("markovChain");
  TTree* markovChain2=(TTree*) g.Get("markovChain");

  float minChi2=10000.;
  float chi2=10000.;
  markovChain2->SetBranchAddress("chi2", &chi2);
  Long64_t nentries=markovChain->GetEntries() ;
  for (Long64_t i=0;i<nentries;i++){
    markovChain2->GetEntry(i);
    if (chi2<minChi2) minChi2=chi2;
  }

  cout<<minChi2<<endl;
  double x[]={-10000,10000};
  double y1[]={minChi2,minChi2};
  TGraph* graph1=new TGraph(2,x,y1);
  graph1->SetLineColor(kRed);
  double y2[]={minChi2+1,minChi2+1};
  TGraph* graph2=new TGraph(2,x,y2);
  graph2->SetLineColor(kRed);

  double y3[]={minChi2+4,minChi2+4};
  TGraph* graph3=new TGraph(2,x,y3);
  graph3->SetLineColor(kRed);

  double y4[]={minChi2+6,minChi2+6};
  TGraph* graph4=new TGraph(2,x,y4);
  graph4->SetLineColor(kRed);

  
  vector<string> leafnames;
   leafnames.push_back("P_M0");
   leafnames.push_back("P_M12");
   leafnames.push_back("P_TanBeta");
   leafnames.push_back("P_A0");
   leafnames.push_back("O_massh0_nofit");
   leafnames.push_back("O_Massh0_npf");
   leafnames.push_back("O_massA0_nofit");
   leafnames.push_back("O_massH0_nofit");
  leafnames.push_back("O_massHplus_nofit");
  leafnames.push_back("O_massNeutralino1_nofit");
  leafnames.push_back("O_massNeutralino2_nofit");
  leafnames.push_back("O_massNeutralino3_nofit");
  leafnames.push_back("O_massNeutralino4_nofit");
  leafnames.push_back("O_massChargino1_nofit");
  leafnames.push_back("O_massChargino2_nofit");
  leafnames.push_back("O_massSelectronR_nofit");
  leafnames.push_back("O_massSelectronL_nofit");
  leafnames.push_back("O_massStau1_nofit");
  leafnames.push_back("O_massStau2_nofit");
  leafnames.push_back("O_massSupR_nofit");
  leafnames.push_back("O_massSupL_nofit");
  leafnames.push_back("O_massSbottom1_nofit");
  leafnames.push_back("O_massSbottom2_nofit");
  leafnames.push_back("O_massStop1_nofit");
  leafnames.push_back("O_massStop2_nofit");
  leafnames.push_back("O_massGluino_nofit");


  TCanvas* canvas;
  for (Int_t iLeaf=0; iLeaf<leafnames.size(); iLeaf++){


    string leafname=leafnames[iLeaf];
    canvas=new TCanvas(leafname.c_str(),leafname.c_str()); 
        canvas->SetBorderMode(0);
   canvas->SetFrameBorderMode(0);
    canvas->SetFillColor(kWhite);
    canvas->Divide(2,1);
    canvas->cd(1);

    int iContour = 0;
    markovChain->SetMarkerColor(kBlack);
    markovChain->SetMarkerStyle(1);
    markovChain->Draw(("chi2:"+leafname).c_str());
      while (1) {
	char contourNumber[256];
	sprintf(contourNumber,"%i",iContour);
	string contourName = "chi2_" 
	  + leafname + "_" 
	  + contourNumber ;

	TCutG* contour = (TCutG*)Cutfile.Get(contourName.c_str());
	if (!contour)  break;
	//	if (iContour==0) markovChain->Draw(("chi2:"+leafname).c_str());
	markovChain->SetMarkerColor(kRed);
	markovChain->SetMarkerStyle(20);
	markovChain->SetMarkerSize(0.37);
	markovChain->Draw(("chi2:"+leafname).c_str(),contourName.c_str(), "same");
	iContour++;
  }
      

      canvas->cd(2);


      markovChain2->Draw(("chi2:"+leafname).c_str());
      graph1->Draw("same L");
      graph2->Draw("same L");
      graph3->Draw("same L");
      graph4->Draw("same L");
      canvas->cd(0);
      gPad->Update();
      canvas->SaveAs(("skim_"+leafname+".png").c_str());
  }

}
