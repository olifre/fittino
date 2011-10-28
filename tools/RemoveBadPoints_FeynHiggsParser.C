// this macro is for removing points which have a faulty chi2 due to a bug in the afterburner for the 2011 production
// the bug can cause that for a given point where FeynHiggs crashes, the FeynHiggs observables are taken from the previous point.
// then, the chi2 for a point depends on the characteristics of the previous point.
// this should by now (27/10/2011) have been fixed;
// this script works as follows:
//
// for each point, the next-to-previous point is checked. If this point has not been accepted for the markovChain, it is written into the ntuple and the next-to-next-to previous point is written into the ntuple again.
// thus, if the next-to-previous point has accpoint == 0, the script compares the value for O_Massh0_npf for the current and the next-to-previous point. if the difference is smaller than 1.e-20, the point is rejected as a bad point. 
//
// if the next-to-previous point was accepted, there are two possibilities: 
// either, it is a good point. Then, the script compares the value for the current point for O_Massh0_npf with the value for the previous point.
// or, it is a bad point. Then the following can happen:
// the previous point is also a bad point ==> the recent point will be rejected, because it's higgs mass compares to the previous' point higgs mass
// the previous point is a good point --> all codes run without any problem, but it is not accepted. Then the recent point is a copy of a the previous, bad point. Then the recent point is rejected if the next-to-previous point is already a bad point.
//


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
using namespace std;

void RemoveFaultyPoints( string inputRootFileName = "MarkovChainNtupFile.root", string outputRootFileName = "newMarkovChainNtupFile.root" ) {
  TChain markovChain("markovChain");
  markovChain.Add(inputRootFileName.c_str());
  int nEntries = markovChain.GetEntries();

  const int nLeaves = markovChain.GetListOfLeaves() -> GetEntries();

  if( nLeaves > 10000 ) {
    cerr << "Increase leaf array size" << endl;
    return;
  }

  float *par = new float[nLeaves];
  TLeafD* leaf[10000];
  int iChi2 = -1;
  int iLikelihood = -1;
  int iTanBeta = -1;
  int iM0      = -1;
  int iM12     = -1;
  int iA0      = -1;
  int iCgrav   = -1;
  int iMmess   = -1;
  int iLambda  = -1;
  int iO_Massh0_npf = -1;  
  int iaccpoint = -1;

  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
    leaf[iLeaf] = (TLeafD*)markovChain.GetListOfLeaves()->At(iLeaf);
    leaf[iLeaf]->SetAddress(&par[iLeaf]);
    if (!strcmp(leaf[iLeaf]->GetName(), "chi2")) {
      iChi2 = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "likelihood")) {
      iLikelihood = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_TanBeta")) {
      iTanBeta = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_M0")) {
      iM0 = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_M12")) {
      iM12 = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_A0")) {
      iA0 = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_Lambda")) {
      iLambda = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_Mmess")) {
      iMmess = iLeaf;
    }
    else if (!strcmp(leaf[iLeaf]->GetName(), "P_cGrav")) {
      iCgrav = iLeaf;
    }
    else if(!strcmp(leaf[iLeaf]->GetName(), "O_Massh0_npf")) {
      iO_Massh0_npf = iLeaf;
    }
    else if(!strcmp(leaf[iLeaf]->GetName(), "accpoint")) {
      iaccpoint = iLeaf;
    }

  }
  if (iChi2<0) {
    cout << "input tree incomplete" << endl;
    return;
  }
  if (iLikelihood<0) {
    cout << "input tree incomplete" << endl;
    return;
  }
  if( iO_Massh0_npf < 0 ) {
    cout << "FATAL: cannot apply correction due to missing observable O_Massh0_npf!" << endl;
    return;
  }


  TFile* outputRootFile = new TFile (outputRootFileName.c_str(),"RECREATE");
  TTree* newTree = new TTree ("markovChain","Skimmed MarkovChainTree");
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
     string str = leaf[iLeaf]->GetName();
     str.append("/F");
     newTree->Branch(leaf[iLeaf]->GetName(), &par[iLeaf], str.c_str());
  }
  vector<int> wasBad;
  wasBad.push_back(0); // index 0 = next-to-previous event
  wasBad.push_back(0); // index 1 = previous-event
  wasBad.push_back(0); // index 2 = recent event
  for( Int_t i = 0; i < nEntries; ++i ) {
    wasBad.at(0) = wasBad.at(1);
    wasBad.at(1) = wasBad.at(2);
    float O_Massh0_npf_old = -1.;
    if( ((i+1)%10000) == 0 ) {
      cout << "done " << (float)(i+1)/(float)nEntries*100. << "%\r";
      fflush(stdout);
    }
    markovChain.GetEntry(i);
    //if( par[iaccpoint] < 0.5 ) continue;

    if( i == 1 ) {
      markovChain.GetEntry(i-1);
      O_Massh0_npf_old = par[iO_Massh0_npf];
    } 
    else if( i >= 2 ) {
      markovChain.GetEntry(i-2);
      if( par[iaccpoint] < 0.5  || (par[iaccpoint] > 0.5 && wasBad.at(0) == 1) ) {
        O_Massh0_npf_old = par[iO_Massh0_npf];
      }
      else {
        markovChain.GetEntry(i-1);
        O_Massh0_npf_old = par[iO_Massh0_npf];
      
      }
    }
    //cout << "have set " << O_Massh0_npf_old << endl;
    markovChain.GetEntry(i);
    if( fabs( O_Massh0_npf_old - par[iO_Massh0_npf]) < 1.e-20 ) {
      wasBad.at(2)=1;
      continue;
    }
    else {
      wasBad.at(2)=0;
      /*
			if( par[iM12] > 1500 && par[iChi2] < 15. && par[iaccpoint] ) {
        cout << endl;
        cout << "HEERE: at index " << i << endl;
        markovChain.GetEntry(i-11);
        cout << "i-11: " << par[iO_Massh0_npf] << " " << par[iaccpoint] << " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-10);
        cout << "i-10: " << par[iO_Massh0_npf] << " " << par[iaccpoint] << " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-9);
        cout << "i-9: " << par[iO_Massh0_npf] << " " << par[iaccpoint] << " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-8);
        cout << "i-8: " << par[iO_Massh0_npf] << " " << par[iaccpoint] << " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-7);
        cout << "i-7: " << par[iO_Massh0_npf] << " " << par[iaccpoint] << " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-6);
        cout << "i-6: " << par[iO_Massh0_npf] << " " << par[iaccpoint] << " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-5);
        cout << "i-5: " << par[iO_Massh0_npf] << " " << par[iaccpoint] << " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-4);
        cout << "i-4: " << par[iO_Massh0_npf] << " " << par[iaccpoint] << " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-3);
        cout << "i-3: " << par[iO_Massh0_npf] << " " << par[iaccpoint] << " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-2);
        cout << "i-2: " << par[iO_Massh0_npf] << " " << par[iaccpoint] <<  " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i-1);
        cout << "i-1: " << par[iO_Massh0_npf] << " " << par[iaccpoint] <<  " " << par[iM12] << " " << par[iChi2] << endl;
        markovChain.GetEntry(i);
        cout << "i: " << par[iO_Massh0_npf] << " " << par[iaccpoint] <<  " " << par[iM12] << " " << par[iChi2] << endl;
        cout << "get difference" << endl;
        cout << fabs( O_Massh0_npf_old - par[iO_Massh0_npf]) << endl;
      }*/
      newTree -> Fill();
    }
  }
  newTree -> Write();
  outputRootFile->Close();
  return;
}
