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
  

  std::cout<<"Using input file "<<inFileName<<std::endl;
  std::cout<<"Using output file "<<outFileName<<std::endl;
  Chi2CalculatorDataBase2013 db2013;

  Chi2Calculator chi2 = db2013.GetChi2Calculator("NoHiggsRates", "category");

  
  TFile inFile( inFileName.c_str(), "READ" );
  TTree* inTree = (TTree*) inFile.Get( "markovChain" );
  if (!inTree)   
    std::cout<<"Could not get input tree"<<std::endl;

  TTree* metadata = (TTree*) inFile.Get( "metadata" );
  
  

  TTree* dummyTree = new TTree( "dummy", "dummy" );

  TFile outFile( outFileName.c_str(), "RECREATE" );

  TTree* metadataClone = metadata->CloneTree();

  TTree* outTree = new TTree( inTree->GetName(), inTree->GetTitle() );
  outFile.cd();


  FloatStorage data( outTree );
  data.Connect( inTree );
  data.Add("chi2_noHiggsRates");
  data.Add("chi2_scan");
  chi2.SetInput( &data );

  FloatStorage dummyData( dummyTree );
  chi2.SetOutput( &dummyData );

  int nEvents = inTree->GetEntries();

  std::cout<<"Looping over "<<nEvents<<" events..."<<std::endl;

  for (int i=0; i<nEvents; i++) {
    
    inTree->GetEntry( i );

    chi2.Calculate();

    data.Set("chi2_noHiggsRates", chi2.GetChi2());
    data.Set("chi2_scan", data.Get("chi2"));
    data.Set("chi2", data.Get("chi2_scan"));

    outFile.cd();
    outTree->Fill();

  }

  outFile.cd();

  outTree->Write();
  metadataClone->Write();

  outFile.Close();
  inFile.Close();


  return 0;

}


