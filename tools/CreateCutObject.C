
//This very simple macro hopefully helps to create TCutG objects with the graphics editor. 
//Start root and load the root file with the NTuple you want to skim, e.g.: root -l MarkovChainNtupfile.root
//Load this file: .L CreateCutObject.C++
//Draw the variables you want use for skimming, e.g. markovChain->Draw("chi2:P_M0", "chi2<35")
//In the canvas, click on View->ToolBar. Select the graphical cut tool on the right hand side.
//One short mouse click determines the first point of the polygon.
//Successive further mouse clicks determine the edges of the polygon.
//For the last edge double click, then the polygon will automatically be closed.
//Use this function to save the cut you have just drawn in a root file, e.g.: CreateCutObject("AllObs2010Cuts.root", "M0Cut")
//or simply CreateCutObject("AllObs2010Cuts.root"). In the later case the macro will try to determine a meaningfull name for the cut by itself
//Go on with the next variable: markovChain->Draw("chi2:P_M12", "chi2<35")...


#include "TKey.h" 
#include "TFile.h" 
#include "TCutG.h" 
#include "TDirectory.h" 
#include "TList.h" 
#include "TROOT.h" 
#include "iostream" 


void CreateCutObject(const char* cutfile, const char* cutname){

  TFile* file=(TFile*) gROOT->GetListOfFiles()->At(0);

  TCutG *mycutg;                                                                                                                                                                                  

  mycutg = (TCutG*)gROOT->GetListOfSpecials()->FindObject("CUTG");

  mycutg->SetName(cutname);
  
  TFile Cutfile(cutfile, "update");
  Cutfile.cd();

  mycutg->Write(); 

  Cutfile.Close();

  file->cd();

}



void CreateCutObject(const char* cutfile){

  TFile* file=(TFile*) gROOT->GetListOfFiles()->At(0);

  TCutG *mycutg;                                                                                                                                                                                  

  mycutg = (TCutG*)gROOT->GetListOfSpecials()->FindObject("CUTG");

  const char* varx=mycutg->GetVarX();
  const char* vary=mycutg->GetVarY();

  char newname[200];
  strcpy(newname,vary);
  strcat(newname,"_");
  strcat(newname,varx);

  
  int NumberOfCutsOfThatVariable=0;

  TFile Cutfile(cutfile, "update");
  
  TList *listOfKeys = (TList*) Cutfile.GetListOfKeys();

  TIter next(listOfKeys);
  
  while (TKey* key = (TKey*) next()) {

    TObject *obj = key->ReadObj();

    const char* name=obj->GetName();
    
    if (!strncmp(newname,name,strlen(newname))){

      NumberOfCutsOfThatVariable++;

    }

  }
  
  char CutsOfThatVariable[10];
  sprintf(CutsOfThatVariable,"%d", NumberOfCutsOfThatVariable);

  strcat(newname, "_");
  strcat(newname, CutsOfThatVariable); 
  cout<<"Save cut as "<<newname<<endl;
  mycutg->SetName(newname);
  
  Cutfile.cd();
  mycutg->Write(); 
  Cutfile.Close();
  
  file->cd();

}
