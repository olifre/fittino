#ifndef CLEANING_H
#define CLEANING_H

#include "TSpline.h"
#include "TKey.h"
#include "postProcessing.h"

// == Removal of multiple points in the ntuple
const int prevRange = 10;
Float_t M0_bef[prevRange] = {0}, M12_bef[prevRange] = {0}, TanBeta_bef[prevRange] = {0}, A0_bef[prevRange] = {0};

// == Removal of buggy points
//TCutG* cuts[7] = {0};
TSpline* cuts[7] = {0};
TFile* cutsFile = 0;
ofstream bestFitStreamOut;
//TTree* cleanedMarkovChain;

// ===================================================================
// == Assign the variables to the ntuples and open the IO files
// task: "buggyPointsRemoval", "multiplePointsRemoval"
// arg1: fit name
// arg2: input directory
// arg3: output directory

void preparIOfiles( TString task, TString arg1, TString arg2, TString arg3 ){

  fit = arg1;
  inputDir = arg2;
  outputDir = arg3;
  if( fit.Contains("NUHM1") ) model = "NUHM1";
  else if( fit.Contains("NUHM2") ) model = "NUHM2";
  else model = "msugra";

  // For the fits 3 to 6, use only the msugra mode
  if( !inputDir.Contains("fittino.out.summer2012_07") && 
      !inputDir.Contains("fittino.out.summer2012_08") && 
      !inputDir.Contains("fittino.out.summer2012_09") &&
      !inputDir.Contains("fittino.out.summer2012_10") ) model = "msugra";
  

  pp_segment = atoi( getenv("PP_SEGMENT") );
  nb_segment = atoi( getenv("NB_SEGMENT") );
  pp_segment_st = getenv("PP_SEGMENT");

  // == Opening input fit to process
  TString name_in = inputDir + fit + ".root";
  file_in = new TFile( name_in );
  markovChain_in = (TTree*) file_in->Get("markovChain");
  
 // == Assign the variables to the input ntuple
  markovChain_in->SetBranchAddress("likelihood",&likelihood );
  markovChain_in->SetBranchAddress("rho",&rho );
  markovChain_in->SetBranchAddress("chi2",&chi2 );
  if( task == "buggyPointsRemoval" ){
    markovChain_in->SetBranchAddress("LEO_chi2",&LEO_chi2 );
    markovChain_in->SetBranchAddress("LHC_chi2",&LHC_chi2 );
    markovChain_in->SetBranchAddress("Higgs_chi2",&Higgs_chi2 );
    markovChain_in->SetBranchAddress("af_chi2",&af_chi2 );
    markovChain_in->SetBranchAddress("Bsg_chi2",&Bsg_chi2 );
    markovChain_in->SetBranchAddress("dm_s_chi2",&dm_s_chi2 );
    markovChain_in->SetBranchAddress("Btn_chi2",&Btn_chi2 );
    markovChain_in->SetBranchAddress("gmin2_chi2",&gmin2_chi2 );
    markovChain_in->SetBranchAddress("omega_chi2",&omega_chi2 );
    markovChain_in->SetBranchAddress("MassW_chi2",&MassW_chi2 );
    markovChain_in->SetBranchAddress("sin_th_eff_chi2",&sin_th_eff_chi2 );
    markovChain_in->SetBranchAddress("B_smm_chi2",&B_smm_chi2 );
    markovChain_in->SetBranchAddress("massTop_chi2",&massTop_chi2 );
  }
  markovChain_in->SetBranchAddress("accpoint",&accpoint );
  markovChain_in->SetBranchAddress("n",&n );
  markovChain_in->SetBranchAddress("globalIter",&globalIter );
  markovChain_in->SetBranchAddress("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne );
  markovChain_in->SetBranchAddress("LHC_Exp_CLb",&LHC_Exp_CLb );
  markovChain_in->SetBranchAddress("LHC_Exp_CLsb",&LHC_Exp_CLsb );
  markovChain_in->SetBranchAddress("LHC_Exp_chi2",&LHC_Exp_chi2 );
  markovChain_in->SetBranchAddress("af_photon",&af_photon );
  markovChain_in->SetBranchAddress("af_relic",&af_relic );
  markovChain_in->SetBranchAddress("af_svind",&af_svind );
  markovChain_in->SetBranchAddress("af_direct",&af_direct );
  markovChain_in->SetBranchAddress("af_chi2_total",&af_chi2_total );
  markovChain_in->SetBranchAddress("af_chi2_photon",&af_chi2_photon );
  markovChain_in->SetBranchAddress("af_chi2_relic",&af_chi2_relic );
  markovChain_in->SetBranchAddress("af_chi2_svind",&af_chi2_svind );
  markovChain_in->SetBranchAddress("af_chi2_direct",&af_chi2_direct );
  markovChain_in->SetBranchAddress("globalHiggsChi2",&globalHiggsChi2 );
  markovChain_in->SetBranchAddress("HiggsSignals_TotalChi2",&HiggsSignals_TotalChi2 );
  markovChain_in->SetBranchAddress("P_M0",&P_M0 );
  markovChain_in->SetBranchAddress("P_M12",&P_M12 );
  markovChain_in->SetBranchAddress("P_A0",&P_A0 );
  markovChain_in->SetBranchAddress("P_massTop", &P_massTop );
  markovChain_in->SetBranchAddress("P_TanBeta",&P_TanBeta );
  if( model == "NUHM1" ) markovChain_in->SetBranchAddress("P_M0H",&P_M0H );
  if( model == "NUHM2" ){
    markovChain_in->SetBranchAddress("P_M0Hu",&P_M0Hu );
    markovChain_in->SetBranchAddress("P_M0Hd",&P_M0Hd );
  }
  markovChain_in->SetBranchAddress("O_massTop",&O_massTop );   
  if( fit.Contains("noObs") ){
    markovChain_in->SetBranchAddress("O_Bsg_npf_nofit",&O_Bsg_npf );
    markovChain_in->SetBranchAddress("O_dm_s_npf_nofit",&O_dm_s_npf );
    markovChain_in->SetBranchAddress("O_Btn_npf_nofit",&O_Btn_npf );
    markovChain_in->SetBranchAddress("O_omega_nofit",&O_omega);
    markovChain_in->SetBranchAddress("O_gmin2m_npf_nofit",&O_gmin2m_npf);
    markovChain_in->SetBranchAddress("O_Massh0_npf_nofit",&O_Massh0_npf );
    markovChain_in->SetBranchAddress("O_MassW_npf_nofit",&O_MassW_npf );
    markovChain_in->SetBranchAddress("O_sin_th_eff_npf_nofit",&O_sin_th_eff_npf );
    markovChain_in->SetBranchAddress("O_B_smm_npf_nofit",&O_B_smm_npf );
  }else if( fit.Contains("HiggsObs") ){
  markovChain_in->SetBranchAddress("O_Bsg_npf_nofit",&O_Bsg_npf );
    markovChain_in->SetBranchAddress("O_dm_s_npf_nofit",&O_dm_s_npf );
    markovChain_in->SetBranchAddress("O_Btn_npf_nofit",&O_Btn_npf );
    markovChain_in->SetBranchAddress("O_omega_nofit",&O_omega);
    markovChain_in->SetBranchAddress("O_gmin2m_npf_nofit",&O_gmin2m_npf);
    markovChain_in->SetBranchAddress("O_Massh0_npf",&O_Massh0_npf );
    markovChain_in->SetBranchAddress("O_MassW_npf_nofit",&O_MassW_npf );
    markovChain_in->SetBranchAddress("O_sin_th_eff_npf_nofit",&O_sin_th_eff_npf );
    markovChain_in->SetBranchAddress("O_B_smm_npf_nofit",&O_B_smm_npf );
  }else{
   markovChain_in->SetBranchAddress("O_Bsg_npf",&O_Bsg_npf );
    markovChain_in->SetBranchAddress("O_dm_s_npf",&O_dm_s_npf );
    markovChain_in->SetBranchAddress("O_Btn_npf",&O_Btn_npf );
    markovChain_in->SetBranchAddress("O_omega",&O_omega);
    markovChain_in->SetBranchAddress("O_gmin2m_npf",&O_gmin2m_npf);
    markovChain_in->SetBranchAddress("O_Massh0_npf",&O_Massh0_npf );
    markovChain_in->SetBranchAddress("O_MassW_npf",&O_MassW_npf );
    markovChain_in->SetBranchAddress("O_sin_th_eff_npf",&O_sin_th_eff_npf );
    markovChain_in->SetBranchAddress("O_B_smm_npf",&O_B_smm_npf );
  }
  markovChain_in->SetBranchAddress("O_alphaem",&O_alphaem );
  markovChain_in->SetBranchAddress("O_G_F_nofit",&O_G_F_nofit );
  markovChain_in->SetBranchAddress("O_alphas",&O_alphas );
  markovChain_in->SetBranchAddress("O_massZ",&O_massZ );
  markovChain_in->SetBranchAddress("O_massBottom_nofit",&O_massBottom_nofit );
  markovChain_in->SetBranchAddress("O_massTop",&O_massTop );
  markovChain_in->SetBranchAddress("O_massTau",&O_massTau );
  markovChain_in->SetBranchAddress("O_massCharm_nofit",&O_massCharm_nofit );
  markovChain_in->SetBranchAddress("O_massh0_nofit",&O_massh0_nofit );
  markovChain_in->SetBranchAddress("O_massA0_nofit",&O_massA0_nofit );
  markovChain_in->SetBranchAddress("O_massH0_nofit",&O_massH0_nofit );
  markovChain_in->SetBranchAddress("O_massHplus_nofit",&O_massHplus_nofit );
  markovChain_in->SetBranchAddress("O_massSupL_nofit",&O_massSupL_nofit );
  markovChain_in->SetBranchAddress("O_massSupR_nofit",&O_massSupR_nofit );
  markovChain_in->SetBranchAddress("O_massSdownL_nofit",&O_massSdownL_nofit );
  markovChain_in->SetBranchAddress("O_massSdownR_nofit",&O_massSdownR_nofit );
  markovChain_in->SetBranchAddress("O_massScharmL_nofit",&O_massScharmL_nofit );
  markovChain_in->SetBranchAddress("O_massScharmR_nofit",&O_massScharmR_nofit );
  markovChain_in->SetBranchAddress("O_massSstrangeL_nofit",&O_massSstrangeL_nofit );
  markovChain_in->SetBranchAddress("O_massSstrangeR_nofit",&O_massSstrangeR_nofit );
  markovChain_in->SetBranchAddress("O_massStop1_nofit",&O_massStop1_nofit );
  markovChain_in->SetBranchAddress("O_massStop2_nofit",&O_massStop2_nofit );
  markovChain_in->SetBranchAddress("O_massSbottom1_nofit",&O_massSbottom1_nofit );
  markovChain_in->SetBranchAddress("O_massSbottom2_nofit",&O_massSbottom2_nofit );
  markovChain_in->SetBranchAddress("O_massSelectronL_nofit",&O_massSelectronL_nofit );
  markovChain_in->SetBranchAddress("O_massSelectronR_nofit",&O_massSelectronR_nofit );
  markovChain_in->SetBranchAddress("O_massSmuL_nofit",&O_massSmuL_nofit );
  markovChain_in->SetBranchAddress("O_massSmuR_nofit",&O_massSmuR_nofit );
  markovChain_in->SetBranchAddress("O_massStau1_nofit",&O_massStau1_nofit );
  markovChain_in->SetBranchAddress("O_massStau2_nofit",&O_massStau2_nofit );
  markovChain_in->SetBranchAddress("O_massSnueL_nofit",&O_massSnueL_nofit );
  markovChain_in->SetBranchAddress("O_massSnumuL_nofit",&O_massSnumuL_nofit );
  markovChain_in->SetBranchAddress("O_massSnutau1_nofit",&O_massSnutau1_nofit );
  markovChain_in->SetBranchAddress("O_massGluino_nofit",&O_massGluino_nofit );
  markovChain_in->SetBranchAddress("O_massNeutralino1_nofit",&O_massNeutralino1_nofit );
  markovChain_in->SetBranchAddress("O_massNeutralino2_nofit",&O_massNeutralino2_nofit );
  markovChain_in->SetBranchAddress("O_massNeutralino3_nofit",&O_massNeutralino3_nofit );
  markovChain_in->SetBranchAddress("O_massNeutralino4_nofit",&O_massNeutralino4_nofit );
  markovChain_in->SetBranchAddress("O_massChargino1_nofit",&O_massChargino1_nofit );
  markovChain_in->SetBranchAddress("O_massChargino2_nofit",&O_massChargino2_nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Electron_SelectronR__nofit",&O_Neutralino2_To_Electron_SelectronR__nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Muon_SmuonR__nofit",&O_Neutralino2_To_Muon_SmuonR__nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Electron_SelectronL__nofit",&O_Neutralino2_To_Electron_SelectronL__nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Muon_SmuonL__nofit",&O_Neutralino2_To_Muon_SmuonL__nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Tau_Stau1__nofit",&O_Neutralino2_To_Tau_Stau1__nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Nutau_Snutau1__nofit",&O_Neutralino2_To_Nutau_Snutau1__nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Tau_Stau2__nofit",&O_Neutralino2_To_Tau_Stau2__nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Neutralino1_Z__nofit",&O_Neutralino2_To_Neutralino1_Z__nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Neutralino1_h0__nofit",&O_Neutralino2_To_Neutralino1_h0__nofit );
  markovChain_in->SetBranchAddress("O_Neutralino2_To_Nutau_Snutau2__nofit",&O_Neutralino2_To_Nutau_Snutau2__nofit );
  markovChain_in->SetBranchAddress("O_Chargino1_To_Neutralino1_W__nofit",&O_Chargino1_To_Neutralino1_W__nofit );
  markovChain_in->SetBranchAddress("O_Chargino1_To_Nutau_Stau1__nofit",&O_Chargino1_To_Nutau_Stau1__nofit );
  markovChain_in->SetBranchAddress("O_Chargino1_To_Nutau_Stau2__nofit",&O_Chargino1_To_Nutau_Stau2__nofit );
  markovChain_in->SetBranchAddress("O_Chargino1_To_Electron_SnueL__nofit",&O_Chargino1_To_Electron_SnueL__nofit );
  markovChain_in->SetBranchAddress("O_Chargino1_To_Muon_SnumuL__nofit",&O_Chargino1_To_Muon_SnumuL__nofit );
  markovChain_in->SetBranchAddress("O_Chargino1_To_Tau_Snutau1__nofit",&O_Chargino1_To_Tau_Snutau1__nofit );
  markovChain_in->SetBranchAddress("O_SelectronR_To_Neutralino1_Electron__nofit",&O_SelectronR_To_Neutralino1_Electron__nofit );
  markovChain_in->SetBranchAddress("O_SelectronR_To_Neutralino2_Electron__nofit",&O_SelectronR_To_Neutralino2_Electron__nofit );
  markovChain_in->SetBranchAddress("O_SelectronL_To_Neutralino1_Electron__nofit",&O_SelectronL_To_Neutralino1_Electron__nofit );
  markovChain_in->SetBranchAddress("O_SelectronL_To_Neutralino2_Electron__nofit",&O_SelectronL_To_Neutralino2_Electron__nofit );
  markovChain_in->SetBranchAddress("O_Stau1_To_Neutralino1_Tau__nofit",&O_Stau1_To_Neutralino1_Tau__nofit );
  markovChain_in->SetBranchAddress("O_Stau2_To_Neutralino1_Tau__nofit",&O_Stau2_To_Neutralino1_Tau__nofit );
  markovChain_in->SetBranchAddress("O_Stau2_To_Neutralino2_Tau__nofit",&O_Stau2_To_Neutralino2_Tau__nofit );
  markovChain_in->SetBranchAddress("O_Stau2_To_Chargino1_Nutau__nofit",&O_Stau2_To_Chargino1_Nutau__nofit );
  markovChain_in->SetBranchAddress("O_Gluino_To_Bottom_Sbottom2__nofit",&O_Gluino_To_Bottom_Sbottom2__nofit );
  markovChain_in->SetBranchAddress("O_Gluino_To_Bottom_Sbottom1__nofit",&O_Gluino_To_Bottom_Sbottom1__nofit );
  markovChain_in->SetBranchAddress("O_Gluino_To_Stop1_Top__nofit",&O_Gluino_To_Stop1_Top__nofit );
  markovChain_in->SetBranchAddress("O_Gluino_To_Stop2_Top__nofit",&O_Gluino_To_Stop2_Top__nofit );
  markovChain_in->SetBranchAddress("O_Gluino_To_SupL_up__nofit",&O_Gluino_To_SupL_up__nofit );
  markovChain_in->SetBranchAddress("O_Gluino_To_SupR_up__nofit",&O_Gluino_To_SupR_up__nofit );
  markovChain_in->SetBranchAddress("O_Gluino_To_SdownL_down__nofit",&O_Gluino_To_SdownL_down__nofit );
  markovChain_in->SetBranchAddress("O_Gluino_To_SdownR_down__nofit",&O_Gluino_To_SdownR_down__nofit );
  markovChain_in->SetBranchAddress("O_SupL_To_Up_Neutralino1__nofit",&O_SupL_To_Up_Neutralino1__nofit );
  markovChain_in->SetBranchAddress("O_SupR_To_Up_Neutralino1__nofit",&O_SupR_To_Up_Neutralino1__nofit );
  markovChain_in->SetBranchAddress("O_SupL_To_Up_Neutralino2__nofit",&O_SupL_To_Up_Neutralino2__nofit );
  markovChain_in->SetBranchAddress("O_SupR_To_Up_Neutralino2__nofit",&O_SupR_To_Up_Neutralino2__nofit );
  markovChain_in->SetBranchAddress("O_SupL_To_Down_Chargino1__nofit",&O_SupL_To_Down_Chargino1__nofit );
  markovChain_in->SetBranchAddress("O_SupR_To_Down_Chargino1__nofit",&O_SupR_To_Down_Chargino1__nofit );
  markovChain_in->SetBranchAddress("O_SupL_To_Down_Chargino2__nofit",&O_SupL_To_Down_Chargino2__nofit );
  markovChain_in->SetBranchAddress("O_SupR_To_Down_Chargino2__nofit",&O_SupR_To_Down_Chargino2__nofit );
  markovChain_in->SetBranchAddress("O_Stop1_To_Bottom_Chargino1__nofit",&O_Stop1_To_Bottom_Chargino1__nofit );
  markovChain_in->SetBranchAddress("O_Stop1_To_Bottom_Chargino2__nofit",&O_Stop1_To_Bottom_Chargino2__nofit );
  markovChain_in->SetBranchAddress("O_Stop1_To_Top_Neutralino1__nofit",&O_Stop1_To_Top_Neutralino1__nofit );
  markovChain_in->SetBranchAddress("O_Stop1_To_Top_Neutralino2__nofit",&O_Stop1_To_Top_Neutralino2__nofit );
  markovChain_in->SetBranchAddress("O_Sbottom1_To_W_Stop1__nofit",&O_Sbottom1_To_W_Stop1__nofit );
  markovChain_in->SetBranchAddress("O_Sbottom2_To_W_Stop1__nofit",&O_Sbottom2_To_W_Stop1__nofit );
  markovChain_in->SetBranchAddress("O_Sbottom1_To_Top_Chargino1__nofit",&O_Sbottom1_To_Top_Chargino1__nofit );
  markovChain_in->SetBranchAddress("O_Sbottom2_To_Neutralino2_Bottom__nofit",&O_Sbottom2_To_Neutralino2_Bottom__nofit );
  markovChain_in->SetBranchAddress("O_Sbottom1_To_Neutralino2_Bottom__nofit",&O_Sbottom1_To_Neutralino2_Bottom__nofit );

  if( task == "multiplePointsRemoval" ){
    markovChain_in->SetBranchAddress("O_h0_To_Bottom_Bottom~__nofit",&O_h0_To_Bottom_Bottom__nofit );
    markovChain_in->SetBranchAddress("O_h0_To_Strange_Strange~__nofit",&O_h0_To_Strange_Strange__nofit );
    markovChain_in->SetBranchAddress("O_h0_To_Charm_Charm~__nofit",&O_h0_To_Charm_Charm__nofit );
    markovChain_in->SetBranchAddress("O_h0_To_Tau_Tau~__nofit",&O_h0_To_Tau_Tau__nofit );
    markovChain_in->SetBranchAddress("O_h0_To_Muon_Muon~__nofit",&O_h0_To_Muon_Muon__nofit );
  }
  if( task == "buggyPointsRemoval" ){
    markovChain_in->SetBranchAddress("O_h0_To_Bottom_Bottom__nofit",&O_h0_To_Bottom_Bottom__nofit );
    markovChain_in->SetBranchAddress("O_h0_To_Strange_Strange__nofit",&O_h0_To_Strange_Strange__nofit );
    markovChain_in->SetBranchAddress("O_h0_To_Charm_Charm__nofit",&O_h0_To_Charm_Charm__nofit );
    markovChain_in->SetBranchAddress("O_h0_To_Tau_Tau__nofit",&O_h0_To_Tau_Tau__nofit );
    markovChain_in->SetBranchAddress("O_h0_To_Muon_Muon__nofit",&O_h0_To_Muon_Muon__nofit );
  }
  
  markovChain_in->SetBranchAddress("O_h0_To_Gamma_Gamma__nofit",&O_h0_To_Gamma_Gamma__nofit );
  markovChain_in->SetBranchAddress("O_h0_To_Gluon_Gluon__nofit",&O_h0_To_Gluon_Gluon__nofit );
  markovChain_in->SetBranchAddress("O_h0_To_W_W__nofit",&O_h0_To_W_W__nofit );
  markovChain_in->SetBranchAddress("O_h0_To_Z_Z__nofit",&O_h0_To_Z_Z__nofit );
  markovChain_in->SetBranchAddress("O_h0_To_Z_Gamma__nofit",&O_h0_To_Z_Gamma__nofit );

  markovChain_in->SetBranchAddress("O_HiggsScalarFermionCoupling3250505_nofit",&O_HiggsScalarFermionCoupling3250505_nofit );// h0->bb
  markovChain_in->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3250505_nofit",&O_HiggsPseudoScalarFermionCoupling3250505_nofit );// h0->bb
  markovChain_in->SetBranchAddress("O_HiggsScalarFermionCoupling3350505_nofit",&O_HiggsScalarFermionCoupling3350505_nofit );// H0->bb
  markovChain_in->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3350505_nofit",&O_HiggsPseudoScalarFermionCoupling3350505_nofit );// H0->bb
  markovChain_in->SetBranchAddress("O_HiggsScalarFermionCoupling3360505_nofit",&O_HiggsScalarFermionCoupling3360505_nofit );// A0->bb
  markovChain_in->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3360505_nofit",&O_HiggsPseudoScalarFermionCoupling3360505_nofit );// A0->bb
  markovChain_in->SetBranchAddress("O_HiggsScalarFermionCoupling3250606_nofit",&O_HiggsScalarFermionCoupling3250606_nofit );// h0->toptop
  markovChain_in->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3250606_nofit",&O_HiggsPseudoScalarFermionCoupling3250606_nofit );// h0->toptop
  markovChain_in->SetBranchAddress("O_HiggsScalarFermionCoupling3350606_nofit",&O_HiggsScalarFermionCoupling3350606_nofit );// H0->toptop
  markovChain_in->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3350606_nofit",&O_HiggsPseudoScalarFermionCoupling3350606_nofit );// H0->toptop
  markovChain_in->SetBranchAddress("O_HiggsScalarFermionCoupling3360606_nofit",&O_HiggsScalarFermionCoupling3360606_nofit );// A0->toptop
  markovChain_in->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3360606_nofit",&O_HiggsPseudoScalarFermionCoupling3360606_nofit );// A0->toptop
  markovChain_in->SetBranchAddress("O_HiggsScalarFermionCoupling3251515_nofit",&O_HiggsScalarFermionCoupling3251515_nofit );// h0->tautau
  markovChain_in->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3251515_nofit",&O_HiggsPseudoScalarFermionCoupling3251515_nofit );// h0->tautau
  markovChain_in->SetBranchAddress("O_HiggsScalarFermionCoupling3351515_nofit",&O_HiggsScalarFermionCoupling3351515_nofit );// H0->tautau
  markovChain_in->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3351515_nofit",&O_HiggsPseudoScalarFermionCoupling3351515_nofit );// H0->tautau
  markovChain_in->SetBranchAddress("O_HiggsScalarFermionCoupling3361515_nofit",&O_HiggsScalarFermionCoupling3361515_nofit );// A0->tautau
  markovChain_in->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3361515_nofit",&O_HiggsPseudoScalarFermionCoupling3361515_nofit );// A0->tautau

  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3252424_nofit",&O_HiggsBosonCoupling3252424_nofit );// h0->WW
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3352424_nofit",&O_HiggsBosonCoupling3352424_nofit );// H0->WW
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3362424_nofit",&O_HiggsBosonCoupling3362424_nofit );// A0->WW
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3252323_nofit",&O_HiggsBosonCoupling3252323_nofit );// h0->ZZ
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3352323_nofit",&O_HiggsBosonCoupling3352323_nofit );// H0->ZZ
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3362323_nofit",&O_HiggsBosonCoupling3362323_nofit );// A0->ZZ
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3252121_nofit",&O_HiggsBosonCoupling3252121_nofit );// h0->gluglu
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3352121_nofit",&O_HiggsBosonCoupling3352121_nofit );// H0->gluglu
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3362121_nofit",&O_HiggsBosonCoupling3362121_nofit );// A0->gluglu
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3252523_nofit",&O_HiggsBosonCoupling3252523_nofit );// h0->h0Z0
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3352523_nofit",&O_HiggsBosonCoupling3352523_nofit );// H0->h0Z0
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3353523_nofit",&O_HiggsBosonCoupling3353523_nofit );// H0->H0Z0
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3362523_nofit",&O_HiggsBosonCoupling3362523_nofit );// A0->h0Z0
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3363523_nofit",&O_HiggsBosonCoupling3363523_nofit );// A0->H0Z0
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling3363623_nofit",&O_HiggsBosonCoupling3363623_nofit );// A0->A0Z0
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling425212123_nofit",&O_HiggsBosonCoupling425212123_nofit );// h0->glu glu Z0
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling435212123_nofit",&O_HiggsBosonCoupling435212123_nofit );// H0->glu glu Z0
  markovChain_in->SetBranchAddress("O_HiggsBosonCoupling436212123_nofit",&O_HiggsBosonCoupling436212123_nofit );// A0->glu glu Z0
  markovChain_in->SetBranchAddress("O_h0_To_Neutralino1_Neutralino1__nofit",&O_h0_To_Neutralino1_Neutralino1__nofit );//h0->Chi10 Chi10
  markovChain_in->SetBranchAddress("O_widthh0_nofit",&O_widthh0_nofit );//h0->Chi10 Chi10


  // == Output cleaned file
  TString outName = "";
  if( task == "buggyPointsRemoval" ) outName = fit + "_final.root";
  if( task == "multiplePointsRemoval" ) outName = fit + "_cleaned.root";
  file_out = new TFile( outName, "RECREATE" );
  markovChain_out = new TTree( "markovChain", "Processed real fit" );
  //markovChain_out->SetDirectory(0);

  // 
  markovChain_out->Branch("likelihood",&likelihood,"likelihood/F");
  markovChain_out->Branch("rho",&rho,"rho/F");
  markovChain_out->Branch("chi2",&chi2,"chi2/F");
  if( task == "buggyPointsRemoval" ){
    markovChain_out->Branch("Bsg_chi2",&Bsg_chi2,"Bsg_chi2/F");
    markovChain_out->Branch("dm_s_chi2",&dm_s_chi2,"dm_s_chi2/F");
    markovChain_out->Branch("Btn_chi2",&Btn_chi2,"Btn_chi2/F");
    markovChain_out->Branch("gmin2_chi2",&gmin2_chi2,"gmin2_chi2/F");
    markovChain_out->Branch("omega_chi2",&omega_chi2,"omega_chi2/F");
    markovChain_out->Branch("MassW_chi2",&MassW_chi2,"MassW_chi2/F");
    markovChain_out->Branch("sin_th_eff_chi2",&sin_th_eff_chi2,"sin_th_eff_chi2/F");
    markovChain_out->Branch("B_smm_chi2",&B_smm_chi2,"B_smm_chi2/F");
    markovChain_out->Branch("massTop_chi2",&massTop_chi2,"massTop_chi2/F");
    markovChain_out->Branch("LEO_chi2",&LEO_chi2,"LEO_chi2/F");
    markovChain_out->Branch("LHC_chi2",&LHC_chi2,"LHC_chi2/F");
    markovChain_out->Branch("Higgs_chi2",&Higgs_chi2,"Higgs_chi2/F");
    markovChain_out->Branch("af_chi2",&af_chi2,"af_chi2/F");
  }
  markovChain_out->Branch("accpoint",&accpoint,"accpoint/F");
  markovChain_out->Branch("n",&n,"n/F");
  markovChain_out->Branch("globalIter",&globalIter,"globalIter/F");
  markovChain_out->Branch("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne,"haveAcceptedAtLeastOne/F");
  markovChain_out->Branch("LHC_Exp_CLb",&LHC_Exp_CLb,"LHC_Exp_CLb/F");
  markovChain_out->Branch("LHC_Exp_CLsb",&LHC_Exp_CLsb,"LHC_Exp_CLsb/F");
  markovChain_out->Branch("LHC_Exp_chi2",&LHC_Exp_chi2,"LHC_Exp_chi2/F");
  markovChain_out->Branch("af_photon",&af_photon,"af_photon/F");
  markovChain_out->Branch("af_relic",&af_relic,"af_relic/F");
  markovChain_out->Branch("af_svind",&af_svind,"af_svind/F");
  markovChain_out->Branch("af_direct",&af_direct,"af_direct/F");
  markovChain_out->Branch("af_chi2_total",&af_chi2_total,"af_chi2_total/F");
  markovChain_out->Branch("af_chi2_photon",&af_chi2_photon,"af_chi2_photon/F");
  markovChain_out->Branch("af_chi2_relic",&af_chi2_relic,"af_chi2_relic/F");
  markovChain_out->Branch("af_chi2_svind",&af_chi2_svind,"af_chi2_svind/F");
  markovChain_out->Branch("af_chi2_direct",&af_chi2_direct,"af_chi2_direct/F");
  markovChain_out->Branch("globalHiggsChi2",&globalHiggsChi2,"globalHiggsChi2/F");
  markovChain_out->Branch("HiggsSignals_TotalChi2",&HiggsSignals_TotalChi2,"HiggsSignals_TotalChi2/F");
  markovChain_out->Branch("P_M12",&P_M12,"P_M12/F");
  markovChain_out->Branch("P_M0",&P_M0,"P_M0/F");
  markovChain_out->Branch("P_A0",&P_A0,"P_A0/F");
  markovChain_out->Branch("P_TanBeta",&P_TanBeta,"P_TanBeta/F");
  markovChain_out->Branch("P_massTop",&P_massTop,"P_massTop/F");
  if( model == "NUHM1" ) markovChain_out->Branch("P_M0H",&P_M0H,"P_M0H/F");
   if( model == "NUHM2" ){
    markovChain_out->Branch("P_M0Hu",&P_M0Hu,"P_M0Hu/F");
    markovChain_out->Branch("P_M0Hd",&P_M0Hd,"P_M0Hd/F");
   }
   markovChain_out->Branch("O_Bsg_npf",&O_Bsg_npf,"O_Bsg_npf/F");
   markovChain_out->Branch("O_dm_s_npf",&O_dm_s_npf,"O_dm_s_npf/F");
   markovChain_out->Branch("O_Btn_npf",&O_Btn_npf,"O_Btn_npf/F");
   markovChain_out->Branch("O_omega",&O_omega,"O_omega/F");
   markovChain_out->Branch("O_gmin2m_npf",&O_gmin2m_npf,"O_gmin2m_npf/F");
   markovChain_out->Branch("O_Massh0_npf",&O_Massh0_npf,"O_Massh0_npf/F");
   markovChain_out->Branch("O_MassW_npf",&O_MassW_npf,"O_MassW_npf/F");
   markovChain_out->Branch("O_sin_th_eff_npf",&O_sin_th_eff_npf,"O_sin_th_eff_npf/F");
   markovChain_out->Branch("O_B_smm_npf",&O_B_smm_npf,"O_B_smm_npf/F");
   
   markovChain_out->Branch("O_alphaem",&O_alphaem,"O_alphaem/F");
   markovChain_out->Branch("O_G_F_nofit",&O_G_F_nofit,"O_G_F_nofit/F");
  markovChain_out->Branch("O_alphas",&O_alphas,"O_alphas/F");
  markovChain_out->Branch("O_massZ",&O_massZ,"O_massZ/F");
  markovChain_out->Branch("O_massBottom_nofit",&O_massBottom_nofit,"O_massBottom_nofit/F");
  markovChain_out->Branch("O_massTop",&O_massTop,"O_massTop/F");
  markovChain_out->Branch("O_massTau",&O_massTau,"O_massTau/F");
  markovChain_out->Branch("O_massCharm_nofit",&O_massCharm_nofit,"O_massCharm_nofit/F");
  markovChain_out->Branch("O_massh0_nofit",&O_massh0_nofit,"O_massh0_nofit/F");
  markovChain_out->Branch("O_massA0_nofit",&O_massA0_nofit,"O_massA0_nofit/F");
  markovChain_out->Branch("O_massH0_nofit",&O_massH0_nofit,"O_massH0_nofit/F");
  markovChain_out->Branch("O_massHplus_nofit",&O_massHplus_nofit,"O_massHplus_nofit/F");
  markovChain_out->Branch("O_massSupL_nofit",&O_massSupL_nofit,"O_massSupL_nofit/F");
  markovChain_out->Branch("O_massSupR_nofit",&O_massSupR_nofit,"O_massSupR_nofit/F");
  markovChain_out->Branch("O_massSdownL_nofit",&O_massSdownL_nofit,"O_massSdownL_nofit/F");
  markovChain_out->Branch("O_massSdownR_nofit",&O_massSdownR_nofit,"O_massSdownR_nofit/F");
  markovChain_out->Branch("O_massScharmL_nofit",&O_massScharmL_nofit,"O_massScharmL_nofit/F");
  markovChain_out->Branch("O_massScharmR_nofit",&O_massScharmR_nofit,"O_massScharmR_nofit/F");
  markovChain_out->Branch("O_massSstrangeL_nofit",&O_massSstrangeL_nofit,"O_massSstrangeL_nofit/F");
  markovChain_out->Branch("O_massSstrangeR_nofit",&O_massSstrangeR_nofit,"O_massSstrangeR_nofit/F");
  markovChain_out->Branch("O_massStop1_nofit",&O_massStop1_nofit,"O_massStop1_nofit/F");
  markovChain_out->Branch("O_massStop2_nofit",&O_massStop2_nofit,"O_massStop2_nofit/F");
  markovChain_out->Branch("O_massSbottom1_nofit",&O_massSbottom1_nofit,"O_massSbottom1_nofit/F");
  markovChain_out->Branch("O_massSbottom2_nofit",&O_massSbottom2_nofit,"O_massSbottom2_nofit/F");
  markovChain_out->Branch("O_massSelectronL_nofit",&O_massSelectronL_nofit,"O_massSelectronL_nofit/F");
  markovChain_out->Branch("O_massSelectronR_nofit",&O_massSelectronR_nofit,"O_massSelectronR_nofit/F");
  markovChain_out->Branch("O_massSmuL_nofit",&O_massSmuL_nofit,"O_massSmuL_nofit/F");
  markovChain_out->Branch("O_massSmuR_nofit",&O_massSmuR_nofit,"O_massSmuR_nofit/F");
  markovChain_out->Branch("O_massStau1_nofit",&O_massStau1_nofit,"O_massStau1_nofit/F");
  markovChain_out->Branch("O_massStau2_nofit",&O_massStau2_nofit,"O_massStau2_nofit/F");
  markovChain_out->Branch("O_massSnueL_nofit",&O_massSnueL_nofit,"O_massSnueL_nofit/F");
  markovChain_out->Branch("O_massSnumuL_nofit",&O_massSnumuL_nofit,"O_massSnumuL_nofit/F");
  markovChain_out->Branch("O_massSnutau1_nofit",&O_massSnutau1_nofit,"O_massSnutau1_nofit/F");
  markovChain_out->Branch("O_massGluino_nofit",&O_massGluino_nofit,"O_massGluino_nofit/F");
  markovChain_out->Branch("O_massNeutralino1_nofit",&O_massNeutralino1_nofit,"O_massNeutralino1_nofit/F");
  markovChain_out->Branch("O_massNeutralino2_nofit",&O_massNeutralino2_nofit,"O_massNeutralino2_nofit/F");
  markovChain_out->Branch("O_massNeutralino3_nofit",&O_massNeutralino3_nofit,"O_massNeutralino3_nofit/F");
  markovChain_out->Branch("O_massNeutralino4_nofit",&O_massNeutralino4_nofit,"O_massNeutralino4_nofit/F");
  markovChain_out->Branch("O_massChargino1_nofit",&O_massChargino1_nofit,"O_massChargino1_nofit/F");
  markovChain_out->Branch("O_massChargino2_nofit",&O_massChargino2_nofit,"O_massChargino2_nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Electron_SelectronR__nofit",&O_Neutralino2_To_Electron_SelectronR__nofit,"O_Neutralino2_To_Electron_SelectronR__nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Muon_SmuonR__nofit",&O_Neutralino2_To_Muon_SmuonR__nofit,"O_Neutralino2_To_Muon_SmuonR__nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Electron_SelectronL__nofit",&O_Neutralino2_To_Electron_SelectronL__nofit,"O_Neutralino2_To_Electron_SelectronL__nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Muon_SmuonL__nofit",&O_Neutralino2_To_Muon_SmuonL__nofit,"O_Neutralino2_To_Muon_SmuonL__nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Tau_Stau1__nofit",&O_Neutralino2_To_Tau_Stau1__nofit,"O_Neutralino2_To_Tau_Stau1__nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Nutau_Snutau1__nofit",&O_Neutralino2_To_Nutau_Snutau1__nofit,"O_Neutralino2_To_Nutau_Snutau1__nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Tau_Stau2__nofit",&O_Neutralino2_To_Tau_Stau2__nofit,"O_Neutralino2_To_Tau_Stau2__nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Neutralino1_Z__nofit",&O_Neutralino2_To_Neutralino1_Z__nofit,"O_Neutralino2_To_Neutralino1_Z__nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Neutralino1_h0__nofit",&O_Neutralino2_To_Neutralino1_h0__nofit,"O_Neutralino2_To_Neutralino1_h0__nofit/F");
  markovChain_out->Branch("O_Neutralino2_To_Nutau_Snutau2__nofit",&O_Neutralino2_To_Nutau_Snutau2__nofit,"O_Neutralino2_To_Nutau_Snutau2__nofit/F");
  markovChain_out->Branch("O_Chargino1_To_Neutralino1_W__nofit",&O_Chargino1_To_Neutralino1_W__nofit,"O_Chargino1_To_Neutralino1_W__nofit/F");
  markovChain_out->Branch("O_Chargino1_To_Nutau_Stau1__nofit",&O_Chargino1_To_Nutau_Stau1__nofit,"O_Chargino1_To_Nutau_Stau1__nofit/F");
  markovChain_out->Branch("O_Chargino1_To_Nutau_Stau2__nofit",&O_Chargino1_To_Nutau_Stau2__nofit,"O_Chargino1_To_Nutau_Stau2__nofit/F");
  markovChain_out->Branch("O_Chargino1_To_Electron_SnueL__nofit",&O_Chargino1_To_Electron_SnueL__nofit,"O_Chargino1_To_Electron_SnueL__nofit/F");
  markovChain_out->Branch("O_Chargino1_To_Muon_SnumuL__nofit",&O_Chargino1_To_Muon_SnumuL__nofit,"O_Chargino1_To_Muon_SnumuL__nofit/F");
  markovChain_out->Branch("O_Chargino1_To_Tau_Snutau1__nofit",&O_Chargino1_To_Tau_Snutau1__nofit,"O_Chargino1_To_Tau_Snutau1__nofit/F");
  markovChain_out->Branch("O_SelectronR_To_Neutralino1_Electron__nofit",&O_SelectronR_To_Neutralino1_Electron__nofit,"O_SelectronR_To_Neutralino1_Electron__nofit/F");
  markovChain_out->Branch("O_SelectronR_To_Neutralino2_Electron__nofit",&O_SelectronR_To_Neutralino2_Electron__nofit,"O_SelectronR_To_Neutralino2_Electron__nofit/F");
  markovChain_out->Branch("O_SelectronL_To_Neutralino1_Electron__nofit",&O_SelectronL_To_Neutralino1_Electron__nofit,"O_SelectronL_To_Neutralino1_Electron__nofit/F");
  markovChain_out->Branch("O_SelectronL_To_Neutralino2_Electron__nofit",&O_SelectronL_To_Neutralino2_Electron__nofit,"O_SelectronL_To_Neutralino2_Electron__nofit/F");
  markovChain_out->Branch("O_Stau1_To_Neutralino1_Tau__nofit",&O_Stau1_To_Neutralino1_Tau__nofit,"O_Stau1_To_Neutralino1_Tau__nofit/F");
  markovChain_out->Branch("O_Stau2_To_Neutralino1_Tau__nofit",&O_Stau2_To_Neutralino1_Tau__nofit,"O_Stau2_To_Neutralino1_Tau__nofit/F");
  markovChain_out->Branch("O_Stau2_To_Neutralino2_Tau__nofit",&O_Stau2_To_Neutralino2_Tau__nofit,"O_Stau2_To_Neutralino2_Tau__nofit/F");
  markovChain_out->Branch("O_Stau2_To_Chargino1_Nutau__nofit",&O_Stau2_To_Chargino1_Nutau__nofit,"O_Stau2_To_Chargino1_Nutau__nofit/F");
  markovChain_out->Branch("O_Gluino_To_Bottom_Sbottom2__nofit",&O_Gluino_To_Bottom_Sbottom2__nofit,"O_Gluino_To_Bottom_Sbottom2__nofit/F");
  markovChain_out->Branch("O_Gluino_To_Bottom_Sbottom1__nofit",&O_Gluino_To_Bottom_Sbottom1__nofit,"O_Gluino_To_Bottom_Sbottom1__nofit/F");
  markovChain_out->Branch("O_Gluino_To_Stop1_Top__nofit",&O_Gluino_To_Stop1_Top__nofit,"O_Gluino_To_Stop1_Top__nofit/F");
  markovChain_out->Branch("O_Gluino_To_Stop2_Top__nofit",&O_Gluino_To_Stop2_Top__nofit,"O_Gluino_To_Stop2_Top__nofit/F");
  markovChain_out->Branch("O_Gluino_To_SupL_up__nofit",&O_Gluino_To_SupL_up__nofit,"O_Gluino_To_SupL_up__nofit/F");
  markovChain_out->Branch("O_Gluino_To_SupR_up__nofit",&O_Gluino_To_SupR_up__nofit,"O_Gluino_To_SupR_up__nofit/F");
  markovChain_out->Branch("O_Gluino_To_SdownL_down__nofit",&O_Gluino_To_SdownL_down__nofit,"O_Gluino_To_SdownL_down__nofit/F");
  markovChain_out->Branch("O_Gluino_To_SdownR_down__nofit",&O_Gluino_To_SdownR_down__nofit,"O_Gluino_To_SdownR_down__nofit/F");
  markovChain_out->Branch("O_SupL_To_Up_Neutralino1__nofit",&O_SupL_To_Up_Neutralino1__nofit,"O_SupL_To_Up_Neutralino1__nofit/F");
  markovChain_out->Branch("O_SupR_To_Up_Neutralino1__nofit",&O_SupR_To_Up_Neutralino1__nofit,"O_SupR_To_Up_Neutralino1__nofit/F");
  markovChain_out->Branch("O_SupL_To_Up_Neutralino2__nofit",&O_SupL_To_Up_Neutralino2__nofit,"O_SupL_To_Up_Neutralino2__nofit/F");
  markovChain_out->Branch("O_SupR_To_Up_Neutralino2__nofit",&O_SupR_To_Up_Neutralino2__nofit,"O_SupR_To_Up_Neutralino2__nofit/F");
  markovChain_out->Branch("O_SupL_To_Down_Chargino1__nofit",&O_SupL_To_Down_Chargino1__nofit,"O_SupL_To_Down_Chargino1__nofit/F");
  markovChain_out->Branch("O_SupR_To_Down_Chargino1__nofit",&O_SupR_To_Down_Chargino1__nofit,"O_SupR_To_Down_Chargino1__nofit/F");
  markovChain_out->Branch("O_SupL_To_Down_Chargino2__nofit",&O_SupL_To_Down_Chargino2__nofit,"O_SupL_To_Down_Chargino2__nofit/F");
  markovChain_out->Branch("O_SupR_To_Down_Chargino2__nofit",&O_SupR_To_Down_Chargino2__nofit,"O_SupR_To_Down_Chargino2__nofit/F");
  markovChain_out->Branch("O_Stop1_To_Bottom_Chargino1__nofit",&O_Stop1_To_Bottom_Chargino1__nofit,"O_Stop1_To_Bottom_Chargino1__nofit/F");
  markovChain_out->Branch("O_Stop1_To_Bottom_Chargino2__nofit",&O_Stop1_To_Bottom_Chargino2__nofit,"O_Stop1_To_Bottom_Chargino2__nofit/F");
  markovChain_out->Branch("O_Stop1_To_Top_Neutralino1__nofit",&O_Stop1_To_Top_Neutralino1__nofit,"O_Stop1_To_Top_Neutralino1__nofit/F");
  markovChain_out->Branch("O_Stop1_To_Top_Neutralino2__nofit",&O_Stop1_To_Top_Neutralino2__nofit,"O_Stop1_To_Top_Neutralino2__nofit/F");
  markovChain_out->Branch("O_Sbottom1_To_W_Stop1__nofit",&O_Sbottom1_To_W_Stop1__nofit,"O_Sbottom1_To_W_Stop1__nofit/F");
  markovChain_out->Branch("O_Sbottom2_To_W_Stop1__nofit",&O_Sbottom2_To_W_Stop1__nofit,"O_Sbottom2_To_W_Stop1__nofit/F");
  markovChain_out->Branch("O_Sbottom1_To_Top_Chargino1__nofit",&O_Sbottom1_To_Top_Chargino1__nofit,"O_Sbottom1_To_Top_Chargino1__nofit/F");
  markovChain_out->Branch("O_Sbottom2_To_Neutralino2_Bottom__nofit",&O_Sbottom2_To_Neutralino2_Bottom__nofit,"O_Sbottom2_To_Neutralino2_Bottom__nofit/F");
  markovChain_out->Branch("O_Sbottom1_To_Neutralino2_Bottom__nofit",&O_Sbottom1_To_Neutralino2_Bottom__nofit,"O_Sbottom1_To_Neutralino2_Bottom__nofit/F");

  markovChain_out->Branch("O_h0_To_Bottom_Bottom__nofit",&O_h0_To_Bottom_Bottom__nofit,"O_h0_To_Bottom_Bottom__nofit/F");
  markovChain_out->Branch("O_h0_To_Strange_Strange__nofit",&O_h0_To_Strange_Strange__nofit,"O_h0_To_Strange_Strange__nofit/F");
  markovChain_out->Branch("O_h0_To_Charm_Charm__nofit",&O_h0_To_Charm_Charm__nofit,"O_h0_To_Charm_Charm__nofit/F");
  markovChain_out->Branch("O_h0_To_Tau_Tau__nofit",&O_h0_To_Tau_Tau__nofit,"O_h0_To_Tau_Tau__nofit/F");
  markovChain_out->Branch("O_h0_To_Muon_Muon__nofit",&O_h0_To_Muon_Muon__nofit,"O_h0_To_Muon_Muon__nofit/F");
  markovChain_out->Branch("O_h0_To_Gamma_Gamma__nofit",&O_h0_To_Gamma_Gamma__nofit,"O_h0_To_Gamma_Gamma__nofit/F");
  markovChain_out->Branch("O_h0_To_Gluon_Gluon__nofit",&O_h0_To_Gluon_Gluon__nofit,"O_h0_To_Gluon_Gluon__nofit/F");
  markovChain_out->Branch("O_h0_To_W_W__nofit",&O_h0_To_W_W__nofit,"O_h0_To_W_W__nofit/F");
  markovChain_out->Branch("O_h0_To_Z_Z__nofit",&O_h0_To_Z_Z__nofit,"O_h0_To_Z_Z__nofit/F");
  markovChain_out->Branch("O_h0_To_Z_Gamma__nofit",&O_h0_To_Z_Gamma__nofit,"O_h0_To_Z_Gamma__nofit/F");

  markovChain_out->Branch("O_HiggsScalarFermionCoupling3250505_nofit",&O_HiggsScalarFermionCoupling3250505_nofit,"O_HiggsScalarFermionCoupling3250505_nofit/F");
  markovChain_out->Branch("O_HiggsPseudoScalarFermionCoupling3250505_nofit",&O_HiggsPseudoScalarFermionCoupling3250505_nofit,"O_HiggsPseudoScalarFermionCoupling3250505_nofit/F");
  markovChain_out->Branch("O_HiggsScalarFermionCoupling3350505_nofit",&O_HiggsScalarFermionCoupling3350505_nofit,"O_HiggsScalarFermionCoupling3350505_nofit/F");
  markovChain_out->Branch("O_HiggsPseudoScalarFermionCoupling3350505_nofit",&O_HiggsPseudoScalarFermionCoupling3350505_nofit,"O_HiggsPseudoScalarFermionCoupling3350505_nofit/F");
  markovChain_out->Branch("O_HiggsScalarFermionCoupling3360505_nofit",&O_HiggsScalarFermionCoupling3360505_nofit,"O_HiggsScalarFermionCoupling3360505_nofit/F");
  markovChain_out->Branch("O_HiggsPseudoScalarFermionCoupling3360505_nofit",&O_HiggsPseudoScalarFermionCoupling3360505_nofit,"O_HiggsPseudoScalarFermionCoupling3360505_nofit/F");
  markovChain_out->Branch("O_HiggsScalarFermionCoupling3250606_nofit",&O_HiggsScalarFermionCoupling3250606_nofit,"O_HiggsScalarFermionCoupling3250606_nofit/F");
  markovChain_out->Branch("O_HiggsPseudoScalarFermionCoupling3250606_nofit",&O_HiggsPseudoScalarFermionCoupling3250606_nofit,"O_HiggsPseudoScalarFermionCoupling3250606_nofit/F");
  markovChain_out->Branch("O_HiggsScalarFermionCoupling3350606_nofit",&O_HiggsScalarFermionCoupling3350606_nofit,"O_HiggsScalarFermionCoupling3350606_nofit/F");
  markovChain_out->Branch("O_HiggsPseudoScalarFermionCoupling3350606_nofit",&O_HiggsPseudoScalarFermionCoupling3350606_nofit,"O_HiggsPseudoScalarFermionCoupling3350606_nofit/F");
  markovChain_out->Branch("O_HiggsScalarFermionCoupling3360606_nofit",&O_HiggsScalarFermionCoupling3360606_nofit,"O_HiggsScalarFermionCoupling3360606_nofit/F");
  markovChain_out->Branch("O_HiggsPseudoScalarFermionCoupling3360606_nofit",&O_HiggsPseudoScalarFermionCoupling3360606_nofit,"O_HiggsPseudoScalarFermionCoupling3360606_nofit/F");
  markovChain_out->Branch("O_HiggsScalarFermionCoupling3251515_nofit",&O_HiggsScalarFermionCoupling3251515_nofit,"O_HiggsScalarFermionCoupling3251515_nofit/F");
  markovChain_out->Branch("O_HiggsPseudoScalarFermionCoupling3251515_nofit",&O_HiggsPseudoScalarFermionCoupling3251515_nofit,"O_HiggsPseudoScalarFermionCoupling3251515_nofit/F");
  markovChain_out->Branch("O_HiggsScalarFermionCoupling3351515_nofit",&O_HiggsScalarFermionCoupling3351515_nofit,"O_HiggsScalarFermionCoupling3351515_nofit/F");
  markovChain_out->Branch("O_HiggsPseudoScalarFermionCoupling3351515_nofit",&O_HiggsPseudoScalarFermionCoupling3351515_nofit,"O_HiggsPseudoScalarFermionCoupling3351515_nofit/F");
  markovChain_out->Branch("O_HiggsScalarFermionCoupling3361515_nofit",&O_HiggsScalarFermionCoupling3361515_nofit,"O_HiggsScalarFermionCoupling3361515_nofit/F");
  markovChain_out->Branch("O_HiggsPseudoScalarFermionCoupling3361515_nofit",&O_HiggsPseudoScalarFermionCoupling3361515_nofit,"O_HiggsPseudoScalarFermionCoupling3361515_nofit/F");

  markovChain_out->Branch("O_HiggsBosonCoupling3252424_nofit",&O_HiggsBosonCoupling3252424_nofit,"O_HiggsBosonCoupling3252424_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3352424_nofit",&O_HiggsBosonCoupling3352424_nofit,"O_HiggsBosonCoupling3352424_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3362424_nofit",&O_HiggsBosonCoupling3362424_nofit,"O_HiggsBosonCoupling3362424_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3252323_nofit",&O_HiggsBosonCoupling3252323_nofit,"O_HiggsBosonCoupling3252323_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3352323_nofit",&O_HiggsBosonCoupling3352323_nofit,"O_HiggsBosonCoupling3352323_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3362323_nofit",&O_HiggsBosonCoupling3362323_nofit,"O_HiggsBosonCoupling3362323_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3252121_nofit",&O_HiggsBosonCoupling3252121_nofit,"O_HiggsBosonCoupling3252121_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3352121_nofit",&O_HiggsBosonCoupling3352121_nofit,"O_HiggsBosonCoupling3352121_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3362121_nofit",&O_HiggsBosonCoupling3362121_nofit,"O_HiggsBosonCoupling3362121_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3252523_nofit",&O_HiggsBosonCoupling3252523_nofit,"O_HiggsBosonCoupling3252523_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3352523_nofit",&O_HiggsBosonCoupling3352523_nofit,"O_HiggsBosonCoupling3352523_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3353523_nofit",&O_HiggsBosonCoupling3353523_nofit,"O_HiggsBosonCoupling3353523_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3362523_nofit",&O_HiggsBosonCoupling3362523_nofit,"O_HiggsBosonCoupling3362523_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3363523_nofit",&O_HiggsBosonCoupling3363523_nofit,"O_HiggsBosonCoupling3363523_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling3363623_nofit",&O_HiggsBosonCoupling3363623_nofit,"O_HiggsBosonCoupling3363623_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling425212123_nofit",&O_HiggsBosonCoupling425212123_nofit,"O_HiggsBosonCoupling425212123_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling435212123_nofit",&O_HiggsBosonCoupling435212123_nofit,"O_HiggsBosonCoupling435212123_nofit/F");
  markovChain_out->Branch("O_HiggsBosonCoupling436212123_nofit",&O_HiggsBosonCoupling436212123_nofit,"O_HiggsBosonCoupling436212123_nofit/F");
  markovChain_out->Branch("O_h0_To_Neutralino1_Neutralino1__nofit",&O_h0_To_Neutralino1_Neutralino1__nofit,"O_h0_To_Neutralino1_Neutralino1__nofit/F");
  markovChain_out->Branch("O_widthh0_nofit",&O_widthh0_nofit,"O_widthh0_nofit/F");

 return; 
}

// ===================================================================
// == Cleaning of the input file
// == - removal of multiple points
// arg1 = fit, arg2 = path to input file, arg3 = ./

void cleaningInputFile( TString task, TString arg1, TString arg2, TString arg3 ){
  
  if( task == "multiplePointsRemoval" ) cout << " >>> Removing multiple points from:" << endl << arg2 + arg1 + ".root" << endl;
  if( task == "buggyPointsRemoval" ) cout << " >>> Removing buggy points from:" << endl << arg2 + arg1 + ".root" << endl;
  preparIOfiles( task, arg1, arg2, arg3 );
  
  // ----------------------------------------------
  // Remove the buggy points
  if( task == "buggyPointsRemoval" ){

    // extract the cuts from the cuts files
    TString file_cuts = getenv( "FILECUTS" );
     cout << " >>> Splines used:" << endl << file_cuts << endl;
    cutsFile = new TFile( file_cuts );
    if( cutsFile == 0 ) cout << "WARNING, the file with cuts was not found" << endl;
    if( cutsFile != 0 ){
      TIter nextkey( cutsFile->GetListOfKeys() );
      TKey *key;
      int iter=0;
      while (key = (TKey*)nextkey()){
	TObject *obj = key->ReadObj();
	//if (obj->InheritsFrom("TCutG")){
	//cuts[iter] = (TCutG*) obj;
	if (obj->InheritsFrom("TSpline")){
	  cuts[iter] = (TSpline*) obj;
	  iter++;
	}
      }
      cutsFile->Close();
    }

    // prepar the file for the best fit point
    TString bestFitFile = outputDir + "/bestFit_" + fit + "_final.txt";
    cout << endl << " >>> Creating the file for the best fit point.. " << endl << bestFitFile << endl;
    bestFitStreamOut.open( bestFitFile );
    bestFitVal[0] = 1E5;
  }

  cout << endl << "  >> Looping over the file.. " << endl;

  // == Cut flow
  int cutFlow[6]={0};

  // == Splitting the files
  int nEnt = markovChain_in->GetEntries();
  int nBet = 0;
  int first = 0;
  int last = nEnt;
  if( task == "multiplePointsRemoval" ){
    nBet = TMath::FloorNint( nEnt / nb_segment );
    first = (pp_segment-1) * nBet;
    last = first + nBet;  
    cout << "   > PP segment: " << pp_segment << "/" << nb_segment<<" -> events: " << first << " to " << last-1 << " of " << nEnt << endl;
  }
  
  for( Int_t ievt = 0; ievt < 50000; ++ievt )  
    //for( Int_t ievt = first; ievt < last; ++ievt )  
  {
    markovChain_in->GetEntry( ievt );
    cutFlow[0]++;

    // ----------------------------------------------
    // Remove the error points (chi2=1000)
    if( chi2 >= 1000 ) continue;
    cutFlow[1]++;

    // Cut off negative chi2
    if( af_chi2_total < 0 ) continue;
    if( LHC_Exp_chi2 < 0 ) continue;
    if( HiggsSignals_TotalChi2 < 0 ) continue;
    if( !(chi2 > 0) ) continue;
    cutFlow[2]++;

    // ----------------------------------------------
    // Remove the multiple points
    // Considering the current point, the 10 points after it are compared to the current points
    // if any of these 10 is similar, the current point is rejected. Thus of all multiple points only the
    // last of the file remain, if the others stand at a maximale 'distance' of 10
    //cout << " ====================================== " << endl;
    if( task == "multiplePointsRemoval" )
      {
	Float_t thisM0 = P_M0;
	Float_t thisM12 = P_M12;
	Float_t thisA0 = P_A0;
	Float_t thisTanBeta = P_TanBeta;
	//cout << thisM0 << "  " << thisM12<< "  " <<thisA0 << "  " <<thisTanBeta<< endl;

	bool alreadySeen = 0;
	int firstChecked = ievt+1;
	int lastChecked;
	if( (ievt+10) > markovChain_in->GetEntries() ) lastChecked = last;
	else lastChecked = ievt+10;    

	for( Int_t jevt = firstChecked; jevt < lastChecked; ++jevt ){
	markovChain_in->GetEntry( jevt );
	//cout << "...... Checking " << P_M0  << "  " << P_M12<< "  " <<P_TanBeta << "  " <<P_A0 << endl;
	if( thisM0 == P_M0 && thisM12 == P_M12 && thisA0 == P_A0 && thisTanBeta == P_TanBeta ){
	  alreadySeen = 1;
	  break;
	}
	}
	if( alreadySeen ) continue;      	
	markovChain_in->GetEntry( ievt );	
	//cout << P_M0 << "  " << P_M12 << "   " << P_TanBeta << "   " << P_A0 << " --> " << alreadySeen << endl;
      }  

    cutFlow[3]++;

     // ----------------------------------------------
    // Remove the buggy points
    // Cuts are implemented by eye&hand, should be soon make use
    // of splines and edge detection algorithm
    if( task == "buggyPointsRemoval" )
      {
	bool raus = 0;
	for( int icut = 0; icut < 7; icut++ ){
	  if( raus ) break;
	  if( cuts[icut] == 0 ) continue;
	  TString name = cuts[icut]->GetName();

/* 	  if( name.Contains("A0") && cuts[icut]->IsInside( P_A0, chi2 ) ) raus = 1; */
/* 	  if( name.Contains("TanBeta") && cuts[icut]->IsInside( P_TanBeta, chi2 ) ) raus = 1; */
/* 	  if( name.Contains("M0") && cuts[icut]->IsInside( P_M0, chi2 ) ) raus = 1; */
/* 	  if( name.Contains("M12") && cuts[icut]->IsInside( P_M12, chi2 ) ) raus = 1; */
/* 	  if( name.Contains("massTop") && cuts[icut]->IsInside( P_massTop, chi2 ) ) raus = 1; */
/* 	  if( model == "NUHM1" ) */
/* 	  if( name.Contains("M0H") && cuts[icut]->IsInside( P_M0H, chi2 ) ) raus = 1; */
/* 	  if( model == "NUHM2" ){ */
/* 	    if( name.Contains("M0Hu") && cuts[icut]->IsInside( P_M0Hu, chi2 ) ) raus = 1; */
/* 	    if( name.Contains("M0Hd") && cuts[icut]->IsInside( P_M0Hd, chi2 ) ) raus = 1; */
/* 	  } */

	
/* 	  cout << name << endl; */
/* 	  if( name.Contains("A0") ) cout << cuts[icut]->Eval( P_A0 )  << endl; */
/* 	  if( name.Contains("TanBeta") ) cout << cuts[icut]->Eval( P_TanBeta )  << endl; */
/* 	  if( name.Contains("M0") ) cout << cuts[icut]->Eval( P_M0 )  << endl; */
/* 	  if( name.Contains("M12") ) cout << cuts[icut]->Eval( P_M12 )  << endl; */
/* 	  if( name.Contains("MassTop") ) cout << cuts[icut]->Eval( P_massTop )  << endl; */



	  if( name.Contains("A0") && chi2 < cuts[icut]->Eval( P_A0 ) ) raus = 1;
	  if( name.Contains("TanBeta") && chi2 < cuts[icut]->Eval( P_TanBeta ) ) raus = 1;
	  if( name.Contains("M0") && !name.Contains("M0H") && chi2 < cuts[icut]->Eval( P_M0 ) ) raus = 1;
	  if( name.Contains("M12") && chi2 < cuts[icut]->Eval( P_M12 ) ) raus = 1;
	  if( name.Contains("MassTop") && chi2 < cuts[icut]->Eval( P_massTop ) ) raus = 1;
	  //if( model == "NUHM1" )
	  //if( name.Contains("M0H") && chi2 < cuts[icut]->Eval( P_M0H ) ) raus = 1;
	  //if( model == "NUHM2" ){
	  //if( name.Contains("M0Hu") && chi2 < cuts[icut]->Eval( P_M0Hu ) ) raus = 1;
	  //if( name.Contains("M0Hd") && chi2 < cuts[icut]->Eval( P_M0Hd ) ) raus = 1;
	  //}
	}

	// == Cut out useless high chi2 points, chi2=60 is the limit used by the buggy point removal tool
	if( chi2 > 60 ) continue;
        cutFlow[4]++;
	if( raus ) continue;	
	cutFlow[5]++;
      
	// == On ATLAS request, special cuts
	//if( chi2 > (32+2.3) ) continue;

	if( chi2 < bestFitVal[0] ){
	  bestFitVal[0] = chi2;
	  bestFitVal[1] = O_Bsg_npf;
	  bestFitVal[2] = O_dm_s_npf;
	  bestFitVal[3] = O_Btn_npf;
	  bestFitVal[4] = O_gmin2m_npf;
	  bestFitVal[5] = O_omega;
	  bestFitVal[6] = O_Massh0_npf;
	  bestFitVal[7] = O_MassW_npf;
	  bestFitVal[8] = O_sin_th_eff_npf;
	  bestFitVal[9] = O_B_smm_npf;
	  bestFitVal[10] = O_massTop;
	  bestFitVal[11] = O_massNeutralino1_nofit;
	  bestFitVal[12] = af_direct;
	  bestFitVal[13] = LEO_chi2;
	  bestFitVal[14] = LHC_chi2;
	  bestFitVal[15] = Higgs_chi2;
	  bestFitVal[16] = af_chi2;
	  bestFitVal[17] = Bsg_chi2;
	  bestFitVal[18] = dm_s_chi2;
	  bestFitVal[19] = Btn_chi2;
	  bestFitVal[20] = gmin2_chi2;
	  bestFitVal[21] = omega_chi2;
	  bestFitVal[22] = MassW_chi2;
	  bestFitVal[23] = sin_th_eff_chi2;
	  bestFitVal[24] = B_smm_chi2;
	  bestFitVal[25] = massTop_chi2;
	  //
	  bestFitPar[0] = P_M0;
	  bestFitPar[1] = P_M12;
	  bestFitPar[2] = P_A0;
	  bestFitPar[3] = P_TanBeta;
	  bestFitPar[4] = P_massTop;
	  if( model == "NUHM1" ) bestFitPar[5] = P_M0H;
	  if( model == "NUHM2" ){
	    bestFitPar[5] = P_M0Hu;
	    bestFitPar[6] = P_M0Hd;
	  }
	}       	
      }

    markovChain_out->Fill();
  }

  // == Print out the cut flow
  cout << endl << "  >> Cut flow of the cleaning.. " << endl;
  cout << "   > Start:         " << cutFlow[0] << endl;
  cout << "   > Chi2<1000:     " << cutFlow[1] << endl;
  cout << "   > Chi2>0:        " << cutFlow[2] << endl;
  cout << "   > Double points: " << cutFlow[3] << endl;
  if( task == "buggyPointsRemoval" ){
    cout << "   > Chi2<60:       " << cutFlow[4] << endl;
    cout << "   > Buggy points:  " << cutFlow[5] << endl;
  }

  // Save the ntuples
 file_out->cd();
 markovChain_out->FlushBaskets();
 markovChain_out->Write();
 file_in->Close();
 file_out->Close();

 // Save the best fit point 
 if( task == "buggyPointsRemoval" )
   {
     for( int iVal = 0; iVal < ValName.size(); iVal++ ) bestFitStreamOut << ValName[iVal] << " " << bestFitVal[iVal] << endl;
     for( int iPar = 0; iPar < ParName.size(); iPar++ ) bestFitStreamOut << ParName[iPar] << " " << bestFitPar[iPar] << endl;      
     bestFitStreamOut.close(); 
     
     // Display the results
     cout << endl << " >>> Lowest chi2 point after post-processing.." << endl;
     for( int iPar = 0; iPar < ParName.size(); iPar++ ){
       cout << ParName[iPar] << " = " << bestFitPar[iPar] << endl;
     }
     for( int iVal = 0; iVal < ValName.size(); iVal++ ) cout << ValName[iVal] << " = " << bestFitVal[iVal] << endl;
   }  

 return;
}

#endif
