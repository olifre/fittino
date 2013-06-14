#include "slhaea.h"
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include "TTree.h"
#include "TChain.h"
#include "TFile.h" 
#include "FHCalculator.h"
#include "SPhenoCalculator.h"
#include "TSystem.h"

int main(int argc, char** argv){

  if (argc!=4){

    std::cout<<"Usage: ./runFH model firstEvent maxEvents"<<std::endl;
    return 1;
    
  }

  std::string model = argv[1];
  std::string firstEventStr = argv[2];
  std::string numberOfEventsStr = argv[3];

  std::stringstream sstream;
  
  Long64_t numberOfEvents;
  sstream.str(numberOfEventsStr);
  sstream>>numberOfEvents;
  sstream.clear();

  Long64_t firstEvent;
  sstream.str(firstEventStr);
  sstream>>firstEvent;
  sstream.clear();

  TString ifDir="$FITTINO_INTERFACE/"+model;
  gSystem->ExpandPathName(ifDir);

  bool useInterFaceFile=false;
  if ( firstEvent<0 ) useInterFaceFile=true;

  int rc=1;

  if (useInterFaceFile){
  
    while (rc!=0){
      rc=system(("mkdir "+ifDir+"/locked").Data());
    }
  
    ifstream fin((ifDir+"/event.txt").Data());
    fin >> firstEventStr;
    fin.close();

    sstream.str(firstEventStr);
    sstream>>firstEvent;
    sstream.clear();

  }

  Long64_t lastEvent = firstEvent+numberOfEvents;

  std::string lastEventStr;
  sstream.str(std::string());
  sstream << lastEvent;
  lastEventStr=sstream.str();
  sstream.clear();

  if (useInterFaceFile){

    system(("mv "+ifDir+"/event.txt.last "+ifDir+"/event.txt.last2").Data()); 
    system(("mv "+ifDir+"/event.txt "+ifDir+"/event.txt.last").Data()); 

    ofstream ifFile;
    ifFile.open((ifDir+"/event.txt").Data());
    ifFile << lastEvent<< std::endl;
    ifFile.close();
  
    system(("rm -r "+ifDir+"/locked").Data());

  }

  std::cout<<"Building the chains"<<std::endl;

  TChain* markovChain_in = new TChain("markovChain");
  markovChain_in->Add(("$FITTINO_SORT/outputs/"+model+"/*.root").c_str());
  markovChain_in->LoadTree(0); 

  TChain* metadata_in = new TChain("metadata");
  metadata_in->Add(("$FITTINO_SORT/outputs/"+model+"/*.root").c_str());
  metadata_in->LoadTree(0);   

  std::cout<<"Finished building the chains"<<std::endl;

  std::string outFileName=model+"_evnt_"+firstEventStr+"_"+lastEventStr+".root";

  std::cout<<"Creating out file "<<outFileName<<std::endl;

  TFile* outFile= new TFile(outFileName.c_str() , "RECREATE");
  
  TTree *metadata_out = metadata_in->GetTree()->CloneTree(0); 

  TTree* markovChain_out = new TTree(markovChain_in->GetName(), markovChain_in->GetTitle());

  FloatStorage data(markovChain_out);
  data.Connect(markovChain_in);

  SPhenoCalculator spheno(model);
  spheno.SetInput(&data);
  spheno.SetOutput(&data);

  FHCalculator fh;
  fh.SetOutput(&data);  

  std::cout<<"Looping from "<<firstEvent<<" to "<<lastEvent<<std::endl; 

  for (Long64_t i=firstEvent; i<lastEvent; i++){

    if (i%500==0){

      std::cout<<"Entry "<<i<<std::endl;

    }

    int nb1=markovChain_in->GetEntry(i);
    int nb2=metadata_in->GetEntry(i);

    if (nb1<=0 || nb2<=0){
      
      std::cout<<"Problem reading entry "<<i<<std::endl;
      std::cout<<"Maybe end of chain reached. Stopping. "<<std::endl;
      break;
      
    }

    int rcSPheno=spheno.Calculate();
    int rcFH=0;

    if (rcSPheno==0){
      
      rcFH=fh.Calculate();

    }

    //if (rcSPheno!=0 || rcFH!=0) continue;

    markovChain_out->Fill();
    metadata_out->Fill();


  }
  
  outFile->Write();
  outFile->Close();
  

}
