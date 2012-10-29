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
#include "TStopwatch.h"

#include <iostream>
#include <string>
#include <fstream>

#include "Higgs.h"
#include "LHC.h"
#include "astrofit.h"

using namespace std;

// == Most relevant parameters
bool verbose = 0;
bool useHiggsSignal = 1;
int pp_segment = 0;// to speed up the PP
int nb_segment = 0;
TString pp_segment_st;

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

// == Links for LHC chi2
string SignalGrid;
TH1F* LHC_extChi2 = 0;

// == Time measurement
TH1F* ht1;
TH1F* ht2;
TH1F* ht3;
TH1F* ht4;
TH1F* ht5;
TH1F* ht6;
TH1F* ht7;
TH1F* ht8;

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

// == Lower chi2 point for an individual toy
vector<float> toyBestFitVal;
vector<float> toyBestFitPar;

// == output ntuple
TNtuple* toyNtuple = 0;
TRandom3 r;

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
/* Float_t LHC_CLb; */
/* Float_t LHC_CLsb; */
/* Float_t LHC_chi2; */
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
float Higgs_chi2; 
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



// ===================================================================
// == Set all variables to zero
void initialize( TString arg1, TString arg2, TString arg3, int PP_or_Toys ){

  // == Options and parameters of the post processing
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

  if( PP_or_Toys == 0 ) randomSeed = atoi( getenv("RANDOM_SEED") );
  nb_segment = atoi( getenv("NB_SEGMENT") );
  pp_segment = atoi( getenv("PP_SEGMENT") );
  pp_segment_st = getenv("PP_SEGMENT");
  int _verbose = atoi( getenv("VERBOSE") );
  if( _verbose == 1 ) verbose = true;
  if( _verbose == 0 ) verbose = false;
  int _useHiggsSignal = atoi( getenv("USEHIGGSSIGNAL") );
  if( _useHiggsSignal == 0 ) useHiggsSignal = false;
  if( _useHiggsSignal == 1 ) useHiggsSignal = true;

  // == Tools for chi2 calculation
  SignalGrid   = "signalGrids.root";

  // === Time histograms
  ht1 = new TH1F( "ht1", "", 1000000, 0, 1 );
  ht2 = new TH1F( "ht2", "", 1000000, 0, 1 );
  ht3 = new TH1F( "ht3", "", 1000000, 0, 1 );
  ht4 = new TH1F( "ht4", "", 1000000, 0, 1 );
  ht5 = new TH1F( "ht5", "", 1000000, 0, 1 );
  ht6 = new TH1F( "ht6", "", 1000000, 0, 1 );
  ht7 = new TH1F( "ht7", "", 1000000, 0, 1 );
  ht8 = new TH1F( "ht8", "", 1000000, 0, 1 );

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

  if( model == "msugra" ){
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

  toyNtuple = new TNtuple( "toyNtuple", "Toy results", allValues.c_str() ); 
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
  initializeHiggs( verbose );

 return; 
}



// ===================================================================
// == Assign the variables to the output ntuple
void assignOutputBranches(){
  markovChain_out->Branch("likelihood",&likelihood,"likelihood/F");
  markovChain_out->Branch("rho",&rho,"rho/F");
  markovChain_out->Branch("chi2",&chi2,"chi2/F");
  markovChain_out->Branch("pre_chi2",&pre_chi2,"pre_chi2/F");
   markovChain_out->Branch("accpoint",&accpoint,"accpoint/F");
  markovChain_out->Branch("n",&n,"n/F");
  markovChain_out->Branch("globalIter",&globalIter,"globalIter/F");
  markovChain_out->Branch("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne,"haveAcceptedAtLeastOne/F");
 /*  markovChain_out->Branch("LHC_CLb",&LHC_CLb,"LHC_CLb/F"); */
/*   markovChain_out->Branch("LHC_CLsb",&LHC_CLsb,"LHC_CLsb/F"); */
/*   markovChain_out->Branch("LHC_chi2",&LHC_chi2,"LHC_chi2/F"); */
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
  markovChain_out->Branch("Higgs_chi2",&Higgs_chi2,"Higgs_chi2/F");
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
// == Assign the variables to the input ntuple
void assignInputBranches(){

  markovChain_in->SetBranchAddress("likelihood",&likelihood );
  markovChain_in->SetBranchAddress("rho",&rho );
  markovChain_in->SetBranchAddress("chi2",&chi2 );
  markovChain_in->SetBranchAddress("accpoint",&accpoint );
  markovChain_in->SetBranchAddress("n",&n );
  markovChain_in->SetBranchAddress("globalIter",&globalIter );
  markovChain_in->SetBranchAddress("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne );
 /*  markovChain_in->SetBranchAddress("LHC_CLb",&LHC_CLb ); */
/*   markovChain_in->SetBranchAddress("LHC_CLsb",&LHC_CLsb ); */
/*   markovChain_in->SetBranchAddress("LHC_chi2",&LHC_chi2 ); */
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

 return; 
}



// ===================================================================
// == Prepar input and output files
void openIOfiles( int PP_or_Toys, TString _fit ){

 // == Opening input fit to process

 // If you have cleaned it before (removal of multiple points in cleaning.h)
  TString name_in;
  if( PP_or_Toys == 1 ) name_in = _fit + "_cleaned.root";  
  if( PP_or_Toys == 0 ) name_in = inputDir + "/" + _fit + ".root";  
  file_in = new TFile( name_in );
  markovChain_in = (TTree*) file_in->Get("markovChain");

  // == Output processed file
  TString name_out = "";
  if( PP_or_Toys == 1 ) name_out = _fit + "_seg" + pp_segment_st + ".root";
  if( PP_or_Toys == 0 ) name_out = outputDir + "/" + _fit + "_toys_seg" + pp_segment_st + ".root";
  file_out = new TFile( name_out, "RECREATE" );
  markovChain_out = new TTree( "markovChain", "Processed fit" );

  cout << endl << " >>> Processing... "  << endl
       <<" fit: " << _fit << endl
       <<" model: " << model << endl;
  cout << " input: " << name_in << endl;
  cout << " output: " << name_out << endl;
  
  assignInputBranches();
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
  if( !fittinoInput.good() ) cout << "WARNING, file fittinoNewObservables.txt not found, check the script preparFittinoInput.sh" << endl; 
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
	// So far Bs->mumu from LHCb not included in the input file, so added by hand
	// Exp unc = 1.8e-9, Theo unc = 0.76e-9
	//if( ValName[i] == "O_B_smm_npf" ){
	//float BsmumuExp = 1.8e-9, BsmumuTheo = 0.76e-9;
	//	  LEObs[i] = 0.8e-9;
	//uncLEObs[i] = TMath::Sqrt( BsmumuExp*BsmumuExp + BsmumuTheo*BsmumuTheo );
	//	}

      }    
  }
  fittinoInput.close();

  cout << endl << " >>> Observables for post-processing.." << endl;
  for( int i = 0; i < ValName.size(); i++ ) 
    if( ValName[i].Contains("O_") && !ValName[i].Contains("chi2") && !ValName[i].Contains("massNeutralino1")) 
      cout << ValName[i] <<" = " << LEObs[i] << " +- " << uncLEObs[i] << endl;

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
  smearingResult[0] = toyVal[1];
  smearingResult[1] = toyVal[2];
  smearingResult[2] = toyVal[3];
  smearingResult[3] = toyVal[4];
  smearingResult[4] = toyVal[5];
  smearingResult[5] = toyVal[6];
  smearingResult[6] = toyVal[7];
  smearingResult[7] = toyVal[8];
  smearingResult[8] = toyVal[9];
  smearingResult[9] = toyVal[10];
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
  for( int iVal = 1; iVal < ValName.size(); iVal++ ) toyVal[iVal] = r.Gaus( bestFitVal[iVal], uncLEObs[iVal] );
  
  // Smear the cut on the chargino mass with the theoretical uncertainty of 1 GeV
  mChipl = r.Gaus( chipl_bound, 1.0 );
  if( verbose ) cout << "   > Lower limit on chargino mass: " << mChipl << endl;

  return;
}



// ===================================================================
// == Recalculate the minimal chi2 for a given toy with smeared observables
// == and spot the point of minimal chi2
void calculateChi2( int PP_or_Toys ){

  // Chi2 before the post-processing
  pre_chi2 = chi2;

  TStopwatch t1;
  // Set up the LHC tool and smear the number of observed events for toys
  // Our LHC grid is limited in M0, we extend it by giving the chi2 values obtained at M0=2.5TeV
  // For high M12 the LHC chi2 is set to zero
  setLHCchi2Tools( PP_or_Toys, randomSeed, SignalGrid, bestFitPar[0], bestFitPar[1], verbose );
  ht1->Fill( t1.RealTime() );

  TFile f_LHC_extChi2 ( "/afs/naf.desy.de/user/p/prudent/fittino/postProcessing/postProcessing_2012/LHC_extChi2.root" );
  TH1F* LHC_extChi2 = (TH1F*) f_LHC_extChi2.Get("LHC_extChi2");

  // To produce the histogram LHC_extChi2 as a function of M12
  //LHC_extChi2 = new TH1F( "LHC_extChi2", "", 200, 100, 900 );
  //for( int ibin = 1; ibin <= 200; ibin++ ){
  //float _M12 = LHC_extChi2->GetBinCenter( ibin );    
  //float _LHC_chi2 = LHCchi2( 2500, _M12 );
  //LHC_extChi2->SetBinContent( ibin, _LHC_chi2 );
  //}    
  //file_out->cd();
  //LHC_extChi2->Write();
  
  TStopwatch t2;  
  // Set the Xenon100 contour, smear it for toys
  setAstrofit( PP_or_Toys, randomSeed, bestFitVal[11], bestFitVal[12], verbose );
  ht2->Fill( t2.RealTime() );

  TStopwatch t3;
  if( PP_or_Toys == 0 )
    {
      // Smear low energy observables and lower limit on chargino
      smearLEObs( verbose );          

      // Smear the Higgs mh, mu
      if( useHiggsSignal ) smearHiggs( verbose, randomSeed );

      // Save smeared observables in an ntuple
      saveSmearedObs();
    }
  ht3->Fill( t3.RealTime() );

  // Monitor the cut flow
  int cutFlow[6] = {0};
  
  // Calculate new chi2 and find the lowest chi2
  if( verbose ) cout << "   > Calculate new chi2.." << endl;
  toyBestFitVal[0] = 1E5;
  float newChi2 = 0;
  
  // == Splitting the files
  int nEnt = markovChain_in->GetEntries();
  int nBet = 0;
  int first = 0;
  int last = nEnt;
  if( PP_or_Toys == 0 ){
    nBet = TMath::FloorNint( nEnt / (nb_segment*10) );
    first = (pp_segment-1) * nBet;
    last = first + nBet;  
    cout << "   > PP segment: " << pp_segment << "/" << nb_segment<<" -> events: " << first << " to " << last-1 << " of " << nEnt << endl;
  }

  for( Int_t ievt = first; ievt < last; ++ievt ) 
    {
      markovChain_in->GetEntry( ievt );

      LEO_chi2 = 0; LHC_chi2 = 0; Higgs_chi2 = 0; af_chi2 = 0; newChi2 = 0;
      Bsg_chi2=0; dm_s_chi2=0; Btn_chi2=0; gmin2_chi2=0; omega_chi2=0; Massh0_chi2=0; MassW_chi2=0; sin_th_eff_chi2=0; B_smm_chi2=0; massTop_chi2=0;

      if( verbose ) cout << " ---------- EVENT # "<< ievt << " ---------- " << endl;
      if( verbose ) cout <<"    - Parameters: M0(" <<P_M0<<") M12("<<P_M12<<") TanBeta("<<P_TanBeta<<") A0("<<P_A0<<")" <<endl;
      cutFlow[0]++;

      TStopwatch t4;
      // Cut on chargino mass
       float mChiplCut = 0;
       if( PP_or_Toys == 0 ) mChiplCut = mChipl;//smeared value
       if( PP_or_Toys == 1 ) mChiplCut = chipl_bound;//nominal value	 
       if( verbose ) cout <<"    - Chargino mass " << O_massChargino1_nofit << " bound: " << mChiplCut << endl;
       if( O_massChargino1_nofit < mChiplCut ) continue;
       cutFlow[1]++;

      // Chi2 for low energy observables
      if( PP_or_Toys == 1 ) Bsg_chi2 = myChi2( O_Bsg_npf,  LEObs[1], uncLEObs[1] ) ;
      if( PP_or_Toys == 0 ) Bsg_chi2 = myChi2( O_Bsg_npf,  toyVal[1], uncLEObs[1] ) ;         
      LEO_chi2 += Bsg_chi2;

      if( PP_or_Toys == 1 ) dm_s_chi2 = myChi2( O_dm_s_npf,  LEObs[2], uncLEObs[2] ) ;
      if( PP_or_Toys == 0 ) dm_s_chi2 = myChi2( O_dm_s_npf,  toyVal[2], uncLEObs[2] ) ;    
      LEO_chi2 += dm_s_chi2;

      if( PP_or_Toys == 1 ) Btn_chi2 = myChi2( O_Btn_npf,  LEObs[3], uncLEObs[3] ) ;
      if( PP_or_Toys == 0 ) Btn_chi2 = myChi2( O_Btn_npf,  toyVal[3], uncLEObs[3] ) ;
      LEO_chi2 += Btn_chi2;

      if( PP_or_Toys == 1 ) gmin2_chi2 = myChi2( O_gmin2m_npf,  LEObs[4], uncLEObs[4] ) ;
      if( PP_or_Toys == 0 ) gmin2_chi2 = myChi2( O_gmin2m_npf,  toyVal[4], uncLEObs[4] ) ;
      LEO_chi2 += gmin2_chi2;

      if( PP_or_Toys == 1 ) omega_chi2 = myChi2( O_omega,  LEObs[5], uncLEObs[5] ) ;
      if( PP_or_Toys == 0 ) omega_chi2 = myChi2( O_omega,  toyVal[5], uncLEObs[5] ) ;
      LEO_chi2 += omega_chi2;

      if( PP_or_Toys == 1 ) Massh0_chi2 = myChi2( O_Massh0_npf,  LEObs[7], uncLEObs[7] ) ;
      if( PP_or_Toys == 0 ) Massh0_chi2 = myChi2( O_Massh0_npf,  toyVal[7], uncLEObs[7] ) ;
      if( !useHiggsSignal ) LEO_chi2 += Massh0_chi2;      

      if( PP_or_Toys == 1 ) MassW_chi2 = myChi2( O_MassW_npf,  LEObs[7], uncLEObs[7] ) ;
      if( PP_or_Toys == 0 ) MassW_chi2 = myChi2( O_MassW_npf,  toyVal[7], uncLEObs[7] ) ;
      LEO_chi2 += MassW_chi2;

      if( PP_or_Toys == 1 ) sin_th_eff_chi2 = myChi2( O_sin_th_eff_npf,  LEObs[8], uncLEObs[8] ) ;
      if( PP_or_Toys == 0 ) sin_th_eff_chi2 = myChi2( O_sin_th_eff_npf,  toyVal[8], uncLEObs[8] ) ;
      LEO_chi2 += sin_th_eff_chi2;

      if( PP_or_Toys == 1 ) B_smm_chi2 = ul_myChi2( O_B_smm_npf,  LEObs[9], uncLEObs[9] ); // Upper limit
      if( PP_or_Toys == 0 ) B_smm_chi2 = ul_myChi2( O_B_smm_npf,  toyVal[9], uncLEObs[9] );// Upper limit
      LEO_chi2 += B_smm_chi2;

      if( PP_or_Toys == 1 ) massTop_chi2 = myChi2( O_massTop,  LEObs[10], uncLEObs[10] ) ;
      if( PP_or_Toys == 0 ) massTop_chi2 = myChi2( O_massTop,  toyVal[10], uncLEObs[10] ) ;
      LEO_chi2 += massTop_chi2;
      newChi2 += LEO_chi2;
      cutFlow[2]++;
      ht4->Fill( t4.RealTime() );

      if( verbose ){
	cout << "    - Individual chi2 per observables:"<<endl;       
	if( PP_or_Toys == 1 ){
	  cout << "       Bsg: theo = " << O_Bsg_npf << " meas = " << LEObs[1] << " ->chi2 = " << Bsg_chi2 << endl;
	  cout << "       Dms: theo = " << O_dm_s_npf<< " meas = " << LEObs[2] << " ->chi2 = " << dm_s_chi2 << endl;
	  cout << "       Btn: theo = " << O_Btn_npf<< " meas = " << LEObs[3] << " ->chi2 = " << Btn_chi2 << endl;
	  cout << "       gmin2: theo = " << O_gmin2m_npf<< " meas = " << LEObs[4] << " ->chi2 = " << gmin2_chi2 << endl;
	  cout << "       omega: theo = " << O_omega<< " meas = " << LEObs[5] << " ->chi2 = " << omega_chi2 << endl;
	  if( !useHiggsSignal ) cout << "       Massh0: theo = " << O_Massh0_npf<< " meas = " << LEObs[7] << " ->chi2 = " << Massh0_chi2 << endl;
	  cout << "       MassW: theo = " << O_MassW_npf<< " meas = " << LEObs[7] << " ->chi2 = " << MassW_chi2 << endl;
	  cout << "       sinThEff: theo = " << O_sin_th_eff_npf<< " meas = " << LEObs[8] << " ->chi2 = " << sin_th_eff_chi2 << endl;
	  cout << "       Bsmm: theo = " << O_B_smm_npf<< " meas = " << LEObs[9] << " ->chi2 = " << B_smm_chi2 << endl;
	  cout << "       masstop: theo = " <<  O_massTop<< " meas = " << LEObs[10] << " ->chi2 = " << massTop_chi2 << endl;
	}
	if( PP_or_Toys == 0 ){
	  cout << "       Bsg: theo = " << O_Bsg_npf << " meas = " << toyVal[1] << " ->chi2 = " << Bsg_chi2 << endl;
	  cout << "       Dms: theo = " << O_dm_s_npf<< " meas = " << toyVal[2] << " ->chi2 = " << dm_s_chi2 << endl;
	  cout << "       Btn: theo = " << O_Btn_npf<< " meas = " << toyVal[3] << " ->chi2 = " << Btn_chi2 << endl;
	  cout << "       gmin2: theo = " << O_gmin2m_npf<< " meas = " << toyVal[4] << " ->chi2 = " << gmin2_chi2 << endl;
	  cout << "       omega: theo = " << O_omega<< " meas = " << toyVal[5] << " ->chi2 = " << omega_chi2 << endl;
	  cout << "       MassW: theo = " << O_MassW_npf<< " meas = " << toyVal[7] << " ->chi2 = " << MassW_chi2 << endl;
	  if( !useHiggsSignal ) cout << "       Massh0: theo = " << O_Massh0_npf<< " meas = " << toyVal[7] << " ->chi2 = " << Massh0_chi2 << endl;
	  cout << "       sinThEff: theo = " << O_sin_th_eff_npf<< " meas = " << toyVal[8] << " ->chi2 = " << sin_th_eff_chi2 << endl;
	  cout << "       Bsmm: theo = " << O_B_smm_npf<< " meas = " << toyVal[9] << " ->chi2 = " << B_smm_chi2 << endl;
	  cout << "       masstop: theo = " <<  O_massTop<< " meas = " << toyVal[10] << " ->chi2 = " << massTop_chi2 << endl;
	}
      }
      
      /*
      TStopwatch t5;
      // Chi2 for LHC if the point lies in the limits of the grid
      if( P_M0 > 20 && P_M12 > 100 && P_M0 < 2500 && P_M12 < 900 ) LHC_chi2 = LHCchi2( P_M0, P_M12 );
      else if( P_M12 > 900 ) LHC_chi2 = 0;
      else if( P_M0 > 2500 ) LHC_chi2 = LHC_extChi2->GetBinContent( LHC_extChi2->FindBin( P_M12 ) );
      else LHC_chi2 = 1000;
      newChi2 += LHC_chi2;
      if( verbose ) cout << "       LHC " << LHC_chi2 << endl;      
      cutFlow[3]++;
      ht5->Fill( t5.RealTime() );
      */

      
      TStopwatch t5;
      // Fast calculation of the LHC chi2
      LHC_chi2 = LHCchi2_fast( P_M0, P_M12 );

      ht5->Fill( t5.RealTime() );
      

      TStopwatch t6;
      // New chi2 for Higgs       
      if( useHiggsSignal ){
	if( O_Massh0_npf < 10 || O_Massh0_npf > 1000 ) Higgs_chi2 = 1000;
	else{
	  fillHiggsMassCouplings( O_Massh0_npf );
	  Higgs_chi2 = getHiggsChi2( HiggsMassCouplings );
	}
	newChi2 += Higgs_chi2;
	if( verbose ) cout << "       Higgs " << Higgs_chi2 << endl; 
      } else Higgs_chi2 = Massh0_chi2;
      cutFlow[4]++;
      ht6->Fill( t6.RealTime() );

      TStopwatch t7;
      // New chi2 for astrofit
      af_chi2 = astrofitChi2( O_massNeutralino1_nofit, af_direct, false );
      newChi2 += af_chi2;
      if( verbose ) cout << "       Astrofit " << af_chi2 << endl;
      if( verbose ) cout << "    - Total chi2 " << newChi2 << endl;
      if( verbose ) cout << "    - Total LEO chi2 " << LEO_chi2 << endl;
      ht7->Fill( t7.RealTime() );

      // Don't save large chi2 points for PP
      if( PP_or_Toys == 1 && newChi2 > 60 ) continue;
      cutFlow[5]++;

      // Fill output ntuple for the real fit
      if( useHiggsSignal ) chi2 = LEO_chi2 + LHC_chi2 + Higgs_chi2 + af_chi2;
      if( !useHiggsSignal ) chi2 = LEO_chi2 + LHC_chi2 + af_chi2;
      markovChain_out->Fill();
	
	// Find lowest chi2 for that toy
      if( newChi2 < toyBestFitVal[0] ){
	toyBestFitVal[0] = newChi2;
	toyBestFitVal[1] = O_Bsg_npf;
	toyBestFitVal[2] = O_dm_s_npf;
	toyBestFitVal[3] = O_Btn_npf;
	toyBestFitVal[4] = O_gmin2m_npf;
	toyBestFitVal[5] = O_omega;
	toyBestFitVal[6] = O_Massh0_npf;
	toyBestFitVal[7] = O_MassW_npf;
	toyBestFitVal[8] = O_sin_th_eff_npf;
	toyBestFitVal[9] = O_B_smm_npf;
	toyBestFitVal[10] = O_massTop;
	toyBestFitVal[11] = O_massNeutralino1_nofit;
	toyBestFitVal[12] = af_direct;
	toyBestFitVal[13] = LEO_chi2;
	toyBestFitVal[14] = LHC_chi2;
	toyBestFitVal[15] = Higgs_chi2;
	toyBestFitVal[16] = af_chi2;
	toyBestFitVal[17] = Bsg_chi2; 
	toyBestFitVal[18] = dm_s_chi2; 
	toyBestFitVal[19] = Btn_chi2; 
	toyBestFitVal[20] = gmin2_chi2; 
	toyBestFitVal[21] = omega_chi2; 
	toyBestFitVal[22] = Massh0_chi2; 
	toyBestFitVal[23] = MassW_chi2; 
	toyBestFitVal[24] = sin_th_eff_chi2; 
	toyBestFitVal[25] = B_smm_chi2; 
	toyBestFitVal[26] = massTop_chi2;	
	//
	toyBestFitPar[0] = P_M0;
	toyBestFitPar[1] = P_M12;
	toyBestFitPar[2] = P_A0;
	toyBestFitPar[3] = P_TanBeta;
	toyBestFitPar[4] = P_massTop;
	if( model == "NUHM1" ) toyBestFitPar[5] = P_M0H;
	if( model == "NUHM2" ){
	  toyBestFitPar[5] = P_M0Hu;
	  toyBestFitPar[6] = P_M0Hd;
	}	
      }
    }
  
  cout << endl << " >>> Cut flow.." << endl;
  for( int icut=0; icut < 6; icut++ ) cout << "Step "<< icut << ": "<< cutFlow[icut] << endl;  

  file_out->cd();
  ht1->Write();
  ht2->Write();
  ht3->Write();
  ht4->Write();
  ht5->Write();
  ht6->Write();
  ht7->Write();
  ht8->Write();

  //delete prov;

  return;
}



// ===================================================================
// == Save the result of each toy in the ntuple
void saveToyResult(){

  // Observables and parameters at the best fit point for the toy
  const int size = ValName.size() + ParName.size();
  float* toyResult = new float[size];

  for( int i = 0; i < size; i++ ){
    if( i >= 0 && i < ValName.size() ) toyResult[i] = toyBestFitVal[i];
    if( i >= ValName.size() && i < size ) toyResult[i] = toyBestFitPar[i-ValName.size()];
  }

  cout << " >>> Saved in ntuples.." << endl;
  for( int i = 0; i < size; i++ ){
    if( i >= 0 && i < ValName.size() ) cout << "   - " << ValName[i] << "   " << toyResult[i] << endl;;
    if( i >= ValName.size() && i < size ) cout << "   - " << ParName[i-ValName.size()] << "   " << toyResult[i] << endl;
  }

  toyNtuple->Fill( toyResult );
  delete toyResult;

  return;
}

// ===================================================================
// == Read the file with the lowest chi2 point
void readBestFitPoint(){
  
  TString bestFitFile = inputDir + "/bestFit_" + fit + ".txt";
  ifstream bestFitStreamIn( bestFitFile );
  
  // If the file does not exist, create and fill it
  if( !bestFitStreamIn.good() ) cout << " >>>>>> WARNING <<<<<< the file of the best fit point is missing: " 
				     << endl << bestFitFile << endl;
  else{
    // If the file exists read it
    cout << endl << " >>> Reading file with lowest chi2 point.. " << endl << bestFitFile << endl;
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
    cout << endl << " >>> Lowest chi2 point after post-processing.." << endl;
    for( int iPar = 0; iPar < ParName.size(); iPar++ ){
      cout << ParName[iPar] << " = " << bestFitPar[iPar] << endl;
    }
    for( int iVal = 0; iVal < ValName.size(); iVal++ ) cout << ValName[iVal] << " = " << bestFitVal[iVal] << endl;       
  }

  return;
}



// ===================================================================
// == simulate toys, for each get the minimal chi2
// == PP_or_Toys = true-> postProcessing, wrong-> simulated toys
void processData( bool PP_or_Toys ){

  // Post-processing
  if( PP_or_Toys == 1 ){
    cout << endl << " >>> Post-processing.." << endl;
    // Calculate the chi2 for each point
    calculateChi2( PP_or_Toys );
  }

  // Simulate toys
  if( PP_or_Toys == 0 ){
    // Read the best fit point file
    readBestFitPoint();
    cout << endl << " >>> Simulating a toy " << endl;    
    // Calculate the chi2 for each point
    calculateChi2( PP_or_Toys );	          
    // Save the best toy fit point in the ntuple
    saveToyResult();    
  }
  return;
}



// ===================================================================
// == Write all histograms and trees and close files
void writeAndClose( int PP_or_Toys ){

  file_out->cd();
  
  markovChain_out->Write();
  if( PP_or_Toys == 0 ){
    toyNtuple->Write();
    smearedObsNtuple->Write();
  }
  
  file_in->Close();
  file_out->Close();
  finish_higgssignals_();

  return;
}






#endif
