#include "TTree.h"
#include "TFile.h"
#include "HiggsCalculator.h"
#include <iostream>
#include <sstream>
#include <stdexcept>
#include "TStopwatch.h"
#include "TChain.h"
#include "ChainBuilder.h"


int main(int argc, char **argv){

  if (argc!=6){
    std::cout<<argc<<std::endl;
    std::cout<<"Usage: flag firstEvent maxEvents obsSet theoUnc"<<std::endl;
    return 1;

  }

  

  //  flag firstEvent maxEvents

  std::stringstream ss; 

  double flag;
  ss << argv[1];
  ss >> flag;
  ss.str("");
  ss.clear();

  int firstEvent;
  ss << argv[2];
  ss >> firstEvent;
  ss.str("");
  ss.clear();
  
  int maxEvents;
  ss << argv[3];
  ss >> maxEvents;
  ss.str("");
  ss.clear();

  std::string obsSet = argv[4];
  std::string theoUnc = argv[5];

  
  std::cout<<"Using firstEvent "<<firstEvent<<std::endl;
  std::cout<<"Using maxEvents "<<maxEvents<<std::endl;
  std::cout<<"Using obsSet "<<obsSet<<std::endl;
  std::cout<<"Using theoUnc "<<theoUnc<<std::endl;

  std::cout<<"Get the chains"<<std::endl;

  ChainBuilder chains(1);

  TChain* markovChain_in = chains.GetMarkovChain();
  TChain* metadata_in =  chains.GetMetaData();

  std::cout<<"Count the events"<<std::endl;

  int nEvents=firstEvent+maxEvents;

//    nEvents = markovChain_in->GetEntries();
//   std::cout<<"File contains "<<nEvents<<" entries."<<std::endl;
//   if ( firstEvent >= nEvents ) {
//     throw std::runtime_error( "First event parameter too large" );
//   }
//   if ( maxEvents > 0 && ( nEvents > firstEvent + maxEvents) ) {
//     nEvents = firstEvent + maxEvents;
//   }

  

  ss<<nEvents;

  

  std::string outFileName="Evnt_"+std::string(argv[2])+"_"+ss.str()+".root";
  TFile outFile( outFileName.c_str(), "RECREATE" );
  if (!metadata_in){
    std::cout<<"Problem with metadata"<<std::endl;
  }

  if (!markovChain_in){
    std::cout<<"Problem with markovChain"<<std::endl;
  }


  TTree* markovChain_out = new TTree( markovChain_in->GetName(), markovChain_in->GetTitle() );

  TTree *metadata_out = metadata_in->GetTree()->CloneTree(0); 

  FloatStorage data( markovChain_out );
  data.Connect( markovChain_in );

  HiggsCalculator higgs_cat30( &data,  &data, obsSet, theoUnc );
  // HiggsCalculator higgs_cat15( &data,  &data, "category", "1.5" );
//   HiggsCalculator higgs_inkl30( &data,  &data, "inclusive", "3.0" );
//   HiggsCalculator higgs_inkl15( &data,  &data, "inclusive", "1.5" );


  std::cout<<"Looping vom  "<<firstEvent<<" to "<<nEvents<<"."<<std::endl;  


  for ( int i = firstEvent; i < nEvents; i++) {

    if (i % 10000 == 0){

      std::cout<<"Entry "<<i<<std::endl;

    }

    markovChain_in->GetEntry( i );
    metadata_in->GetEntry( i );


    higgs_cat30.Calculate(); 
//     higgs_cat15.Calculate(); 
//     higgs_inkl30.Calculate();
//     higgs_inkl15.Calculate();


    
    markovChain_out->Fill();
    metadata_out->Fill();

  }

  markovChain_out->Write();
  metadata_out->Write();

  outFile.Close();

  return 0;

}


