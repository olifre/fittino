#include "TTree.h"
#include "TreeUtil.h"
#include "TFile.h"
#include "Chi2CalculatorDataBase2012.h"
#include "Chi2CalculatorDataBase2013.h"
#include <iostream>
#include <sstream>
#include <stdexcept>


int main(int argc, char **argv){

  std::string inFileName = argv[1];
  std::string outFileName = argv[2];
  std::string obsSet = argv[3];
  
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

  
  TFile inFile( inFileName.c_str(), "READ" );
  TTree* inTree = (TTree*) inFile.Get( "markovChain" );
  if (!inTree)   
    std::cout<<"Could not get input tree"<<std::endl;


  TFile outFile( outFileName.c_str(), "RECREATE" );
  TTree* outTree = new TTree( inTree->GetName(), inTree->GetTitle() );
  outFile.cd();


  FloatStorage data( outTree );
  data.Connect( inTree );

  chi2.SetInput( &data );
  chi2.SetOutput( &data );

  int nEvents = inTree->GetEntries();

  if ( maxEvents > 0 && nEvents > maxEvents )
    nEvents = maxEvents;

  std::cout<<"Looping over "<<nEvents<<" events..."<<std::endl;

  for (int i=0; i<nEvents; i++) {
    
    inTree->GetEntry( i );

    if ( chi2.Calculate() ){
      outFile.cd();
      outTree->Fill();

    }

  }

  outTree->Write();

  inFile.Close();
  outFile.Close();

  return 0;

}


