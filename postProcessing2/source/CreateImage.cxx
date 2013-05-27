#include "TFile.h"
#include "TTree.h"
#include "TH2F.h"
#include "Chi2CalculatorDataBase2013.h"

int main(int argc, char** argv){

  std::string inFileName = argv[1];
  std::string imageFileName = argv[2];
  std::string obsSet = argv[3];
  std::string HS = argv[4];

  std::cout<<"HS obsset "<<HS<<std::endl;
  
  float P_M0H;
  float P_M0Hu;
  float P_M0Hd;
  float P_A0;
  float P_M0;
  float P_M12;
  float P_TanBeta;
  float P_massTop;
  float chi2;


  Int_t numberOfBins = 500;

//   double XXMINCHI2=46;
//   double XXMAXCHI2=55;

  
  


    Chi2CalculatorDataBase2013 db;
    Chi2Calculator calc = db.GetChi2Calculator(obsSet, HS);
    Double_t chi2Max = calc.GetMaxChi2();

  double XXMINCHI2=0;
  double XXMAXCHI2=chi2Max;


  TFile* outputFile = new TFile(imageFileName.c_str(), "RECREATE");


  TH2F* histChi2VsA0  = new TH2F("Chi2VsA0",      "#chi^{2} vs A_{0}",     numberOfBins, -10000, 10000, numberOfBins, XXMINCHI2, XXMAXCHI2);
   histChi2VsA0->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsA0->GetXaxis()->SetTitle("A_{0} [GeV]");
   histChi2VsA0->GetXaxis()->SetNdivisions(506);

   TH2F* histChi2VsM0 = new TH2F("Chi2VsM0",      "#chi^{2} vs M_{0}",     numberOfBins,     0,  10000, numberOfBins, XXMINCHI2, XXMAXCHI2);
   histChi2VsM0->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsM0->GetXaxis()->SetTitle("M_{0} [GeV]");
   histChi2VsM0->GetXaxis()->SetNdivisions(506);

   TH2F* histChi2VsM12  = new TH2F("Chi2VsM12",     "#chi^{2} vs M_{1/2}",   numberOfBins,    0,  10000, numberOfBins, XXMINCHI2, XXMAXCHI2);
   histChi2VsM12->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsM12->GetXaxis()->SetTitle("M_{1/2} [GeV]");

   //   TH2F* histChi2VsTanBeta  = new TH2F("Chi2VsTanBeta", "#chi^{2} vs tan#beta",  numberOfBins,     0, 65, numberOfBins, XXMINCHI2, XXMAXCHI2);
   TH2F* histChi2VsTanBeta  = new TH2F("Chi2VsTanBeta", "#chi^{2} vs tan#beta",  numberOfBins,     0, 100, numberOfBins, XXMINCHI2, XXMAXCHI2);
   histChi2VsTanBeta->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsTanBeta->GetXaxis()->SetTitle("tan#beta");

   //   TH2F* histChi2VsMassTop = new TH2F("Chi2VsMassTop", "#chi^{2} vs m_{t}",     numberOfBins,    165, 180, numberOfBins, XXMINCHI2, XXMAXCHI2);
   TH2F* histChi2VsMassTop = new TH2F("Chi2VsMassTop", "#chi^{2} vs m_{t}",     numberOfBins,    100, 300, numberOfBins, XXMINCHI2, XXMAXCHI2);
   histChi2VsMassTop->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsMassTop->GetXaxis()->SetTitle("m_{t} [GeV]");

   TH2F* histChi2VsM0H =  new TH2F("Chi2VsM0H", "#chi^{2} vs M_{0H}",         numberOfBins,   -1.e7,   1.e7, numberOfBins, XXMINCHI2, XXMAXCHI2);
   histChi2VsM0H->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsM0H->GetXaxis()->SetTitle("M_{0H} [GeV]");
   histChi2VsM0H->GetXaxis()->SetNdivisions(506);

   TH2F* histChi2VsM0Hu = new TH2F("Chi2VsM0Hu", "#chi^{2} vs M_{0Hu}", numberOfBins, -1.e7, 1.e7, numberOfBins, XXMINCHI2, XXMAXCHI2);
   histChi2VsM0Hu->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsM0Hu->GetXaxis()->SetTitle("M_{0Hu} [GeV]");
   histChi2VsM0Hu->GetXaxis()->SetNdivisions(506);

   TH2F* histChi2VsM0Hd = new TH2F("Chi2VsM0Hd", "#chi^{2} vs M_{0Hd}", numberOfBins, -1.e7, 1.e7, numberOfBins, XXMINCHI2, XXMAXCHI2);
   histChi2VsM0Hd->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsM0Hd->GetXaxis()->SetTitle("M_{0Hd} [GeV]");
   histChi2VsM0Hd->GetXaxis()->SetNdivisions(506);

   
   TFile* inFile = TFile::Open(inFileName.c_str(), "READ");
   TTree* tree = (TTree*) inFile->Get("markovChain");
   tree->SetBranchStatus("*", 0);
   tree->SetBranchStatus("P_M0H", 1);
   tree->SetBranchStatus("P_M0Hu", 1);
   tree->SetBranchStatus("P_M0Hd", 1);
   tree->SetBranchStatus("P_A0", 1);
   tree->SetBranchStatus("P_M0", 1);
   tree->SetBranchStatus("P_M12", 1);
   tree->SetBranchStatus("P_TanBeta", 1);
   tree->SetBranchStatus("P_massTop", 1);
   tree->SetBranchStatus("chi2", 1);

   tree->SetBranchAddress("P_M0H", &P_M0H);
   tree->SetBranchAddress("P_M0Hu", &P_M0Hu);
   tree->SetBranchAddress("P_M0Hd", &P_M0Hd);
   tree->SetBranchAddress("P_A0", &P_A0);
   tree->SetBranchAddress("P_M0", &P_M0);
   tree->SetBranchAddress("P_M12", &P_M12);
   tree->SetBranchAddress("P_TanBeta", &P_TanBeta);
   tree->SetBranchAddress("P_massTop", &P_massTop);
   tree->SetBranchAddress("chi2", &chi2);

   unsigned int nEntries = tree->GetEntries();

   outputFile->cd();

   for ( unsigned int i=0; i<nEntries; i++ ){

     tree->GetEntry(i);

     if ( chi2 >= XXMINCHI2  ){
       histChi2VsM0H->Fill(P_M0H, chi2);
       histChi2VsM0Hu->Fill(P_M0Hu, chi2);
       histChi2VsM0Hd->Fill(P_M0Hd, chi2);
       histChi2VsA0->Fill(P_A0, chi2);
       histChi2VsM0->Fill(P_M0, chi2);
       histChi2VsM12->Fill(P_M12, chi2);
       histChi2VsTanBeta->Fill(P_TanBeta, chi2);
       histChi2VsMassTop->Fill(P_massTop, chi2);
     }
   

     
   }

     histChi2VsA0->Write();
     histChi2VsM0->Write();
     histChi2VsM12->Write();
     histChi2VsTanBeta->Write();
     histChi2VsMassTop->Write();
     histChi2VsM0H->Write();
     histChi2VsM0Hu->Write();
     histChi2VsM0Hd->Write();


   outputFile->Close();
   inFile->Close();
   

}
   
