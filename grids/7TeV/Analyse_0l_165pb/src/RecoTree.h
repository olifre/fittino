//////////////////////////////////////////////////////////
// This class has been automatically generated on
// Mon May 16 16:17:31 2011 by ROOT version 5.26/00b
// from TTree RecoTree/Reco Tree
// found on file: RecSim.root
//////////////////////////////////////////////////////////

#ifndef RecoTree_h
#define RecoTree_h

#include <TROOT.h>
#include <TChain.h>
#include <TFile.h>
#include <TMath.h>
#include <TH2.h>
#include <TH1.h>
#include <TStyle.h>
#include <TCanvas.h>
#include "TLorentzVector.h"
#include <fstream>
#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>

using namespace std;

class RecoTree {
public :
   TTree          *fChain;   //!pointer to the analyzed TTree or TChain
   Int_t           fCurrent; //!current Tree number in a TChain
   TTree          *t_weights;

   // Environment variables
   TString input_RecSim;
   TString input_Channels;
   TString input_WeightingFactors;
   TString output_txt;
   TString output_2jets;
   TString output_3jets;
   TString output_4jets;

   // Declaration of leaf types
   Double_t factor;

   Int_t           Jet;
   vector<float>   *Jet_E;
   vector<float>   *Jet_Px;
   vector<float>   *Jet_Py;
   vector<float>   *Jet_Pz;
   vector<float>   *Jet_Eta;
   vector<float>   *Jet_Phi;
   vector<float>   *Jet_PT;
   vector<int>     *Jet_Btag;
   vector<int>     *Jet_NTracks;
   vector<float>   *Jet_EHoverEE;
   Int_t           Jet_size;
   Int_t           Electron;
   vector<float>   *Electron_E;
   vector<float>   *Electron_Px;
   vector<float>   *Electron_Py;
   vector<float>   *Electron_Pz;
   vector<float>   *Electron_Eta;
   vector<float>   *Electron_Phi;
   vector<float>   *Electron_PT;
   vector<float>   *Electron_Charge;
   vector<int>     *Electron_IsolFlag;
   vector<float>   *Electron_SumPt;
   vector<float>   *Electron_EtaCalo;
   vector<float>   *Electron_PhiCalo;
   vector<float>   *Electron_EHoverEE;
   vector<int>     *Electron_FlagLoose;
   vector<int>     *Electron_FlagMedium;
   vector<int>     *Electron_FlagTight;
   Int_t           Electron_size;
   Int_t           Muon;
   vector<float>   *Muon_E;
   vector<float>   *Muon_Px;
   vector<float>   *Muon_Py;
   vector<float>   *Muon_Pz;
   vector<float>   *Muon_Eta;
   vector<float>   *Muon_Phi;
   vector<float>   *Muon_PT;
   vector<float>   *Muon_Charge;
   vector<int>     *Muon_IsolFlag;
   vector<float>   *Muon_SumPt;
   vector<float>   *Muon_EtaCalo;
   vector<float>   *Muon_PhiCalo;
   vector<float>   *Muon_EHoverEE;
   vector<float>   *Muon_EtRatio;
   vector<int>     *Muon_ID;
   Int_t           Muon_size;
   Int_t           Tracks;
   vector<float>   *Tracks_Eta;
   vector<float>   *Tracks_Phi;
   vector<float>   *Tracks_EtaOuter;
   vector<float>   *Tracks_PhiOuter;
   vector<float>   *Tracks_PT;
   vector<float>   *Tracks_E;
   vector<float>   *Tracks_Px;
   vector<float>   *Tracks_Py;
   vector<float>   *Tracks_Pz;
   vector<float>   *Tracks_Charge;
   Int_t           Tracks_size;
   Int_t           ETmis;
   vector<float>   *ETmis_ET;
   vector<float>   *ETmis_Phi;
   vector<float>   *ETmis_Px;
   vector<float>   *ETmis_Py;
   Int_t           ETmis_size;

   // List of branches
   TBranch        *b_Jet;   //!
   TBranch        *b_Jet_E;   //!
   TBranch        *b_Jet_Px;   //!
   TBranch        *b_Jet_Py;   //!
   TBranch        *b_Jet_Pz;   //!
   TBranch        *b_Jet_Eta;   //!
   TBranch        *b_Jet_Phi;   //!
   TBranch        *b_Jet_PT;   //!
   TBranch        *b_Jet_Btag;   //!
   TBranch        *b_Jet_NTracks;   //!
   TBranch        *b_Jet_EHoverEE;   //!
   TBranch        *b_Jet_size;   //!
   TBranch        *b_Electron;   //!
   TBranch        *b_Electron_E;   //!
   TBranch        *b_Electron_Px;   //!
   TBranch        *b_Electron_Py;   //!
   TBranch        *b_Electron_Pz;   //!
   TBranch        *b_Electron_Eta;   //!
   TBranch        *b_Electron_Phi;   //!
   TBranch        *b_Electron_PT;   //!
   TBranch        *b_Electron_Charge;   //!
   TBranch        *b_Electron_IsolFlag;   //!
   TBranch        *b_Electron_SumPt;   //!
   TBranch        *b_Electron_EtaCalo;   //!
   TBranch        *b_Electron_PhiCalo;   //!
   TBranch        *b_Electron_EHoverEE;   //!
   TBranch        *b_Electron_FlagLoose;   //!
   TBranch        *b_Electron_FlagMedium;   //!
   TBranch        *b_Electron_FlagTight;   //!
   TBranch        *b_Electron_size;   //!
   TBranch        *b_Muon;   //!
   TBranch        *b_Muon_E;   //!
   TBranch        *b_Muon_Px;   //!
   TBranch        *b_Muon_Py;   //!
   TBranch        *b_Muon_Pz;   //!
   TBranch        *b_Muon_Eta;   //!
   TBranch        *b_Muon_Phi;   //!
   TBranch        *b_Muon_PT;   //!
   TBranch        *b_Muon_Charge;   //!
   TBranch        *b_Muon_IsolFlag;   //!
   TBranch        *b_Muon_SumPt;   //!
   TBranch        *b_Muon_EtaCalo;   //!
   TBranch        *b_Muon_PhiCalo;   //!
   TBranch        *b_Muon_EHoverEE;   //!
   TBranch        *b_Muon_EtRatio;   //!
   TBranch        *b_Muon_ID;   //!
   TBranch        *b_Muon_size;   //!
   TBranch        *b_Tracks;   //!
   TBranch        *b_Tracks_Eta;   //!
   TBranch        *b_Tracks_Phi;   //!
   TBranch        *b_Tracks_EtaOuter;   //!
   TBranch        *b_Tracks_PhiOuter;   //!
   TBranch        *b_Tracks_PT;   //!
   TBranch        *b_Tracks_E;   //!
   TBranch        *b_Tracks_Px;   //!
   TBranch        *b_Tracks_Py;   //!
   TBranch        *b_Tracks_Pz;   //!
   TBranch        *b_Tracks_Charge;   //!
   TBranch        *b_Tracks_size;   //!
   TBranch        *b_ETmis;   //!
   TBranch        *b_ETmis_ET;   //!
   TBranch        *b_ETmis_Phi;   //!
   TBranch        *b_ETmis_Px;   //!
   TBranch        *b_ETmis_Py;   //!
   TBranch        *b_ETmis_size;   //!


   RecoTree(TTree *tree=0);
   virtual ~RecoTree();
   virtual Int_t    GetEntry(Long64_t entry);
   virtual Long64_t LoadTree(Long64_t entry);
   virtual void     Init(TTree *tree);
   virtual float    Loop( TString signalRegion );
   virtual Bool_t   Notify();
   virtual void     Show(Long64_t entry = -1);
   virtual void     writeResults( float _nA, float _nB, float _nC );
};

#endif

#ifdef RecoTree_cxx
RecoTree::RecoTree(TTree *tree)
{
  input_RecSim = getenv( "input_RecSim" );
  input_Channels = getenv( "input_Channels" );
  input_WeightingFactors = getenv( "input_WeightingFactors" );
  output_txt = getenv( "output_txt" );
  output_2jets = getenv( "output_2jets" );
  output_3jets = getenv( "output_3jets" );
  output_4jets = getenv( "output_4jets" );

  cout << " >>> Input ROOT files..." << endl;
  cout << input_RecSim << endl << input_Channels << endl << input_WeightingFactors << endl;
  cout << " >>> Output ROOT files..." << endl;
  cout << output_2jets << endl << output_3jets << endl << output_4jets << endl;

  // if parameter tree is not specified (or zero), connect the file
  // used to generate this class and read the Tree.
  if (tree == 0) {
    TFile *f = (TFile*)gROOT->GetListOfFiles()->FindObject("RecSim.root");
    if (!f) {
      f = new TFile( input_RecSim );
    }
      tree = (TTree*)gDirectory->Get("RecoTree");
  }
  Init(tree);
}

RecoTree::~RecoTree()
{
   if (!fChain) return;
   delete fChain->GetCurrentFile();
}

Int_t RecoTree::GetEntry(Long64_t entry)
{
// Read contents of entry.
   if (!fChain) return 0;
   return fChain->GetEntry(entry);
}
Long64_t RecoTree::LoadTree(Long64_t entry)
{
// Set the environment to read one entry
   if (!fChain) return -5;
   Long64_t centry = fChain->LoadTree(entry);
   if (centry < 0) return centry;
   if (!fChain->InheritsFrom(TChain::Class()))  return centry;
   TChain *chain = (TChain*)fChain;
   if (chain->GetTreeNumber() != fCurrent) {
      fCurrent = chain->GetTreeNumber();
      Notify();
   }
   return centry;
}

void RecoTree::Init(TTree *tree)
{
   // The Init() function is called when the selector needs to initialize
   // a new tree or chain. Typically here the branch addresses and branch
   // pointers of the tree will be set.
   // It is normally not necessary to make changes to the generated
   // code, but the routine can be extended by the user if needed.
   // Init() will be called many times when running on PROOF
   // (once per file to be processed).

   // Set object pointer
   Jet_E = 0;
   Jet_Px = 0;
   Jet_Py = 0;
   Jet_Pz = 0;
   Jet_Eta = 0;
   Jet_Phi = 0;
   Jet_PT = 0;
   Jet_Btag = 0;
   Jet_NTracks = 0;
   Jet_EHoverEE = 0;
   Electron_E = 0;
   Electron_Px = 0;
   Electron_Py = 0;
   Electron_Pz = 0;
   Electron_Eta = 0;
   Electron_Phi = 0;
   Electron_PT = 0;
   Electron_Charge = 0;
   Electron_IsolFlag = 0;
   Electron_SumPt = 0;
   Electron_EtaCalo = 0;
   Electron_PhiCalo = 0;
   Electron_EHoverEE = 0;
   Electron_FlagLoose = 0;
   Electron_FlagMedium = 0;
   Electron_FlagTight = 0;
   Muon_E = 0;
   Muon_Px = 0;
   Muon_Py = 0;
   Muon_Pz = 0;
   Muon_Eta = 0;
   Muon_Phi = 0;
   Muon_PT = 0;
   Muon_Charge = 0;
   Muon_IsolFlag = 0;
   Muon_SumPt = 0;
   Muon_EtaCalo = 0;
   Muon_PhiCalo = 0;
   Muon_EHoverEE = 0;
   Muon_EtRatio = 0;
   Muon_ID = 0;
   Tracks_Eta = 0;
   Tracks_Phi = 0;
   Tracks_EtaOuter = 0;
   Tracks_PhiOuter = 0;
   Tracks_PT = 0;
   Tracks_E = 0;
   Tracks_Px = 0;
   Tracks_Py = 0;
   Tracks_Pz = 0;
   Tracks_Charge = 0;
   ETmis_ET = 0;
   ETmis_Phi = 0;
   ETmis_Px = 0;
   ETmis_Py = 0;
   // Set branch addresses and branch pointers
   if (!tree) return;
   fChain = tree;
   fCurrent = -1;
   fChain->SetMakeClass(1);

   fChain->SetBranchAddress("Jet", &Jet, &b_Jet);
   fChain->SetBranchAddress("Jet_E", &Jet_E, &b_Jet_E);
   fChain->SetBranchAddress("Jet_Px", &Jet_Px, &b_Jet_Px);
   fChain->SetBranchAddress("Jet_Py", &Jet_Py, &b_Jet_Py);
   fChain->SetBranchAddress("Jet_Pz", &Jet_Pz, &b_Jet_Pz);
   fChain->SetBranchAddress("Jet_Eta", &Jet_Eta, &b_Jet_Eta);
   fChain->SetBranchAddress("Jet_Phi", &Jet_Phi, &b_Jet_Phi);
   fChain->SetBranchAddress("Jet_PT", &Jet_PT, &b_Jet_PT);
   fChain->SetBranchAddress("Jet_Btag", &Jet_Btag, &b_Jet_Btag);
   fChain->SetBranchAddress("Jet_NTracks", &Jet_NTracks, &b_Jet_NTracks);
   fChain->SetBranchAddress("Jet_EHoverEE", &Jet_EHoverEE, &b_Jet_EHoverEE);
   fChain->SetBranchAddress("Jet_size", &Jet_size, &b_Jet_size);
   fChain->SetBranchAddress("Electron", &Electron, &b_Electron);
   fChain->SetBranchAddress("Electron_E", &Electron_E, &b_Electron_E);
   fChain->SetBranchAddress("Electron_Px", &Electron_Px, &b_Electron_Px);
   fChain->SetBranchAddress("Electron_Py", &Electron_Py, &b_Electron_Py);
   fChain->SetBranchAddress("Electron_Pz", &Electron_Pz, &b_Electron_Pz);
   fChain->SetBranchAddress("Electron_Eta", &Electron_Eta, &b_Electron_Eta);
   fChain->SetBranchAddress("Electron_Phi", &Electron_Phi, &b_Electron_Phi);
   fChain->SetBranchAddress("Electron_PT", &Electron_PT, &b_Electron_PT);
   fChain->SetBranchAddress("Electron_Charge", &Electron_Charge, &b_Electron_Charge);
   fChain->SetBranchAddress("Electron_IsolFlag", &Electron_IsolFlag, &b_Electron_IsolFlag);
   fChain->SetBranchAddress("Electron_SumPt", &Electron_SumPt, &b_Electron_SumPt);
   fChain->SetBranchAddress("Electron_EtaCalo", &Electron_EtaCalo, &b_Electron_EtaCalo);
   fChain->SetBranchAddress("Electron_PhiCalo", &Electron_PhiCalo, &b_Electron_PhiCalo);
   fChain->SetBranchAddress("Electron_EHoverEE", &Electron_EHoverEE, &b_Electron_EHoverEE);
   fChain->SetBranchAddress("Electron_FlagLoose", &Electron_FlagLoose, &b_Electron_FlagLoose);
   fChain->SetBranchAddress("Electron_FlagMedium", &Electron_FlagMedium, &b_Electron_FlagMedium);
   fChain->SetBranchAddress("Electron_FlagTight", &Electron_FlagTight, &b_Electron_FlagTight);
   fChain->SetBranchAddress("Electron_size", &Electron_size, &b_Electron_size);
   fChain->SetBranchAddress("Muon", &Muon, &b_Muon);
   fChain->SetBranchAddress("Muon_E", &Muon_E, &b_Muon_E);
   fChain->SetBranchAddress("Muon_Px", &Muon_Px, &b_Muon_Px);
   fChain->SetBranchAddress("Muon_Py", &Muon_Py, &b_Muon_Py);
   fChain->SetBranchAddress("Muon_Pz", &Muon_Pz, &b_Muon_Pz);
   fChain->SetBranchAddress("Muon_Eta", &Muon_Eta, &b_Muon_Eta);
   fChain->SetBranchAddress("Muon_Phi", &Muon_Phi, &b_Muon_Phi);
   fChain->SetBranchAddress("Muon_PT", &Muon_PT, &b_Muon_PT);
   fChain->SetBranchAddress("Muon_Charge", &Muon_Charge, &b_Muon_Charge);
   fChain->SetBranchAddress("Muon_IsolFlag", &Muon_IsolFlag, &b_Muon_IsolFlag);
   fChain->SetBranchAddress("Muon_SumPt", &Muon_SumPt, &b_Muon_SumPt);
   fChain->SetBranchAddress("Muon_EtaCalo", &Muon_EtaCalo, &b_Muon_EtaCalo);
   fChain->SetBranchAddress("Muon_PhiCalo", &Muon_PhiCalo, &b_Muon_PhiCalo);
   fChain->SetBranchAddress("Muon_EHoverEE", &Muon_EHoverEE, &b_Muon_EHoverEE);
   fChain->SetBranchAddress("Muon_EtRatio", &Muon_EtRatio, &b_Muon_EtRatio);
   fChain->SetBranchAddress("Muon_ID", &Muon_ID, &b_Muon_ID);
   fChain->SetBranchAddress("Muon_size", &Muon_size, &b_Muon_size);
   fChain->SetBranchAddress("Tracks", &Tracks, &b_Tracks);
   fChain->SetBranchAddress("Tracks_Eta", &Tracks_Eta, &b_Tracks_Eta);
   fChain->SetBranchAddress("Tracks_Phi", &Tracks_Phi, &b_Tracks_Phi);
   fChain->SetBranchAddress("Tracks_EtaOuter", &Tracks_EtaOuter, &b_Tracks_EtaOuter);
   fChain->SetBranchAddress("Tracks_PhiOuter", &Tracks_PhiOuter, &b_Tracks_PhiOuter);
   fChain->SetBranchAddress("Tracks_PT", &Tracks_PT, &b_Tracks_PT);
   fChain->SetBranchAddress("Tracks_E", &Tracks_E, &b_Tracks_E);
   fChain->SetBranchAddress("Tracks_Px", &Tracks_Px, &b_Tracks_Px);
   fChain->SetBranchAddress("Tracks_Py", &Tracks_Py, &b_Tracks_Py);
   fChain->SetBranchAddress("Tracks_Pz", &Tracks_Pz, &b_Tracks_Pz);
   fChain->SetBranchAddress("Tracks_Charge", &Tracks_Charge, &b_Tracks_Charge);
   fChain->SetBranchAddress("Tracks_size", &Tracks_size, &b_Tracks_size);
   fChain->SetBranchAddress("ETmis", &ETmis, &b_ETmis);
   fChain->SetBranchAddress("ETmis_ET", &ETmis_ET, &b_ETmis_ET);
   fChain->SetBranchAddress("ETmis_Phi", &ETmis_Phi, &b_ETmis_Phi);
   fChain->SetBranchAddress("ETmis_Px", &ETmis_Px, &b_ETmis_Px);
   fChain->SetBranchAddress("ETmis_Py", &ETmis_Py, &b_ETmis_Py);
   fChain->SetBranchAddress("ETmis_size", &ETmis_size, &b_ETmis_size);


   TFile *f_weights = new TFile( input_WeightingFactors );
   t_weights = (TTree*)f_weights->Get( "WeightingFactor" );
   factor=0;
   t_weights->SetBranchAddress("factor", &factor );

   if (fChain->GetEntries()!= t_weights->GetEntries()){
     cout<<"different number of entries "<<endl;
     exit(-1);
   }
   fChain->AddFriend( t_weights );
   
   Notify();
}

Bool_t RecoTree::Notify()
{
   // The Notify() function is called when a new file is opened. This
   // can be either for a new TTree in a TChain or when when a new TTree
   // is started when using PROOF. It is normally not necessary to make changes
   // to the generated code, but the routine can be extended by the
   // user if needed. The return value is currently not used.

   return kTRUE;
}

void RecoTree::Show(Long64_t entry)
{
// Print contents of entry.
// If entry is not specified, print current entry
   if (!fChain) return;
   fChain->Show(entry);
}

void RecoTree::writeResults( float _nA, float _nB, float _nC )
{
  cout << " >>> Writing in NLO.txt " << endl;
  std::ofstream _output_txt;
  _output_txt.open( output_txt  );
  _output_txt << _nA << "   " << _nB << "   " << _nC << endl;
  _output_txt.close();
}

#endif // #ifdef RecoTree_cxx


