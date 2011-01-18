#include "TStyle.h"
#include "TROOT.h"
#include "TFile.h"
#include "TDirectory.h"
#include "TChain.h"
#include "TCanvas.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TGraphErrors.h"
#include "TList.h"
#include "TLine.h"
#include "TMath.h"
#include "TObjArray.h"
#include "iostream"
#include "fstream"
#include "sstream"
#include "string"
#include "vector"
#include "TTree.h"
#include "TImage.h"
#include "TColor.h"
#include "TMarker.h"
#include "TPaletteAxis.h"
#include "TVectorT.h"
#include "TPaveStats.h"
#include "THStack.h"

using namespace std;

void PlotBugMassDifferences(){

  bool zoom=true; //if true the Bug Points determine the range of the x-axis
  
  TFile *file = new TFile("../../SkimmedFile.root", "READ");
  TTree* tree=(TTree*)file->Get("markovChain");
    
  const int nLeaves = tree->GetListOfLeaves()->GetEntries();  
  vector<string> observables;
  
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
    
    string leafname=tree->GetListOfLeaves()->At(iLeaf)->GetName();

    if (strncmp(leafname.c_str(), "O_mass",6) &&  strncmp(leafname.c_str(), "O_mass",6)) continue;  
              observables.push_back(leafname);
  }


  //  observables.push_back("O_massNeutralino1_nofit");
  //observables.push_back("O_massNeutralino2_nofit");

  for (int i=0; i<observables.size();i++){

    for (int j=0;j<i;j++){

      string observable1=observables[i];
      string observable2=observables[j];
      
      TCanvas * canvas = new TCanvas("canvas","canvas",900,600);
      canvas->cd();

      // if you want a scatter plot in addition...
//       tree->SetMarkerColor(kRed);
//       tree->Draw((observable1+":"+observable2).c_str());
//       tree->SetMarkerColor(kBlue);
//       tree->Draw((observable1+":"+observable2).c_str(),"bug==1", "same");
//       gPad->RedrawAxis();
//       canvas->SaveAs((observable1+"_vs_"+observable2+".png").c_str());


      canvas->SetLogy();

      string plotcommand=observable1+"-"+observable2;

      string cutcommand;
      if (zoom) cutcommand="bug==1";
      else cutcommand="";
      cout<<cutcommand<<endl;      
      tree->Draw((plotcommand+">>"+observable1+"_"+observable2).c_str(), cutcommand.c_str());
      
      TH1F *First = (TH1F*)gDirectory->Get((observable1+"_"+observable2).c_str()); 
      
      int nbins=First->GetNbinsX();
      double low=First->GetXaxis()->GetXmin();
      double high=First->GetXaxis()->GetXmax();

      TH1F *NoBug = new TH1F("NoBug", "", nbins, low,high); 
      tree->Draw((plotcommand+">>NoBug").c_str(), "bug==0 ");

      TH1F *Bug;
      TH1F *AllTogether;

      if(zoom){
	Bug=(TH1F*)First->Clone("Bug");
	AllTogether=new TH1F("AllTogether", "", nbins, low,high); 
	tree->Draw((plotcommand+">>AllTogether").c_str());
      }
      else{
	Bug = new TH1F("Bug", "", nbins, low,high); 
	tree->Draw((plotcommand+">>Bug").c_str(), "bug==1");
	AllTogether=(TH1F*)First->Clone("AllTogether");
      }

      double ymax=AllTogether->GetBinContent(AllTogether->GetMaximumBin());
      double ymin=ymax;

      for (int i=0; i<Bug->GetNbinsX();i++){
	if (Bug->GetBinContent(i)!=0 && Bug->GetBinContent(i)<ymin) ymin=Bug->GetBinContent(i);
      }
      
      for (int i=0; i<NoBug->GetNbinsX();i++){
	if (NoBug->GetBinContent(i)!=0 && NoBug->GetBinContent(i)<ymin) ymin=NoBug->GetBinContent(i);
      }

      TH2D* PlotHisto=new TH2D("PlotHisto", "",2,low,high,2,0.2*ymin,1.8*ymax);    
      PlotHisto->GetXaxis()->SetTitle(plotcommand.c_str());
      PlotHisto->GetXaxis()->SetTitleSize(0.03);
      PlotHisto->GetXaxis()->SetTitleOffset(1.2);
      PlotHisto->SetStats(0);
      PlotHisto->Draw();

      Bug->SetStats(0);
      NoBug->SetStats(0);
      Bug->SetFillColor(kBlue);
      NoBug->SetFillColor(kRed);

      THStack stack("stack","");
      stack.Add(Bug);
      stack.Add(NoBug);
      stack.Draw("same");
      
      gPad->RedrawAxis();
      
      canvas->SaveAs((observable1+"_"+observable2+".pdf").c_str());

      delete First;
      delete Bug;
      delete NoBug;
      delete canvas;
      delete AllTogether;
      delete PlotHisto;
    }
  }
}







