#include "TTree.h"
#include "TFile.h"
#include "HiggsCalculator.h"
#include <iostream>
#include <sstream>
#include <stdexcept>
#include "TStopwatch.h"


int main(int argc, char **argv){

  std::stringstream ss; 

  std::string inFileName = argv[1];
  std::string outFileName = argv[2];
  std::string obsSet = argv[3];

  double massTheoUnc;
  ss << argv[4];
  ss >> massTheoUnc;
  ss.clear();

  int firstEvent;
  ss << argv[5];
  ss >> firstEvent;
  ss.clear();
  
  int maxEvents;
  ss << argv[6];
  ss >> maxEvents;
  ss.clear();

  std::cout<<"Using input file "<<inFileName<<std::endl;
  std::cout<<"Using output file "<<outFileName<<std::endl;
  std::cout<<"Using obsset "<<obsSet<<std::endl;
  std::cout<<"Using massTheoUnc "<<massTheoUnc<<std::endl;
  std::cout<<"Using firstEvent "<<firstEvent<<std::endl;
  std::cout<<"Using maxEvents "<<maxEvents<<std::endl;
  
  TFile inFile( inFileName.c_str(), "READ" );
  TTree* inTree = (TTree*) inFile.Get( "markovChain" );

  TFile outFile( outFileName.c_str(), "RECREATE" );
  TTree* outTree = new TTree( inTree->GetName(), inTree->GetTitle() );

  FloatStorage data( outTree );
  data.Connect( inTree );
  data.Add("GetEntry_real");
  data.Add("GetEntry_cpu");
  data.Add("Calculate_real");
  data.Add("Calculate_cpu");
  data.Add("Fill_real");
  data.Add("Fill_cpu");

  HiggsCalculator higgs( &data,  &data, obsSet, massTheoUnc  );

  int nEvents = inTree->GetEntries();

  std::cout<<"File contains "<<nEvents<<" entries."<<std::endl;

  if ( firstEvent >= nEvents ) {

    throw std::runtime_error( "First event parameter too large" );

  }

  if ( maxEvents > 0 && ( nEvents > firstEvent + maxEvents) ) {

    nEvents = firstEvent + maxEvents;

  }

  std::cout<<"Looping vom  "<<firstEvent<<" to "<<nEvents<<"."<<std::endl;  


  TStopwatch watch2;


  for ( int i = firstEvent; i < nEvents; i++) {

    if (i % 10000 == 0){

      std::cout<<"Entry "<<i<<std::endl;

    }

    watch2.Reset();
    watch2.Start();

    inTree->GetEntry( i );

    data.Set("GetEntry_cpu", watch2.RealTime());
    data.Set("GetEntry_real", watch2.CpuTime());

    watch2.Reset();
    watch2.Start();

    higgs.Calculate();

    data.Set("Calculate_cpu", watch2.RealTime());
    data.Set("Calculate_real", watch2.CpuTime());

    watch2.Reset();
    watch2.Start();
    
    outTree->Fill();

    data.Set("Fill_cpu", watch2.RealTime());
    data.Set("Fill_real", watch2.CpuTime());


  }

  outTree->Write();

  outFile.Close();

  inFile.Close();

  return 0;

}


