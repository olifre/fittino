
//Please scroll to function void SkimMarkovChainWithGraphicalCuts() to see how to use this macro

#include "TStyle.h"
#include "TLeafD.h"
#include "TFile.h"
#include "TDirectory.h"
#include "TChain.h"
#include "TCanvas.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TList.h"
#include "TLine.h"
#include "TLeaf.h"
#include "TObjArray.h"
#include "iostream"
#include "string"
#include "vector"
#include "TClonesArray.h"
#include "TCutG.h"
#include "map"
#include "TKey.h"

using namespace std;

class Skimming {

public:
  Skimming();
  void AddInputFile(string RootInputFile);
  void AddCut(TCutG* CutObject);
  void AddCutFile(const char* CutFile);
  void Perform();
  void SetTreeName(string name);
  void SetAbsMaxChi2(double absMaxChi2);
  void SetAbsMinChi2(double absMinChi2);
  void SetDeleteIdenticalPoints(bool deleteIdenticalPoints);
  void SetKeepBugPoints(bool keepBugPoints);
  void SetMaxDeltaChi2(double maxDeltaChi2);  
  void SetMaxEvents(Long64_t maxEvents);
  void SetOutputFileName(string outputFileName); 
  
private:
  bool keepBugPoints;
  bool deleteIdenticalPoints;
  double absMinChi2;
  double absMaxChi2;
  double maxDeltaChi2;
  Long64_t maxEvents;
  float bug;
  float minChi2;
  string outputFileName;
  vector<string> parameters;
  map<string, float> leaves;
  map<string, vector<float> > LastParameters;
  map <string, float> MinimalParameters;
  TChain* markovChain;   
  TObjArray* CutObjects;
  vector<string> InputFiles;
  TTree* newTree;
  TFile* outputRootFile;
  
private:
  bool Chi2Cut();
  bool Cut();
  bool OldPoint();
  void ClosePolygon(); 
  void FindMinimalChi2();
  void FillEntries();
  void GetAndSetBranches();

};

void SkimMarkovChainWithGraphicalCuts(){

  Skimming Skim;

  //Please add your root inputfiles...
  Skim.AddInputFile("MarkovChainNtupFile.root");

  //.. set the following parameters...
  Skim.SetAbsMaxChi2(1e20); 
  Skim.SetTreeName("markovChain");
  Skim.SetAbsMinChi2(0);
  Skim.SetDeleteIdenticalPoints(false); //  if true identical points are deleted. To save time it's assumed that a 'identical point' corresponds to a point exactly  two entries before. This assumption is made since an identical point in the markovchain should result from the rejection of a point in between. 
  Skim.SetKeepBugPoints(false); //if true, the bugpoints are kept but the new tree gets an additional branch "bug" which is 1 if the point is buggy, otherwise 0
  Skim.SetMaxDeltaChi2(-1);  //if negative, the minimal chi2 is not determined, so one loop less needs to be performaned
  Skim.SetMaxEvents(-1); //if negative, all events are used 
  Skim.SetOutputFileName("SkimmedFile.root"); 

  //... and create/load your TCutG objects and add them! 
  
  //Example for adding a cut file: All TCutG objects in this file are used
  // Skim.AddCutFile("noxsecCuts.root");


  // Example for loading saved cuts from a root file (see CreateCutObjects.C how to easily create such CutObjects with the graphics editor)
  //  TFile* cutfile=new TFile("2Dcut.root", "READ");
  // TCutG* M0= (TCutG*) cutfile->Get("M0_M12");
  //  TCutG* M12= (TCutG*) cutfile->Get("M12");
  // TCutG* A0= (TCutG*) cutfile->Get("A0");
  // TCutG* TanBeta= (TCutG*) cutfile->Get("TanBeta");
  //   Skim.AddCut(M0);
   //   Skim.AddCut(M12);
   // Skim.AddCut(A0);
   // Skim.AddCut(TanBeta);
   
  //Example for creating a CutObject right here:
  TCutG *ExampleCut = new TCutG("ExampleCut",6);
  ExampleCut->SetVarX("P_M12");
  ExampleCut->SetVarY("chi2");
  ExampleCut->SetPoint(0,756.7672,25.46769);
  ExampleCut->SetPoint(1,476.2356,22.36917);
  ExampleCut->SetPoint(2,484.1379,18.33713);
  ExampleCut->SetPoint(3,797.069,18.39672);
  ExampleCut->SetPoint(4,756.7672,25.46769);
  ExampleCut->SetPoint(5,756.7672,25.46769);
  //  Skim.AddCut(ExampleCut);
  
  //Remark1: Please don't forget to set the variable names if you you create the CutObject by hand
  //Remark2: Usually a TCut Object is a closed Polygon, that means the first and the last point are identical and the points inside this polygon are cut away. 
  //If the first and the last point are not identical it is asumed that the user wants to cut all point between the polygon and the x-axis. 
  //The function ClosePolygon() modifies the TCut object automatically according to this by adding 3 points which close the polygon.

  //And now skimming starts.
  Skim.Perform();
  
}

void Skimming::SetTreeName(string name){

  markovChain->SetName(name.c_str());
  //  newTree->SetName(name.c_str());
}

Skimming::Skimming(){

  markovChain=new TChain();
  CutObjects=new TObjArray();
  
  maxDeltaChi2=6.2; 
  absMinChi2=0; 
  absMaxChi2=1e20;
  keepBugPoints=false; 
  deleteIdenticalPoints=false; 
  maxEvents=-1;
  minChi2=1e20;
  
}

void Skimming::AddInputFile(string RootInputFile){

  
  InputFiles.push_back(RootInputFile);

}

void Skimming::AddCut(TCutG* CutObject){

  CutObjects->Add(CutObject);

}


void Skimming::AddCutFile(const char* CutFile){

  TFile f(CutFile);

  TList *listOfKeys = (TList*) f.GetListOfKeys();

  TIter next(listOfKeys);

  while (TKey* key = (TKey*) next()) {
    TObject *obj = key->ReadObj();

    if (obj->InheritsFrom("TCutG")){
      TCutG * cut = (TCutG*) obj;
      AddCut(cut);
    }

  }
}



void Skimming::SetAbsMaxChi2(double absMaxChi2){

  this->absMaxChi2=absMaxChi2;

}

void Skimming::SetAbsMinChi2(double absMinChi2){

  this->absMinChi2=absMinChi2;

}

void Skimming::SetDeleteIdenticalPoints(bool deleteIdenticalPoints){

  this->deleteIdenticalPoints=deleteIdenticalPoints;

}

void Skimming::SetKeepBugPoints(bool keepBugPoints){

  this->keepBugPoints=keepBugPoints;

}

void Skimming::SetMaxDeltaChi2(double maxDeltaChi2){

  this->maxDeltaChi2=maxDeltaChi2;

}

void Skimming::SetMaxEvents(Long64_t maxEvents){

  this->maxEvents=maxEvents;

}

void Skimming::SetOutputFileName(string outputFileName){

  this->outputFileName=outputFileName;
  
}

bool Skimming::Chi2Cut(){

  double chi2=leaves["chi2"];
    
  if ( ( absMaxChi2>=0 && chi2>absMaxChi2 ) || ( absMinChi2>=0 && chi2<absMinChi2 )) return true;

  return false;

}

bool Skimming::Cut(){
   
  TCutG* CutObject;
    
  for (int i=0; i<CutObjects->GetEntries();i++){
    
    CutObject=(TCutG*)CutObjects->At(i);

    string VarX=CutObject->GetVarX();
    string VarY=CutObject->GetVarY();

    if (CutObject->IsInside(leaves[VarX],leaves[VarY])) return true;
      
  }

  return false;
    
}

void Skimming::FindMinimalChi2(){
  
  cout << "looping over events to find minimal chi2"<<endl;


  for (Long64_t i=0; i<maxEvents; i++) {
      
    markovChain->GetEntry(i);	

    if (leaves["chi2"]>=minChi2) continue;      
    if (Chi2Cut() || Cut()) continue;

    minChi2 = leaves["chi2"];
      
    cout << "found new chi2 minimum with chi2 = " << minChi2 << " at" << endl; 
    
    for (int k=0;k<parameters.size();k++){

      MinimalParameters[parameters[k]]=leaves[parameters[k]];
      cout<<parameters[k]<<" = "<<MinimalParameters[parameters[k]]<<"  "; 
      
    }

    cout<<endl;
    
  }

  if (absMaxChi2<0 || minChi2+maxDeltaChi2<absMaxChi2) absMaxChi2=minChi2+maxDeltaChi2;

  cout<<"End of minimal chi2 search."<<endl;
  
}

void Skimming::ClosePolygon(){
  
  TCutG* CutObject;
  int nentries;
  double xFirst, yFirst, xLast, yLast; 
  
  for (int i=0; i<CutObjects->GetEntries();i++){
    
    CutObject=(TCutG*)CutObjects->At(i);
    nentries=CutObject->GetN();
    
    CutObject->GetPoint(0, xFirst, yFirst);
    CutObject->GetPoint(nentries-1, xLast, yLast);

    if (xFirst==xLast && yFirst==yLast) continue;
     
    CutObject->Expand(nentries+3);

    CutObject->SetPoint(nentries, xLast, 0.);
    CutObject->SetPoint(nentries+1, xFirst, 0.);
    CutObject->SetPoint(nentries+2, xFirst, yFirst);
    
  }
  
}

bool Skimming::OldPoint(){

  bool newpoint=false;
      
  for (int ipar=0; ipar<parameters.size(); ipar++){

    string par=parameters[ipar];
    vector<float> *parvec=&LastParameters[par];

    if (leaves[par]!=parvec->at(0)) newpoint=true;

    parvec->push_back(leaves[par]);

    if (parvec->size()>2) parvec->erase(parvec->begin());
	
  }
      
  return (!newpoint); 

}

void Skimming::FillEntries(){


  
  Long64_t nNewEvents = 0;
  
  for (Long64_t i=0; i<maxEvents; i++) {
    
    markovChain->GetEntry(i);	
    if (i % 100000 ==0) cout<<"Loaded entry "<<i<<endl;

    bug=0;


    if (deleteIdenticalPoints){

      if (OldPoint()) continue;
      
    }
    
    if (Chi2Cut()) continue;
      
    if (keepBugPoints){

      if (Cut()) bug=1;
      
    }
    else {

      if (Cut()) continue;

    }
    
    nNewEvents++;
    newTree->Fill();

  }


  newTree->Write();

  outputRootFile->Close();
  
  cout <<"Have written " <<nNewEvents << " to the file." <<endl;



  
}

void Skimming::Perform(){

  cout<<"Perform Skimming with:"<<endl;
  cout<<"keepBugPoints="<<keepBugPoints<<endl;
  cout<<"deleteIdenticalPoints="<<deleteIdenticalPoints<<endl;
  cout<<"absMinChi2="<<absMinChi2<<endl;
  cout<<"absMaxChi2="<<absMaxChi2<<endl;
  cout<<"maxDeltaChi2="<<maxDeltaChi2<<endl;
  cout<<"maxEvents="<<maxEvents<<endl;
  cout<<"outputFileName="<<outputFileName<<endl;
  cout<<"Number of InputFiles="<<InputFiles.size()<<endl;
  cout<<"Number of Cuts="<<CutObjects->GetEntries()<<endl;
  cout<<endl;

  ClosePolygon();

  GetAndSetBranches();

  if (maxDeltaChi2>=0) FindMinimalChi2();
  
  FillEntries();
  
}

void Skimming::GetAndSetBranches(){
  

  for (int i=0; i<InputFiles.size();i++){
    markovChain->Add(InputFiles[i].c_str());
  }

  int nLeaves = markovChain->GetListOfLeaves()->GetEntries();  

  Long64_t nEntries=markovChain->GetEntries();

  if (maxEvents<0 || maxEvents>nEntries) maxEvents=nEntries;

  cout<<"Have found "<<nEntries<<" entries in the input files."<<endl;
  cout<<"Set maxEvents to "<<maxEvents<<endl;

  outputRootFile=new TFile(outputFileName.c_str(), "RECREATE"); 
  newTree =new TTree(markovChain->GetName(), "skimmed tree");

  
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++){

    TLeafD* leaf = (TLeafD*)markovChain->GetListOfLeaves()->At(iLeaf);
    string leafname=leaf->GetName();

    leaves[leafname]=-1;

    if (!strncmp(leafname.c_str(), "P_", 2)){

      parameters.push_back(leafname); 
      LastParameters[leafname].push_back(-1);
      MinimalParameters[leafname]=-1;
      
    }
    
    markovChain->SetBranchAddress(leafname.c_str(),&leaves[leafname]);
    
    newTree->Branch(leafname.c_str(),&leaves[leafname]);
    
  }
  
  if (keepBugPoints)  newTree->Branch("bug", &bug);
  
}
