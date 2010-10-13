
// This ROOT macro skims the markov chains produced by Fittino 

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

// typical chi2 minima without the points with the bug:
// markov.le_obs.only.4paras: 20.587

void SkimMarkovChains ( string outputRootFileName = "MarkovChainNtupFileSkimmed.root", 
			double maxDeltaChi2 = 6.2, 
			int maxevents = -1,
			double absMinChi2 = 0. ) {

  TChain markovChain("markovChain");
  //  markovChain.Add("MarkovChainNtupFile.*.root"); // multiple file chain can give weird results
  markovChain.Add("MarkovChainNtupFile.sum.root");
  // markovChain.Add("MarkovTestRosenbrockNTupel.root");
  //  markovChain.Print();

  int nEntries = markovChain.GetEntries();
  if ( maxevents >= 0 ) {
    if (nEntries > maxevents) nEntries = maxevents;
  }
  std::cout << "number of entries " << nEntries << std::endl;

  const int nLeaves = markovChain.GetListOfLeaves()->GetEntries();

  if (nLeaves > 10000) {
    cerr << "Increase leaf array size" << endl;
    return;
  }

  std::cout << "number of leaves " << nLeaves << std::endl;

  float* par   = new float[nLeaves];
  //float* par   = new float[10000];
  //float par[10000];
  //  TLeafD* leaf[nLeaves];
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

  // get leaves
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
    
  } 

  if (iChi2<0) {
    cout << "input tree incomplete" << endl;
    return;
  }
  if (iLikelihood<0) {
    cout << "input tree incomplete" << endl;
    return;
  }
  

  // create new output tree
  TFile* outputRootFile = new TFile (outputRootFileName.c_str(),"RECREATE");
  TTree* newTree = new TTree ("markovChain","Skimmed MarkovChainTree");
  for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
     string str = leaf[iLeaf]->GetName();
     str.append("/F");
     //     cout << "Adding branch " << leaf[iLeaf]->GetName() << " to tree" << endl;
     newTree->Branch(leaf[iLeaf]->GetName(), &par[iLeaf], str.c_str());
     str.erase();
  }

  cout << "looping over events to find minimal chi2 at iChi2 = " << iChi2 << " iLikelihood = " << iLikelihood << endl;


  // clean up NPFitter bug
  //  absMinChi2 = 19.349; // for xsec_realsys

  /*
  absMinChi2 = 19.31; // for noxsec
  const int nm0 = 15;
  double m0[] = { 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 
                  110, 130, 150, 200};
  double c2m0[] = {21.78, 20.48, 19.76, 19.46, 19.34, 19.31, 19.31, 19.31, 19.32, 19.35, 19.38,
                   19.55, 19.75, 19.98, 20.51};
  TGraph* gm0 = new TGraph(nm0, m0, c2m0);

  const int nm12 = 19;
  double m12[] = { 220, 230, 240, 250, 260, 280, 300, 320, 340, 360, 380, 400,
                   450, 500, 600, 700, 800, 900, 1000};
  double c2m12[] = { 21.72, 20.91, 20.41, 20.07, 19.8, 19.52, 19.37, 19.31, 19.33, 19.47, 19.68, 19.99,
		     20.9, 21.78, 23.46, 25, 26.5, 27.36, 27.36};
  TGraph* gm12 = new TGraph(nm12, m12, c2m12);

  const int ntb = 21;
  double tb[] = {3.04, 3.5, 4, 4.5, 5, 5.5, 6, 7, 8, 9,
                 10, 11, 12, 14, 16, 18, 20, 25, 30, 35, 40};
  double c2tb[] = {26, 23.66, 22.11, 21.25, 20.71, 20.36, 20.13, 19.78, 19.59, 19.43,
                   19.35, 19.32, 19.30, 19.36, 19.48, 19.7, 19.99, 20.83, 22.09, 23.46, 24.16};
  TGraph* gtb = new TGraph(ntb, tb, c2tb);

  const int na0 = 22;
  double a0[] = {-2500, -1580, -1300, -1100, -800, -500, -300, -200, -100, 0,
                 100, 200, 300, 400, 600, 800, 1000, 1200, 1400,
                 1600, 1800, 2100};
  double c2a0[] = {26, 26, 24.97, 24.11, 22.67, 21.05, 20.15, 19.84, 19.61, 19.48,
                   19.39, 19.32, 19.30, 19.30, 19.41, 19.63, 20.06, 20.56, 21.23,
                   22.76, 23.93, 26};
  TGraph* ga0 = new TGraph(na0, a0, c2a0);
  */

  /*
  absMinChi2 = 19.348; // for xsec_realsys
  const int nm0 = 17;
  double m0[] = { 36, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 
                  110, 130, 150, 200, 250};
  double c2m0[] = { 24.40, 22.68, 21.20, 20.22, 19.67, 19.41, 19.36, 19.34, 19.34, 19.36, 19.39, 19.41,
                    19.57, 19.76, 19.96, 20.50, 20.97};
  TGraph* gm0 = new TGraph(nm0, m0, c2m0);

  const int nm12 = 21;
  double m12[] = { 200, 220, 230, 240, 250, 260, 280, 300, 320, 340, 360, 380, 400,
                   450, 500, 600, 700, 750, 800, 900, 1000};
  double c2m12[] = { 26, 23.68, 22.52, 21.73, 21.05, 20.55, 19.81, 19.40, 19.34, 19.36, 19.48, 19.69, 19.97,
                     20.88, 21.75, 23.53, 25.12, 26, 26, 26, 26};
  TGraph* gm12 = new TGraph(nm12, m12, c2m12);

  const int ntb = 22;
  double tb[] = {2, 3.04, 3.5, 4, 4.5, 5, 5.5, 6, 7, 8, 9,
                 10, 11, 12, 14, 16, 18, 20, 25, 30, 35, 40};
  double c2tb[] = {26, 26, 23.66, 22.5, 21.82, 21.31, 20.93, 20.63, 20.12, 19.77, 19.53,
                   19.41, 19.36, 19.34, 19.38, 19.52, 19.75, 19.99, 20.83, 22.02, 23.46, 24.16};
  TGraph* gtb = new TGraph(ntb, tb, c2tb);

  const int na0 = 23;
  double a0[] = {-2500, -1580, -1300, -1100, -800, -500, -300, -200, -100, 0,
                 100, 200, 300, 400, 600, 800, 1000, 1200, 1400,
                 1600, 1800, 2100, 2300};
  double c2a0[] = {26, 26, 24.97, 24.15, 22.77, 21.29, 20.40, 20.06, 19.78, 19.59,
                   19.43, 19.37, 19.34, 19.34, 19.43, 19.63, 20.03, 20.52, 21.23,
                   22.47, 23.93, 26, 26};
  TGraph* ga0 = new TGraph(na0, a0, c2a0);
  */

  absMinChi2 = 19.384; // for xsec_realsys_2fb
  const int nm0 = 19;
  double m0[] = { 34.4, 36, 40, 45, 50, 55, 58, 60, 65, 70, 75, 80, 85, 90, 
                  110, 130, 150, 200, 250};
  double c2m0[] = { 26, 25.25, 23.49, 21.73, 20.57, 19.78, 19.56, 19.46, 19.39, 19.38, 19.38, 19.39, 19.41, 19.43,
                    19.58, 19.76, 19.96, 20.50, 20.97};
  TGraph* gm0 = new TGraph(nm0, m0, c2m0);

  const int nm12 = 23;
  double m12[] = { 200, 214, 230, 240, 250, 260, 270, 280, 290, 300, 320, 340, 360, 380, 400,
                   450, 500, 600, 700, 750, 800, 900, 1000};
  double c2m12[] = { 26, 26, 24.02, 22.77, 21.92, 21.20, 20.58, 20.14, 19.71, 19.47, 19.38, 19.39, 19.50, 19.70, 19.98,
                     20.88, 21.75, 23.53, 25.12, 26, 26, 26, 26};
  TGraph* gm12 = new TGraph(nm12, m12, c2m12);

  const int ntb = 23;
  double tb[] = {2, 3.04, 3.5, 4, 4.5, 5, 5.5, 6, 7, 8, 9,
                 10, 11, 12, 13, 14, 16, 18, 20, 25, 30, 35, 40};
  double c2tb[] = {26, 26, 23.66, 22.55, 22.09, 21.63, 21.22, 20.86, 20.26, 19.85, 19.59,
                   19.46, 19.39, 19.38, 19.38, 19.41, 19.54, 19.75, 19.99, 20.83, 21.78, 23.46, 24.16};
  TGraph* gtb = new TGraph(ntb, tb, c2tb);

  const int na0 = 23;
  double a0[] = {-2500, -1580, -1300, -1100, -800, -500, -300, -200, -100, 0,
                 100, 200, 300, 400, 600, 800, 1000, 1200, 1400,
                 1600, 1800, 2030, 2300};
  double c2a0[] = {26, 26, 24.97, 24.15, 22.77, 21.29, 20.50, 20.16, 19.87, 19.64,
                   19.48, 19.41, 19.38, 19.38, 19.45, 19.66, 20.03, 20.59, 21.69,
                   22.98, 24.38, 26, 26};
  TGraph* ga0 = new TGraph(na0, a0, c2a0);

  // find minimal chi2
  float minChi2 = 1e20;
  float minM0 = -1;
  float minM12 = -1;
  float minTanBeta = -1;
  float minA0 = 0;
  for (Int_t i=0; i<nEntries; i++) {
    markovChain.GetEntry(i);	
    float chi2 =  par[iChi2];
    if (chi2<0.) {
      continue;
    }   
    //    cout << "chi2 = " << chi2 << endl; 
    if (chi2<minChi2 && chi2>=absMinChi2) {

      if ( par[iM0] > m0[0] && par[iM0] < m0[nm0-1]) {
	if (chi2 < gm0->Eval(par[iM0])) continue;
      }
      if ( par[iM12] > m12[0] && par[iM12] < m12[nm12-1]) {
	if (chi2 < gm12->Eval(par[iM12])) continue;
      }
      if ( par[iTanBeta] > tb[0] && par[iTanBeta] < tb[ntb-1]) {
	if (chi2 < gtb->Eval(par[iTanBeta])) continue;
      }
      if ( par[iA0] > a0[0] && par[iA0] < a0[na0-1]) {
	if (chi2 < ga0->Eval(par[iA0])) continue;
      }

      if (iM0 >= 0) minM0 = par[iM0];
      if (iM12 >= 0) minM12 = par[iM12];
      if (iA0 >= 0) minA0 = par[iA0];
      if (iTanBeta >= 0) minTanBeta = par[iTanBeta];
      minChi2 = chi2;
      cout << "found new chi2 minimum with chi2 = " << minChi2 << " at" << endl; 
      cout << "M0 = " << minM0 << "  M12 = " << minM12 
	   << "  TanBeta = " << minTanBeta << "   A0 = " << minA0 << endl;
    }
  }

  cout << "minimal chi2 found at " << minChi2 << " for iChi2 = " << iChi2 << endl;
  cout << "corresponding parameter point:" << endl;
  cout << "M0 = " << minM0 << "  M12 = " << minM12 
       << "  TanBeta = " << minTanBeta << "   A0 = " << minA0 << endl;

  // fill events
  int nNewEvents = 0;
  for (Int_t i=0; i<nEntries; i++) {
    markovChain.GetEntry(i);	
    double chi2 =  par[iChi2];
    //    cout << "chi2 = " << chi2 << endl;
    if (chi2>maxDeltaChi2+minChi2) {
      continue;
    }
    if (chi2<absMinChi2) {
      continue;
    }   
//    // clean up NPfitter bug
//    if (chi2<minChi2+1.) {
//      if (iLambda>=0) {
//	if (42400. > par[iLambda] || par[iLambda] > 72800.) {
//	  continue;
//	}
//      }
//      if (iTanBeta>=0) {
//	if (12. > par[iTanBeta] || par[iTanBeta] > 33.5 ) {
//	  continue;
//	}
//      }
//      if (iM0>=0) {
//	if (0. > par[iM0] || par[iM0] > 170. ) {
//	  continue;
//	}
//      }
//      if (iM12>=0) {
//	if (240. > par[iM12] || par[iM12] > 444. ) {
//	  continue;
//	}
//      }
//      if (iA0>=0) {
//	if (-350. > par[iA0] || par[iA0] > 1250. ) {
//	  continue;
//	}
//      }
//    }
//    else if (chi2<minChi2+6.) {
//      if (iTanBeta>=0) {
//	if (3.0 > par[iTanBeta] || par[iTanBeta] > 52. ) {
//	  continue;
//	}
//      }
//      if (iM0>=0) {
//	if (0. > par[iM0] || par[iM0] > 695. ) {
//	  continue;
//	}
//      }
//      if (iM12>=0) {
//	if (185. > par[iM12] || par[iM12] > 890. ) {
//	  continue;
//	}
//      }
//      if (iA0>=0) {
//	if (-1301. > par[iA0] || par[iA0] > 2400. ) {
//	  continue;
//	}
//      }
//    }

    if ( par[iM0] > m0[0] && par[iM0] < m0[nm0-1]) {
      if (chi2 < gm0->Eval(par[iM0])) continue;
    }
    if ( par[iM12] > m12[0] && par[iM12] < m12[nm12-1]) {
      if (chi2 < gm12->Eval(par[iM12])) continue;
    }
    if ( par[iTanBeta] > tb[0] && par[iTanBeta] < tb[ntb-1]) {
      if (chi2 < gtb->Eval(par[iTanBeta])) continue;
    }
    if ( par[iA0] > a0[0] && par[iA0] < a0[na0-1]) {
      if (chi2 < ga0->Eval(par[iA0])) continue;
    }

    // end clean up
    if (iTanBeta>=0) {
      if (par[iTanBeta]>100. || par[iTanBeta]<0.) {
	continue;
      }
    }
    if (iM0>=0) {
      if (par[iM0]>10000. || par[iM0]<0.) {
	continue;
      }
    }
    if (iM12>=0) {
      if (par[iM12]>10000. || par[iM12]<0.) {
	continue;
      }
    }
    if (iA0>=0) {
      if (par[iA0]>10000. || par[iA0]<-10000.) {
	continue;
      }
    }
    if (iLambda>=0) {
      if (par[iLambda]>1000000000. || par[iLambda]<0.) {
	continue;
      }
    }
    if (iMmess>=0) {
      if (par[iMmess]>1000000000. || par[iMmess]<0.) {
	continue;
      }
    }
    if (iCgrav>=0) {
      if (par[iCgrav]>1000000. || par[iCgrav]<0.) {
	continue;
      }
    }
    nNewEvents++;
    newTree->Fill();
  }
  
  cout << "found " << nNewEvents << " events after skim" <<  endl;

  newTree->Write();
  outputRootFile->Close();

  return;

}

