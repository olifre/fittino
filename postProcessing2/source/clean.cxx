#include "TTree.h"
#include "TFile.h"
#include "TSpline.h"
#include "Chi2CalculatorDataBase2012.h"
#include "Chi2CalculatorDataBase2013.h"
#include <iostream>
#include <sstream>
#include <stdexcept>


int main(int argc, char **argv){

  

  std::string inFileName  = argv[1];
  std::string outFileName = argv[2];
  std::string splinesFileName = argv[3];
  std::string model = argv[4];

  if (model!="CMSSM" && model!="NUHM1" && model!="NUHM2"){

    throw std::runtime_error("Unknown model");

  }

    // "/scratch/hh/dust/naf/atlas/user/sarrazin/postProcessing/2/chi22/outputs/allObs/CMSSM_category_3.0.root";
  // std::string outFileName = "Cleaned.root";

  TFile* splinesFile=new TFile(splinesFileName.c_str(), "READ"  );

  TSpline3* A0 = (TSpline3*) splinesFile->Get("Chi2VsA0");
  TSpline3* M0 = (TSpline3*) splinesFile->Get("Chi2VsM0");
  TSpline3* M12 = (TSpline3*) splinesFile->Get("Chi2VsM12");
  TSpline3* TanBeta = (TSpline3*) splinesFile->Get("Chi2VsTanBeta");
  TSpline3* MassTop = (TSpline3*) splinesFile->Get("Chi2VsMassTop");

  TSpline3* M0H = (TSpline3*) splinesFile->Get("Chi2VsM0H");
  TSpline3* M0Hu = (TSpline3*) splinesFile->Get("Chi2VsM0Hu");
  TSpline3* M0Hd = (TSpline3*) splinesFile->Get("Chi2VsM0Hd");
  
  TFile inFile( inFileName.c_str(), "READ" );
  TTree* inTree = (TTree*) inFile.Get( "markovChain" );
  if (!inTree)   
    std::cout<<"Could not get input tree"<<std::endl;


  TFile outFile( outFileName.c_str(), "RECREATE" );
  TTree* outTree = new TTree( inTree->GetName(), inTree->GetTitle() );
  outFile.cd();


  FloatStorage data( outTree );
  data.Connect( inTree );


  int nEvents = inTree->GetEntries();

  std::cout<<"Looping over "<<nEvents<<" events..."<<std::endl;

  double minChi2=1e20;

  for (int i=0; i<nEvents; i++) {
  
    inFile.cd();
    inTree->GetEntry( i );
    
    if (data.Get("chi2")<A0->Eval(data.Get("P_A0")))
      continue;
    
    if (data.Get("chi2")<M0->Eval(data.Get("P_M0")))
      continue;
    
    if (data.Get("chi2")<M12->Eval(data.Get("P_M12")))
      continue;

    if (data.Get("chi2")<TanBeta->Eval(data.Get("P_TanBeta")))
      continue;

    if (data.Get("chi2")<MassTop->Eval(data.Get("P_massTop")))
      continue;
  
    if ( model=="NUHM1" && data.Get("chi2")<M0H->Eval(data.Get("P_M0H")))
      continue;
  
    if ( model=="NUHM2" && data.Get("chi2")<M0Hu->Eval(data.Get("P_M0Hu")))
      continue;

    if ( model=="NUHM2" && data.Get("chi2")<M0Hd->Eval(data.Get("P_M0Hd")))
      continue;

    outFile.cd();
    //    outTree->Fill();
    
    if (data.Get("chi2")<minChi2)
      minChi2=data.Get("chi2");


  }

  std::cout<<"Looping over "<<nEvents<<" events again..."<<std::endl;

  for (int i=0; i<nEvents; i++) {
  
    inFile.cd();
    inTree->GetEntry( i );

    if (data.Get("chi2")>minChi2+6.02)
      continue;
    
    if (data.Get("chi2")<A0->Eval(data.Get("P_A0")))
      continue;
    
    if (data.Get("chi2")<M0->Eval(data.Get("P_M0")))
      continue;
    
    if (data.Get("chi2")<M12->Eval(data.Get("P_M12")))
      continue;

    if (data.Get("chi2")<TanBeta->Eval(data.Get("P_TanBeta")))
      continue;

    if (data.Get("chi2")<MassTop->Eval(data.Get("P_massTop")))
      continue;
  
    if ( model=="NUHM1" && data.Get("chi2")<M0H->Eval(data.Get("P_M0H")))
      continue;
  
    if ( model=="NUHM2" && data.Get("chi2")<M0Hu->Eval(data.Get("P_M0Hu")))
      continue;

    if ( model=="NUHM2" && data.Get("chi2")<M0Hd->Eval(data.Get("P_M0Hd")))
      continue;

    outFile.cd();
    outTree->Fill();

  }



  outFile.cd();
  outTree->Write();

  inFile.Close();
  outFile.Close();

  return 0;

}


