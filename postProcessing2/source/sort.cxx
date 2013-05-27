#include "TBranch.h"
#include "TLeaf.h"
#include "TTree.h"
#include "TFile.h"
#include "TChain.h"
#include "TMath.h"
#include "TSystem.h"
#include "TString.h"
#include <string>
#include <iostream>
#include <limits>
#include <fstream>
#include <iomanip>
#include <stdexcept>
#include <sstream>

int main(int argc, char** argv){

  std::string model = argv[1];
  std::string minChi2Str = argv[2];
  std::string maxChi2Str = argv[3];

  double minChi2;
  double maxChi2;

  std::stringstream ss;
  ss<< minChi2Str;
  ss>>minChi2;

  //  ss.str("");
  ss.clear();

  ss<<maxChi2Str;
  ss>>maxChi2;

  int dblPrec=std::numeric_limits< double >::digits10;

  std::cout<<"min chi2 string "<<minChi2Str<<std::endl;
  std::cout<<"max chi2 string "<<maxChi2Str<<std::endl;


  std::cout<<std::fixed<<std::setprecision(dblPrec)<<"min chi2 "<<minChi2<<std::endl;
  std::cout<<std::fixed<<std::setprecision(dblPrec)<<"max chi2 "<<maxChi2<<std::endl;
  
  TChain* markovChain = new TChain("markovChain");
  TChain* metadata = new TChain("metadata");

  TString dir = "$FITTINO_SCRATCH/defChi2/outputs/"+model+"*.root";

  gSystem->ExpandPathName(dir);

  int added1 = markovChain->Add(dir.Data());
  int added2 = metadata->Add(dir.Data());

  std::cout<<"Files added to markovChain: "<<added1<<std::endl;
  std::cout<<"Files added to metadata: "<<added2<<std::endl;

  std::cout<<"Number of trees in markovChain: "<<markovChain->GetNtrees()<<std::endl;
  std::cout<<"Number of files: "<<markovChain->GetListOfFiles()->GetSize()<<std::endl;
  std::cout<<"Number of tree offsets "<<markovChain->GetTreeOffsetLen()<<std::endl;

  markovChain->LoadTree(0); 
  metadata->LoadTree(0);   

  TFile* outFile = new TFile((model+"_chi2_"+minChi2Str+"_"+maxChi2Str+".root").c_str(), "RECREATE");
  TTree *mc = markovChain->GetTree()->CloneTree(0); 
  TTree *md = metadata->GetTree()->CloneTree(0); 

  Double_t chi2;

  Long64_t nentries = markovChain->GetEntries();
  Long64_t totalEntries=0;
  Long64_t nSelectedEntries=0;

  //  for (Int_t file = 0; file < markovChain->GetListOfFiles()->GetSize(); file++) {
  for (Int_t file = 0; file < markovChain->GetNtrees(); file++) {
    
    Long64_t first = markovChain->GetTreeOffset()[file];

    markovChain->LoadTree(first);

    TTree* tree = markovChain->GetTree();
    TLeaf* leaf = markovChain->GetLeaf("chi2_noHiggsRates");
    TBranch* branch = leaf->GetBranch();
  
    for (Long64_t i = 0; i < tree->GetEntries(); ++i) {

      if (totalEntries%10000000==0) std::cout<<"entry "<<totalEntries<<std::endl;
      totalEntries++;

      //       Long64_t entryNumber = tree->GetEntryNumber(i); 
      //       if (entryNumber < 0) break;

      branch->GetEntry(i);

      if (leaf->GetLen() != 1 )
	throw std::runtime_error("Wrong length of leaf");

      chi2 = leaf->GetValue(0);

      if (chi2>=minChi2 && chi2<maxChi2){
	
	markovChain->GetEntry(markovChain->GetChainEntryNumber(i));
	metadata->GetEntry(markovChain->GetChainEntryNumber(i));
	nSelectedEntries++;

	outFile->cd();
	mc->Fill();
	md->Fill();

      }

    } // loop over entries in tree

  } // loop over files/trees

  if (totalEntries!=nentries){
    std::cout<<totalEntries<<" vs "<<nentries<<std::endl;
    throw std::runtime_error("Number of events does not match");
  }

  Long64_t ncutentries = markovChain->GetEntries(("chi2_noHiggsRates>="+minChi2Str+" && chi2_noHiggsRates<"+maxChi2Str).c_str());
  if (ncutentries!=nSelectedEntries){

    std::cout<<nSelectedEntries<<" vs "<<ncutentries<<std::endl;
    throw std::runtime_error("Number of selected events does not match");
  }
    
  std::cout<<"total entries "<<totalEntries<<std::endl;
  std::cout<<"selected entries "<<nSelectedEntries<<std::endl;

  outFile->cd();
  outFile->Write();
  outFile->Close();
}





//   ifstream txtfile("files.txt");
//   std::string line;
//   std::vector<std::string> files; 

//   while(std::getline(txtfile, line)) {
//     files.push_back(line);
//   }

//   for (unsigned int i=0; i<files.size(); i++){
//     std::cout<<"Adding file "<<files[i]<<std::endl;
//     markovChain->Add(files[i].c_str());
//     metadata->Add(files[i].c_str());

//   }

