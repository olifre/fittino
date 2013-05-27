#include "TTree.h"
#include "FloatStorage.h"
#include "TFile.h"
#include <vector>
#include "TreeUtil.h"
#include <map>
#include "TLeafD.h"
#include "TSystem.h"
#include "TROOT.h"


int main(int argc, char* argv[] ) {

//   gSystem->Load("libCintex.so");
//   Cintex::Cintex::Enable();

  gROOT->ProcessLine("#include <vector>");
  std::string name = argv[1];

  std::map< std::string, float > inMap;
  std::map< std::string, std::vector<float>* > outMap;

  TFile* f = new TFile( name.c_str() );

  TTree* inTree = (TTree*) f->Get("markovChain");

  TFile* g = new TFile( "confidenceInterval3.root", "RECREATE");
  TTree* outTree = new TTree(inTree->GetName(), inTree->GetTitle());
  

  unsigned int nLeaves = inTree->GetListOfLeaves()->GetEntries();  

  std::vector<float> start (5,0);

  for (unsigned int iLeaf = 0; iLeaf < nLeaves; iLeaf++ ) {

    TLeafD* leaf = (TLeafD*) inTree->GetListOfLeaves()->At(iLeaf);
    TString leafName=leaf->GetName();
    TString newLeafName = leafName;
    newLeafName.ReplaceAll("_nofit", "");
    std::string key= std::string(newLeafName.Data());
    inMap[key]=0;
    std::vector<float>* start =new std::vector<float>(5,0) ;
    outMap[key]=start;
    inTree->SetBranchAddress( leafName.Data(), &inMap[key] ) ;
    outTree->Branch( leafName.Data(), &outMap[key] );

  }

  int index = GetMinimumIndex(inTree, "chi2");

  inTree->GetEntry(index);

  double minChi2=inMap.at("chi2");

  std::map<std::string, float>::iterator iterator;

  for(iterator = inMap.begin(); iterator != inMap.end(); iterator++) {

    std::string key= iterator->first;

    for (unsigned int i=0; i<5; i++)
      outMap.at(key)->at(i)=inMap.at(key);

  }



  for (unsigned int i=0; i<inTree->GetEntries(); i++){

    inTree->GetEntry(i);

    for(iterator = inMap.begin(); iterator != inMap.end(); iterator++) {

      std::string key= iterator->first;

      if ( inMap.at("chi2") < minChi2+4 && inMap.at(key)< outMap.at(key)->at(0) )
	outMap.at(key)->at(0) = inMap.at(key);

      if ( inMap.at("chi2") < minChi2+1 && inMap.at(key)< outMap.at(key)->at(1) )
	outMap.at(key)->at(1) = inMap.at(key);

      if ( inMap.at("chi2") < minChi2+1 && inMap.at(key)> outMap.at(key)->at(3) )
	outMap.at(key)->at(3) = inMap.at(key);

      if ( inMap.at("chi2") < minChi2+4 && inMap.at(key)> outMap.at(key)->at(4) )
	outMap.at(key)->at(4) = inMap.at(key);

    }
  

  }


  outTree->Fill();
  g->Write();
  g->Close();

}
  
