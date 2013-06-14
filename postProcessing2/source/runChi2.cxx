#include "TTree.h"
#include "TreeUtil.h"
#include "TFile.h"
#include "Chi2CalculatorDataBase2012.h"
#include "Chi2CalculatorDataBase2013.h"
#include <iostream>
#include <sstream>
#include <stdexcept>


int main(int argc, char **argv){

  std::string outFileName = argv[2];
  std::string obsSet = argv[3];
  std::string HSobSet = argv[3];
  std::string theoMassUnc = argv[3];
  
  int maxEvents;
  std::stringstream ss; 
  ss << argv[4];
  ss >> maxEvents;

  std::cout<<"Using input file "<<inFileName<<std::endl;
  std::cout<<"Using output file "<<outFileName<<std::endl;
  std::cout<<"Using obsSet "<<obsSet<<std::endl;
  std::cout<<"Using maxEvents "<<maxEvents<<std::endl;

  Chi2CalculatorDataBase2012 db2012;
  Chi2CalculatorDataBase2013 db2013;

  Chi2Calculator chi2;

  std::string HS;

  if (std::string::npos != inFileName.find("_category_")){

    HS="category";

  }
  else if (std::string::npos != inFileName.find("_inclusive_")){

    HS="inclusive";

  }
  else {

    throw std::runtime_error("UNKNOWN HS OBSSET");


  }

  if( obsSet == "paper2012_LHCmh" ){

    chi2 = db2012.GetChi2Calculator(obsSet);

  }
  else {

    chi2 = db2013.GetChi2Calculator(obsSet, HS);

  }
  
  
  TChain* markovChain_in=new TChain("markovChain");
  markovChain_in->Add("*.root");
  markovChain_in->LoadTree(0);
    
  TChain* metadata_in=new TChain("metadata");
  metadata_in->Add("*.root");
  metadata_in->LoadTree(0);
  
  TFile outFile( outFileName.c_str(), "RECREATE" );
  outFile.cd();
  TChain* markovChain_out = new TTree( markovChain_in->GetName(), markovChain_out->GetTitle() );
  TChain* metadata_out = metadata_in->GetTree()->CloneTree(0);

  FloatStorage data( markovChain_out );
  data.Connect( markovChain_in );

  chi2.SetInput( &data );
  chi2.SetOutput( &data );

  int nEvents = markovChain_in->GetEntries();

  if ( maxEvents > 0 && nEvents > maxEvents )
    nEvents = maxEvents;

  std::cout<<"Looping over "<<nEvents<<" events..."<<std::endl;

  for (int i=0; i<nEvents; i++) {
    
    markovChain_in->GetEntry( i );

    if ( chi2.Calculate() ){
      outFile.cd();
      markovChain_out->Fill();

    }

  }

  markovChain_out->Write();

  outFile.Close();

  return 0;

}


