//////////////////////////////////////////////////////////
// This class has been automatically generated on
// Wed Jul 18 15:21:23 2012 by ROOT version 5.28/00
// from TTree markovChain/skimmed tree
// found on file: test2.root
//////////////////////////////////////////////////////////

#ifndef EdgeDetection_h
#define EdgeDetection_h

#include <TROOT.h>
#include <TChain.h>
#include <TFile.h>
#include <TSelector.h>

// Which model
// NUHM1 = 1
// NUHM2 = 2
int model = THEMODEL;

// Minimum chi2
float minChi2 = 1E10;

class EdgeDetection : public TSelector {
public :
   TTree          *fChain;   //!pointer to the analyzed TTree or TChain

   // Declaration of leaf types
   Float_t         likelihood;
   Float_t         rho;
   Float_t         chi2;
   Float_t         LEO_chi2;
   Float_t         af_chi2;
   Float_t         accpoint;
   Float_t         n;
   Float_t         globalIter;
   Float_t         haveAcceptedAtLeastOne;
   Float_t         LHC_CLb;
   Float_t         LHC_CLsb;
   Float_t         LHC_chi2;
   Float_t         LHC_Exp_CLb;
   Float_t         LHC_Exp_CLsb;
   Float_t         LHC_Exp_chi2;
   Float_t         af_photon;
   Float_t         af_relic;
   Float_t         af_svind;
   Float_t         af_direct;
   Float_t         af_chi2_total;
   Float_t         af_chi2_photon;
   Float_t         af_chi2_relic;
   Float_t         af_chi2_svind;
   Float_t         af_chi2_direct;
   Float_t         globalHiggsChi2;
   Float_t         P_M0;
   Float_t         P_M12;
   Float_t         P_A0;
   Float_t         P_M0H;
   Float_t         P_M0Hu;
   Float_t         P_M0Hd;
   Float_t         P_massTop;
   Float_t         P_TanBeta;
   Float_t         O_Bsg_npf;
   Float_t         O_dm_s_npf;
   Float_t         O_Btn_npf;
   Float_t         O_gmin2m_npf;
   Float_t         O_omega;
   Float_t         O_Massh0_npf;
   Float_t         O_MassW_npf;
   Float_t         O_sin_th_eff_npf;
   Float_t         O_B_smm_npf;
   Float_t         O_alphaem;
   Float_t         O_G_F;
   Float_t         O_alphas;
   Float_t         O_massZ;
   Float_t         O_massBottom;
   Float_t         O_massTop;
   Float_t         O_massTau;
   Float_t         O_massCharm;
   Float_t         O_massh0_nofit;
   Float_t         O_massA0_nofit;
   Float_t         O_massH0_nofit;
   Float_t         O_massHplus_nofit;
   Float_t         O_massSupL_nofit;
   Float_t         O_massSupR_nofit;
   Float_t         O_massSdownL_nofit;
   Float_t         O_massSdownR_nofit;
   Float_t         O_massScharmL_nofit;
   Float_t         O_massScharmR_nofit;
   Float_t         O_massSstrangeL_nofit;
   Float_t         O_massSstrangeR_nofit;
   Float_t         O_massStop1_nofit;
   Float_t         O_massStop2_nofit;
   Float_t         O_massSbottom1_nofit;
   Float_t         O_massSbottom2_nofit;
   Float_t         O_massSelectronL_nofit;
   Float_t         O_massSelectronR_nofit;
   Float_t         O_massSmuL_nofit;
   Float_t         O_massSmuR_nofit;
   Float_t         O_massStau1_nofit;
   Float_t         O_massStau2_nofit;
   Float_t         O_massSnueL_nofit;
   Float_t         O_massSnumuL_nofit;
   Float_t         O_massSnutau1_nofit;
   Float_t         O_massGluino_nofit;
   Float_t         O_massNeutralino1_nofit;
   Float_t         O_massNeutralino2_nofit;
   Float_t         O_massNeutralino3_nofit;
   Float_t         O_massNeutralino4_nofit;
   Float_t         O_massChargino1_nofit;
   Float_t         O_massChargino2_nofit;
   Float_t         O_Neutralino2_To_Electron_SelectronR__nofit;
   Float_t         O_Neutralino2_To_Muon_SmuonR__nofit;
   Float_t         O_Neutralino2_To_Electron_SelectronL__nofit;
   Float_t         O_Neutralino2_To_Muon_SmuonL__nofit;
   Float_t         O_Neutralino2_To_Tau_Stau1__nofit;
   Float_t         O_Neutralino2_To_Nutau_Snutau1__nofit;
   Float_t         O_Neutralino2_To_Tau_Stau2__nofit;
   Float_t         O_Neutralino2_To_Neutralino1_Z__nofit;
   Float_t         O_Neutralino2_To_Neutralino1_h0__nofit;
   Float_t         O_Neutralino2_To_Nutau_Snutau2__nofit;
   Float_t         O_Chargino1_To_Neutralino1_W__nofit;
   Float_t         O_Chargino1_To_Nutau_Stau1__nofit;
   Float_t         O_Chargino1_To_Nutau_Stau2__nofit;
   Float_t         O_Chargino1_To_Electron_SnueL__nofit;
   Float_t         O_Chargino1_To_Muon_SnumuL__nofit;
   Float_t         O_Chargino1_To_Tau_Snutau1__nofit;
   Float_t         O_SelectronR_To_Neutralino1_Electron__nofit;
   Float_t         O_SelectronR_To_Neutralino2_Electron__nofit;
   Float_t         O_SelectronL_To_Neutralino1_Electron__nofit;
   Float_t         O_SelectronL_To_Neutralino2_Electron__nofit;
   Float_t         O_Stau1_To_Neutralino1_Tau__nofit;
   Float_t         O_Stau2_To_Neutralino1_Tau__nofit;
   Float_t         O_Stau2_To_Neutralino2_Tau__nofit;
   Float_t         O_Stau2_To_Chargino1_Nutau__nofit;
   Float_t         O_Gluino_To_Bottom_Sbottom2__nofit;
   Float_t         O_Gluino_To_Bottom_Sbottom1__nofit;
   Float_t         O_Gluino_To_Stop1_Top__nofit;
   Float_t         O_Gluino_To_Stop2_Top__nofit;
   Float_t         O_Gluino_To_SupL_up__nofit;
   Float_t         O_Gluino_To_SupR_up__nofit;
   Float_t         O_Gluino_To_SdownL_down__nofit;
   Float_t         O_Gluino_To_SdownR_down__nofit;
   Float_t         O_SupL_To_Up_Neutralino1__nofit;
   Float_t         O_SupR_To_Up_Neutralino1__nofit;
   Float_t         O_SupL_To_Up_Neutralino2__nofit;
   Float_t         O_SupR_To_Up_Neutralino2__nofit;
   Float_t         O_SupL_To_Down_Chargino1__nofit;
   Float_t         O_SupR_To_Down_Chargino1__nofit;
   Float_t         O_SupL_To_Down_Chargino2__nofit;
   Float_t         O_SupR_To_Down_Chargino2__nofit;
   Float_t         O_Stop1_To_Bottom_Chargino1__nofit;
   Float_t         O_Stop1_To_Bottom_Chargino2__nofit;
   Float_t         O_Stop1_To_Top_Neutralino1__nofit;
   Float_t         O_Stop1_To_Top_Neutralino2__nofit;
   Float_t         O_Sbottom1_To_W_Stop1__nofit;
   Float_t         O_Sbottom2_To_W_Stop1__nofit;
   Float_t         O_Sbottom1_To_Top_Chargino1__nofit;
   Float_t         O_Sbottom2_To_Neutralino2_Bottom__nofit;
   Float_t         O_Sbottom1_To_Neutralino2_Bottom__nofit;

   // List of branches
   TBranch        *b_likelihood;   //!
   TBranch        *b_rho;   //!
   TBranch        *b_chi2;   //!
   TBranch        *b_LEO_chi2;   //!
   TBranch        *b_af_chi2;   //!
   TBranch        *b_accpoint;   //!
   TBranch        *b_n;   //!
   TBranch        *b_globalIter;   //!
   TBranch        *b_haveAcceptedAtLeastOne;   //!
   TBranch        *b_LHC_CLb;   //!
   TBranch        *b_LHC_CLsb;   //!
   TBranch        *b_LHC_chi2;   //!
   TBranch        *b_LHC_Exp_CLb;   //!
   TBranch        *b_LHC_Exp_CLsb;   //!
   TBranch        *b_LHC_Exp_chi2;   //!
   TBranch        *b_af_photon;   //!
   TBranch        *b_af_relic;   //!
   TBranch        *b_af_svind;   //!
   TBranch        *b_af_direct;   //!
   TBranch        *b_af_chi2_total;   //!
   TBranch        *b_af_chi2_photon;   //!
   TBranch        *b_af_chi2_relic;   //!
   TBranch        *b_af_chi2_svind;   //!
   TBranch        *b_af_chi2_direct;   //!
   TBranch        *b_globalHiggsChi2;   //!
   TBranch        *b_P_M0;   //!
   TBranch        *b_P_M0H;   //!
   TBranch        *b_P_M0Hu;   //!
   TBranch        *b_P_M0Hd;   //!
   TBranch        *b_P_M12;   //!
   TBranch        *b_P_A0;   //!
   TBranch        *b_P_massTop;   //!
   TBranch        *b_P_TanBeta;   //!
   TBranch        *b_O_Bsg_npf;   //!
   TBranch        *b_O_dm_s_npf;   //!
   TBranch        *b_O_Btn_npf;   //!
   TBranch        *b_O_gmin2m_npf;   //!
   TBranch        *b_O_omega;   //!
   TBranch        *b_O_Massh0_npf;   //!
   TBranch        *b_O_MassW_npf;   //!
   TBranch        *b_O_sin_th_eff_npf;   //!
   TBranch        *b_O_B_smm_npf;   //!
   TBranch        *b_O_alphaem;   //!
   TBranch        *b_O_G_F;   //!
   TBranch        *b_O_alphas;   //!
   TBranch        *b_O_massZ;   //!
   TBranch        *b_O_massBottom;   //!
   TBranch        *b_O_massTop;   //!
   TBranch        *b_O_massTau;   //!
   TBranch        *b_O_massCharm;   //!
   TBranch        *b_O_massh0_nofit;   //!
   TBranch        *b_O_massA0_nofit;   //!
   TBranch        *b_O_massH0_nofit;   //!
   TBranch        *b_O_massHplus_nofit;   //!
   TBranch        *b_O_massSupL_nofit;   //!
   TBranch        *b_O_massSupR_nofit;   //!
   TBranch        *b_O_massSdownL_nofit;   //!
   TBranch        *b_O_massSdownR_nofit;   //!
   TBranch        *b_O_massScharmL_nofit;   //!
   TBranch        *b_O_massScharmR_nofit;   //!
   TBranch        *b_O_massSstrangeL_nofit;   //!
   TBranch        *b_O_massSstrangeR_nofit;   //!
   TBranch        *b_O_massStop1_nofit;   //!
   TBranch        *b_O_massStop2_nofit;   //!
   TBranch        *b_O_massSbottom1_nofit;   //!
   TBranch        *b_O_massSbottom2_nofit;   //!
   TBranch        *b_O_massSelectronL_nofit;   //!
   TBranch        *b_O_massSelectronR_nofit;   //!
   TBranch        *b_O_massSmuL_nofit;   //!
   TBranch        *b_O_massSmuR_nofit;   //!
   TBranch        *b_O_massStau1_nofit;   //!
   TBranch        *b_O_massStau2_nofit;   //!
   TBranch        *b_O_massSnueL_nofit;   //!
   TBranch        *b_O_massSnumuL_nofit;   //!
   TBranch        *b_O_massSnutau1_nofit;   //!
   TBranch        *b_O_massGluino_nofit;   //!
   TBranch        *b_O_massNeutralino1_nofit;   //!
   TBranch        *b_O_massNeutralino2_nofit;   //!
   TBranch        *b_O_massNeutralino3_nofit;   //!
   TBranch        *b_O_massNeutralino4_nofit;   //!
   TBranch        *b_O_massChargino1_nofit;   //!
   TBranch        *b_O_massChargino2_nofit;   //!
   TBranch        *b_O_Neutralino2_To_Electron_SelectronR__nofit;   //!
   TBranch        *b_O_Neutralino2_To_Muon_SmuonR__nofit;   //!
   TBranch        *b_O_Neutralino2_To_Electron_SelectronL__nofit;   //!
   TBranch        *b_O_Neutralino2_To_Muon_SmuonL__nofit;   //!
   TBranch        *b_O_Neutralino2_To_Tau_Stau1__nofit;   //!
   TBranch        *b_O_Neutralino2_To_Nutau_Snutau1__nofit;   //!
   TBranch        *b_O_Neutralino2_To_Tau_Stau2__nofit;   //!
   TBranch        *b_O_Neutralino2_To_Neutralino1_Z__nofit;   //!
   TBranch        *b_O_Neutralino2_To_Neutralino1_h0__nofit;   //!
   TBranch        *b_O_Neutralino2_To_Nutau_Snutau2__nofit;   //!
   TBranch        *b_O_Chargino1_To_Neutralino1_W__nofit;   //!
   TBranch        *b_O_Chargino1_To_Nutau_Stau1__nofit;   //!
   TBranch        *b_O_Chargino1_To_Nutau_Stau2__nofit;   //!
   TBranch        *b_O_Chargino1_To_Electron_SnueL__nofit;   //!
   TBranch        *b_O_Chargino1_To_Muon_SnumuL__nofit;   //!
   TBranch        *b_O_Chargino1_To_Tau_Snutau1__nofit;   //!
   TBranch        *b_O_SelectronR_To_Neutralino1_Electron__nofit;   //!
   TBranch        *b_O_SelectronR_To_Neutralino2_Electron__nofit;   //!
   TBranch        *b_O_SelectronL_To_Neutralino1_Electron__nofit;   //!
   TBranch        *b_O_SelectronL_To_Neutralino2_Electron__nofit;   //!
   TBranch        *b_O_Stau1_To_Neutralino1_Tau__nofit;   //!
   TBranch        *b_O_Stau2_To_Neutralino1_Tau__nofit;   //!
   TBranch        *b_O_Stau2_To_Neutralino2_Tau__nofit;   //!
   TBranch        *b_O_Stau2_To_Chargino1_Nutau__nofit;   //!
   TBranch        *b_O_Gluino_To_Bottom_Sbottom2__nofit;   //!
   TBranch        *b_O_Gluino_To_Bottom_Sbottom1__nofit;   //!
   TBranch        *b_O_Gluino_To_Stop1_Top__nofit;   //!
   TBranch        *b_O_Gluino_To_Stop2_Top__nofit;   //!
   TBranch        *b_O_Gluino_To_SupL_up__nofit;   //!
   TBranch        *b_O_Gluino_To_SupR_up__nofit;   //!
   TBranch        *b_O_Gluino_To_SdownL_down__nofit;   //!
   TBranch        *b_O_Gluino_To_SdownR_down__nofit;   //!
   TBranch        *b_O_SupL_To_Up_Neutralino1__nofit;   //!
   TBranch        *b_O_SupR_To_Up_Neutralino1__nofit;   //!
   TBranch        *b_O_SupL_To_Up_Neutralino2__nofit;   //!
   TBranch        *b_O_SupR_To_Up_Neutralino2__nofit;   //!
   TBranch        *b_O_SupL_To_Down_Chargino1__nofit;   //!
   TBranch        *b_O_SupR_To_Down_Chargino1__nofit;   //!
   TBranch        *b_O_SupL_To_Down_Chargino2__nofit;   //!
   TBranch        *b_O_SupR_To_Down_Chargino2__nofit;   //!
   TBranch        *b_O_Stop1_To_Bottom_Chargino1__nofit;   //!
   TBranch        *b_O_Stop1_To_Bottom_Chargino2__nofit;   //!
   TBranch        *b_O_Stop1_To_Top_Neutralino1__nofit;   //!
   TBranch        *b_O_Stop1_To_Top_Neutralino2__nofit;   //!
   TBranch        *b_O_Sbottom1_To_W_Stop1__nofit;   //!
   TBranch        *b_O_Sbottom2_To_W_Stop1__nofit;   //!
   TBranch        *b_O_Sbottom1_To_Top_Chargino1__nofit;   //!
   TBranch        *b_O_Sbottom2_To_Neutralino2_Bottom__nofit;   //!
   TBranch        *b_O_Sbottom1_To_Neutralino2_Bottom__nofit;   //!

   EdgeDetection(TTree * /*tree*/ =0) { }
   virtual ~EdgeDetection() { }
   virtual Int_t   Version() const { return 2; }
   virtual void    Begin(TTree *tree);
   virtual void    SlaveBegin(TTree *tree);
   virtual void    Init(TTree *tree);
   virtual Bool_t  Notify();
   virtual Bool_t  Process(Long64_t entry);
   virtual Int_t   GetEntry(Long64_t entry, Int_t getall = 0) { return fChain ? fChain->GetTree()->GetEntry(entry, getall) : 0; }
   virtual void    SetOption(const char *option) { fOption = option; }
   virtual void    SetObject(TObject *obj) { fObject = obj; }
   virtual void    SetInputList(TList *input) { fInput = input; }
   virtual TList  *GetOutputList() const { return fOutput; }
   virtual void    SlaveTerminate();
   virtual void    Terminate();

   ClassDef(EdgeDetection,0);
};

#endif

#ifdef EdgeDetection_cxx
void EdgeDetection::Init(TTree *tree)
{
   // The Init() function is called when the selector needs to initialize
   // a new tree or chain. Typically here the branch addresses and branch
   // pointers of the tree will be set.
   // It is normally not necessary to make changes to the generated
   // code, but the routine can be extended by the user if needed.
   // Init() will be called many times when running on PROOF
   // (once per file to be processed).

   // Set branch addresses and branch pointers
   if (!tree) return;
   fChain = tree;
   fChain->SetMakeClass(1);

   fChain->SetBranchAddress("likelihood", &likelihood, &b_likelihood);
   fChain->SetBranchAddress("rho", &rho, &b_rho);
   fChain->SetBranchAddress("chi2", &chi2, &b_chi2);
   fChain->SetBranchAddress("LEO_chi2", &LEO_chi2, &b_LEO_chi2);
   fChain->SetBranchAddress("af_chi2", &af_chi2, &b_af_chi2);
   fChain->SetBranchAddress("accpoint", &accpoint, &b_accpoint);
   fChain->SetBranchAddress("n", &n, &b_n);
   fChain->SetBranchAddress("globalIter", &globalIter, &b_globalIter);
   fChain->SetBranchAddress("haveAcceptedAtLeastOne", &haveAcceptedAtLeastOne, &b_haveAcceptedAtLeastOne);
   fChain->SetBranchAddress("LHC_CLb", &LHC_CLb, &b_LHC_CLb);
   fChain->SetBranchAddress("LHC_CLsb", &LHC_CLsb, &b_LHC_CLsb);
   fChain->SetBranchAddress("LHC_chi2", &LHC_chi2, &b_LHC_chi2);
   fChain->SetBranchAddress("LHC_Exp_CLb", &LHC_Exp_CLb, &b_LHC_Exp_CLb);
   fChain->SetBranchAddress("LHC_Exp_CLsb", &LHC_Exp_CLsb, &b_LHC_Exp_CLsb);
   fChain->SetBranchAddress("LHC_Exp_chi2", &LHC_Exp_chi2, &b_LHC_Exp_chi2);
   fChain->SetBranchAddress("af_photon", &af_photon, &b_af_photon);
   fChain->SetBranchAddress("af_relic", &af_relic, &b_af_relic);
   fChain->SetBranchAddress("af_svind", &af_svind, &b_af_svind);
   fChain->SetBranchAddress("af_direct", &af_direct, &b_af_direct);
   fChain->SetBranchAddress("af_chi2_total", &af_chi2_total, &b_af_chi2_total);
   fChain->SetBranchAddress("af_chi2_photon", &af_chi2_photon, &b_af_chi2_photon);
   fChain->SetBranchAddress("af_chi2_relic", &af_chi2_relic, &b_af_chi2_relic);
   fChain->SetBranchAddress("af_chi2_svind", &af_chi2_svind, &b_af_chi2_svind);
   fChain->SetBranchAddress("af_chi2_direct", &af_chi2_direct, &b_af_chi2_direct);
   fChain->SetBranchAddress("globalHiggsChi2", &globalHiggsChi2, &b_globalHiggsChi2);
   fChain->SetBranchAddress("P_M0", &P_M0, &b_P_M0);
   fChain->SetBranchAddress("P_M0H", &P_M0H, &b_P_M0H);
   fChain->SetBranchAddress("P_M0Hu", &P_M0Hu, &b_P_M0Hu);
   fChain->SetBranchAddress("P_M0Hd", &P_M0Hd, &b_P_M0Hd);
   if (model == 1)
   {
      fChain->SetBranchAddress("P_M0H", &P_M0H, &b_P_M0H);
   }
   else if (model == 2)
   {
      fChain->SetBranchAddress("P_M0Hu", &P_M0Hu, &b_P_M0Hu);
      fChain->SetBranchAddress("P_M0Hd", &P_M0Hd, &b_P_M0Hd);
   }
   fChain->SetBranchAddress("P_M12", &P_M12, &b_P_M12);
   fChain->SetBranchAddress("P_A0", &P_A0, &b_P_A0);
   fChain->SetBranchAddress("P_massTop", &P_massTop, &b_P_massTop);
   fChain->SetBranchAddress("P_TanBeta", &P_TanBeta, &b_P_TanBeta);
   fChain->SetBranchAddress("O_Bsg_npf", &O_Bsg_npf, &b_O_Bsg_npf);
   fChain->SetBranchAddress("O_dm_s_npf", &O_dm_s_npf, &b_O_dm_s_npf);
   fChain->SetBranchAddress("O_Btn_npf", &O_Btn_npf, &b_O_Btn_npf);
   fChain->SetBranchAddress("O_gmin2m_npf", &O_gmin2m_npf, &b_O_gmin2m_npf);
   fChain->SetBranchAddress("O_omega", &O_omega, &b_O_omega);
   fChain->SetBranchAddress("O_Massh0_npf", &O_Massh0_npf, &b_O_Massh0_npf);
   fChain->SetBranchAddress("O_MassW_npf", &O_MassW_npf, &b_O_MassW_npf);
   fChain->SetBranchAddress("O_sin_th_eff_npf", &O_sin_th_eff_npf, &b_O_sin_th_eff_npf);
   fChain->SetBranchAddress("O_B_smm_npf", &O_B_smm_npf, &b_O_B_smm_npf);
   fChain->SetBranchAddress("O_alphaem", &O_alphaem, &b_O_alphaem);
   fChain->SetBranchAddress("O_G_F", &O_G_F, &b_O_G_F);
   fChain->SetBranchAddress("O_alphas", &O_alphas, &b_O_alphas);
   fChain->SetBranchAddress("O_massZ", &O_massZ, &b_O_massZ);
   fChain->SetBranchAddress("O_massBottom", &O_massBottom, &b_O_massBottom);
   fChain->SetBranchAddress("O_massTop", &O_massTop, &b_O_massTop);
   fChain->SetBranchAddress("O_massTau", &O_massTau, &b_O_massTau);
   fChain->SetBranchAddress("O_massCharm", &O_massCharm, &b_O_massCharm);
   fChain->SetBranchAddress("O_massh0_nofit", &O_massh0_nofit, &b_O_massh0_nofit);
   fChain->SetBranchAddress("O_massA0_nofit", &O_massA0_nofit, &b_O_massA0_nofit);
   fChain->SetBranchAddress("O_massH0_nofit", &O_massH0_nofit, &b_O_massH0_nofit);
   fChain->SetBranchAddress("O_massHplus_nofit", &O_massHplus_nofit, &b_O_massHplus_nofit);
   fChain->SetBranchAddress("O_massSupL_nofit", &O_massSupL_nofit, &b_O_massSupL_nofit);
   fChain->SetBranchAddress("O_massSupR_nofit", &O_massSupR_nofit, &b_O_massSupR_nofit);
   fChain->SetBranchAddress("O_massSdownL_nofit", &O_massSdownL_nofit, &b_O_massSdownL_nofit);
   fChain->SetBranchAddress("O_massSdownR_nofit", &O_massSdownR_nofit, &b_O_massSdownR_nofit);
   fChain->SetBranchAddress("O_massScharmL_nofit", &O_massScharmL_nofit, &b_O_massScharmL_nofit);
   fChain->SetBranchAddress("O_massScharmR_nofit", &O_massScharmR_nofit, &b_O_massScharmR_nofit);
   fChain->SetBranchAddress("O_massSstrangeL_nofit", &O_massSstrangeL_nofit, &b_O_massSstrangeL_nofit);
   fChain->SetBranchAddress("O_massSstrangeR_nofit", &O_massSstrangeR_nofit, &b_O_massSstrangeR_nofit);
   fChain->SetBranchAddress("O_massStop1_nofit", &O_massStop1_nofit, &b_O_massStop1_nofit);
   fChain->SetBranchAddress("O_massStop2_nofit", &O_massStop2_nofit, &b_O_massStop2_nofit);
   fChain->SetBranchAddress("O_massSbottom1_nofit", &O_massSbottom1_nofit, &b_O_massSbottom1_nofit);
   fChain->SetBranchAddress("O_massSbottom2_nofit", &O_massSbottom2_nofit, &b_O_massSbottom2_nofit);
   fChain->SetBranchAddress("O_massSelectronL_nofit", &O_massSelectronL_nofit, &b_O_massSelectronL_nofit);
   fChain->SetBranchAddress("O_massSelectronR_nofit", &O_massSelectronR_nofit, &b_O_massSelectronR_nofit);
   fChain->SetBranchAddress("O_massSmuL_nofit", &O_massSmuL_nofit, &b_O_massSmuL_nofit);
   fChain->SetBranchAddress("O_massSmuR_nofit", &O_massSmuR_nofit, &b_O_massSmuR_nofit);
   fChain->SetBranchAddress("O_massStau1_nofit", &O_massStau1_nofit, &b_O_massStau1_nofit);
   fChain->SetBranchAddress("O_massStau2_nofit", &O_massStau2_nofit, &b_O_massStau2_nofit);
   fChain->SetBranchAddress("O_massSnueL_nofit", &O_massSnueL_nofit, &b_O_massSnueL_nofit);
   fChain->SetBranchAddress("O_massSnumuL_nofit", &O_massSnumuL_nofit, &b_O_massSnumuL_nofit);
   fChain->SetBranchAddress("O_massSnutau1_nofit", &O_massSnutau1_nofit, &b_O_massSnutau1_nofit);
   fChain->SetBranchAddress("O_massGluino_nofit", &O_massGluino_nofit, &b_O_massGluino_nofit);
   fChain->SetBranchAddress("O_massNeutralino1_nofit", &O_massNeutralino1_nofit, &b_O_massNeutralino1_nofit);
   fChain->SetBranchAddress("O_massNeutralino2_nofit", &O_massNeutralino2_nofit, &b_O_massNeutralino2_nofit);
   fChain->SetBranchAddress("O_massNeutralino3_nofit", &O_massNeutralino3_nofit, &b_O_massNeutralino3_nofit);
   fChain->SetBranchAddress("O_massNeutralino4_nofit", &O_massNeutralino4_nofit, &b_O_massNeutralino4_nofit);
   fChain->SetBranchAddress("O_massChargino1_nofit", &O_massChargino1_nofit, &b_O_massChargino1_nofit);
   fChain->SetBranchAddress("O_massChargino2_nofit", &O_massChargino2_nofit, &b_O_massChargino2_nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Electron_SelectronR__nofit", &O_Neutralino2_To_Electron_SelectronR__nofit, &b_O_Neutralino2_To_Electron_SelectronR__nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Muon_SmuonR__nofit", &O_Neutralino2_To_Muon_SmuonR__nofit, &b_O_Neutralino2_To_Muon_SmuonR__nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Electron_SelectronL__nofit", &O_Neutralino2_To_Electron_SelectronL__nofit, &b_O_Neutralino2_To_Electron_SelectronL__nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Muon_SmuonL__nofit", &O_Neutralino2_To_Muon_SmuonL__nofit, &b_O_Neutralino2_To_Muon_SmuonL__nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Tau_Stau1__nofit", &O_Neutralino2_To_Tau_Stau1__nofit, &b_O_Neutralino2_To_Tau_Stau1__nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Nutau_Snutau1__nofit", &O_Neutralino2_To_Nutau_Snutau1__nofit, &b_O_Neutralino2_To_Nutau_Snutau1__nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Tau_Stau2__nofit", &O_Neutralino2_To_Tau_Stau2__nofit, &b_O_Neutralino2_To_Tau_Stau2__nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Neutralino1_Z__nofit", &O_Neutralino2_To_Neutralino1_Z__nofit, &b_O_Neutralino2_To_Neutralino1_Z__nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Neutralino1_h0__nofit", &O_Neutralino2_To_Neutralino1_h0__nofit, &b_O_Neutralino2_To_Neutralino1_h0__nofit);
   fChain->SetBranchAddress("O_Neutralino2_To_Nutau_Snutau2__nofit", &O_Neutralino2_To_Nutau_Snutau2__nofit, &b_O_Neutralino2_To_Nutau_Snutau2__nofit);
   fChain->SetBranchAddress("O_Chargino1_To_Neutralino1_W__nofit", &O_Chargino1_To_Neutralino1_W__nofit, &b_O_Chargino1_To_Neutralino1_W__nofit);
   fChain->SetBranchAddress("O_Chargino1_To_Nutau_Stau1__nofit", &O_Chargino1_To_Nutau_Stau1__nofit, &b_O_Chargino1_To_Nutau_Stau1__nofit);
   fChain->SetBranchAddress("O_Chargino1_To_Nutau_Stau2__nofit", &O_Chargino1_To_Nutau_Stau2__nofit, &b_O_Chargino1_To_Nutau_Stau2__nofit);
   fChain->SetBranchAddress("O_Chargino1_To_Electron_SnueL__nofit", &O_Chargino1_To_Electron_SnueL__nofit, &b_O_Chargino1_To_Electron_SnueL__nofit);
   fChain->SetBranchAddress("O_Chargino1_To_Muon_SnumuL__nofit", &O_Chargino1_To_Muon_SnumuL__nofit, &b_O_Chargino1_To_Muon_SnumuL__nofit);
   fChain->SetBranchAddress("O_Chargino1_To_Tau_Snutau1__nofit", &O_Chargino1_To_Tau_Snutau1__nofit, &b_O_Chargino1_To_Tau_Snutau1__nofit);
   fChain->SetBranchAddress("O_SelectronR_To_Neutralino1_Electron__nofit", &O_SelectronR_To_Neutralino1_Electron__nofit, &b_O_SelectronR_To_Neutralino1_Electron__nofit);
   fChain->SetBranchAddress("O_SelectronR_To_Neutralino2_Electron__nofit", &O_SelectronR_To_Neutralino2_Electron__nofit, &b_O_SelectronR_To_Neutralino2_Electron__nofit);
   fChain->SetBranchAddress("O_SelectronL_To_Neutralino1_Electron__nofit", &O_SelectronL_To_Neutralino1_Electron__nofit, &b_O_SelectronL_To_Neutralino1_Electron__nofit);
   fChain->SetBranchAddress("O_SelectronL_To_Neutralino2_Electron__nofit", &O_SelectronL_To_Neutralino2_Electron__nofit, &b_O_SelectronL_To_Neutralino2_Electron__nofit);
   fChain->SetBranchAddress("O_Stau1_To_Neutralino1_Tau__nofit", &O_Stau1_To_Neutralino1_Tau__nofit, &b_O_Stau1_To_Neutralino1_Tau__nofit);
   fChain->SetBranchAddress("O_Stau2_To_Neutralino1_Tau__nofit", &O_Stau2_To_Neutralino1_Tau__nofit, &b_O_Stau2_To_Neutralino1_Tau__nofit);
   fChain->SetBranchAddress("O_Stau2_To_Neutralino2_Tau__nofit", &O_Stau2_To_Neutralino2_Tau__nofit, &b_O_Stau2_To_Neutralino2_Tau__nofit);
   fChain->SetBranchAddress("O_Stau2_To_Chargino1_Nutau__nofit", &O_Stau2_To_Chargino1_Nutau__nofit, &b_O_Stau2_To_Chargino1_Nutau__nofit);
   fChain->SetBranchAddress("O_Gluino_To_Bottom_Sbottom2__nofit", &O_Gluino_To_Bottom_Sbottom2__nofit, &b_O_Gluino_To_Bottom_Sbottom2__nofit);
   fChain->SetBranchAddress("O_Gluino_To_Bottom_Sbottom1__nofit", &O_Gluino_To_Bottom_Sbottom1__nofit, &b_O_Gluino_To_Bottom_Sbottom1__nofit);
   fChain->SetBranchAddress("O_Gluino_To_Stop1_Top__nofit", &O_Gluino_To_Stop1_Top__nofit, &b_O_Gluino_To_Stop1_Top__nofit);
   fChain->SetBranchAddress("O_Gluino_To_Stop2_Top__nofit", &O_Gluino_To_Stop2_Top__nofit, &b_O_Gluino_To_Stop2_Top__nofit);
   fChain->SetBranchAddress("O_Gluino_To_SupL_up__nofit", &O_Gluino_To_SupL_up__nofit, &b_O_Gluino_To_SupL_up__nofit);
   fChain->SetBranchAddress("O_Gluino_To_SupR_up__nofit", &O_Gluino_To_SupR_up__nofit, &b_O_Gluino_To_SupR_up__nofit);
   fChain->SetBranchAddress("O_Gluino_To_SdownL_down__nofit", &O_Gluino_To_SdownL_down__nofit, &b_O_Gluino_To_SdownL_down__nofit);
   fChain->SetBranchAddress("O_Gluino_To_SdownR_down__nofit", &O_Gluino_To_SdownR_down__nofit, &b_O_Gluino_To_SdownR_down__nofit);
   fChain->SetBranchAddress("O_SupL_To_Up_Neutralino1__nofit", &O_SupL_To_Up_Neutralino1__nofit, &b_O_SupL_To_Up_Neutralino1__nofit);
   fChain->SetBranchAddress("O_SupR_To_Up_Neutralino1__nofit", &O_SupR_To_Up_Neutralino1__nofit, &b_O_SupR_To_Up_Neutralino1__nofit);
   fChain->SetBranchAddress("O_SupL_To_Up_Neutralino2__nofit", &O_SupL_To_Up_Neutralino2__nofit, &b_O_SupL_To_Up_Neutralino2__nofit);
   fChain->SetBranchAddress("O_SupR_To_Up_Neutralino2__nofit", &O_SupR_To_Up_Neutralino2__nofit, &b_O_SupR_To_Up_Neutralino2__nofit);
   fChain->SetBranchAddress("O_SupL_To_Down_Chargino1__nofit", &O_SupL_To_Down_Chargino1__nofit, &b_O_SupL_To_Down_Chargino1__nofit);
   fChain->SetBranchAddress("O_SupR_To_Down_Chargino1__nofit", &O_SupR_To_Down_Chargino1__nofit, &b_O_SupR_To_Down_Chargino1__nofit);
   fChain->SetBranchAddress("O_SupL_To_Down_Chargino2__nofit", &O_SupL_To_Down_Chargino2__nofit, &b_O_SupL_To_Down_Chargino2__nofit);
   fChain->SetBranchAddress("O_SupR_To_Down_Chargino2__nofit", &O_SupR_To_Down_Chargino2__nofit, &b_O_SupR_To_Down_Chargino2__nofit);
   fChain->SetBranchAddress("O_Stop1_To_Bottom_Chargino1__nofit", &O_Stop1_To_Bottom_Chargino1__nofit, &b_O_Stop1_To_Bottom_Chargino1__nofit);
   fChain->SetBranchAddress("O_Stop1_To_Bottom_Chargino2__nofit", &O_Stop1_To_Bottom_Chargino2__nofit, &b_O_Stop1_To_Bottom_Chargino2__nofit);
   fChain->SetBranchAddress("O_Stop1_To_Top_Neutralino1__nofit", &O_Stop1_To_Top_Neutralino1__nofit, &b_O_Stop1_To_Top_Neutralino1__nofit);
   fChain->SetBranchAddress("O_Stop1_To_Top_Neutralino2__nofit", &O_Stop1_To_Top_Neutralino2__nofit, &b_O_Stop1_To_Top_Neutralino2__nofit);
   fChain->SetBranchAddress("O_Sbottom1_To_W_Stop1__nofit", &O_Sbottom1_To_W_Stop1__nofit, &b_O_Sbottom1_To_W_Stop1__nofit);
   fChain->SetBranchAddress("O_Sbottom2_To_W_Stop1__nofit", &O_Sbottom2_To_W_Stop1__nofit, &b_O_Sbottom2_To_W_Stop1__nofit);
   fChain->SetBranchAddress("O_Sbottom1_To_Top_Chargino1__nofit", &O_Sbottom1_To_Top_Chargino1__nofit, &b_O_Sbottom1_To_Top_Chargino1__nofit);
   fChain->SetBranchAddress("O_Sbottom2_To_Neutralino2_Bottom__nofit", &O_Sbottom2_To_Neutralino2_Bottom__nofit, &b_O_Sbottom2_To_Neutralino2_Bottom__nofit);
   fChain->SetBranchAddress("O_Sbottom1_To_Neutralino2_Bottom__nofit", &O_Sbottom1_To_Neutralino2_Bottom__nofit, &b_O_Sbottom1_To_Neutralino2_Bottom__nofit);
}

Bool_t EdgeDetection::Notify()
{
   // The Notify() function is called when a new file is opened. This
   // can be either for a new TTree in a TChain or when when a new TTree
   // is started when using PROOF. It is normally not necessary to make changes
   // to the generated code, but the routine can be extended by the
   // user if needed. The return value is currently not used.

   return kTRUE;
}

#endif // #ifdef EdgeDetection_cxx
