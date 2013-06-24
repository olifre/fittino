#include <string>
#include <map>
#include <iostream>
#include <stdexcept>
#include "TFile.h"
#include "TTree.h"
#include "TH1F.h"
#include "TLeafD.h"
#include "TMath.h"


// removes multiple points
// skims on chi2<1000
// removes "_nofit" from branches to have the same branch names independent of observable set
// adds NUHM parameters

//TODO should be integrated in the main code and make use of FloatStorage


void mpr(std::string inFileName, std::string outFileName, std::string histFileName, std::string model, Long64_t maxEntries) {

  if (model!="CMSSM" && model!="NUHM1" && model!= "NUHM2"){

    throw std::runtime_error("Unknown model");

  }


  std::cout<<"MaxEvents set to "<<maxEntries<<std::endl;  
  
  TFile *inFile = new TFile(inFileName.c_str(), "READ");
  TTree *inTree = (TTree*) inFile->Get("markovChain");

  Long64_t nEntries = inTree->GetEntries();

  std::cout<<"File "<<inFileName<<" contains "<<nEntries<<" events."<<std::endl;

  if (maxEntries>0 && maxEntries< nEntries)
    nEntries=maxEntries;

  int nLeaves = inTree->GetListOfLeaves()->GetEntries();  

  TFile *histFile = new TFile(histFileName.c_str(),"RECREATE");
  TH1I * hist = new TH1I("cutflow", "cutflow", 20, 0, 20);

  TFile *outFile = new TFile(outFileName.c_str(),"RECREATE");
  TTree *outTree = new TTree (inTree->GetName(), inTree->GetTitle());

  std::map<std::string, float> map;

  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++){

    TLeafD* leaf = (TLeafD*) inTree->GetListOfLeaves()->At(iLeaf);
    TString leafName=leaf->GetName();
    std::string key= std::string(leafName.Data());
    
    map[key]=-1;
    inTree->SetBranchAddress( leafName.Data(), &map[key] );
    
    TString newLeafName = leafName;
    newLeafName.ReplaceAll("_nofit", "");
    outTree->Branch(newLeafName.Data(), &map[key]);
    
  }


  std::vector<string> required;
  required.push_back("P_M0H");
  required.push_back("P_M0Hu");
  required.push_back("P_M0Hd");
  
  for (unsigned int i=0; i< required.size(); i++){

    if ( !map.count( required[i] ) ) {
      map[required[i]]=-1;
      outTree->Branch( required[i].c_str(), &map[required[i]] );
    }
  }
  

  std::vector<std::string> par_names;
  par_names.push_back("P_M0");
  par_names.push_back("P_M12");
  par_names.push_back("P_TanBeta");
  par_names.push_back("P_A0");
  par_names.push_back("P_massTop");

  if (model=="NUHM1")
    par_names.push_back("M0H");

  else if (model=="NUHM2"){
    par_names.push_back("M0Hu");
    par_names.push_back("M0Hd");
  }


  std::map<std::string, float> par_last;
  
  for (unsigned int i=0; i< par_names.size(); i++){

    par_last[par_names[i]]=-1;

  }


  std::cout<<"Looping over "<<nEntries<<" entries."<<std::endl;

  for (Long64_t iEntry=0; iEntry<nEntries; iEntry++) {

    if ( iEntry % 10000 == 0 )
      std::cout<<"Entry "<<iEntry<<std::endl;

    inTree->GetEntry(iEntry);

    hist->Fill(0);

    if (model=="CMSSM"){

      float P_M0H = TMath::Power(map["P_M0"],2); 
      map["P_M0H"]  = P_M0H;
      map["P_M0Hu"] = P_M0H;
      map["P_M0Hd"] = P_M0H;

    }
    else if (model=="NUHM1"){

      map["P_M0Hu"]=map["P_M0H"];
      map["P_M0Hd"]=map["P_M0H"];
    }
    else if (model=="NUHM2"){
      map["P_M0H"] = 0;
    }

    if ( map["accpoint"] ) {

      bool oldpoint = true;
      
      for (unsigned int i=0; i<par_names.size(); i++ ) {

	if ( map[par_names[i]]!=par_last[par_names[i]] ) {
	  
	  oldpoint=false;
	  par_last[par_names[i]] = map[par_names[i]];
	  
	}
	
      }

      if ( oldpoint ) continue;

    }

    hist->Fill(1);

    if ( map["chi2"]>=1000 ) continue;

    //     if ( map["chi2"]<1000 ) continue;
    //     if ( map["chi2"]>1e11 ) continue;
    

    hist->Fill(2);
    outTree->Fill();      
    
  }

  histFile->Write();
  histFile->Close();

  outFile->Write(0,TObject::kOverwrite);
  outFile->Close();

  inFile->Close();

}

  
