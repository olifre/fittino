
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

int main(int arc, char** argv){

  std::string model = argv[1];
  std::string numberOfEventsStr = argv[2];

  std::stringstream numberOfEventsStream;
  int numberOfEvents;
  numberOfEventsStream<<numberOfEventsStr;
  numberOfEventsStream>>numberOfEvents;


  TString ifDir="$FITTINO_INTERFACE/FH_noHiggsRates/"+model;
  TString lockDir="$FITTINO_LOCKING/FH_noHiggsRates/"+model;

  gSystem->ExpandPathName(ifDir);
  gSystem->ExpandPathName(lockDir);

  int rc=1;
  while (rc!=0){
    rc=system(("mkdir "+lockDir+"/locked").Data());
  }
  
  ifstream fin((ifDir+"/event.txt").Data());
  int firstEvent;
  fin >> firstEvent;
  fin.close();

  system(("mv "+ifDir+"/event.txt.last "+ifDir+"/event.txt.last2").Data()); 
  system(("mv "+ifDir+"/event.txt "+ifDir+"/event.txt.last").Data()); 

  int lastEvent = firstEvent+numberOfEvents;

  ofstream ifFile;
  ifFile.open((ifDir+"/event.txt").Data());
  ifFile << lastEvent<< std::endl;
  ifFile.close();
  
  system(("rm -r "+lockDir+"/locked").Data());

  std::stringstream firstEventStream; 
  firstEventStream << firstEvent;
  std::string firstEventStr=firstEventStream.str();

  std::stringstream lastEventStream; 
  lastEventStream << lastEvent;
  std::string lastEventStr=lastEventStream.str();

  TChain* markovChain_in = new TChain("markovChain");
  markovChain_in->Add(("$FITTINO_SORT/outputs/"+model+"/*.root").c_str());
  markovChain_in->LoadTree(0); 

  TChain* metadata_in = new TChain("metadata");
  metadata_in->Add(("$FITTINO_SORT/outputs/"+model+"/*.root").c_str());
  metadata_in->LoadTree(0);   

  TFile* outFile= new TFile((model+"_evnt_"+firstEventStr+"_"+lastEventStr+".root").c_str() , "RECREATE");
  
  TTree *metadata_out = metadata_in->GetTree()->CloneTree(0); 

  TTree* markovChain_out = new TTree(markovChain_in->GetName(), markovChain_in->GetTitle());

  FloatStorage data(markovChain_out);
  data.Connect(markovChain_in);

  SPhenoCalculator spheno(model);
  spheno.SetInput(&data);
  spheno.SetOutput(&data);

  FHCalculator fh;
  fh.SetOutput(&data);  

  for (int i=firstEvent; i<lastEvent; i++){

    markovChain_in->GetEntry(i);
    metadata_in->GetEntry(i);

    rc=spheno.Calculate();
    if (rc) continue;

    rc=fh.Calculate();
    if (rc) continue;

    markovChain_out->Fill();
    metadata_out->Fill();

  }
  
  outFile->Write();
  outFile->Close();
  

}
