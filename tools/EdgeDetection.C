#define EdgeDetection_cxx
// The class definition in EdgeDetection.h has been generated automatically
// by the ROOT utility TTree::MakeSelector(). This class is derived
// from the ROOT class TSelector. For more information on the TSelector
// framework see $ROOTSYS/README/README.SELECTOR or the ROOT User Manual.

// The following methods are defined in this file:
//    Begin():        called every time a loop on the tree starts,
//                    a convenient place to create your histograms.
//    SlaveBegin():   called after Begin(), when on PROOF called only on the
//                    slave servers.
//    Process():      called for each event, in this function you decide what
//                    to read and fill your histograms.
//    SlaveTerminate: called at the end of the loop on the tree, when on PROOF
//                    called only on the slave servers.
//    Terminate():    called at the end of the loop on the tree,
//                    a convenient place to draw/fit your histograms.
//
// To use this file, try the following session on your Tree T:
//
// Root > T->Process("EdgeDetection.C")
// Root > T->Process("EdgeDetection.C","some options")
// Root > T->Process("EdgeDetection.C+")
//

#include "EdgeDetection.h"
#include <TH2.h>
#include <TStyle.h>

TFile* outputFile = 0;
TH2F* histChi2VsA0 = 0;
TH2F* histChi2VsM0 = 0;
TH2F* histChi2VsM12 = 0;
TH2F* histChi2VsTanBeta = 0;
TH2F* histChi2VsMassTop = 0;

void EdgeDetection::Begin(TTree* tree)
{
   // The Begin() function is called at the start of the query.
   // When running with PROOF Begin() is only called on the client.
   // The tree argument is deprecated (on PROOF 0 is passed).

   // Create and open the output ROOT file.
   outputFile = new TFile("Images.root", "RECREATE");

   // Initialize the Tree branch addresses
   Init(tree);

   //histChi2VsA0      = new TH2F("Chi2VsA0",      "#chi^{2} vs A_{0}",     100, -5000., 5000., 100, 0., 50.);
   //histChi2VsM0      = new TH2F("Chi2VsM0",      "#chi^{2} vs M_{0}",     100,     0.,  500., 100, 0., 50.);
   //histChi2VsM12     = new TH2F("Chi2VsM12",     "#chi^{2} vs M_{1/2}",   100,     0., 1200., 100, 0., 50.);
   //histChi2VsTanBeta = new TH2F("Chi2VsTanBeta", "#chi^{2} vs tan #beta", 100,     0.,   60., 100, 0., 50.);
   //histChi2VsMassTop = new TH2F("Chi2VsMassTop", "#chi^{2} vs m_{t}",     100,     0.,   60., 100, 0., 50.);

   histChi2VsA0      = new TH2F("Chi2VsA0",      "#chi^{2} vs A_{0}",     500, -6000., 6000., 500, 25., 50.);
   histChi2VsA0->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsA0->GetXaxis()->SetTitle("A_{0} [GeV]");

   histChi2VsM0      = new TH2F("Chi2VsM0",      "#chi^{2} vs M_{0}",     500,     0., 1800., 500, 25., 50.);
   histChi2VsM0->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsM0->GetXaxis()->SetTitle("M_{0} [GeV]");
   histChi2VsM0->GetXaxis()->SetNdivisions(506);

   histChi2VsM12     = new TH2F("Chi2VsM12",     "#chi^{2} vs M_{1/2}",   500,   300., 1200., 500, 25., 50.);
   histChi2VsM12->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsM12->GetXaxis()->SetTitle("M_{1/2} [GeV]");

   histChi2VsTanBeta = new TH2F("Chi2VsTanBeta", "#chi^{2} vs tan#beta", 500,     0.,  100., 500, 25., 50.);
   histChi2VsTanBeta->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsTanBeta->GetXaxis()->SetTitle("tan#beta");

   histChi2VsMassTop = new TH2F("Chi2VsMassTop", "#chi^{2} vs m_{t}",     500,   164.,  184., 500, 25., 50.);
   histChi2VsMassTop->GetYaxis()->SetTitle("#chi^{2}");
   histChi2VsMassTop->GetXaxis()->SetTitle("m_{t} [GeV]");

   TString option = GetOption();
}

void EdgeDetection::SlaveBegin(TTree * /*tree*/)
{
   // The SlaveBegin() function is called after the Begin() function.
   // When running with PROOF SlaveBegin() is called on each slave server.
   // The tree argument is deprecated (on PROOF 0 is passed).

   TString option = GetOption();
}

Bool_t EdgeDetection::Process(Long64_t entry)
{
   // The Process() function is called for each entry in the tree (or possibly
   // keyed object in the case of PROOF) to be processed. The entry argument
   // specifies which entry in the currently loaded tree is to be processed.
   // It can be passed to either EdgeDetection::GetEntry() or TBranch::GetEntry()
   // to read either all or the required parts of the data. When processing
   // keyed objects with PROOF, the object is already loaded and is available
   // via the fObject pointer.
   //
   // This function should contain the "body" of the analysis. It can contain
   // simple or elaborate selection criteria, run algorithms on the data
   // of the event and typically fill histograms.
   //
   // The processing can be stopped by calling Abort().
   //
   // Use fStatus to set the return value of TTree::Process().
   //
   // The return value is currently not used.

   b_chi2->GetEntry(entry);
   b_P_A0->GetEntry(entry);
   b_P_M0->GetEntry(entry);
   b_P_M12->GetEntry(entry);
   b_P_TanBeta->GetEntry(entry);
   b_P_massTop->GetEntry(entry);
   b_O_Bsg_npf->GetEntry(entry);

   histChi2VsA0->Fill(P_A0, chi2);
   histChi2VsM0->Fill(P_M0, chi2);
   histChi2VsM12->Fill(P_M12, chi2);
   histChi2VsTanBeta->Fill(P_TanBeta, chi2);
   histChi2VsMassTop->Fill(P_massTop, chi2);

   return kTRUE;
}

void EdgeDetection::SlaveTerminate()
{
   // The SlaveTerminate() function is called after all entries or objects
   // have been processed. When running with PROOF SlaveTerminate() is called
   // on each slave server.
}

void EdgeDetection::Terminate()
{
   // The Terminate() function is the last function to be called during
   // a query. It always runs on the client, it can be used to present
   // the results graphically or save the results to file.

   histChi2VsA0->Write();
   histChi2VsM0->Write();
   histChi2VsM12->Write();
   histChi2VsTanBeta->Write();
   histChi2VsMassTop->Write();

   // Close the output file.
   outputFile->Close();
   delete outputFile;
}
