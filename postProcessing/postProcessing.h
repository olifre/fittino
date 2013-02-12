#ifndef POSTPROCESSING_H
#define POSTPROCESSING_H

#include "TRandom3.h"
#include "TString.h"
#include "TFile.h"
#include "TTree.h"
#include "TMath.h"
#include "TNtuple.h"
#include "TH2.h"
#include "TCutG.h"
#include "TKey.h"

#include <iostream>
#include <string>
#include <fstream>

#include "Higgs.h"
#include "LHC.h"
#include "astrofit.h"

using namespace std;

// == Most relevant parameters
bool verbose = 0;
//int pp_segment = 0;// to speed up the PP
//int nb_segment = 0;
//TString pp_segment_st;

// == Input/Output ntuples
TFile* file_in;
TTree* markovChain_in; 
TFile* file_out;
TTree* markovChain_out;
 
// == Global variables to identify fit and model
TString fit;
TString model;
TString outputDir;
TString inputDir;

// == Fittino input file with observables
TString fittinoInput;
int useObs;

// == Measurements or bounds und uncertainties
vector<float> LEObs;
vector<float> uncLEObs;
float chipl_bound = 102.5;// lower limit on chargino mass
float mChipl = 0;

// == Lower chi2 point for nominal fit
vector<float> bestFitVal;
vector<float> bestFitPar;
vector<TString> ValName;
vector<TString> ParName;

// == Toys smeared observables
int randomSeed;
vector<float> toyVal;
TRandom3 r;
TTree* testToy_tree;

// == Lower chi2 point for an individual toy
vector<float> toyBestFitVal;
vector<float> toyBestFitPar;

// == Check ntuples for the smeared observables
TNtuple* smearedObsNtuple = {0};

// == Ntuple variables
// -- Chi2, likelihood, Markov chain
Float_t likelihood;
Float_t rho;
Float_t chi2;
Float_t pre_chi2;
Float_t accpoint;
Float_t n;
Float_t globalIter;
Float_t haveAcceptedAtLeastOne;

// -- LHC
Float_t LHC_Exp_CLb;
Float_t LHC_Exp_CLsb;
Float_t LHC_Exp_chi2;  

// -- Astrofit
Float_t af_photon;
Float_t af_relic;
Float_t af_svind;
Float_t af_direct;
Float_t af_chi2_total;
Float_t af_chi2_photon;
Float_t af_chi2_relic;
Float_t af_chi2_svind;
Float_t af_chi2_direct;

// -- Higgs
Float_t HiggsSignals_TotalChi2;
Float_t globalHiggsChi2;

// -- Individual chi2
float LEO_chi2; 
float LHC_chi2; 
double Higgs_chi2; 
double mu_chi2;
double mh_chi2;
float af_chi2;
float Bsg_chi2; 
float dm_s_chi2; 
float Btn_chi2; 
float gmin2_chi2; 
float omega_chi2; 
float MassW_chi2; 
float Massh0_chi2; 
float sin_th_eff_chi2; 
float B_smm_chi2; 
float massTop_chi2;

// -- Parameters
Float_t P_M0;
Float_t P_M12;
Float_t P_A0;
Float_t P_TanBeta;
Float_t P_massTop;
Float_t P_M0H;
Float_t P_M0Hu;
Float_t P_M0Hd;

// -- Observables
Float_t O_Bsg_npf;  
Float_t O_dm_s_npf;
Float_t O_Btn_npf;
Float_t O_gmin2m_npf;
Float_t O_omega;
Float_t O_Massh0_npf;
Float_t O_MassW_npf;
Float_t O_sin_th_eff_npf;
Float_t O_B_smm_npf;
Float_t O_alphaem;
Float_t O_G_F_nofit;
Float_t O_alphas;
Float_t O_massZ;
Float_t O_massBottom_nofit;
Float_t O_massTop;
Float_t O_massTau;
Float_t O_massCharm_nofit;
Float_t O_massh0_nofit;
Float_t O_massA0_nofit;
Float_t O_massH0_nofit;
Float_t O_massHplus_nofit;
Float_t O_massSupL_nofit;
Float_t O_massSupR_nofit;
Float_t O_massSdownL_nofit;
Float_t O_massSdownR_nofit;
Float_t O_massScharmL_nofit;
Float_t O_massScharmR_nofit;
Float_t O_massSstrangeL_nofit;
Float_t O_massSstrangeR_nofit;
Float_t O_massStop1_nofit;
Float_t O_massStop2_nofit;
Float_t O_massSbottom1_nofit;
Float_t O_massSbottom2_nofit;
Float_t O_massSelectronL_nofit;
Float_t O_massSelectronR_nofit;
Float_t O_massSmuL_nofit;
Float_t O_massSmuR_nofit;
Float_t O_massStau1_nofit;
Float_t O_massStau2_nofit;
Float_t O_massSnueL_nofit;
Float_t O_massSnumuL_nofit;
Float_t O_massSnutau1_nofit;
Float_t O_massGluino_nofit;
Float_t O_massNeutralino1_nofit;
Float_t O_massNeutralino2_nofit;
Float_t O_massNeutralino3_nofit;
Float_t O_massNeutralino4_nofit;
Float_t O_massChargino1_nofit;
Float_t O_massChargino2_nofit;
Float_t O_Neutralino2_To_Electron_SelectronR__nofit;
Float_t O_Neutralino2_To_Muon_SmuonR__nofit;
Float_t O_Neutralino2_To_Electron_SelectronL__nofit;
Float_t O_Neutralino2_To_Muon_SmuonL__nofit;
Float_t O_Neutralino2_To_Tau_Stau1__nofit;
Float_t O_Neutralino2_To_Nutau_Snutau1__nofit;
Float_t O_Neutralino2_To_Tau_Stau2__nofit;
Float_t O_Neutralino2_To_Neutralino1_Z__nofit;
Float_t O_Neutralino2_To_Neutralino1_h0__nofit;
Float_t O_Neutralino2_To_Nutau_Snutau2__nofit;
Float_t O_Chargino1_To_Neutralino1_W__nofit;
Float_t O_Chargino1_To_Nutau_Stau1__nofit;
Float_t O_Chargino1_To_Nutau_Stau2__nofit;
Float_t O_Chargino1_To_Electron_SnueL__nofit;
Float_t O_Chargino1_To_Muon_SnumuL__nofit;
Float_t O_Chargino1_To_Tau_Snutau1__nofit;
Float_t O_SelectronR_To_Neutralino1_Electron__nofit;
Float_t O_SelectronR_To_Neutralino2_Electron__nofit;
Float_t O_SelectronL_To_Neutralino1_Electron__nofit;
Float_t O_SelectronL_To_Neutralino2_Electron__nofit;
Float_t O_Stau1_To_Neutralino1_Tau__nofit;
Float_t O_Stau2_To_Neutralino1_Tau__nofit;
Float_t O_Stau2_To_Neutralino2_Tau__nofit;
Float_t O_Stau2_To_Chargino1_Nutau__nofit;
Float_t O_Gluino_To_Bottom_Sbottom2__nofit;
Float_t O_Gluino_To_Bottom_Sbottom1__nofit;
Float_t O_Gluino_To_Stop1_Top__nofit;
Float_t O_Gluino_To_Stop2_Top__nofit;
Float_t O_Gluino_To_SupL_up__nofit;
Float_t O_Gluino_To_SupR_up__nofit;
Float_t O_Gluino_To_SdownL_down__nofit;
Float_t O_Gluino_To_SdownR_down__nofit;
Float_t O_SupL_To_Up_Neutralino1__nofit;
Float_t O_SupR_To_Up_Neutralino1__nofit;
Float_t O_SupL_To_Up_Neutralino2__nofit;
Float_t O_SupR_To_Up_Neutralino2__nofit;
Float_t O_SupL_To_Down_Chargino1__nofit;
Float_t O_SupR_To_Down_Chargino1__nofit;
Float_t O_SupL_To_Down_Chargino2__nofit;
Float_t O_SupR_To_Down_Chargino2__nofit;
Float_t O_Stop1_To_Bottom_Chargino1__nofit;
Float_t O_Stop1_To_Bottom_Chargino2__nofit;
Float_t O_Stop1_To_Top_Neutralino1__nofit;
Float_t O_Stop1_To_Top_Neutralino2__nofit;
Float_t O_Sbottom1_To_W_Stop1__nofit;
Float_t O_Sbottom2_To_W_Stop1__nofit;
Float_t O_Sbottom1_To_Top_Chargino1__nofit;
Float_t O_Sbottom2_To_Neutralino2_Bottom__nofit;
Float_t O_Sbottom1_To_Neutralino2_Bottom__nofit;
Float_t O_FineTuningParameter1_nofit;
Float_t O_FineTuningParameter2_nofit;
Float_t O_FineTuningParameter3_nofit;
Float_t O_FineTuningParameter4_nofit;
Float_t O_FineTuningParameter5_nofit;
Float_t O_FineTuningParameter6_nofit;

// -- Higgs
Float_t O_h0_To_Bottom_Bottom__nofit;                                    
Float_t O_h0_To_Strange_Strange__nofit;                                  
Float_t O_h0_To_Charm_Charm__nofit;                                      
Float_t O_h0_To_Tau_Tau__nofit;                                          
Float_t O_h0_To_Muon_Muon__nofit;                                        
Float_t O_h0_To_Gamma_Gamma__nofit;                                       
Float_t O_h0_To_Gluon_Gluon__nofit;                                       
Float_t O_h0_To_W_W__nofit;                                               
Float_t O_h0_To_Z_Z__nofit;                                               
Float_t O_h0_To_Z_Gamma__nofit;       
Float_t O_HiggsScalarFermionCoupling3250505_nofit;
Float_t O_HiggsPseudoScalarFermionCoupling3250505_nofit;
Float_t O_HiggsScalarFermionCoupling3350505_nofit;
Float_t O_HiggsPseudoScalarFermionCoupling3350505_nofit;
Float_t O_HiggsScalarFermionCoupling3360505_nofit;
Float_t O_HiggsPseudoScalarFermionCoupling3360505_nofit;
Float_t O_HiggsScalarFermionCoupling3250606_nofit;
Float_t O_HiggsPseudoScalarFermionCoupling3250606_nofit;
Float_t O_HiggsScalarFermionCoupling3350606_nofit;
Float_t O_HiggsPseudoScalarFermionCoupling3350606_nofit;
Float_t O_HiggsScalarFermionCoupling3360606_nofit;
Float_t O_HiggsPseudoScalarFermionCoupling3360606_nofit;
Float_t O_HiggsScalarFermionCoupling3251515_nofit;
Float_t O_HiggsPseudoScalarFermionCoupling3251515_nofit;
Float_t O_HiggsScalarFermionCoupling3351515_nofit;
Float_t O_HiggsPseudoScalarFermionCoupling3351515_nofit;
Float_t O_HiggsScalarFermionCoupling3361515_nofit;
Float_t O_HiggsPseudoScalarFermionCoupling3361515_nofit;
Float_t O_HiggsBosonCoupling3252424_nofit;
Float_t O_HiggsBosonCoupling3352424_nofit;
Float_t O_HiggsBosonCoupling3362424_nofit;
Float_t O_HiggsBosonCoupling3252323_nofit;
Float_t O_HiggsBosonCoupling3352323_nofit;
Float_t O_HiggsBosonCoupling3362323_nofit;
Float_t O_HiggsBosonCoupling3252121_nofit;
Float_t O_HiggsBosonCoupling3352121_nofit;
Float_t O_HiggsBosonCoupling3362121_nofit;
Float_t O_HiggsBosonCoupling3252523_nofit;
Float_t O_HiggsBosonCoupling3352523_nofit;
Float_t O_HiggsBosonCoupling3353523_nofit;
Float_t O_HiggsBosonCoupling3362523_nofit;
Float_t O_HiggsBosonCoupling3363523_nofit;
Float_t O_HiggsBosonCoupling3363623_nofit;
Float_t O_HiggsBosonCoupling425212123_nofit;
Float_t O_HiggsBosonCoupling435212123_nofit;
Float_t O_HiggsBosonCoupling436212123_nofit;
Float_t O_h0_To_Neutralino1_Neutralino1__nofit;
Float_t O_widthh0_nofit;
double R_H_WW;
double R_H_ZZ; 
double R_H_gaga; 
double R_H_tautau; 
double R_H_bb; 
double R_VH_bb;

double predmu[26]={0};;

// ===================================================================
// == Set all variables to zero
void initialize( TString arg1, TString arg2, TString arg3, int PP_or_Toys, int step ){

  // == Options and parameters of the post processing
  fit = arg1;
  inputDir = arg2;
  outputDir = arg3;

  if( fit.Contains("NUHM1") ) model = "NUHM1";
  else if( fit.Contains("NUHM2") ) model = "NUHM2";
  else model = "CMSSM";

  // For the fits 3 to 6, use only the CMSSM mode
  if( !inputDir.Contains("jobs_for_multiplePointsRemoval/doublePointsRemoved/7/") &&
      !inputDir.Contains("jobs_for_multiplePointsRemoval/doublePointsRemoved/8/") &&
      !inputDir.Contains("jobs_for_multiplePointsRemoval/doublePointsRemoved/9/") &&
      !inputDir.Contains("jobs_for_multiplePointsRemoval/doublePointsRemoved/10/") &&
      !inputDir.Contains("jobs_for_multiplePointsRemoval/doublePointsRemoved/11/") &&
      !inputDir.Contains("jobs_for_multiplePointsRemoval/doublePointsRemoved/12/") &&
      !inputDir.Contains("jobs_for_multiplePointsRemoval/doublePointsRemoved/13/") ) model = "CMSSM";

  if( PP_or_Toys == 0 && step == 1 ) randomSeed = atoi( getenv("RANDOM_SEED") );
  //if(step == 1 ){
  //    nb_segment = atoi( getenv("NB_SEGMENT") );
  //    pp_segment = atoi( getenv("PP_SEGMENT") );
  //    pp_segment_st = getenv("PP_SEGMENT");
  //  }
  int _verbose = atoi( getenv("VERBOSE") );
  if( _verbose == 1 ) verbose = true;
  if( _verbose == 0 ) verbose = false;
  if( step == 1 ) useObs = atoi( getenv("OBSERVABLES") );

  if( PP_or_Toys == 2 ) testToy_tree = new TTree( "testToy_tree", "testToy_tree" );
  
  // == Set names
  ValName.push_back( "chi2" );
  ValName.push_back( "O_Bsg_npf" );
  ValName.push_back( "O_dm_s_npf" );       
  ValName.push_back( "O_Btn_npf" );        
  ValName.push_back( "O_gmin2m_npf" );     
  ValName.push_back( "O_omega" );      
  ValName.push_back( "O_Massh0_npf" );     
  ValName.push_back( "O_MassW_npf" );      
  ValName.push_back( "O_sin_th_eff_npf" ); 
  ValName.push_back( "O_B_smm_npf" );    
  ValName.push_back( "O_massTop" ); 
  ValName.push_back( "O_massNeutralino1_nofit" ); 
  ValName.push_back( "af_direct" ); 

  ValName.push_back( "LEO_chi2" ); 
  ValName.push_back( "LHC_chi2" ); 
  ValName.push_back( "Higgs_chi2" ); 
  ValName.push_back( "af_chi2" ); 
  ValName.push_back( "Bsg_chi2"); 
  ValName.push_back( "dm_s_chi2"); 
  ValName.push_back( "Btn_chi2"); 
  ValName.push_back( "gmin2_chi2"); 
  ValName.push_back( "omega_chi2"); 
  ValName.push_back( "Massh0_chi2");
  ValName.push_back( "MassW_chi2"); 
  ValName.push_back( "sin_th_eff_chi2"); 
  ValName.push_back( "B_smm_chi2"); 
  ValName.push_back( "massTop_chi2" );

  if( model == "CMSSM" ){
    ParName.push_back( "P_M0" );
    ParName.push_back( "P_M12" );
    ParName.push_back( "P_A0" );
    ParName.push_back( "P_TanBeta" );
    ParName.push_back( "P_massTop" );
  }
  if( model == "NUHM1" ){
    ParName.push_back( "P_M0" );
    ParName.push_back( "P_M12" );
    ParName.push_back( "P_A0" );
    ParName.push_back( "P_TanBeta" );
    ParName.push_back( "P_massTop" );
    ParName.push_back( "P_M0H" );
  }
  if( model == "NUHM2" ){
    ParName.push_back( "P_M0" );
    ParName.push_back( "P_M12" );
    ParName.push_back( "P_A0" );
    ParName.push_back( "P_TanBeta" );
    ParName.push_back( "P_massTop" );
    ParName.push_back( "P_M0Hu" );
    ParName.push_back( "P_M0Hd" );
  }
  string allValues = "";
  for( int iVal = 0; iVal < ValName.size(); iVal++ ){
    allValues += ValName[iVal];
    allValues += ":";
  }
  allValues += "P_M0:P_M12:P_A0:P_TanBeta";
  if( model == "NUHM1" )  allValues += ":P_M0H";
  if( model == "NUHM2" )  allValues += ":P_M0Hu:P_M0Hd";

  string smearedObsList = "Bsg:dm_s:Btn:gmin2m:omega:Massh0:MassW:sin_th_eff:B_smm:massTop:mChipl";
  smearedObsNtuple = new TNtuple( "smearedObsNtuple", "Smeared observables", smearedObsList.c_str() ); 

  // == Set size of arrays
  toyBestFitVal.resize( ValName.size() );
  toyBestFitPar.resize( ParName.size() );
  bestFitVal.resize( ValName.size() );
  bestFitPar.resize( ParName.size() );

  // == Initialize global variables to zero
  file_in = 0;
  markovChain_in = 0; 
  file_out = 0;
  markovChain_out = 0;
 
  // == Initialize HiggsSignal
  if ( useObs != 1 && useObs != 3 && useObs != 4 && useObs != 11 && useObs != 12 ) initializeHiggs( verbose, useObs );

 return; 
}



// ===================================================================
// == Assign the variables to the output ntuple
// To save disk space, only relevant branches are kept for the toys

void assignOutputBranches(){

  markovChain_out->Branch("chi2",&chi2,"chi2/F");
  markovChain_out->Branch("Bsg_chi2",&Bsg_chi2,"Bsg_chi2/F");
  markovChain_out->Branch("dm_s_chi2",&dm_s_chi2,"dm_s_chi2/F");
  markovChain_out->Branch("Btn_chi2",&Btn_chi2,"Btn_chi2/F");
  markovChain_out->Branch("gmin2_chi2",&gmin2_chi2,"gmin2_chi2/F");
  markovChain_out->Branch("omega_chi2",&omega_chi2,"omega_chi2/F");
  markovChain_out->Branch("MassW_chi2",&MassW_chi2,"MassW_chi2/F");
  markovChain_out->Branch("Massh0_chi2",&Massh0_chi2,"Massh0_chi2/F");
  markovChain_out->Branch("sin_th_eff_chi2",&sin_th_eff_chi2,"sin_th_eff_chi2/F");
  markovChain_out->Branch("B_smm_chi2",&B_smm_chi2,"B_smm_chi2/F");
  markovChain_out->Branch("massTop_chi2",&massTop_chi2,"massTop_chi2/F");
  markovChain_out->Branch("LEO_chi2",&LEO_chi2,"LEO_chi2/F");
  markovChain_out->Branch("LHC_chi2",&LHC_chi2,"LHC_chi2/F");
  markovChain_out->Branch("Higgs_chi2",&Higgs_chi2,"Higgs_chi2/D");
  markovChain_out->Branch("mu_chi2",&mu_chi2,"mu_chi2/D");
  markovChain_out->Branch("mh_chi2",&mh_chi2,"mh_chi2/D");
  markovChain_out->Branch("af_chi2",&af_chi2,"af_chi2/F");
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
  markovChain_out->Branch("O_massTop",&O_massTop,"O_massTop/F");
  markovChain_out->Branch("O_massh0_nofit",&O_massh0_nofit,"O_massh0_nofit/F");
  markovChain_out->Branch("likelihood",&likelihood,"likelihood/F");
  markovChain_out->Branch("rho",&rho,"rho/F");
  markovChain_out->Branch("pre_chi2",&pre_chi2,"pre_chi2/F");
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
  markovChain_out->Branch("O_alphaem",&O_alphaem,"O_alphaem/F");
  markovChain_out->Branch("O_G_F_nofit",&O_G_F_nofit,"O_G_F_nofit/F");
  markovChain_out->Branch("O_alphas",&O_alphas,"O_alphas/F");
  markovChain_out->Branch("O_massZ",&O_massZ,"O_massZ/F");
  markovChain_out->Branch("O_massBottom_nofit",&O_massBottom_nofit,"O_massBottom_nofit/F");
  markovChain_out->Branch("O_massTau",&O_massTau,"O_massTau/F");
  markovChain_out->Branch("O_massCharm_nofit",&O_massCharm_nofit,"O_massCharm_nofit/F");
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

  markovChain_out->Branch("R_H_WW",&R_H_WW,"R_H_WW/D");
  markovChain_out->Branch("R_H_ZZ",&R_H_ZZ,"R_H_ZZ/D");
  markovChain_out->Branch("R_H_gaga",&R_H_gaga,"R_H_gaga/D");
  markovChain_out->Branch("R_H_tautau",&R_H_tautau,"R_H_tautau/D");
  markovChain_out->Branch("R_H_bb",&R_H_bb,"R_H_bb/D");
  markovChain_out->Branch("R_VH_bb",&R_VH_bb,"R_VH_bb/D");

  markovChain_out->Branch("predmu0",&predmu[0],"predmu0/D");
  markovChain_out->Branch("predmu1",&predmu[1],"predmu1/D");
  markovChain_out->Branch("predmu2",&predmu[2],"predmu2/D");
  markovChain_out->Branch("predmu3",&predmu[3],"predmu3/D");
  markovChain_out->Branch("predmu4",&predmu[4],"predmu4/D");
  markovChain_out->Branch("predmu5",&predmu[5],"predmu5/D");
  markovChain_out->Branch("predmu6",&predmu[6],"predmu6/D");
  markovChain_out->Branch("predmu7",&predmu[7],"predmu7/D");
  markovChain_out->Branch("predmu8",&predmu[8],"predmu8/D");
  markovChain_out->Branch("predmu9",&predmu[9],"predmu9/D");
  markovChain_out->Branch("predmu10",&predmu[10],"predmu10/D");
  markovChain_out->Branch("predmu11",&predmu[11],"predmu11/D");
  markovChain_out->Branch("predmu12",&predmu[12],"predmu12/D");
  markovChain_out->Branch("predmu13",&predmu[13],"predmu13/D");
  markovChain_out->Branch("predmu14",&predmu[14],"predmu14/D");
  markovChain_out->Branch("predmu15",&predmu[15],"predmu15/D");
  markovChain_out->Branch("predmu16",&predmu[16],"predmu16/D");
  markovChain_out->Branch("predmu17",&predmu[17],"predmu17/D");
  markovChain_out->Branch("predmu18",&predmu[18],"predmu18/D");
  markovChain_out->Branch("predmu19",&predmu[19],"predmu19/D");
  markovChain_out->Branch("predmu20",&predmu[20],"predmu20/D");
  markovChain_out->Branch("predmu21",&predmu[21],"predmu21/D");
  markovChain_out->Branch("predmu22",&predmu[22],"predmu22/D");
  markovChain_out->Branch("predmu23",&predmu[23],"predmu23/D");
  markovChain_out->Branch("predmu24",&predmu[24],"predmu24/D");
  markovChain_out->Branch("predmu25",&predmu[25],"predmu25/D");
  
 return; 
}



// ===================================================================
// == Assign the variables to the input ntuple
void assignInputBranches( int PP_or_Toys ){

  markovChain_in->SetBranchAddress("likelihood",&likelihood );
  markovChain_in->SetBranchAddress("rho",&rho );
  markovChain_in->SetBranchAddress("chi2",&chi2 );
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
  markovChain_in->SetBranchAddress("O_Bsg_npf",&O_Bsg_npf );
  markovChain_in->SetBranchAddress("O_dm_s_npf",&O_dm_s_npf );
  markovChain_in->SetBranchAddress("O_Btn_npf",&O_Btn_npf );
  markovChain_in->SetBranchAddress("O_omega",&O_omega);
  markovChain_in->SetBranchAddress("O_gmin2m_npf",&O_gmin2m_npf);
  markovChain_in->SetBranchAddress("O_Massh0_npf",&O_Massh0_npf );
  markovChain_in->SetBranchAddress("O_MassW_npf",&O_MassW_npf );
  markovChain_in->SetBranchAddress("O_sin_th_eff_npf",&O_sin_th_eff_npf );
  markovChain_in->SetBranchAddress("O_B_smm_npf",&O_B_smm_npf );
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

  markovChain_in->SetBranchAddress("O_h0_To_Bottom_Bottom__nofit",&O_h0_To_Bottom_Bottom__nofit );
  markovChain_in->SetBranchAddress("O_h0_To_Strange_Strange__nofit",&O_h0_To_Strange_Strange__nofit );
  markovChain_in->SetBranchAddress("O_h0_To_Charm_Charm__nofit",&O_h0_To_Charm_Charm__nofit );
  markovChain_in->SetBranchAddress("O_h0_To_Tau_Tau__nofit",&O_h0_To_Tau_Tau__nofit );
  markovChain_in->SetBranchAddress("O_h0_To_Muon_Muon__nofit",&O_h0_To_Muon_Muon__nofit );
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
  if( PP_or_Toys == 0 ){

    markovChain_in->SetBranchAddress("mu_chi2",&mu_chi2);
    markovChain_in->SetBranchAddress("mh_chi2",&mh_chi2);
    markovChain_in->SetBranchAddress("Massh0_chi2",&Massh0_chi2);

    markovChain_in->SetBranchAddress("R_H_WW",&R_H_WW );
    markovChain_in->SetBranchAddress("R_H_ZZ",&R_H_ZZ );
    markovChain_in->SetBranchAddress("R_H_gaga",&R_H_gaga );
    markovChain_in->SetBranchAddress("R_H_tautau",&R_H_tautau );
    markovChain_in->SetBranchAddress("R_H_bb",&R_H_bb );
    markovChain_in->SetBranchAddress("R_VH_bb",&R_VH_bb );

    markovChain_in->SetBranchAddress("predmu0",&predmu[0] );
    markovChain_in->SetBranchAddress("predmu1",&predmu[1] );
    markovChain_in->SetBranchAddress("predmu2",&predmu[2] );
    markovChain_in->SetBranchAddress("predmu3",&predmu[3] );
    markovChain_in->SetBranchAddress("predmu4",&predmu[4] );
    markovChain_in->SetBranchAddress("predmu5",&predmu[5] );
    markovChain_in->SetBranchAddress("predmu6",&predmu[6] );
    markovChain_in->SetBranchAddress("predmu7",&predmu[7] );
    markovChain_in->SetBranchAddress("predmu8",&predmu[8] );
    markovChain_in->SetBranchAddress("predmu9",&predmu[9] );
    markovChain_in->SetBranchAddress("predmu10",&predmu[10] );
    markovChain_in->SetBranchAddress("predmu11",&predmu[11] );
    markovChain_in->SetBranchAddress("predmu12",&predmu[12] );
    markovChain_in->SetBranchAddress("predmu13",&predmu[13] );
    markovChain_in->SetBranchAddress("predmu14",&predmu[14] );
    markovChain_in->SetBranchAddress("predmu15",&predmu[15] );
    markovChain_in->SetBranchAddress("predmu16",&predmu[16] );
    markovChain_in->SetBranchAddress("predmu17",&predmu[17] );
    markovChain_in->SetBranchAddress("predmu18",&predmu[18] );
    markovChain_in->SetBranchAddress("predmu19",&predmu[19] );
    markovChain_in->SetBranchAddress("predmu20",&predmu[20] );
    markovChain_in->SetBranchAddress("predmu21",&predmu[21] );
    markovChain_in->SetBranchAddress("predmu22",&predmu[22] );
    markovChain_in->SetBranchAddress("predmu23",&predmu[23] );
    markovChain_in->SetBranchAddress("predmu24",&predmu[24] );
    markovChain_in->SetBranchAddress("predmu25",&predmu[25] );
  }
 return; 
}



// ===================================================================
// == Prepar input and output files
void openIOfiles( int PP_or_Toys, TString _fit ){

 // == Opening input fit to process

 // If you have cleaned it before (removal of multiple points in cleaning.h)
  TString name_in;
  if( PP_or_Toys == 1 ) name_in = inputDir + "/" + _fit + "_cleaned.root";  
  if( PP_or_Toys == 0 ||  PP_or_Toys == 2 ) name_in = inputDir + "/" + _fit + ".root";  
  file_in = new TFile( name_in );
  markovChain_in = (TTree*) file_in->Get("markovChain");
  cout << EMR << endl << " >>> Processing... "  << FIN << endl;
  cout << EMB <<" fit: " << _fit << endl
       <<" model: " << model << endl
       << " input: " << name_in << FIN << endl;
  assignInputBranches( PP_or_Toys );

  // == Output processed file
   TString name_out = "";
   //   if( PP_or_Toys == 1 ) name_out = _fit + "_seg" + pp_segment_st + ".root";
   //   if( PP_or_Toys == 0 ) name_out = outputDir + "/" + _fit + "_toys_seg" + pp_segment_st + ".root";
   if( PP_or_Toys == 1 ) name_out = _fit + ".root";
   if( PP_or_Toys == 0 ) name_out = _fit + "_toys_TEMP.root";
   //if( PP_or_Toys == 0 ) name_out = outputDir + "/" + _fit + "_toys_TEMP.root";
   file_out = new TFile( name_out, "RECREATE" );
   markovChain_out = new TTree( "markovChain", "Processed fit" );
   cout << EMB << " output: " << name_out << FIN << endl;
   assignOutputBranches();

  return;
}



// ===================================================================
// == Read the experimental values from the Fittino input file
void assignLEObs(){

// == To account for the different uncertainties, -1 is assigned to empty ones
// == The fittino input is first read by a bash script preparFittinoInput.sh
  TString name;
  double meas, unc1, unc2, unc3, unc4, unc;
  LEObs.resize( ValName.size() );
  uncLEObs.resize( ValName.size() );

  ifstream fittinoInput ( "fittinoNewObservables.txt" );
  if( !fittinoInput.good() ) cout << BGK << EMR << "WARNING, file fittinoNewObservables.txt not found, check the script preparFittinoInput.sh" << FIN << endl; 
  else 
    while( fittinoInput >> name >> meas >> unc1 >> unc2 >> unc3 >> unc4 ){

      // The 4th uncertainty is to enlarge the scanning spread and should not enter the chi2 calculation
      if( name == "Btn_npf" ) unc4 = -1;

      if( unc2 == -1 && unc3 == -1 ) unc = unc1;
      if( unc2 != -1 && unc3 == -1 ) unc = TMath::Sqrt( unc1*unc1 + unc2*unc2 );
      if( unc2 != -1 && unc3 != -1 ) unc = TMath::Sqrt( unc1*unc1 + unc2*unc2 + unc3*unc3 );
      name = "O_"+name;
      for( int i = 0; i < ValName.size(); i++ ){
	if( ValName[i] == name ){
	  LEObs[i] = meas;
	  uncLEObs[i] = unc;
	}
      }    
  }
  fittinoInput.close();

  cout << endl << EMR << " >>> Observables for post-processing.." << FIN << endl;
  for( int i = 0; i < ValName.size(); i++ ) 
    if( ValName[i].Contains("O_") && !ValName[i].Contains("chi2") && !ValName[i].Contains("massNeutralino1")) 
      cout << EMB << ValName[i] <<" = " << LEObs[i] << " +- " << uncLEObs[i] << FIN << endl;

 return;  
}



// ===================================================================
// == Calculating Higgs chi2 requires the couplings and mass
double HiggsMassCouplings[22] = {0};
// == Define functions to call HiggsBound to calculate the SM BR
// == when the couplings were not saved in the ntuple: g2 = BF*Gamma / BF_SM*Gamma_SM 
// == /afs/naf.desy.de/group/atlas/scratch/fittino/theorycodes/HiggsBounds-3.8.1/access_SM.f90
// == Pseudoscalar and invisible couplings set to 0
extern "C" { double smbr_hss_( double *Mh );}
extern "C" { double smbr_hcc_( double *Mh );}
extern "C" { double smbr_hmumu_( double *Mh );}
extern "C" { double smbr_hzgam_( double *Mh );}
extern "C" { double smbr_hgamgam_( double *Mh );}
extern "C" { double smgamma_h_( double *Mh );}



// ===================================================================
void fillHiggsMassCouplings( double Mh ){
  
  HiggsMassCouplings[0] = O_massh0_nofit;
  HiggsMassCouplings[1] = O_h0_To_Strange_Strange__nofit * O_widthh0_nofit / ( smbr_hss_( &Mh ) * smgamma_h_( &Mh ) );//g2hjss_s
  HiggsMassCouplings[2] = 0;//g2hjss_p
  HiggsMassCouplings[3] = O_h0_To_Charm_Charm__nofit * O_widthh0_nofit / ( smbr_hcc_( &Mh ) * smgamma_h_( &Mh ) );//g2hjcc_s
  HiggsMassCouplings[4] = 0;//g2hjcc_p
  HiggsMassCouplings[5] = O_HiggsScalarFermionCoupling3250505_nofit;//g2hjbb_s
  HiggsMassCouplings[6] = 0;//O_HiggsPseudoScalarFermionCoupling3250505_nofit;//g2hjbb_p
  HiggsMassCouplings[7] = O_HiggsScalarFermionCoupling3250606_nofit;//g2hjtt_s
  HiggsMassCouplings[8] = 0;//O_HiggsPseudoScalarFermionCoupling3250606_nofit;//g2hjtt_p
  HiggsMassCouplings[9] = O_h0_To_Muon_Muon__nofit * O_widthh0_nofit / ( smbr_hmumu_( &Mh ) * smgamma_h_( &Mh ) );//g2hjmumu_s
  HiggsMassCouplings[10] = 0;//g2hjmumu_p
  HiggsMassCouplings[11] = O_HiggsScalarFermionCoupling3251515_nofit;//g2hjtautau_s
  HiggsMassCouplings[12] = 0;//O_HiggsPseudoScalarFermionCoupling3251515_nofit;//g2hjtautau_p
  HiggsMassCouplings[13] = O_HiggsBosonCoupling3252424_nofit;//g2hjWW
  HiggsMassCouplings[14] = O_HiggsBosonCoupling3252323_nofit;//g2hjZZ
  HiggsMassCouplings[15] = O_h0_To_Z_Gamma__nofit * O_widthh0_nofit / ( smbr_hzgam_( &Mh ) * smgamma_h_( &Mh ) );//g2hjZga
  HiggsMassCouplings[16] = O_h0_To_Gamma_Gamma__nofit * O_widthh0_nofit / ( smbr_hgamgam_( &Mh ) * smgamma_h_( &Mh ) );//g2hjgaga
  HiggsMassCouplings[17] = O_HiggsBosonCoupling3252121_nofit;//g2hjgg
  HiggsMassCouplings[18] = O_HiggsBosonCoupling425212123_nofit;//g2hjggZ
  HiggsMassCouplings[19] = O_HiggsBosonCoupling3252523_nofit;//g2hjhiZ ---> ???????????????
  HiggsMassCouplings[20] = O_h0_To_Neutralino1_Neutralino1__nofit;//BR_hjinvisible
  HiggsMassCouplings[21] = 0;//BR_hjhihi
  
  return;
}



// ===================================================================
// == Simple function to calculate the chi2 without messing up
Float_t myChi2( Float_t theo, Float_t exp, Float_t unc ){
  return ( theo - exp ) * ( theo - exp ) / ( unc * unc );
}

// ===================================================================
// == Simple function to calculate the chi2 for an upper limit
Float_t ul_myChi2( Float_t theo, Float_t exp, Float_t unc ){
  if( theo <= exp ) return 0;
  else{
    return ( ( theo - exp ) * ( theo - exp ) / ( unc * unc ) );
  }
}

// ===================================================================
// == Save smeared observables in an ntuple
void saveSmearedObs(){
  float* smearingResult = new float[11];
  smearingResult[0] = toyVal[1];//bsg
  smearingResult[1] = toyVal[2];//dms
  smearingResult[2] = toyVal[3];//btn
  smearingResult[3] = toyVal[4];//gmin2
  smearingResult[4] = toyVal[5];//omega
  smearingResult[5] = toyVal[6];//massh0
  smearingResult[6] = toyVal[7];//massW
  smearingResult[7] = toyVal[8];//sintheff
  smearingResult[8] = toyVal[9];//bsmm
  smearingResult[9] = toyVal[10];//massTop
  smearingResult[10] = mChipl;
  smearedObsNtuple->Fill( smearingResult );
  delete smearingResult;
  return;
}

// ===================================================================
// == Smear low energy observables and lower limit on chargino
void smearLEObs( bool verb ){

  toyVal.clear();
  toyVal.resize( ValName.size() );
  r.SetSeed( randomSeed );

  // Smearing all LEO following a Gaussian centered on the values
  // at the best fit point, and whose width is the total uncertainty
  if( verb ) cout << "   > Smearing low energy observables.." << endl;  
  //for( int iVal = 1; iVal < ValName.size(); iVal++ ) toyVal[iVal] = bestFitVal[iVal];//test the toys
  for( int iVal = 1; iVal < ValName.size(); iVal++ ) toyVal[iVal] = r.Gaus( bestFitVal[iVal], uncLEObs[iVal] );

  // Smear the cut on the chargino mass with the theoretical uncertainty of 1 GeV  
  //mChipl = chipl_bound;//test the toys
  mChipl = r.Gaus( chipl_bound, 1.0 );

  if( verbose ) cout << "   > Lower limit on chargino mass: " << mChipl << endl;

  return;
}


// ===================================================================
// == Observables of the 2012 paper
float paper2012( bool verbose ){

  // Calculating the chi2 for each LEO 
  // The excluded chargino and Higgs range are already taken into into account
  // The top mass had been fixed for the nominal fit
  // ---------
  // Omega
  Float_t valOmega = 0.1123;
  Float_t uncExpOmega = 0.0035;
  Float_t uncTheoOmega = 0.01123;// 10% relative for 1 sigma
  Float_t uncOmega = TMath::Sqrt( uncExpOmega*uncExpOmega + uncTheoOmega*uncTheoOmega );
   omega_chi2 = myChi2( O_omega, valOmega, uncOmega );

  // ---------
  // b->sg
  Float_t valBsg = 3.55E-4;
  Float_t uncExpBsg = TMath::Sqrt( 0.24E-4*0.24E-4 + 0.09E-4*0.09E-4 );
  Float_t uncTheoBsg_2loops = 0.23E-4;
  Float_t uncBsg = TMath::Sqrt( uncExpBsg*uncExpBsg + uncTheoBsg_2loops*uncTheoBsg_2loops );
   Bsg_chi2 = myChi2( O_Bsg_npf, valBsg, uncBsg );

  // ---------
  // W mass, world average 2012
  Float_t valMW = 80.385;
  Float_t uncMW = TMath::Sqrt( 0.015*0.015 + 0.010*0.010 );
   MassW_chi2 = myChi2( O_MassW_npf, valMW, uncMW );

  // ---------
  // Bs->mumu, moriond 2012
  Float_t valBsmumu = 4.5E-9;
  Float_t uncBsmumu = 0.2E-9;
   B_smm_chi2 = myChi2( O_B_smm_npf, valBsmumu, uncBsmumu );

  // ---------
  // DeltaMs
  Float_t valdm_s = 17.78;
  Float_t uncdm_s = TMath::Sqrt( 0.12*0.12 + 5.2*5.2 );
   dm_s_chi2 = myChi2( O_dm_s_npf, valdm_s, uncdm_s );

  // ---------
  // B->taunu
  Float_t valBtn = 1.67E-4;
  Float_t uncBtn = 0.39E-4;
   Btn_chi2 = myChi2( O_Btn_npf, valBtn, uncBtn );

  // ---------
  // (g-2)muon
  Float_t valgmin2 = 28.7E-10;
  Float_t uncgmin2 = TMath::Sqrt( 8.0E-10*8.0E-10 + 2.0E-10*2.0E-10 );
   gmin2_chi2 = myChi2( O_gmin2m_npf, valgmin2, uncgmin2 );

  // ---------
  // Sin(Theta_eff)
  Float_t valsin_th_eff = 0.23113;
  Float_t uncsin_th_eff = 0.00021;
   sin_th_eff_chi2 = myChi2( O_sin_th_eff_npf, valsin_th_eff, uncsin_th_eff );

   // Total LEO chi2
   LEO_chi2 = sin_th_eff_chi2 + gmin2_chi2 + Btn_chi2 + dm_s_chi2 + B_smm_chi2 + MassW_chi2 + Bsg_chi2 + omega_chi2;   

   // Calculating the LHC chi2 for 4.7/fb at 7TeV (0lepton search at ATLAS)
   if( P_M0 > 20 && P_M12 > 100 && P_M0 < 2500 && P_M12 < 1200 ) LHC_chi2 = hChi2->Interpolate( P_M0, P_M12 );
   else if( P_M0 > 2500 ) LHC_chi2 = hChi2->Interpolate( 2500, P_M12 );
   else LHC_chi2 = 0;
   if( LHC_chi2 < 0 ) LHC_chi2 = 0;

   // Calculating the Astrofit chi2 for XENON100
   af_chi2 = astrofitChi2( O_massNeutralino1_nofit, af_direct, false );

   if( verbose ){
   cout << "       Bsg:      theo = " << O_Bsg_npf << " meas = " << valBsg << " ->chi2 = " << Bsg_chi2 << endl;
   cout << "       Dms:      theo = " << O_dm_s_npf<< " meas = " << valdm_s << " ->chi2 = " << dm_s_chi2 << endl;
   cout << "       Btn:      theo = " << O_Btn_npf<< " meas = " << valBtn << " ->chi2 = " << Btn_chi2 << endl;
   cout << "       gmin2:    theo = " << O_gmin2m_npf<< " meas = " << valgmin2 << " ->chi2 = " << gmin2_chi2 << endl;
   cout << "       omega:    theo = " << O_omega<< " meas = " << valOmega << " ->chi2 = " << omega_chi2 << endl;
   cout << "       MassW:    theo = " << O_MassW_npf<< " meas = " << valMW << " ->chi2 = " << MassW_chi2 << endl;
   cout << "       sinThEff: theo = " << O_sin_th_eff_npf<< " meas = " << valsin_th_eff << " ->chi2 = " << sin_th_eff_chi2 << endl;
   cout << "       Bsmm:     theo = " << O_B_smm_npf<< " meas = " << valBsmumu << " ->chi2 = " << B_smm_chi2 << endl;
   cout << "    - Total LEO chi2  = " << LEO_chi2 << endl;
   cout << "    - LHC             = " << LHC_chi2 << endl;
   cout << "    - Astrofit        = " << af_chi2 << endl;
   cout << "    - Total chi2      = " << LEO_chi2+LHC_chi2+af_chi2<< endl;
   }
         

   return( LEO_chi2 + LHC_chi2 + af_chi2 );
}


// ===================================================================
// == Recalculate the minimal chi2 for a given toy with smeared observables
// == and spot the point of minimal chi2
void calculateChi2( int PP_or_Toys ){

  if( PP_or_Toys == 1 ) cout << EMR << endl << " >>> Post-processing.." << FIN << endl;
  if( PP_or_Toys == 0 ) cout << EMR << endl << " >>> Simulating a toy " << FIN << endl;    
  if( PP_or_Toys == 2 ) cout << EMR << endl << " >>> Testing the toy at the best fit point" << FIN << endl;    

  // Chi2 before the post-processing
  pre_chi2 = chi2;

  // Maximal values of the chi2
  float maxChi2 = 0;
  if( useObs == 0 ) maxChi2 = 50;
  else if( useObs == 1 ) maxChi2 = 30;
  else if( useObs == 2 ) maxChi2 = 40;
  else if( useObs == 3 ) maxChi2 = 20;
  else if( useObs == 4 ) maxChi2 = 26;
  else maxChi2 = 50;

  // Set up the LHC tool and smear the number of observed events for toys
  if( useObs != 4 ) setLHCchi2Tools( PP_or_Toys, randomSeed, verbose, bestFitPar[0], bestFitPar[1], fit, useObs );
  
  // Set the Xenon100 contour, smear it for toys, bestFitVal[11] = mass of the neutralino, bestFitVal[12] = total cross section
  setAstrofit( PP_or_Toys, randomSeed, bestFitVal[11], bestFitVal[12], verbose );

  if( PP_or_Toys == 0 || PP_or_Toys == 2 )
    {
      // Smear low energy observables and lower limit on chargino
      smearLEObs( verbose );          

      // Smear the Higgs mh, mu
      if ( useObs != 1 && useObs != 3 && useObs != 4 && useObs != 11 && useObs != 12 ) smearHiggs( verbose, randomSeed, inputDir, fit );

      // Save smeared observables in an ntuple
      saveSmearedObs();
    }

  // Monitor the cut flow
  int cutFlow[3] = {0};

  // Calculate new chi2 and find the lowest chi2
  if( verbose ) cout << "   > Calculate new chi2.." << endl;
  toyBestFitVal[0] = 1E5;

  // == Splitting the files
  int nEnt = markovChain_in->GetEntries();
  int nBet = 0;
  int first = 0;
  int last = nEnt;

  //if( PP_or_Toys == 0 ){
    //nBet = TMath::FloorNint( nEnt / (nb_segment) );
    //first = (pp_segment-1) * nBet;
  //    last = first + nBet;  
  //    cout << "   > PP segment: " << pp_segment << "/" << nb_segment<<" -> events: " << first << " to " << last-1 << " of " << nEnt << endl;
  //}
  
  // == Loop on the events
  for( Int_t ievt = first; ievt < last; ++ievt ) 
    {
      markovChain_in->GetEntry( ievt );
  
      LEO_chi2 = 0; LHC_chi2 = 0; Higgs_chi2 = 0; af_chi2 = 0;
      Bsg_chi2=0; dm_s_chi2=0; Btn_chi2=0; gmin2_chi2=0; omega_chi2=0; Massh0_chi2=0; MassW_chi2=0; sin_th_eff_chi2=0; B_smm_chi2=0; massTop_chi2=0;

      if( verbose ) cout << " ---------- POINT # "<< ievt << " ---------- " << endl;
      if( verbose ) cout <<"    - Parameters: M0(" <<P_M0<<") M12("<<P_M12<<") TanBeta("<<P_TanBeta<<") A0("<<P_A0<<")" <<endl;
      cutFlow[0]++;
      
      // --------------------
      // Cut on chargino mass
      float mChiplCut = 0;
      if( PP_or_Toys == 0 || PP_or_Toys == 2 ) mChiplCut = mChipl;//smeared value
      if( PP_or_Toys == 1 ) mChiplCut = chipl_bound;//nominal value	 
      if( verbose ) cout <<"    - Chargino mass " << O_massChargino1_nofit << " bound: " << mChiplCut << endl;
      if( O_massChargino1_nofit < mChiplCut ) continue;
      cutFlow[1]++;

      // ------------------------------------------------------
      // Obs 17 corresponds to the observable of the 2012 paper
      // Excluded Higgs mass range +- 3 GeV theo unc
      float HiggsUpperLimit = 130.5;// CMS
      float HiggsLowerLimit = 114.5;// ATLAS
      if( useObs == 17 && ( O_Massh0_npf < HiggsLowerLimit || O_Massh0_npf > HiggsUpperLimit ) ) continue;

      if( useObs != 17 )
	{
	  
	  // ----------------------------
	  // Chi2 for low energy observables
	  if( PP_or_Toys == 1 ) Bsg_chi2 = myChi2( O_Bsg_npf,  LEObs[1], uncLEObs[1] ) ;
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) Bsg_chi2 = myChi2( O_Bsg_npf,  toyVal[1], uncLEObs[1] ) ;         
	  if( useObs != 7 ) LEO_chi2 += Bsg_chi2;
	  
	  if( PP_or_Toys == 1 ) dm_s_chi2 = myChi2( O_dm_s_npf,  LEObs[2], uncLEObs[2] ) ;
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) dm_s_chi2 = myChi2( O_dm_s_npf,  toyVal[2], uncLEObs[2] ) ;    
	  if( useObs != 7 ) LEO_chi2 += dm_s_chi2;
	  
	  if( PP_or_Toys == 1 ) Btn_chi2 = myChi2( O_Btn_npf,  LEObs[3], uncLEObs[3] ) ;
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) Btn_chi2 = myChi2( O_Btn_npf,  toyVal[3], uncLEObs[3] ) ;
	  if( useObs != 7 ) LEO_chi2 += Btn_chi2;
	  
	  if( PP_or_Toys == 1 ) gmin2_chi2 = myChi2( O_gmin2m_npf,  LEObs[4], uncLEObs[4] ) ;
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) gmin2_chi2 = myChi2( O_gmin2m_npf,  toyVal[4], uncLEObs[4] ) ;
	  if( useObs != 9 && useObs != 10 ) LEO_chi2 += gmin2_chi2;
	  
	  if( PP_or_Toys == 1 ) omega_chi2 = myChi2( O_omega,  LEObs[5], uncLEObs[5] ) ;
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) omega_chi2 = myChi2( O_omega,  toyVal[5], uncLEObs[5] ) ;
	  if( useObs != 8 && useObs != 10 ) LEO_chi2 += omega_chi2;
	  
	  if( PP_or_Toys == 1 ) Massh0_chi2 = myChi2( O_Massh0_npf,  LEObs[6], uncLEObs[6] ) ;
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) Massh0_chi2 = myChi2( O_Massh0_npf,  toyVal[6], uncLEObs[6] ) ;
	  
	  if( PP_or_Toys == 1 ) MassW_chi2 = myChi2( O_MassW_npf,  LEObs[7], uncLEObs[7] ) ;
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) MassW_chi2 = myChi2( O_MassW_npf,  toyVal[7], uncLEObs[7] ) ;
	  LEO_chi2 += MassW_chi2;
	  
	  if( PP_or_Toys == 1 ) sin_th_eff_chi2 = myChi2( O_sin_th_eff_npf,  LEObs[8], uncLEObs[8] ) ;
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) sin_th_eff_chi2 = myChi2( O_sin_th_eff_npf,  toyVal[8], uncLEObs[8] ) ;
	  LEO_chi2 += sin_th_eff_chi2;
	  
	  // Upper limit on Bs->mumu
	  //if( PP_or_Toys == 1 ) B_smm_chi2 = ul_myChi2( O_B_smm_npf,  LEObs[9], uncLEObs[9] ); // Upper limit
	  //if( PP_or_Toys == 0 || PP_or_Toys == 2 ) B_smm_chi2 = ul_myChi2( O_B_smm_npf,  toyVal[9], uncLEObs[9] );// Upper limit
	  
	  // Measurement of Bs->mumu
	  if( PP_or_Toys == 1 ) B_smm_chi2 = myChi2( O_B_smm_npf,  LEObs[9], uncLEObs[9] );
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) B_smm_chi2 = myChi2( O_B_smm_npf,  toyVal[9], uncLEObs[9] );
	  if( useObs != 5 && useObs != 7 ) LEO_chi2 += B_smm_chi2;
	  
	  if( PP_or_Toys == 1 ) massTop_chi2 = myChi2( O_massTop,  LEObs[10], uncLEObs[10] ) ;
	  if( PP_or_Toys == 0 || PP_or_Toys == 2 ) massTop_chi2 = myChi2( O_massTop,  toyVal[10], uncLEObs[10] ) ;
	  LEO_chi2 += massTop_chi2;
	  
	  if( verbose ){
	    cout << "    - Individual chi2 per observables:"<<endl;       
	    if( PP_or_Toys == 1 ){
	      cout << "       Bsg: theo = " << O_Bsg_npf << " meas = " << LEObs[1] << " ->chi2 = " << Bsg_chi2 << endl;
	      cout << "       Dms: theo = " << O_dm_s_npf<< " meas = " << LEObs[2] << " ->chi2 = " << dm_s_chi2 << endl;
	      cout << "       Btn: theo = " << O_Btn_npf<< " meas = " << LEObs[3] << " ->chi2 = " << Btn_chi2 << endl;
	      cout << "       gmin2: theo = " << O_gmin2m_npf<< " meas = " << LEObs[4] << " ->chi2 = " << gmin2_chi2 << endl;
	      cout << "       omega: theo = " << O_omega<< " meas = " << LEObs[5] << " ->chi2 = " << omega_chi2 << endl;
	      cout << "       Massh0: theo = " << O_Massh0_npf<< " meas = " << LEObs[6] << " ->chi2 = " << Massh0_chi2 << endl;
	      cout << "       MassW: theo = " << O_MassW_npf<< " meas = " << LEObs[7] << " ->chi2 = " << MassW_chi2 << endl;
	      cout << "       sinThEff: theo = " << O_sin_th_eff_npf<< " meas = " << LEObs[8] << " ->chi2 = " << sin_th_eff_chi2 << endl;
	      cout << "       Bsmm: theo = " << O_B_smm_npf<< " meas = " << LEObs[9] << " ->chi2 = " << B_smm_chi2 << endl;
	      cout << "       masstop: theo = " <<  O_massTop<< " meas = " << LEObs[10] << " ->chi2 = " << massTop_chi2 << endl;
	    }
	    if( PP_or_Toys == 0 || PP_or_Toys == 2 ){
	      cout << "       Bsg: theo = " << O_Bsg_npf << " meas = " << toyVal[1] << " ->chi2 = " << Bsg_chi2 << endl;
	      cout << "       Dms: theo = " << O_dm_s_npf<< " meas = " << toyVal[2] << " ->chi2 = " << dm_s_chi2 << endl;
	      cout << "       Btn: theo = " << O_Btn_npf<< " meas = " << toyVal[3] << " ->chi2 = " << Btn_chi2 << endl;
	      cout << "       gmin2: theo = " << O_gmin2m_npf<< " meas = " << toyVal[4] << " ->chi2 = " << gmin2_chi2 << endl;
	      cout << "       omega: theo = " << O_omega<< " meas = " << toyVal[5] << " ->chi2 = " << omega_chi2 << endl;
	      cout << "       Massh0: theo = " << O_Massh0_npf<< " meas = " << toyVal[6] << " ->chi2 = " << Massh0_chi2 << endl;
	      cout << "       MassW: theo = " << O_MassW_npf<< " meas = " << toyVal[7] << " ->chi2 = " << MassW_chi2 << endl;
	      cout << "       sinThEff: theo = " << O_sin_th_eff_npf<< " meas = " << toyVal[8] << " ->chi2 = " << sin_th_eff_chi2 << endl;
	      cout << "       Bsmm: theo = " << O_B_smm_npf<< " meas = " << toyVal[9] << " ->chi2 = " << B_smm_chi2 << endl;
	      cout << "       masstop: theo = " <<  O_massTop<< " meas = " << toyVal[10] << " ->chi2 = " << massTop_chi2 << endl;
	    }
	  }
	  if( verbose ) cout << "    - Total LEO chi2 " << LEO_chi2 << endl;            
	  
	  // ----------------
	  // New chi2 for LHC
	  // Including the A0-TanBeta corrections
	  if( useObs != 4 && useObs != 16 ){
	    if( P_M0 > 0 && P_M12 > 100 && P_M0 < 2500 && P_M12 < 1200 ) LHC_chi2 = LHCchi2_fast( P_M0, P_M12, P_A0, P_TanBeta );
	    else if( P_M12 > 1200 && P_M0 < 2500 ) LHC_chi2 = LHCchi2_fast( P_M0, 1190, P_A0, P_TanBeta );
	    else if( P_M0 > 2500 && P_M12 < 1200 ) LHC_chi2  = LHCchi2_fast( 2490, P_M12, P_A0, P_TanBeta );      
	    else LHC_chi2 = 1000;
	    if( verbose ) cout << "       LHC: " << LHC_chi2 << endl;      
	  }
	  // Not including the A0-TanBeta corrections
	  if( useObs == 16 ){
	    if( P_M0 > 0 && P_M12 > 100 && P_M0 < 2500 && P_M12 < 1200 ) LHC_chi2 = LHCchi2_fast_nocorr( P_M0, P_M12 );
	    else if( P_M12 > 1200 && P_M0 < 2500 ) LHC_chi2 = LHCchi2_fast_nocorr( P_M0, 1190 );
	    else if( P_M0 > 2500 && P_M12 < 1200 ) LHC_chi2  = LHCchi2_fast_nocorr( 2490, P_M12 );
	    else LHC_chi2 = 1000;
	    if( verbose ) cout << "       LHC: " << LHC_chi2 << endl;
	  }
	  if( LHC_chi2 < 0 ){
	    if( verbose ) cout << "       LHC chi2 < 0 -> set to 0" << endl;
	    LHC_chi2 = 0;
	  }

	  // ---------------------
	  // New chi2 for astrofit
	  if( useObs != 2 && useObs != 3 ){
	    af_chi2 = astrofitChi2( O_massNeutralino1_nofit, af_direct, false );
	    if( verbose ) cout << "       Astrofit " << af_chi2 << endl;
	  }
	  
	  // -------------------
	  // New chi2 for Higgs  
	  if( O_Massh0_npf < 10 || O_Massh0_npf > 1000 ){
	    Higgs_chi2 = 1000;
	    Massh0_chi2 = 1000;
	  }
	  else{
	    if ( useObs != 1 && useObs != 3 && useObs != 4 && useObs != 11 && useObs != 12 ){
	      
	      fillHiggsMassCouplings( O_Massh0_npf );
	      
	      getHiggsChi2( HiggsMassCouplings, Higgs_chi2, mu_chi2, mh_chi2 );
	      getHiggsRatios( R_H_WW, R_H_ZZ, R_H_gaga, R_H_tautau, R_H_bb, R_VH_bb );
	      for( int iChannel = 0; iChannel < 26; iChannel++ ) predmu[iChannel] = getHiggsMu( iChannel+1 );
	      
	      if( verbose ){
		cout << "       Higgs ratios:" <<endl
		     << "             R_H_WW     = " << R_H_WW<<endl
		     << "             R_H_ZZ     = " << R_H_ZZ<<endl
		     << "             R_H_gaga   = " << R_H_gaga<<endl
		     << "             R_H_tautau = " << R_H_tautau<<endl
		     << "             R_H_bb     = " << R_H_bb<<endl
		     << "             R_VH_bb    = " << R_VH_bb << endl;
		cout << "       Higgs mu:" <<endl;
		for( int iChannel = 0; iChannel < 26; iChannel++ ) cout << "             Higgs mu["<<iChannel<<"] = "<<predmu[iChannel]<< endl;
	      }
	    }
	  }
	  if( verbose ){
	    if ( useObs != 1 && useObs != 3 && useObs != 4 && useObs != 11 && useObs != 12 ) cout << "       Higgs: " << Higgs_chi2 << endl;   
	    else cout << "       Higgs: " << Massh0_chi2 << endl;   
	  }
	}

      // --------------------------------------------------------------------
      // Fill output ntuple for the real fit
      // ***** means that the input file with constraints had to be modified
      // For all set the HiggsBound chi2 is added
      //
      // 0: full obs
      // 1: full obs, but only mh
      // 2: only LHC and h0
      // 3: only LHC and h0 with only mh
      // 4: LEO and AF
      // 5: full set without Bsmumu
      // 6: full set with the world average of B->tau nu *****
      // 7: full set with no B physics input
      // 8: full set with no Omega
      // 9: full set with no gmin2
      // 10: full set with no Omega and no gmin2
      // 11: full set with lower Higgs uncertainty with mh only (1GeV) *****
      // 12: full set with lower Higgs uncertainty with mh only (0.5GeV) *****
      // 13: full set with more precise rate measurement (20% of now)
      // 14: full set with more precise rate measurement (5% of now) 
      // 15: full set with more precise Higgs measurement (mass: 25%, rate: 5%)
      // 16: full obs with no LHC correction applied
      // 17: full obs of the 2012 paper

      if( useObs == 0 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 1 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Massh0_chi2 + af_chi2;
      if( useObs == 2 ) chi2 = globalHiggsChi2 + LHC_chi2 + Higgs_chi2;
      if( useObs == 3 ) chi2 = globalHiggsChi2 + LHC_chi2 + Massh0_chi2;
      if( useObs == 4 ) chi2 = globalHiggsChi2 + LEO_chi2 + af_chi2;
      if( useObs == 5 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 6 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 7 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 8 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 9 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 10 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 11 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Massh0_chi2 + af_chi2;
      if( useObs == 12 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Massh0_chi2 + af_chi2;
      if( useObs == 13 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 14 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 15 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 16 ) chi2 = globalHiggsChi2 + LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( useObs == 17 ) chi2 = globalHiggsChi2 + paper2012( verbose );

      if( verbose ) cout << "    - Total chi2 " << chi2 << endl;

      // Don't save large chi2 points for PP
      if( PP_or_Toys == 1 ){
	if( chi2 > maxChi2 ) continue;
      }
      cutFlow[2]++;

      // Fill the output trees
      if( PP_or_Toys == 0 || PP_or_Toys == 1 ) markovChain_out->Fill();
      if( PP_or_Toys == 2 ) testToy_tree->Fill();
   }
  
  if( PP_or_Toys == 1 || PP_or_Toys == 0 ){
    cout << endl << " >>> Cut flow.." << endl;
    cout << "Start   : " << cutFlow[0] << endl;
    cout << "Chargino: " << cutFlow[1] << endl;
    cout << "Max chi2: " << cutFlow[2] << endl;
  }

  return;
}

// ===================================================================
// == Read the file with the lowest chi2 point
void readBestFitPoint(){
  
  TString bestFitFile = inputDir + "/bestFit_" + fit + ".txt";
  ifstream bestFitStreamIn( bestFitFile );
  
  // If the file does not exist, create and fill it
  if( !bestFitStreamIn.good() ) cout << BGK << EMR << " >>>>>> WARNING <<<<<< the file of the best fit point is missing: " 
				     << endl << bestFitFile << endl << FIN;
  else{
    // If the file exists read it
    cout << endl << EMR << " >>> Reading file with lowest chi2 point.. " << endl << bestFitFile << endl << FIN;
    int iVal=0;
    Float_t _bestFitVal;
    TString _ValName;
    while( bestFitStreamIn >> _ValName >> _bestFitVal ){
      if( iVal < ValName.size() ) bestFitVal[iVal] = _bestFitVal;
      if( iVal >= ValName.size() ) bestFitPar[iVal-ValName.size()] = _bestFitVal;      
      iVal++;
    }
    bestFitStreamIn.close();
    
    // Display the results
    cout << EMR << endl << " >>> Lowest chi2 point after post-processing.." << FIN << endl;
    for( int iPar = 0; iPar < ParName.size(); iPar++ ){
      cout << EMB << ParName[iPar] << " = " << bestFitPar[iPar] << FIN << endl;
    }
    for( int iVal = 0; iVal < ValName.size(); iVal++ ) cout << EMB << ValName[iVal] << " = " << bestFitVal[iVal] << FIN << endl;       
  }

  return;
}



// ===================================================================
// == simulate toys, for each get the minimal chi2
// == PP_or_Toys = true-> postProcessing, wrong-> simulated toys
void processData( bool PP_or_Toys ){

  // Post-processing
  if( PP_or_Toys == 1 ) calculateChi2( PP_or_Toys );

  // Simulate toys
  if( PP_or_Toys == 0 )
    {
      // Read the best fit point file
      readBestFitPoint();

      // Calculate the chi2 for each point
      calculateChi2( PP_or_Toys );	
  }
  return;
}
// ===================================================================
// == To test the toy procedure
void testToy(){

  // Read the best fit point file
  readBestFitPoint();
  
  // Calculate the chi2 for each point
  testToy_tree->Branch("chi2",&chi2,"chi2/F");
  testToy_tree->Branch("LEO_chi2",&LEO_chi2,"LEO_chi2/F");
  testToy_tree->Branch("LHC_chi2",&LHC_chi2,"LHC_chi2/F");
  testToy_tree->Branch("Higgs_chi2",&Higgs_chi2,"Higgs_chi2/F");
  testToy_tree->Branch("af_chi2",&af_chi2,"af_chi2/F");
  testToy_tree->Branch("randomSeed",&randomSeed,"randomSeed/I");
  TRandom3 rr(0);

  // 1000 smearings of the best fit point
  for( int i = 0; i < 1000; i++ ){
    randomSeed = int( rr.Uniform( 0, 100000 ) );
    calculateChi2( 2 );
    fChi2->Close();
  }

  TString name_testToy_file = "toto.root";
  //TString name_testToy_file = Form( "testToy_%i.root", pp_segment );
  TFile* testToy_file = new TFile( name_testToy_file, "RECREATE" );
  testToy_tree->Write();
  testToy_file->Close();

return;
}



// ===================================================================
// == Write all histograms and trees and close files
void writeAndClose( int PP_or_Toys ){

  if( PP_or_Toys == 0 || PP_or_Toys == 1 ){
    file_out->cd();  
    markovChain_out->Write();
    if( PP_or_Toys == 0 ) smearedObsNtuple->Write();  
    file_in->Close();
    file_out->Close();
  }
  if ( useObs != 1 && useObs != 3 && useObs != 4 && useObs != 11 && useObs != 12 ) finish_higgssignals_();
  return;
}

// ===================================================================
// Skim the toy ntuple by keeping only deltaChi2<1 points
void skimToyTrees( TString _fit ){

  // == Input
  TString in_name = _fit + "_toys_TEMP.root";
  //TString in_name = outputDir + "/" + _fit + "_toys_TEMP.root";
  TFile* in_file = new TFile ( in_name );
  TTree* in_tree = (TTree*) in_file->Get("markovChain");

  // == Output
  TString out_nameEnd = Form( "_toys%i.root", randomSeed );
  TString out_name = _fit + out_nameEnd;
  //TString out_name = outputDir + "/" + _fit + out_nameEnd;
  TFile* out_file = new TFile( out_name, "RECREATE" );
  TTree* out_tree = new TTree( "markovChain", "skim toy tree" );
  
  // == Content of interest of the input toys
  in_tree->SetBranchAddress("likelihood",&likelihood );
  in_tree->SetBranchAddress("rho",&rho );
  in_tree->SetBranchAddress("chi2",&chi2 );
  in_tree->SetBranchAddress("accpoint",&accpoint );
  in_tree->SetBranchAddress("n",&n );
  in_tree->SetBranchAddress("globalIter",&globalIter );
  in_tree->SetBranchAddress("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne );
  in_tree->SetBranchAddress("LHC_Exp_CLb",&LHC_Exp_CLb );
  in_tree->SetBranchAddress("LHC_Exp_CLsb",&LHC_Exp_CLsb );
  in_tree->SetBranchAddress("LHC_Exp_chi2",&LHC_Exp_chi2 );
  in_tree->SetBranchAddress("af_photon",&af_photon );
  in_tree->SetBranchAddress("af_relic",&af_relic );
  in_tree->SetBranchAddress("af_svind",&af_svind );
  in_tree->SetBranchAddress("af_direct",&af_direct );
  in_tree->SetBranchAddress("af_chi2_total",&af_chi2_total );
  in_tree->SetBranchAddress("af_chi2_photon",&af_chi2_photon );
  in_tree->SetBranchAddress("af_chi2_relic",&af_chi2_relic );
  in_tree->SetBranchAddress("af_chi2_svind",&af_chi2_svind );
  in_tree->SetBranchAddress("af_chi2_direct",&af_chi2_direct );
  in_tree->SetBranchAddress("globalHiggsChi2",&globalHiggsChi2 );
  in_tree->SetBranchAddress("HiggsSignals_TotalChi2",&HiggsSignals_TotalChi2 );
  in_tree->SetBranchAddress("P_M0",&P_M0 );
  in_tree->SetBranchAddress("P_M12",&P_M12 );
  in_tree->SetBranchAddress("P_A0",&P_A0 );
  in_tree->SetBranchAddress("P_massTop", &P_massTop );
  in_tree->SetBranchAddress("P_TanBeta",&P_TanBeta );
  if( model == "NUHM1" ) in_tree->SetBranchAddress("P_M0H",&P_M0H );
   if( model == "NUHM2" ){
    in_tree->SetBranchAddress("P_M0Hu",&P_M0Hu );
    in_tree->SetBranchAddress("P_M0Hd",&P_M0Hd );
  }
  in_tree->SetBranchAddress("O_massTop",&O_massTop );
  in_tree->SetBranchAddress("O_Bsg_npf",&O_Bsg_npf );
  in_tree->SetBranchAddress("O_dm_s_npf",&O_dm_s_npf );
  in_tree->SetBranchAddress("O_Btn_npf",&O_Btn_npf );
  in_tree->SetBranchAddress("O_omega",&O_omega);
  in_tree->SetBranchAddress("O_gmin2m_npf",&O_gmin2m_npf);
  in_tree->SetBranchAddress("O_Massh0_npf",&O_Massh0_npf );
  in_tree->SetBranchAddress("O_MassW_npf",&O_MassW_npf );
  in_tree->SetBranchAddress("O_sin_th_eff_npf",&O_sin_th_eff_npf );
  in_tree->SetBranchAddress("O_B_smm_npf",&O_B_smm_npf );
  in_tree->SetBranchAddress("O_alphaem",&O_alphaem );
  in_tree->SetBranchAddress("O_G_F_nofit",&O_G_F_nofit );
  in_tree->SetBranchAddress("O_alphas",&O_alphas );
  in_tree->SetBranchAddress("O_massZ",&O_massZ );
  in_tree->SetBranchAddress("O_massBottom_nofit",&O_massBottom_nofit );
  in_tree->SetBranchAddress("O_massTop",&O_massTop );
  in_tree->SetBranchAddress("O_massTau",&O_massTau );
  in_tree->SetBranchAddress("O_massCharm_nofit",&O_massCharm_nofit );
  in_tree->SetBranchAddress("O_massh0_nofit",&O_massh0_nofit );
  in_tree->SetBranchAddress("O_massA0_nofit",&O_massA0_nofit );
  in_tree->SetBranchAddress("O_massH0_nofit",&O_massH0_nofit );
  in_tree->SetBranchAddress("O_massHplus_nofit",&O_massHplus_nofit );
  in_tree->SetBranchAddress("O_massSupL_nofit",&O_massSupL_nofit );
  in_tree->SetBranchAddress("O_massSupR_nofit",&O_massSupR_nofit );
  in_tree->SetBranchAddress("O_massSdownL_nofit",&O_massSdownL_nofit );
  in_tree->SetBranchAddress("O_massSdownR_nofit",&O_massSdownR_nofit );
  in_tree->SetBranchAddress("O_massScharmL_nofit",&O_massScharmL_nofit );
  in_tree->SetBranchAddress("O_massScharmR_nofit",&O_massScharmR_nofit );
  in_tree->SetBranchAddress("O_massSstrangeL_nofit",&O_massSstrangeL_nofit );
  in_tree->SetBranchAddress("O_massSstrangeR_nofit",&O_massSstrangeR_nofit );
  in_tree->SetBranchAddress("O_massStop1_nofit",&O_massStop1_nofit );
  in_tree->SetBranchAddress("O_massStop2_nofit",&O_massStop2_nofit );
  in_tree->SetBranchAddress("O_massSbottom1_nofit",&O_massSbottom1_nofit );
  in_tree->SetBranchAddress("O_massSbottom2_nofit",&O_massSbottom2_nofit );
  in_tree->SetBranchAddress("O_massSelectronL_nofit",&O_massSelectronL_nofit );
  in_tree->SetBranchAddress("O_massSelectronR_nofit",&O_massSelectronR_nofit );
  in_tree->SetBranchAddress("O_massSmuL_nofit",&O_massSmuL_nofit );
  in_tree->SetBranchAddress("O_massSmuR_nofit",&O_massSmuR_nofit );
  in_tree->SetBranchAddress("O_massStau1_nofit",&O_massStau1_nofit );
  in_tree->SetBranchAddress("O_massStau2_nofit",&O_massStau2_nofit );
  in_tree->SetBranchAddress("O_massSnueL_nofit",&O_massSnueL_nofit );
  in_tree->SetBranchAddress("O_massSnumuL_nofit",&O_massSnumuL_nofit );
  in_tree->SetBranchAddress("O_massSnutau1_nofit",&O_massSnutau1_nofit );
  in_tree->SetBranchAddress("O_massGluino_nofit",&O_massGluino_nofit );
  in_tree->SetBranchAddress("O_massNeutralino1_nofit",&O_massNeutralino1_nofit );
  in_tree->SetBranchAddress("O_massNeutralino2_nofit",&O_massNeutralino2_nofit );
  in_tree->SetBranchAddress("O_massNeutralino3_nofit",&O_massNeutralino3_nofit );
  in_tree->SetBranchAddress("O_massNeutralino4_nofit",&O_massNeutralino4_nofit );
  in_tree->SetBranchAddress("O_massChargino1_nofit",&O_massChargino1_nofit );
  in_tree->SetBranchAddress("O_massChargino2_nofit",&O_massChargino2_nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Electron_SelectronR__nofit",&O_Neutralino2_To_Electron_SelectronR__nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Muon_SmuonR__nofit",&O_Neutralino2_To_Muon_SmuonR__nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Electron_SelectronL__nofit",&O_Neutralino2_To_Electron_SelectronL__nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Muon_SmuonL__nofit",&O_Neutralino2_To_Muon_SmuonL__nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Tau_Stau1__nofit",&O_Neutralino2_To_Tau_Stau1__nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Nutau_Snutau1__nofit",&O_Neutralino2_To_Nutau_Snutau1__nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Tau_Stau2__nofit",&O_Neutralino2_To_Tau_Stau2__nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Neutralino1_Z__nofit",&O_Neutralino2_To_Neutralino1_Z__nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Neutralino1_h0__nofit",&O_Neutralino2_To_Neutralino1_h0__nofit );
  in_tree->SetBranchAddress("O_Neutralino2_To_Nutau_Snutau2__nofit",&O_Neutralino2_To_Nutau_Snutau2__nofit );
  in_tree->SetBranchAddress("O_Chargino1_To_Neutralino1_W__nofit",&O_Chargino1_To_Neutralino1_W__nofit );
  in_tree->SetBranchAddress("O_Chargino1_To_Nutau_Stau1__nofit",&O_Chargino1_To_Nutau_Stau1__nofit );
  in_tree->SetBranchAddress("O_Chargino1_To_Nutau_Stau2__nofit",&O_Chargino1_To_Nutau_Stau2__nofit );
  in_tree->SetBranchAddress("O_Chargino1_To_Electron_SnueL__nofit",&O_Chargino1_To_Electron_SnueL__nofit );
  in_tree->SetBranchAddress("O_Chargino1_To_Muon_SnumuL__nofit",&O_Chargino1_To_Muon_SnumuL__nofit );
  in_tree->SetBranchAddress("O_Chargino1_To_Tau_Snutau1__nofit",&O_Chargino1_To_Tau_Snutau1__nofit );
  in_tree->SetBranchAddress("O_SelectronR_To_Neutralino1_Electron__nofit",&O_SelectronR_To_Neutralino1_Electron__nofit );
  in_tree->SetBranchAddress("O_SelectronR_To_Neutralino2_Electron__nofit",&O_SelectronR_To_Neutralino2_Electron__nofit );
  in_tree->SetBranchAddress("O_SelectronL_To_Neutralino1_Electron__nofit",&O_SelectronL_To_Neutralino1_Electron__nofit );
  in_tree->SetBranchAddress("O_SelectronL_To_Neutralino2_Electron__nofit",&O_SelectronL_To_Neutralino2_Electron__nofit );
  in_tree->SetBranchAddress("O_Stau1_To_Neutralino1_Tau__nofit",&O_Stau1_To_Neutralino1_Tau__nofit );
  in_tree->SetBranchAddress("O_Stau2_To_Neutralino1_Tau__nofit",&O_Stau2_To_Neutralino1_Tau__nofit );
  in_tree->SetBranchAddress("O_Stau2_To_Neutralino2_Tau__nofit",&O_Stau2_To_Neutralino2_Tau__nofit );
  in_tree->SetBranchAddress("O_Stau2_To_Chargino1_Nutau__nofit",&O_Stau2_To_Chargino1_Nutau__nofit );
  in_tree->SetBranchAddress("O_Gluino_To_Bottom_Sbottom2__nofit",&O_Gluino_To_Bottom_Sbottom2__nofit );
  in_tree->SetBranchAddress("O_Gluino_To_Bottom_Sbottom1__nofit",&O_Gluino_To_Bottom_Sbottom1__nofit );
  in_tree->SetBranchAddress("O_Gluino_To_Stop1_Top__nofit",&O_Gluino_To_Stop1_Top__nofit );
  in_tree->SetBranchAddress("O_Gluino_To_Stop2_Top__nofit",&O_Gluino_To_Stop2_Top__nofit );
  in_tree->SetBranchAddress("O_Gluino_To_SupL_up__nofit",&O_Gluino_To_SupL_up__nofit );
  in_tree->SetBranchAddress("O_Gluino_To_SupR_up__nofit",&O_Gluino_To_SupR_up__nofit );
  in_tree->SetBranchAddress("O_Gluino_To_SdownL_down__nofit",&O_Gluino_To_SdownL_down__nofit );
  in_tree->SetBranchAddress("O_Gluino_To_SdownR_down__nofit",&O_Gluino_To_SdownR_down__nofit );
  in_tree->SetBranchAddress("O_SupL_To_Up_Neutralino1__nofit",&O_SupL_To_Up_Neutralino1__nofit );
  in_tree->SetBranchAddress("O_SupR_To_Up_Neutralino1__nofit",&O_SupR_To_Up_Neutralino1__nofit );
  in_tree->SetBranchAddress("O_SupL_To_Up_Neutralino2__nofit",&O_SupL_To_Up_Neutralino2__nofit );
  in_tree->SetBranchAddress("O_SupR_To_Up_Neutralino2__nofit",&O_SupR_To_Up_Neutralino2__nofit );
  in_tree->SetBranchAddress("O_SupL_To_Down_Chargino1__nofit",&O_SupL_To_Down_Chargino1__nofit );
  in_tree->SetBranchAddress("O_SupR_To_Down_Chargino1__nofit",&O_SupR_To_Down_Chargino1__nofit );
  in_tree->SetBranchAddress("O_SupL_To_Down_Chargino2__nofit",&O_SupL_To_Down_Chargino2__nofit );
  in_tree->SetBranchAddress("O_SupR_To_Down_Chargino2__nofit",&O_SupR_To_Down_Chargino2__nofit );
  in_tree->SetBranchAddress("O_Stop1_To_Bottom_Chargino1__nofit",&O_Stop1_To_Bottom_Chargino1__nofit );
  in_tree->SetBranchAddress("O_Stop1_To_Bottom_Chargino2__nofit",&O_Stop1_To_Bottom_Chargino2__nofit );
  in_tree->SetBranchAddress("O_Stop1_To_Top_Neutralino1__nofit",&O_Stop1_To_Top_Neutralino1__nofit );
  in_tree->SetBranchAddress("O_Stop1_To_Top_Neutralino2__nofit",&O_Stop1_To_Top_Neutralino2__nofit );
  in_tree->SetBranchAddress("O_Sbottom1_To_W_Stop1__nofit",&O_Sbottom1_To_W_Stop1__nofit );
  in_tree->SetBranchAddress("O_Sbottom2_To_W_Stop1__nofit",&O_Sbottom2_To_W_Stop1__nofit );
  in_tree->SetBranchAddress("O_Sbottom1_To_Top_Chargino1__nofit",&O_Sbottom1_To_Top_Chargino1__nofit );
  in_tree->SetBranchAddress("O_Sbottom2_To_Neutralino2_Bottom__nofit",&O_Sbottom2_To_Neutralino2_Bottom__nofit );
  in_tree->SetBranchAddress("O_Sbottom1_To_Neutralino2_Bottom__nofit",&O_Sbottom1_To_Neutralino2_Bottom__nofit );
  in_tree->SetBranchAddress("O_h0_To_Bottom_Bottom__nofit",&O_h0_To_Bottom_Bottom__nofit );
  in_tree->SetBranchAddress("O_h0_To_Strange_Strange__nofit",&O_h0_To_Strange_Strange__nofit );
  in_tree->SetBranchAddress("O_h0_To_Charm_Charm__nofit",&O_h0_To_Charm_Charm__nofit );
  in_tree->SetBranchAddress("O_h0_To_Tau_Tau__nofit",&O_h0_To_Tau_Tau__nofit );
  in_tree->SetBranchAddress("O_h0_To_Muon_Muon__nofit",&O_h0_To_Muon_Muon__nofit );
  in_tree->SetBranchAddress("O_h0_To_Gamma_Gamma__nofit",&O_h0_To_Gamma_Gamma__nofit );
  in_tree->SetBranchAddress("O_h0_To_Gluon_Gluon__nofit",&O_h0_To_Gluon_Gluon__nofit );
  in_tree->SetBranchAddress("O_h0_To_W_W__nofit",&O_h0_To_W_W__nofit );
  in_tree->SetBranchAddress("O_h0_To_Z_Z__nofit",&O_h0_To_Z_Z__nofit );
  in_tree->SetBranchAddress("O_h0_To_Z_Gamma__nofit",&O_h0_To_Z_Gamma__nofit );
  in_tree->SetBranchAddress("O_HiggsScalarFermionCoupling3250505_nofit",&O_HiggsScalarFermionCoupling3250505_nofit );// h0->bb
  in_tree->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3250505_nofit",&O_HiggsPseudoScalarFermionCoupling3250505_nofit );// h0->bb
  in_tree->SetBranchAddress("O_HiggsScalarFermionCoupling3350505_nofit",&O_HiggsScalarFermionCoupling3350505_nofit );// H0->bb
  in_tree->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3350505_nofit",&O_HiggsPseudoScalarFermionCoupling3350505_nofit );// H0->bb
  in_tree->SetBranchAddress("O_HiggsScalarFermionCoupling3360505_nofit",&O_HiggsScalarFermionCoupling3360505_nofit );// A0->bb
  in_tree->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3360505_nofit",&O_HiggsPseudoScalarFermionCoupling3360505_nofit );// A0->bb
  in_tree->SetBranchAddress("O_HiggsScalarFermionCoupling3250606_nofit",&O_HiggsScalarFermionCoupling3250606_nofit );// h0->toptop
  in_tree->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3250606_nofit",&O_HiggsPseudoScalarFermionCoupling3250606_nofit );// h0->toptop
  in_tree->SetBranchAddress("O_HiggsScalarFermionCoupling3350606_nofit",&O_HiggsScalarFermionCoupling3350606_nofit );// H0->toptop
  in_tree->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3350606_nofit",&O_HiggsPseudoScalarFermionCoupling3350606_nofit );// H0->toptop
  in_tree->SetBranchAddress("O_HiggsScalarFermionCoupling3360606_nofit",&O_HiggsScalarFermionCoupling3360606_nofit );// A0->toptop
  in_tree->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3360606_nofit",&O_HiggsPseudoScalarFermionCoupling3360606_nofit );// A0->toptop
  in_tree->SetBranchAddress("O_HiggsScalarFermionCoupling3251515_nofit",&O_HiggsScalarFermionCoupling3251515_nofit );// h0->tautau
  in_tree->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3251515_nofit",&O_HiggsPseudoScalarFermionCoupling3251515_nofit );// h0->tautau
  in_tree->SetBranchAddress("O_HiggsScalarFermionCoupling3351515_nofit",&O_HiggsScalarFermionCoupling3351515_nofit );// H0->tautau
  in_tree->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3351515_nofit",&O_HiggsPseudoScalarFermionCoupling3351515_nofit );// H0->tautau
  in_tree->SetBranchAddress("O_HiggsScalarFermionCoupling3361515_nofit",&O_HiggsScalarFermionCoupling3361515_nofit );// A0->tautau
  in_tree->SetBranchAddress("O_HiggsPseudoScalarFermionCoupling3361515_nofit",&O_HiggsPseudoScalarFermionCoupling3361515_nofit );// A0->tautau
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3252424_nofit",&O_HiggsBosonCoupling3252424_nofit );// h0->WW
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3352424_nofit",&O_HiggsBosonCoupling3352424_nofit );// H0->WW
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3362424_nofit",&O_HiggsBosonCoupling3362424_nofit );// A0->WW
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3252323_nofit",&O_HiggsBosonCoupling3252323_nofit );// h0->ZZ
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3352323_nofit",&O_HiggsBosonCoupling3352323_nofit );// H0->ZZ
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3362323_nofit",&O_HiggsBosonCoupling3362323_nofit );// A0->ZZ
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3252121_nofit",&O_HiggsBosonCoupling3252121_nofit );// h0->gluglu
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3352121_nofit",&O_HiggsBosonCoupling3352121_nofit );// H0->gluglu
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3362121_nofit",&O_HiggsBosonCoupling3362121_nofit );// A0->gluglu
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3252523_nofit",&O_HiggsBosonCoupling3252523_nofit );// h0->h0Z0
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3352523_nofit",&O_HiggsBosonCoupling3352523_nofit );// H0->h0Z0
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3353523_nofit",&O_HiggsBosonCoupling3353523_nofit );// H0->H0Z0
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3362523_nofit",&O_HiggsBosonCoupling3362523_nofit );// A0->h0Z0
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3363523_nofit",&O_HiggsBosonCoupling3363523_nofit );// A0->H0Z0
  in_tree->SetBranchAddress("O_HiggsBosonCoupling3363623_nofit",&O_HiggsBosonCoupling3363623_nofit );// A0->A0Z0
  in_tree->SetBranchAddress("O_HiggsBosonCoupling425212123_nofit",&O_HiggsBosonCoupling425212123_nofit );// h0->glu glu Z0
  in_tree->SetBranchAddress("O_HiggsBosonCoupling435212123_nofit",&O_HiggsBosonCoupling435212123_nofit );// H0->glu glu Z0
  in_tree->SetBranchAddress("O_HiggsBosonCoupling436212123_nofit",&O_HiggsBosonCoupling436212123_nofit );// A0->glu glu Z0
  in_tree->SetBranchAddress("O_h0_To_Neutralino1_Neutralino1__nofit",&O_h0_To_Neutralino1_Neutralino1__nofit );//h0->Chi10 Chi10
  in_tree->SetBranchAddress("O_widthh0_nofit",&O_widthh0_nofit );//h0->Chi10 Chi10
    in_tree->SetBranchAddress("mu_chi2",&mu_chi2);
    in_tree->SetBranchAddress("mh_chi2",&mh_chi2);
    in_tree->SetBranchAddress("Massh0_chi2",&Massh0_chi2);
    in_tree->SetBranchAddress("R_H_WW",&R_H_WW );
    in_tree->SetBranchAddress("R_H_ZZ",&R_H_ZZ );
    in_tree->SetBranchAddress("R_H_gaga",&R_H_gaga );
    in_tree->SetBranchAddress("R_H_tautau",&R_H_tautau );
    in_tree->SetBranchAddress("R_H_bb",&R_H_bb );
    in_tree->SetBranchAddress("R_VH_bb",&R_VH_bb );
    in_tree->SetBranchAddress("predmu0",&predmu[0] );
    in_tree->SetBranchAddress("predmu1",&predmu[1] );
    in_tree->SetBranchAddress("predmu2",&predmu[2] );
    in_tree->SetBranchAddress("predmu3",&predmu[3] );
    in_tree->SetBranchAddress("predmu4",&predmu[4] );
    in_tree->SetBranchAddress("predmu5",&predmu[5] );
    in_tree->SetBranchAddress("predmu6",&predmu[6] );
    in_tree->SetBranchAddress("predmu7",&predmu[7] );
    in_tree->SetBranchAddress("predmu8",&predmu[8] );
    in_tree->SetBranchAddress("predmu9",&predmu[9] );
    in_tree->SetBranchAddress("predmu10",&predmu[10] );
    in_tree->SetBranchAddress("predmu11",&predmu[11] );
    in_tree->SetBranchAddress("predmu12",&predmu[12] );
    in_tree->SetBranchAddress("predmu13",&predmu[13] );
    in_tree->SetBranchAddress("predmu14",&predmu[14] );
    in_tree->SetBranchAddress("predmu15",&predmu[15] );
    in_tree->SetBranchAddress("predmu16",&predmu[16] );
    in_tree->SetBranchAddress("predmu17",&predmu[17] );
    in_tree->SetBranchAddress("predmu18",&predmu[18] );
    in_tree->SetBranchAddress("predmu19",&predmu[19] );
    in_tree->SetBranchAddress("predmu20",&predmu[20] );
    in_tree->SetBranchAddress("predmu21",&predmu[21] );
    in_tree->SetBranchAddress("predmu22",&predmu[22] );
    in_tree->SetBranchAddress("predmu23",&predmu[23] );
    in_tree->SetBranchAddress("predmu24",&predmu[24] );
    in_tree->SetBranchAddress("predmu25",&predmu[25] );



  // == Content of interest of the output toys
  out_tree->Branch("chi2",&chi2,"chi2/F");
  out_tree->Branch("Bsg_chi2",&Bsg_chi2,"Bsg_chi2/F");
  out_tree->Branch("dm_s_chi2",&dm_s_chi2,"dm_s_chi2/F");
  out_tree->Branch("Btn_chi2",&Btn_chi2,"Btn_chi2/F");
  out_tree->Branch("gmin2_chi2",&gmin2_chi2,"gmin2_chi2/F");
  out_tree->Branch("omega_chi2",&omega_chi2,"omega_chi2/F");
  out_tree->Branch("MassW_chi2",&MassW_chi2,"MassW_chi2/F");
  out_tree->Branch("Massh0_chi2",&Massh0_chi2,"Massh0_chi2/F");
  out_tree->Branch("sin_th_eff_chi2",&sin_th_eff_chi2,"sin_th_eff_chi2/F");
  out_tree->Branch("B_smm_chi2",&B_smm_chi2,"B_smm_chi2/F");
  out_tree->Branch("massTop_chi2",&massTop_chi2,"massTop_chi2/F");
  out_tree->Branch("LEO_chi2",&LEO_chi2,"LEO_chi2/F");
  out_tree->Branch("LHC_chi2",&LHC_chi2,"LHC_chi2/F");
  out_tree->Branch("Higgs_chi2",&Higgs_chi2,"Higgs_chi2/D");
  out_tree->Branch("mu_chi2",&mu_chi2,"mu_chi2/D");
  out_tree->Branch("mh_chi2",&mh_chi2,"mh_chi2/D");
  out_tree->Branch("af_chi2",&af_chi2,"af_chi2/F");
  out_tree->Branch("P_M12",&P_M12,"P_M12/F");
  out_tree->Branch("P_M0",&P_M0,"P_M0/F");
  out_tree->Branch("P_A0",&P_A0,"P_A0/F");
  out_tree->Branch("P_TanBeta",&P_TanBeta,"P_TanBeta/F");
  out_tree->Branch("P_massTop",&P_massTop,"P_massTop/F");
  if( model == "NUHM1" ) out_tree->Branch("P_M0H",&P_M0H,"P_M0H/F");
   if( model == "NUHM2" ){
    out_tree->Branch("P_M0Hu",&P_M0Hu,"P_M0Hu/F");
    out_tree->Branch("P_M0Hd",&P_M0Hd,"P_M0Hd/F");
  }
  out_tree->Branch("O_Bsg_npf",&O_Bsg_npf,"O_Bsg_npf/F");
  out_tree->Branch("O_dm_s_npf",&O_dm_s_npf,"O_dm_s_npf/F");
  out_tree->Branch("O_Btn_npf",&O_Btn_npf,"O_Btn_npf/F");
  out_tree->Branch("O_omega",&O_omega,"O_omega/F");
  out_tree->Branch("O_gmin2m_npf",&O_gmin2m_npf,"O_gmin2m_npf/F");
  out_tree->Branch("O_Massh0_npf",&O_Massh0_npf,"O_Massh0_npf/F");
  out_tree->Branch("O_MassW_npf",&O_MassW_npf,"O_MassW_npf/F");
  out_tree->Branch("O_sin_th_eff_npf",&O_sin_th_eff_npf,"O_sin_th_eff_npf/F");
  out_tree->Branch("O_B_smm_npf",&O_B_smm_npf,"O_B_smm_npf/F");
  out_tree->Branch("O_massTop",&O_massTop,"O_massTop/F");
  out_tree->Branch("O_massh0_nofit",&O_massh0_nofit,"O_massh0_nofit/F");
  out_tree->Branch("likelihood",&likelihood,"likelihood/F");
  out_tree->Branch("rho",&rho,"rho/F");
  out_tree->Branch("pre_chi2",&pre_chi2,"pre_chi2/F");
  out_tree->Branch("accpoint",&accpoint,"accpoint/F");
  out_tree->Branch("n",&n,"n/F");
  out_tree->Branch("globalIter",&globalIter,"globalIter/F");
  out_tree->Branch("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne,"haveAcceptedAtLeastOne/F");
  out_tree->Branch("LHC_Exp_CLb",&LHC_Exp_CLb,"LHC_Exp_CLb/F");
  out_tree->Branch("LHC_Exp_CLsb",&LHC_Exp_CLsb,"LHC_Exp_CLsb/F");
  out_tree->Branch("LHC_Exp_chi2",&LHC_Exp_chi2,"LHC_Exp_chi2/F");
  out_tree->Branch("af_photon",&af_photon,"af_photon/F");
  out_tree->Branch("af_relic",&af_relic,"af_relic/F");
  out_tree->Branch("af_svind",&af_svind,"af_svind/F");
  out_tree->Branch("af_direct",&af_direct,"af_direct/F");
  out_tree->Branch("af_chi2_total",&af_chi2_total,"af_chi2_total/F");
  out_tree->Branch("af_chi2_photon",&af_chi2_photon,"af_chi2_photon/F");
  out_tree->Branch("af_chi2_relic",&af_chi2_relic,"af_chi2_relic/F");
  out_tree->Branch("af_chi2_svind",&af_chi2_svind,"af_chi2_svind/F");
  out_tree->Branch("af_chi2_direct",&af_chi2_direct,"af_chi2_direct/F");
  out_tree->Branch("globalHiggsChi2",&globalHiggsChi2,"globalHiggsChi2/F");
  out_tree->Branch("HiggsSignals_TotalChi2",&HiggsSignals_TotalChi2,"HiggsSignals_TotalChi2/F");
  out_tree->Branch("O_alphaem",&O_alphaem,"O_alphaem/F");
  out_tree->Branch("O_G_F_nofit",&O_G_F_nofit,"O_G_F_nofit/F");
  out_tree->Branch("O_alphas",&O_alphas,"O_alphas/F");
  out_tree->Branch("O_massZ",&O_massZ,"O_massZ/F");
  out_tree->Branch("O_massBottom_nofit",&O_massBottom_nofit,"O_massBottom_nofit/F");
  out_tree->Branch("O_massTau",&O_massTau,"O_massTau/F");
  out_tree->Branch("O_massCharm_nofit",&O_massCharm_nofit,"O_massCharm_nofit/F");
  out_tree->Branch("O_massA0_nofit",&O_massA0_nofit,"O_massA0_nofit/F");
  out_tree->Branch("O_massH0_nofit",&O_massH0_nofit,"O_massH0_nofit/F");
  out_tree->Branch("O_massHplus_nofit",&O_massHplus_nofit,"O_massHplus_nofit/F");
  out_tree->Branch("O_massSupL_nofit",&O_massSupL_nofit,"O_massSupL_nofit/F");
  out_tree->Branch("O_massSupR_nofit",&O_massSupR_nofit,"O_massSupR_nofit/F");
  out_tree->Branch("O_massSdownL_nofit",&O_massSdownL_nofit,"O_massSdownL_nofit/F");
  out_tree->Branch("O_massSdownR_nofit",&O_massSdownR_nofit,"O_massSdownR_nofit/F");
  out_tree->Branch("O_massScharmL_nofit",&O_massScharmL_nofit,"O_massScharmL_nofit/F");
  out_tree->Branch("O_massScharmR_nofit",&O_massScharmR_nofit,"O_massScharmR_nofit/F");
  out_tree->Branch("O_massSstrangeL_nofit",&O_massSstrangeL_nofit,"O_massSstrangeL_nofit/F");
  out_tree->Branch("O_massSstrangeR_nofit",&O_massSstrangeR_nofit,"O_massSstrangeR_nofit/F");
  out_tree->Branch("O_massStop1_nofit",&O_massStop1_nofit,"O_massStop1_nofit/F");
  out_tree->Branch("O_massStop2_nofit",&O_massStop2_nofit,"O_massStop2_nofit/F");
  out_tree->Branch("O_massSbottom1_nofit",&O_massSbottom1_nofit,"O_massSbottom1_nofit/F");
  out_tree->Branch("O_massSbottom2_nofit",&O_massSbottom2_nofit,"O_massSbottom2_nofit/F");
  out_tree->Branch("O_massSelectronL_nofit",&O_massSelectronL_nofit,"O_massSelectronL_nofit/F");
  out_tree->Branch("O_massSelectronR_nofit",&O_massSelectronR_nofit,"O_massSelectronR_nofit/F");
  out_tree->Branch("O_massSmuL_nofit",&O_massSmuL_nofit,"O_massSmuL_nofit/F");
  out_tree->Branch("O_massSmuR_nofit",&O_massSmuR_nofit,"O_massSmuR_nofit/F");
  out_tree->Branch("O_massStau1_nofit",&O_massStau1_nofit,"O_massStau1_nofit/F");
  out_tree->Branch("O_massStau2_nofit",&O_massStau2_nofit,"O_massStau2_nofit/F");
  out_tree->Branch("O_massSnueL_nofit",&O_massSnueL_nofit,"O_massSnueL_nofit/F");
  out_tree->Branch("O_massSnumuL_nofit",&O_massSnumuL_nofit,"O_massSnumuL_nofit/F");
  out_tree->Branch("O_massSnutau1_nofit",&O_massSnutau1_nofit,"O_massSnutau1_nofit/F");
  out_tree->Branch("O_massGluino_nofit",&O_massGluino_nofit,"O_massGluino_nofit/F");
  out_tree->Branch("O_massNeutralino1_nofit",&O_massNeutralino1_nofit,"O_massNeutralino1_nofit/F");
  out_tree->Branch("O_massNeutralino2_nofit",&O_massNeutralino2_nofit,"O_massNeutralino2_nofit/F");
  out_tree->Branch("O_massNeutralino3_nofit",&O_massNeutralino3_nofit,"O_massNeutralino3_nofit/F");
  out_tree->Branch("O_massNeutralino4_nofit",&O_massNeutralino4_nofit,"O_massNeutralino4_nofit/F");
  out_tree->Branch("O_massChargino1_nofit",&O_massChargino1_nofit,"O_massChargino1_nofit/F");
  out_tree->Branch("O_massChargino2_nofit",&O_massChargino2_nofit,"O_massChargino2_nofit/F");
  out_tree->Branch("O_Neutralino2_To_Electron_SelectronR__nofit",&O_Neutralino2_To_Electron_SelectronR__nofit,"O_Neutralino2_To_Electron_SelectronR__nofit/F");
  out_tree->Branch("O_Neutralino2_To_Muon_SmuonR__nofit",&O_Neutralino2_To_Muon_SmuonR__nofit,"O_Neutralino2_To_Muon_SmuonR__nofit/F");
  out_tree->Branch("O_Neutralino2_To_Electron_SelectronL__nofit",&O_Neutralino2_To_Electron_SelectronL__nofit,"O_Neutralino2_To_Electron_SelectronL__nofit/F");
  out_tree->Branch("O_Neutralino2_To_Muon_SmuonL__nofit",&O_Neutralino2_To_Muon_SmuonL__nofit,"O_Neutralino2_To_Muon_SmuonL__nofit/F");
  out_tree->Branch("O_Neutralino2_To_Tau_Stau1__nofit",&O_Neutralino2_To_Tau_Stau1__nofit,"O_Neutralino2_To_Tau_Stau1__nofit/F");
  out_tree->Branch("O_Neutralino2_To_Nutau_Snutau1__nofit",&O_Neutralino2_To_Nutau_Snutau1__nofit,"O_Neutralino2_To_Nutau_Snutau1__nofit/F");
  out_tree->Branch("O_Neutralino2_To_Tau_Stau2__nofit",&O_Neutralino2_To_Tau_Stau2__nofit,"O_Neutralino2_To_Tau_Stau2__nofit/F");
  out_tree->Branch("O_Neutralino2_To_Neutralino1_Z__nofit",&O_Neutralino2_To_Neutralino1_Z__nofit,"O_Neutralino2_To_Neutralino1_Z__nofit/F");
  out_tree->Branch("O_Neutralino2_To_Neutralino1_h0__nofit",&O_Neutralino2_To_Neutralino1_h0__nofit,"O_Neutralino2_To_Neutralino1_h0__nofit/F");
  out_tree->Branch("O_Neutralino2_To_Nutau_Snutau2__nofit",&O_Neutralino2_To_Nutau_Snutau2__nofit,"O_Neutralino2_To_Nutau_Snutau2__nofit/F");
  out_tree->Branch("O_Chargino1_To_Neutralino1_W__nofit",&O_Chargino1_To_Neutralino1_W__nofit,"O_Chargino1_To_Neutralino1_W__nofit/F");
  out_tree->Branch("O_Chargino1_To_Nutau_Stau1__nofit",&O_Chargino1_To_Nutau_Stau1__nofit,"O_Chargino1_To_Nutau_Stau1__nofit/F");
  out_tree->Branch("O_Chargino1_To_Nutau_Stau2__nofit",&O_Chargino1_To_Nutau_Stau2__nofit,"O_Chargino1_To_Nutau_Stau2__nofit/F");
  out_tree->Branch("O_Chargino1_To_Electron_SnueL__nofit",&O_Chargino1_To_Electron_SnueL__nofit,"O_Chargino1_To_Electron_SnueL__nofit/F");
  out_tree->Branch("O_Chargino1_To_Muon_SnumuL__nofit",&O_Chargino1_To_Muon_SnumuL__nofit,"O_Chargino1_To_Muon_SnumuL__nofit/F");
  out_tree->Branch("O_Chargino1_To_Tau_Snutau1__nofit",&O_Chargino1_To_Tau_Snutau1__nofit,"O_Chargino1_To_Tau_Snutau1__nofit/F");
  out_tree->Branch("O_SelectronR_To_Neutralino1_Electron__nofit",&O_SelectronR_To_Neutralino1_Electron__nofit,"O_SelectronR_To_Neutralino1_Electron__nofit/F");
  out_tree->Branch("O_SelectronR_To_Neutralino2_Electron__nofit",&O_SelectronR_To_Neutralino2_Electron__nofit,"O_SelectronR_To_Neutralino2_Electron__nofit/F");
  out_tree->Branch("O_SelectronL_To_Neutralino1_Electron__nofit",&O_SelectronL_To_Neutralino1_Electron__nofit,"O_SelectronL_To_Neutralino1_Electron__nofit/F");
  out_tree->Branch("O_SelectronL_To_Neutralino2_Electron__nofit",&O_SelectronL_To_Neutralino2_Electron__nofit,"O_SelectronL_To_Neutralino2_Electron__nofit/F");
  out_tree->Branch("O_Stau1_To_Neutralino1_Tau__nofit",&O_Stau1_To_Neutralino1_Tau__nofit,"O_Stau1_To_Neutralino1_Tau__nofit/F");
  out_tree->Branch("O_Stau2_To_Neutralino1_Tau__nofit",&O_Stau2_To_Neutralino1_Tau__nofit,"O_Stau2_To_Neutralino1_Tau__nofit/F");
  out_tree->Branch("O_Stau2_To_Neutralino2_Tau__nofit",&O_Stau2_To_Neutralino2_Tau__nofit,"O_Stau2_To_Neutralino2_Tau__nofit/F");
  out_tree->Branch("O_Stau2_To_Chargino1_Nutau__nofit",&O_Stau2_To_Chargino1_Nutau__nofit,"O_Stau2_To_Chargino1_Nutau__nofit/F");
  out_tree->Branch("O_Gluino_To_Bottom_Sbottom2__nofit",&O_Gluino_To_Bottom_Sbottom2__nofit,"O_Gluino_To_Bottom_Sbottom2__nofit/F");
  out_tree->Branch("O_Gluino_To_Bottom_Sbottom1__nofit",&O_Gluino_To_Bottom_Sbottom1__nofit,"O_Gluino_To_Bottom_Sbottom1__nofit/F");
  out_tree->Branch("O_Gluino_To_Stop1_Top__nofit",&O_Gluino_To_Stop1_Top__nofit,"O_Gluino_To_Stop1_Top__nofit/F");
  out_tree->Branch("O_Gluino_To_Stop2_Top__nofit",&O_Gluino_To_Stop2_Top__nofit,"O_Gluino_To_Stop2_Top__nofit/F");
  out_tree->Branch("O_Gluino_To_SupL_up__nofit",&O_Gluino_To_SupL_up__nofit,"O_Gluino_To_SupL_up__nofit/F");
  out_tree->Branch("O_Gluino_To_SupR_up__nofit",&O_Gluino_To_SupR_up__nofit,"O_Gluino_To_SupR_up__nofit/F");
  out_tree->Branch("O_Gluino_To_SdownL_down__nofit",&O_Gluino_To_SdownL_down__nofit,"O_Gluino_To_SdownL_down__nofit/F");
  out_tree->Branch("O_Gluino_To_SdownR_down__nofit",&O_Gluino_To_SdownR_down__nofit,"O_Gluino_To_SdownR_down__nofit/F");
  out_tree->Branch("O_SupL_To_Up_Neutralino1__nofit",&O_SupL_To_Up_Neutralino1__nofit,"O_SupL_To_Up_Neutralino1__nofit/F");
  out_tree->Branch("O_SupR_To_Up_Neutralino1__nofit",&O_SupR_To_Up_Neutralino1__nofit,"O_SupR_To_Up_Neutralino1__nofit/F");
  out_tree->Branch("O_SupL_To_Up_Neutralino2__nofit",&O_SupL_To_Up_Neutralino2__nofit,"O_SupL_To_Up_Neutralino2__nofit/F");
  out_tree->Branch("O_SupR_To_Up_Neutralino2__nofit",&O_SupR_To_Up_Neutralino2__nofit,"O_SupR_To_Up_Neutralino2__nofit/F");
  out_tree->Branch("O_SupL_To_Down_Chargino1__nofit",&O_SupL_To_Down_Chargino1__nofit,"O_SupL_To_Down_Chargino1__nofit/F");
  out_tree->Branch("O_SupR_To_Down_Chargino1__nofit",&O_SupR_To_Down_Chargino1__nofit,"O_SupR_To_Down_Chargino1__nofit/F");
  out_tree->Branch("O_SupL_To_Down_Chargino2__nofit",&O_SupL_To_Down_Chargino2__nofit,"O_SupL_To_Down_Chargino2__nofit/F");
  out_tree->Branch("O_SupR_To_Down_Chargino2__nofit",&O_SupR_To_Down_Chargino2__nofit,"O_SupR_To_Down_Chargino2__nofit/F");
  out_tree->Branch("O_Stop1_To_Bottom_Chargino1__nofit",&O_Stop1_To_Bottom_Chargino1__nofit,"O_Stop1_To_Bottom_Chargino1__nofit/F");
  out_tree->Branch("O_Stop1_To_Bottom_Chargino2__nofit",&O_Stop1_To_Bottom_Chargino2__nofit,"O_Stop1_To_Bottom_Chargino2__nofit/F");
  out_tree->Branch("O_Stop1_To_Top_Neutralino1__nofit",&O_Stop1_To_Top_Neutralino1__nofit,"O_Stop1_To_Top_Neutralino1__nofit/F");
  out_tree->Branch("O_Stop1_To_Top_Neutralino2__nofit",&O_Stop1_To_Top_Neutralino2__nofit,"O_Stop1_To_Top_Neutralino2__nofit/F");
  out_tree->Branch("O_Sbottom1_To_W_Stop1__nofit",&O_Sbottom1_To_W_Stop1__nofit,"O_Sbottom1_To_W_Stop1__nofit/F");
  out_tree->Branch("O_Sbottom2_To_W_Stop1__nofit",&O_Sbottom2_To_W_Stop1__nofit,"O_Sbottom2_To_W_Stop1__nofit/F");
  out_tree->Branch("O_Sbottom1_To_Top_Chargino1__nofit",&O_Sbottom1_To_Top_Chargino1__nofit,"O_Sbottom1_To_Top_Chargino1__nofit/F");
  out_tree->Branch("O_Sbottom2_To_Neutralino2_Bottom__nofit",&O_Sbottom2_To_Neutralino2_Bottom__nofit,"O_Sbottom2_To_Neutralino2_Bottom__nofit/F");
  out_tree->Branch("O_Sbottom1_To_Neutralino2_Bottom__nofit",&O_Sbottom1_To_Neutralino2_Bottom__nofit,"O_Sbottom1_To_Neutralino2_Bottom__nofit/F");
  out_tree->Branch("O_h0_To_Bottom_Bottom__nofit",&O_h0_To_Bottom_Bottom__nofit,"O_h0_To_Bottom_Bottom__nofit/F");
  out_tree->Branch("O_h0_To_Strange_Strange__nofit",&O_h0_To_Strange_Strange__nofit,"O_h0_To_Strange_Strange__nofit/F");
  out_tree->Branch("O_h0_To_Charm_Charm__nofit",&O_h0_To_Charm_Charm__nofit,"O_h0_To_Charm_Charm__nofit/F");
  out_tree->Branch("O_h0_To_Tau_Tau__nofit",&O_h0_To_Tau_Tau__nofit,"O_h0_To_Tau_Tau__nofit/F");
  out_tree->Branch("O_h0_To_Muon_Muon__nofit",&O_h0_To_Muon_Muon__nofit,"O_h0_To_Muon_Muon__nofit/F");
  out_tree->Branch("O_h0_To_Gamma_Gamma__nofit",&O_h0_To_Gamma_Gamma__nofit,"O_h0_To_Gamma_Gamma__nofit/F");
  out_tree->Branch("O_h0_To_Gluon_Gluon__nofit",&O_h0_To_Gluon_Gluon__nofit,"O_h0_To_Gluon_Gluon__nofit/F");
  out_tree->Branch("O_h0_To_W_W__nofit",&O_h0_To_W_W__nofit,"O_h0_To_W_W__nofit/F");
  out_tree->Branch("O_h0_To_Z_Z__nofit",&O_h0_To_Z_Z__nofit,"O_h0_To_Z_Z__nofit/F");
  out_tree->Branch("O_h0_To_Z_Gamma__nofit",&O_h0_To_Z_Gamma__nofit,"O_h0_To_Z_Gamma__nofit/F");
  out_tree->Branch("O_HiggsScalarFermionCoupling3250505_nofit",&O_HiggsScalarFermionCoupling3250505_nofit,"O_HiggsScalarFermionCoupling3250505_nofit/F");
  out_tree->Branch("O_HiggsPseudoScalarFermionCoupling3250505_nofit",&O_HiggsPseudoScalarFermionCoupling3250505_nofit,"O_HiggsPseudoScalarFermionCoupling3250505_nofit/F");
  out_tree->Branch("O_HiggsScalarFermionCoupling3350505_nofit",&O_HiggsScalarFermionCoupling3350505_nofit,"O_HiggsScalarFermionCoupling3350505_nofit/F");
  out_tree->Branch("O_HiggsPseudoScalarFermionCoupling3350505_nofit",&O_HiggsPseudoScalarFermionCoupling3350505_nofit,"O_HiggsPseudoScalarFermionCoupling3350505_nofit/F");
  out_tree->Branch("O_HiggsScalarFermionCoupling3360505_nofit",&O_HiggsScalarFermionCoupling3360505_nofit,"O_HiggsScalarFermionCoupling3360505_nofit/F");
  out_tree->Branch("O_HiggsPseudoScalarFermionCoupling3360505_nofit",&O_HiggsPseudoScalarFermionCoupling3360505_nofit,"O_HiggsPseudoScalarFermionCoupling3360505_nofit/F");
  out_tree->Branch("O_HiggsScalarFermionCoupling3250606_nofit",&O_HiggsScalarFermionCoupling3250606_nofit,"O_HiggsScalarFermionCoupling3250606_nofit/F");
  out_tree->Branch("O_HiggsPseudoScalarFermionCoupling3250606_nofit",&O_HiggsPseudoScalarFermionCoupling3250606_nofit,"O_HiggsPseudoScalarFermionCoupling3250606_nofit/F");
  out_tree->Branch("O_HiggsScalarFermionCoupling3350606_nofit",&O_HiggsScalarFermionCoupling3350606_nofit,"O_HiggsScalarFermionCoupling3350606_nofit/F");
  out_tree->Branch("O_HiggsPseudoScalarFermionCoupling3350606_nofit",&O_HiggsPseudoScalarFermionCoupling3350606_nofit,"O_HiggsPseudoScalarFermionCoupling3350606_nofit/F");
  out_tree->Branch("O_HiggsScalarFermionCoupling3360606_nofit",&O_HiggsScalarFermionCoupling3360606_nofit,"O_HiggsScalarFermionCoupling3360606_nofit/F");
  out_tree->Branch("O_HiggsPseudoScalarFermionCoupling3360606_nofit",&O_HiggsPseudoScalarFermionCoupling3360606_nofit,"O_HiggsPseudoScalarFermionCoupling3360606_nofit/F");
  out_tree->Branch("O_HiggsScalarFermionCoupling3251515_nofit",&O_HiggsScalarFermionCoupling3251515_nofit,"O_HiggsScalarFermionCoupling3251515_nofit/F");
  out_tree->Branch("O_HiggsPseudoScalarFermionCoupling3251515_nofit",&O_HiggsPseudoScalarFermionCoupling3251515_nofit,"O_HiggsPseudoScalarFermionCoupling3251515_nofit/F");
  out_tree->Branch("O_HiggsScalarFermionCoupling3351515_nofit",&O_HiggsScalarFermionCoupling3351515_nofit,"O_HiggsScalarFermionCoupling3351515_nofit/F");
  out_tree->Branch("O_HiggsPseudoScalarFermionCoupling3351515_nofit",&O_HiggsPseudoScalarFermionCoupling3351515_nofit,"O_HiggsPseudoScalarFermionCoupling3351515_nofit/F");
  out_tree->Branch("O_HiggsScalarFermionCoupling3361515_nofit",&O_HiggsScalarFermionCoupling3361515_nofit,"O_HiggsScalarFermionCoupling3361515_nofit/F");
  out_tree->Branch("O_HiggsPseudoScalarFermionCoupling3361515_nofit",&O_HiggsPseudoScalarFermionCoupling3361515_nofit,"O_HiggsPseudoScalarFermionCoupling3361515_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3252424_nofit",&O_HiggsBosonCoupling3252424_nofit,"O_HiggsBosonCoupling3252424_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3352424_nofit",&O_HiggsBosonCoupling3352424_nofit,"O_HiggsBosonCoupling3352424_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3362424_nofit",&O_HiggsBosonCoupling3362424_nofit,"O_HiggsBosonCoupling3362424_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3252323_nofit",&O_HiggsBosonCoupling3252323_nofit,"O_HiggsBosonCoupling3252323_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3352323_nofit",&O_HiggsBosonCoupling3352323_nofit,"O_HiggsBosonCoupling3352323_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3362323_nofit",&O_HiggsBosonCoupling3362323_nofit,"O_HiggsBosonCoupling3362323_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3252121_nofit",&O_HiggsBosonCoupling3252121_nofit,"O_HiggsBosonCoupling3252121_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3352121_nofit",&O_HiggsBosonCoupling3352121_nofit,"O_HiggsBosonCoupling3352121_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3362121_nofit",&O_HiggsBosonCoupling3362121_nofit,"O_HiggsBosonCoupling3362121_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3252523_nofit",&O_HiggsBosonCoupling3252523_nofit,"O_HiggsBosonCoupling3252523_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3352523_nofit",&O_HiggsBosonCoupling3352523_nofit,"O_HiggsBosonCoupling3352523_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3353523_nofit",&O_HiggsBosonCoupling3353523_nofit,"O_HiggsBosonCoupling3353523_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3362523_nofit",&O_HiggsBosonCoupling3362523_nofit,"O_HiggsBosonCoupling3362523_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3363523_nofit",&O_HiggsBosonCoupling3363523_nofit,"O_HiggsBosonCoupling3363523_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling3363623_nofit",&O_HiggsBosonCoupling3363623_nofit,"O_HiggsBosonCoupling3363623_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling425212123_nofit",&O_HiggsBosonCoupling425212123_nofit,"O_HiggsBosonCoupling425212123_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling435212123_nofit",&O_HiggsBosonCoupling435212123_nofit,"O_HiggsBosonCoupling435212123_nofit/F");
  out_tree->Branch("O_HiggsBosonCoupling436212123_nofit",&O_HiggsBosonCoupling436212123_nofit,"O_HiggsBosonCoupling436212123_nofit/F");
  out_tree->Branch("O_h0_To_Neutralino1_Neutralino1__nofit",&O_h0_To_Neutralino1_Neutralino1__nofit,"O_h0_To_Neutralino1_Neutralino1__nofit/F");
  out_tree->Branch("O_widthh0_nofit",&O_widthh0_nofit,"O_widthh0_nofit/F");

  out_tree->Branch("R_H_WW",&R_H_WW,"R_H_WW/D");
  out_tree->Branch("R_H_ZZ",&R_H_ZZ,"R_H_ZZ/D");
  out_tree->Branch("R_H_gaga",&R_H_gaga,"R_H_gaga/D");
  out_tree->Branch("R_H_tautau",&R_H_tautau,"R_H_tautau/D");
  out_tree->Branch("R_H_bb",&R_H_bb,"R_H_bb/D");
  out_tree->Branch("R_VH_bb",&R_VH_bb,"R_VH_bb/D");

  out_tree->Branch("predmu0",&predmu[0],"predmu0/D");
  out_tree->Branch("predmu1",&predmu[1],"predmu1/D");
  out_tree->Branch("predmu2",&predmu[2],"predmu2/D");
  out_tree->Branch("predmu3",&predmu[3],"predmu3/D");
  out_tree->Branch("predmu4",&predmu[4],"predmu4/D");
  out_tree->Branch("predmu5",&predmu[5],"predmu5/D");
  out_tree->Branch("predmu6",&predmu[6],"predmu6/D");
  out_tree->Branch("predmu7",&predmu[7],"predmu7/D");
  out_tree->Branch("predmu8",&predmu[8],"predmu8/D");
  out_tree->Branch("predmu9",&predmu[9],"predmu9/D");
  out_tree->Branch("predmu10",&predmu[10],"predmu10/D");
  out_tree->Branch("predmu11",&predmu[11],"predmu11/D");
  out_tree->Branch("predmu12",&predmu[12],"predmu12/D");
  out_tree->Branch("predmu13",&predmu[13],"predmu13/D");
  out_tree->Branch("predmu14",&predmu[14],"predmu14/D");
  out_tree->Branch("predmu15",&predmu[15],"predmu15/D");
  out_tree->Branch("predmu16",&predmu[16],"predmu16/D");
  out_tree->Branch("predmu17",&predmu[17],"predmu17/D");
  out_tree->Branch("predmu18",&predmu[18],"predmu18/D");
  out_tree->Branch("predmu19",&predmu[19],"predmu19/D");
  out_tree->Branch("predmu20",&predmu[20],"predmu20/D");
  out_tree->Branch("predmu21",&predmu[21],"predmu21/D");
  out_tree->Branch("predmu22",&predmu[22],"predmu22/D");
  out_tree->Branch("predmu23",&predmu[23],"predmu23/D");
  out_tree->Branch("predmu24",&predmu[24],"predmu24/D");
  out_tree->Branch("predmu25",&predmu[25],"predmu25/D");

  // Find the minimal chi2 by rejecting the buggy points
  
  // -1- Fill an histo with the values of the chi2
    float minHisto = 0, maxHisto = 200;
    int nBinHisto = 2000;
    
    TH1F* histo_chi2 = new TH1F( "histo_chi2", "", nBinHisto, minHisto,maxHisto ); 
    for( Int_t ievt = 0; ievt < in_tree->GetEntries(); ++ievt ){
      in_tree->GetEntry( ievt );
      histo_chi2->Fill( chi2 );
    }
    // -2- Find the value for which the bins above gather at least some points
    float minChi2=-1;
    int distance = 2;
    int neighbours = 15;
    for( int ibin = 1; ibin < nBinHisto; ibin++ )
      {
      for( int jbin = ibin; jbin <= (ibin + distance); jbin++ )
	{
	  float nAbove = histo_chi2->Integral( ibin, jbin );
	  if( nAbove >= neighbours ){
	    minChi2 = histo_chi2->GetBinCenter( ibin );
	    cout << "Minimum found at chi2 = " << minChi2 << endl;
	    break;
	  }
	  if( minChi2 != -1 ) break;
	}
      if( minChi2 != -1 ) break;
      }
    // -3- Loop on the input to reject all points with deltaChi2 > 1
    for( Int_t ievt = 0; ievt < in_tree->GetEntries(); ++ievt ){
      in_tree->GetEntry( ievt );
      if( chi2 > (minChi2 + 0.5) ) continue;
      if( chi2 < minChi2 ) continue;
      out_tree->Fill();
    }


    // Write and close
    //in_file->Close();
    //out_file->cd();
    out_tree->Write();
    out_file->Close();

    return;
}

// ===================================================================
// Look for the best fit point and save it in an ntuple (toy->0) or a text file (PP->1)
void saveBestFitPoint( bool PP_or_Toys ){

  // == Input
  TFile* in_file;
  TTree* in_tree; 
  TString in_name;
  int nFiles = 0;
  Float_t _Higgs_chi2;

  // == Output
  TString out_name;
  TFile* out_file = 0;
  TTree* out_tree = 0;
  ofstream out_stream;
  double bestpredmu[26] = {0.};

  // == For a single fit, fill a text file
  if( PP_or_Toys == 1 ){
    // in
    nFiles = 1;
    in_name = inputDir + fit + ".root";
    in_file = new TFile( in_name );
    cout << EMR << endl << " >>> Identifying the best fit point in.. " << endl << in_name << FIN << endl;
    // out  
    out_name = "bestFit_" + fit + ".txt";
    cout << EMR << endl << " >>> Creating the file for the best fit point.. " << endl << out_name << FIN << endl;
    out_stream.open( out_name );
  }


  // == Toys: output ntuple with the best fit points
  if( PP_or_Toys == 0 ){
    nFiles = atoi( getenv("NB_TOYS") );
    out_name = outputDir + "toy.root";
    out_file = new TFile( out_name, "RECREATE" );
    out_tree = new TTree( "markovChain", "best fit points of the toys" );
    out_name = outputDir + "toy.root";
    cout << "Toy substrate.." << endl;
    cout << out_name << endl;

    for( int iVal = 0; iVal < ValName.size(); iVal++ ) out_tree->Branch( ValName[iVal], &bestFitVal[iVal], ValName[iVal] + "/F" );  
    for( int iPar = 0; iPar < ParName.size(); iPar++ ) out_tree->Branch( ParName[iPar], &bestFitPar[iPar], ParName[iPar] + "/F" );
    out_tree->Branch("predmu0",&bestpredmu[0],"predmu0/D");
    out_tree->Branch("predmu1",&bestpredmu[1],"predmu1/D");
    out_tree->Branch("predmu2",&bestpredmu[2],"predmu2/D");
    out_tree->Branch("predmu3",&bestpredmu[3],"predmu3/D");
    out_tree->Branch("predmu4",&bestpredmu[4],"predmu4/D");
    out_tree->Branch("predmu5",&bestpredmu[5],"predmu5/D");
    out_tree->Branch("predmu6",&bestpredmu[6],"predmu6/D");
    out_tree->Branch("predmu7",&bestpredmu[7],"predmu7/D");
    out_tree->Branch("predmu8",&bestpredmu[8],"predmu8/D");
    out_tree->Branch("predmu9",&bestpredmu[9],"predmu9/D");
    out_tree->Branch("predmu10",&bestpredmu[10],"predmu10/D");
    out_tree->Branch("predmu11",&bestpredmu[11],"predmu11/D");
    out_tree->Branch("predmu12",&bestpredmu[12],"predmu12/D");
    out_tree->Branch("predmu13",&bestpredmu[13],"predmu13/D");
    out_tree->Branch("predmu14",&bestpredmu[14],"predmu14/D");
    out_tree->Branch("predmu15",&bestpredmu[15],"predmu15/D");
    out_tree->Branch("predmu16",&bestpredmu[16],"predmu16/D");
    out_tree->Branch("predmu17",&bestpredmu[17],"predmu17/D");
    out_tree->Branch("predmu18",&bestpredmu[18],"predmu18/D");
    out_tree->Branch("predmu19",&bestpredmu[19],"predmu19/D");
    out_tree->Branch("predmu20",&bestpredmu[20],"predmu20/D");
    out_tree->Branch("predmu21",&bestpredmu[21],"predmu21/D");
    out_tree->Branch("predmu22",&bestpredmu[22],"predmu22/D");
    out_tree->Branch("predmu23",&bestpredmu[23],"predmu23/D");
    out_tree->Branch("predmu24",&bestpredmu[24],"predmu24/D");
    out_tree->Branch("predmu25",&bestpredmu[25],"predmu25/D");
  }

// == Loop on the files to check
    for( int iFile = 1; iFile <= nFiles; iFile++ ){

    // == Open file and get ntuples
    if( PP_or_Toys == 0 ){
      TString iToy = Form( model + "_final_toys%i.root", iFile );
      in_name = inputDir + iToy;
      in_file = new TFile( in_name );
      cout << "Toy number " << iFile << " / " << nFiles << endl;
    }

    in_tree = (TTree*) in_file->Get("markovChain");

    // == Content of interest of the input toys
    in_tree->SetBranchAddress("chi2",&chi2 );
    in_tree->SetBranchAddress("O_Bsg_npf",&O_Bsg_npf );
    in_tree->SetBranchAddress("O_dm_s_npf",&O_dm_s_npf );
    in_tree->SetBranchAddress("O_Btn_npf",&O_Btn_npf );
    in_tree->SetBranchAddress("O_gmin2m_npf",&O_gmin2m_npf );
    in_tree->SetBranchAddress("O_omega",&O_omega );
    in_tree->SetBranchAddress("O_Massh0_npf",&O_Massh0_npf );
    in_tree->SetBranchAddress("O_MassW_npf",&O_MassW_npf );
    in_tree->SetBranchAddress("O_sin_th_eff_npf",&O_sin_th_eff_npf );
    in_tree->SetBranchAddress("O_B_smm_npf",&O_B_smm_npf );
    in_tree->SetBranchAddress("O_massTop",&O_massTop );
    in_tree->SetBranchAddress("O_massNeutralino1_nofit",&O_massNeutralino1_nofit );
    in_tree->SetBranchAddress("af_direct",&af_direct );
    in_tree->SetBranchAddress("LEO_chi2",&LEO_chi2 );
    in_tree->SetBranchAddress("LHC_chi2",&LHC_chi2 );
    in_tree->SetBranchAddress("Higgs_chi2",&_Higgs_chi2 );
    in_tree->SetBranchAddress("af_chi2",&af_chi2 );
    in_tree->SetBranchAddress("Bsg_chi2",&Bsg_chi2 );
    in_tree->SetBranchAddress("dm_s_chi2",&dm_s_chi2 );
    in_tree->SetBranchAddress("Btn_chi2",&Btn_chi2 );
    in_tree->SetBranchAddress("gmin2_chi2",&gmin2_chi2 );
    in_tree->SetBranchAddress("omega_chi2",&omega_chi2 );
    in_tree->SetBranchAddress("Massh0_chi2",&Massh0_chi2 );
    in_tree->SetBranchAddress("MassW_chi2",&MassW_chi2 );
    in_tree->SetBranchAddress("sin_th_eff_chi2",&sin_th_eff_chi2 );
    in_tree->SetBranchAddress("B_smm_chi2",&B_smm_chi2 );
    in_tree->SetBranchAddress("massTop_chi2",&massTop_chi2 );
    in_tree->SetBranchAddress("P_M0",&P_M0 );
    in_tree->SetBranchAddress("P_M12",&P_M12 );
    in_tree->SetBranchAddress("P_A0",&P_A0 );
    in_tree->SetBranchAddress("P_TanBeta",&P_TanBeta );
    in_tree->SetBranchAddress("P_massTop",&P_massTop );
    if( in_name.Contains("NUHM1") ) in_tree->SetBranchAddress("P_M0H",&P_M0H );
    if( in_name.Contains("NUHM2") ){
      in_tree->SetBranchAddress("P_M0Hu",&P_M0Hu );
      in_tree->SetBranchAddress("P_M0Hd",&P_M0Hd );
    }
    in_tree->SetBranchAddress("predmu0",&predmu[0]);
    in_tree->SetBranchAddress("predmu1",&predmu[1]);
    in_tree->SetBranchAddress("predmu2",&predmu[2]);
    in_tree->SetBranchAddress("predmu3",&predmu[3]);
    in_tree->SetBranchAddress("predmu4",&predmu[4]);
    in_tree->SetBranchAddress("predmu5",&predmu[5]);
    in_tree->SetBranchAddress("predmu6",&predmu[6]);
    in_tree->SetBranchAddress("predmu7",&predmu[7]);
    in_tree->SetBranchAddress("predmu8",&predmu[8]);
    in_tree->SetBranchAddress("predmu9",&predmu[9]);
    in_tree->SetBranchAddress("predmu10",&predmu[10]);
    in_tree->SetBranchAddress("predmu11",&predmu[11]);
    in_tree->SetBranchAddress("predmu12",&predmu[12]);
    in_tree->SetBranchAddress("predmu13",&predmu[13]);
    in_tree->SetBranchAddress("predmu14",&predmu[14]);
    in_tree->SetBranchAddress("predmu15",&predmu[15]);
    in_tree->SetBranchAddress("predmu16",&predmu[16]);
    in_tree->SetBranchAddress("predmu17",&predmu[17]);
    in_tree->SetBranchAddress("predmu18",&predmu[18]);
    in_tree->SetBranchAddress("predmu19",&predmu[19]);
    in_tree->SetBranchAddress("predmu20",&predmu[20]);
    in_tree->SetBranchAddress("predmu21",&predmu[21]);
    in_tree->SetBranchAddress("predmu22",&predmu[22]);
    in_tree->SetBranchAddress("predmu23",&predmu[23]);
    in_tree->SetBranchAddress("predmu24",&predmu[24]);
    in_tree->SetBranchAddress("predmu25",&predmu[25]);



        
    bestFitVal[0] = 1E10;

    // == Loop on events
    for( Int_t ievt = 0; ievt < in_tree->GetEntries(); ++ievt ){

      in_tree->GetEntry( ievt );
      
      if( chi2 < bestFitVal[0] ){
	bestFitVal[0]=chi2;
	bestFitVal[1]=O_Bsg_npf;
	bestFitVal[2]=O_dm_s_npf;
	bestFitVal[3]=O_Btn_npf;
	bestFitVal[4]=O_gmin2m_npf;
	bestFitVal[5]=O_omega;
	bestFitVal[6]=O_Massh0_npf;
	bestFitVal[7]=O_MassW_npf;
	bestFitVal[8]=O_sin_th_eff_npf;
	bestFitVal[9]=O_B_smm_npf;
	bestFitVal[10]=O_massTop;
	bestFitVal[11]=O_massNeutralino1_nofit;
	bestFitVal[12]=af_direct;
	bestFitVal[13]=LEO_chi2;
	bestFitVal[14]=LHC_chi2;
	bestFitVal[15]=_Higgs_chi2;
	bestFitVal[16]=af_chi2;
	bestFitVal[17]=Bsg_chi2;
	bestFitVal[18]=dm_s_chi2;
	bestFitVal[19]=Btn_chi2;
	bestFitVal[20]=gmin2_chi2;
	bestFitVal[21]=omega_chi2;
	bestFitVal[22]=Massh0_chi2;
	bestFitVal[23]=MassW_chi2;
	bestFitVal[24]=sin_th_eff_chi2;
	bestFitVal[25]=B_smm_chi2;
	bestFitVal[27]=massTop_chi2;
	//
	bestFitPar[0] = P_M0;
	bestFitPar[1] = P_M12;
	bestFitPar[2] = P_A0;
	bestFitPar[3] = P_TanBeta;
	bestFitPar[4] = P_massTop;
	if( in_name.Contains("NUHM1") ) bestFitPar[5] = P_M0H;
	if( in_name.Contains("NUHM2") ){
	  bestFitPar[5] = P_M0Hu;
	  bestFitPar[6] = P_M0Hd;
	}       
	for ( int i = 0; i < 26; i++ ) bestpredmu[i] = predmu[i];
      }
      
      }
      
      if( PP_or_Toys == 0 ) out_tree->Fill();
      if( PP_or_Toys == 1 ){
	for( int iVal = 0; iVal < ValName.size(); iVal++ ) out_stream << ValName[iVal] << " " << bestFitVal[iVal] << endl;
	for( int iPar = 0; iPar < ParName.size(); iPar++ ) out_stream << ParName[iPar] << " " << bestFitPar[iPar] << endl;      
	for( int i    = 0; i    < 26;             i++    ) out_stream << "predmu" << i << " " << bestpredmu[i] << endl;
	out_stream.close();     
      }
      in_file->Close();
  }

  if( PP_or_Toys == 0 ){
    out_file->cd();
    out_tree->Write();
    out_file->Close();
  }

  return;
}

#endif
