#ifndef POSTPROCESSING_H
#define POSTPROCESSING_H

#include "TRandom3.h"
#include "TString.h"
#include "TFile.h"
#include "TTree.h"
#include "TMath.h"
#include "TNtuple.h"
#include "TH2.h"

#include <iostream>
#include <string>
#include <fstream>

#include "Higgs.h"
#include "LHC.h"

using namespace std;


// == Input/Output ntuples
TFile* file_in;
TTree* markovChain_in; 
TFile* file_out;
TTree* markovChain_out;
 
// == Global variables to identify fit and model
TString fit;
TString option;
TString model;
TString outputDir;
TString inputDir;

// == Fittino input file with observables
TString fittinoInput;

// == Links for LHC chi2
string StatTesHisto;
string SignalGrid;

// == Measurements or bounds und uncertainties
const Int_t size = 14;// uper limit on the number of observables
Float_t LEObs[size] = {0};
Float_t uncLEObs[size] = {0};

// == Lower chi2 point for nominal fit
Float_t bestFitVal[size] = {0};
Float_t bestFitPar[size] = {0};
TString ValName[size] = {""};
vector<TString> ParName;

// == Lower chi2 point for an individual toy
Float_t toyBestFitVal[size] = {0};
Float_t toyBestFitPar[size] = {0};

// == Toys variables
int numberToys = 1;
TNtuple* toyNtuple = 0;
TNtuple* bestFitNtuple = 0;
TRandom3 r;

// == Ntuple variables
// -- Chi2, likelihood, Markov chain
Float_t likelihood;
Float_t rho;
Float_t chi2;
Float_t accpoint;
Float_t n;
Float_t globalIter;
Float_t haveAcceptedAtLeastOne;

// -- LHC
Float_t LHC_CLb;
Float_t LHC_CLsb;
Float_t LHC_chi2;
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
Float_t globalHiggsChi2;

// -- Parameters
Float_t P_M0;
Float_t P_M12;
Float_t P_A0;
Float_t P_TanBeta;
Float_t P_QEWSB;
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



// == Set all variables to zero
void initialize( TString arg1, TString arg2, TString arg3, TString arg4, TString arg5 ){

  // == Options and parameters of the post processing
  fit = arg1;
  inputDir = arg2;
  outputDir = arg3;
  if( fit.Contains("NUHM1") ) model = "NUHM1";
  else if( fit.Contains("NUHM2") ) model = "NUHM2";
  else model = "msugra";

  // == Tools for chi2 calculation
  StatTesHisto = arg4;
  SignalGrid = arg5;

  // == Set names
  ValName[0] = "chi2";
  ValName[1] = "O_Bsg_npf";
  ValName[2] = "O_dm_s_npf";       
  ValName[3] = "O_Btn_npf";        
  ValName[4] = "O_gmin2m_npf";     
  ValName[5] = "O_omega";      
  ValName[6] = "O_Massh0_npf";     
  ValName[7] = "O_MassW_npf";      
  ValName[8] = "O_sin_th_eff_npf"; 
  ValName[9] = "O_B_smm_npf";    
  ValName[10] = "O_massTop"; 
  ValName[11] = "LEO_chi2"; 
  ValName[12] = "LHC_chi2"; 
  ValName[13] = "Higgs_chi2"; 
  
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
  for( int iVal = 0; iVal < size; iVal++ ){
    allValues += ValName[iVal];
    allValues += ":";
  }
  allValues += "P_M0:P_M12:P_A0:P_TanBeta";
  if( model == "NUHM1" )  allValues += ":P_M0H";
  if( model == "NUHM2" )  allValues += ":P_M0Hu:P_M0Hd";
  allValues += ":LEO_chi2:LHC_chi2:Higgs_chi2";
  toyNtuple = new TNtuple( "toyNtuple", "toy results", allValues.c_str() ); 
  bestFitNtuple = new TNtuple( "bestFitNtuple", "best fit results", allValues.c_str() ); 

  // == Initialize global variables to zero
  file_in = 0;
  markovChain_in = 0; 
  file_out = 0;
  markovChain_out = 0;
 
  // == Initialize HiggsSignal
  initializeHiggs();

 return; 
}

// == Assign the variables to the output ntuple
void assignOutputBranches(){
  markovChain_out->Branch("likelihood",&likelihood,"likelihood/F");
  markovChain_out->Branch("rho",&rho,"rho/F");
  markovChain_out->Branch("chi2",&chi2,"chi2/F");
  markovChain_out->Branch("accpoint",&accpoint,"accpoint/F");
  markovChain_out->Branch("n",&n,"n/F");
  markovChain_out->Branch("globalIter",&globalIter,"globalIter/F");
  markovChain_out->Branch("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne,"haveAcceptedAtLeastOne/F");
  markovChain_out->Branch("LHC_CLb",&LHC_CLb,"LHC_CLb/F");
  markovChain_out->Branch("LHC_CLsb",&LHC_CLsb,"LHC_CLsb/F");
  markovChain_out->Branch("LHC_chi2",&LHC_chi2,"LHC_chi2/F");
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
  if( fit.Contains("QEWSB") )  markovChain_out->Branch("P_QEWSB",&P_QEWSB,"P_QEWSB/F");

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

  markovChain_out->Branch("O_h0_To_Bottom_Bottom~__nofit",&O_h0_To_Bottom_Bottom__nofit,"O_h0_To_Bottom_Bottom~__nofit/F");
  markovChain_out->Branch("O_h0_To_Strange_Strange~__nofit",&O_h0_To_Strange_Strange__nofit,"O_h0_To_Strange_Strange~__nofit/F");
  markovChain_out->Branch("O_h0_To_Charm_Charm~__nofit",&O_h0_To_Charm_Charm__nofit,"O_h0_To_Charm_Charm~__nofit/F");
  markovChain_out->Branch("O_h0_To_Tau_Tau~__nofit",&O_h0_To_Tau_Tau__nofit,"O_h0_To_Tau_Tau~__nofit/F");
  markovChain_out->Branch("O_h0_To_Muon_Muon~__nofit",&O_h0_To_Muon_Muon__nofit,"O_h0_To_Muon_Muon~__nofit/F");
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
 return; 
}


// == Assign the variables to the input ntuple
void assignInputBranches(){
  markovChain_in->SetBranchAddress("likelihood",&likelihood );
  markovChain_in->SetBranchAddress("rho",&rho );
  markovChain_in->SetBranchAddress("chi2",&chi2 );
  markovChain_in->SetBranchAddress("accpoint",&accpoint );
  markovChain_in->SetBranchAddress("n",&n );
  markovChain_in->SetBranchAddress("globalIter",&globalIter );
  markovChain_in->SetBranchAddress("haveAcceptedAtLeastOne",&haveAcceptedAtLeastOne );
  markovChain_in->SetBranchAddress("LHC_CLb",&LHC_CLb );
  markovChain_in->SetBranchAddress("LHC_CLsb",&LHC_CLsb );
  markovChain_in->SetBranchAddress("LHC_chi2",&LHC_chi2 );
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
 if( fit.Contains("QEWSB") ) markovChain_in->SetBranchAddress("P_QEWSB",&P_QEWSB ); 

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

 return; 
}

// == Prepar input and output files
void openIOfiles( TString _fit ){

 // == Opening input fit to process
  TString name_in = inputDir + _fit + ".root";

  file_in = new TFile( name_in );
  markovChain_in = (TTree*) file_in->Get("markovChain");
  cout << endl << " >>> Processing... "  << endl 
       <<" fit: " << _fit << endl
       <<" file: " << name_in << endl
       <<" model: " << model << endl;
  cout << " output directory: " << outputDir << endl;
  assignInputBranches();

  // == Output processed file
  file_out = new TFile( _fit + ".root", "RECREATE" );
  markovChain_out = new TTree( "markovChain", "Markov chain with updated LHC chi2" );
  assignOutputBranches();

  return;
}

// == Read the experimental values from the Fittino input file
void assignLEObs(){

  //////////////////////////////////////
  //
  //
  //  WILL BE READ FROM INPUT FILE
  //
  //
  //////////////////////////////////////
/*   ValName[0] = "chi2"; */
/*   ValName[1] = "O_Bsg_npf"; */
/*   ValName[2] = "O_dm_s_npf";        */
/*   ValName[3] = "O_Btn_npf";         */
/*   ValName[4] = "O_gmin2m_npf";      */
/*   ValName[5] = "O_omega";       */
/*   ValName[6] = "O_Massh0_npf";      */
/*   ValName[7] = "O_MassW_npf";       */
/*   ValName[8] = "O_sin_th_eff_npf";  */
/*   ValName[9] = "O_B_smm_npf";     */
/*   ValName[10] = "O_massTop";  */

// == To account for the different uncertainties, -1 is assigned to empty ones
// == The fittino input is first read by a bash script preparFittinoInput.sh
  TString name;
  double meas, unc1, unc2, unc3, unc;

  ifstream fittinoInput ( "fittinoNewObservables.txt" );
  if( !fittinoInput.good() ) cout << "WARNING, file fittinoNewObservables.txt not found, check the script preparFittinoInput.sh" << endl; 
  else 
    while( fittinoInput >> name >> meas >> unc1 >> unc2 >> unc3 ){
      if( unc2 == -1 && unc3 == -1 ) unc = unc1;
      if( unc2 != -1 && unc3 == -1 ) unc = TMath::Sqrt( unc1*unc1 + unc2*unc2 );
      if( unc2 != -1 && unc3 != -1 ) unc = TMath::Sqrt( unc1*unc1 + unc2*unc2 + unc3*unc3 );
      name = "O_"+name;
      for( int i = 1; i < size; i++ ){
	if( ValName[i] == name ){
	  LEObs[i] = meas;
	  uncLEObs[i] = unc;
	}
      }    
  }
  fittinoInput.close();



  // Start at 1 to be consistent with the table ValName where '0' is the chi2
  /*
LEObs[1] = 3.55E-4;
 LEObs[2] = 17.78;       
 LEObs[3] = 1.67E-4;        
 LEObs[4] = 28.7E-10;     
 LEObs[5] = 0.1123;      
 LEObs[6] = 126.0;     
 LEObs[7] = 80.399;      
 LEObs[8] = 0.23113; 
 LEObs[9] = 1.6E-8; 
 LEObs[10] = 173.2;

 uncLEObs[1] = TMath::Sqrt( 0.24E-4 * 0.24E-4 + 0.09E-4 * 0.09E-4 + 0.23E-4 * 0.23E-4 );
 uncLEObs[2] = TMath::Sqrt( 0.12 * 0.12 + 5.2 * 5.2 );       
 uncLEObs[3] = 0.39E-4;
 uncLEObs[4] = TMath::Sqrt( 8.0E-10 * 8.0E-10 + 2.0E-10 * 2.0E-10 );     
 uncLEObs[5] = TMath::Sqrt( 0.0035 * 0.0035 + 0.0123 * 0.0123 );      
 uncLEObs[6] = TMath::Sqrt( 2.0 * 2.0 + 3.0 * 3.0 );     
 uncLEObs[7] = TMath::Sqrt( 0.023 * 0.023 + 0.010 * 0.010 );      
 uncLEObs[8] = 0.00021; 
 uncLEObs[9] = 0.02E-8;    
 uncLEObs[10] = 1.34;
  */
  cout << endl << " >>> Reading new observables for PP.." << endl;
  for( int i = 1; i < size; i++ ) if( ValName[i].Contains("O_") && !ValName[i].Contains("chi2")) cout << ValName[i] <<" = " << LEObs[i] << " +- " << uncLEObs[i] << endl;


 return;  
}

// == Calculating Higgs chi2 requires the couplings and mass
double HiggsMassCouplings[22] = {0};
// == Define functions to call HiggsBound to calculate the SM BR
// == when the couplings were not saved in the ntuple. Pseudoscalar and invisible couplings set to 0
extern "C" { double smbr_hss_( double *Mh );}
extern "C" { double smbr_hcc_( double *Mh );}
extern "C" { double smbr_hmumu_( double *Mh );}
extern "C" { double smbr_hzgam_( double *Mh );}
extern "C" { double smbr_hgamgam_( double *Mh );}

void fillHiggsMassCouplings( double Mh ){
  
  HiggsMassCouplings[0] = O_massh0_nofit;
  HiggsMassCouplings[1] = O_h0_To_Strange_Strange__nofit / smbr_hss_( &Mh );//g2hjss_s
  HiggsMassCouplings[2] = 0;//g2hjss_p
  HiggsMassCouplings[3] = O_h0_To_Charm_Charm__nofit / smbr_hcc_( &Mh );//g2hjcc_s
  HiggsMassCouplings[4] = 0;//g2hjcc_p
  HiggsMassCouplings[5] = O_HiggsScalarFermionCoupling3250505_nofit;//g2hjbb_s
  HiggsMassCouplings[6] = 0;//O_HiggsPseudoScalarFermionCoupling3250505_nofit;//g2hjbb_p
  HiggsMassCouplings[7] = O_HiggsScalarFermionCoupling3250606_nofit;//g2hjtt_s
  HiggsMassCouplings[8] = 0;//O_HiggsPseudoScalarFermionCoupling3250606_nofit;//g2hjtt_p
  HiggsMassCouplings[9] = O_h0_To_Muon_Muon__nofit / smbr_hmumu_( &Mh );//g2hjmumu_s
  HiggsMassCouplings[10] = 0;//g2hjmumu_p
  HiggsMassCouplings[11] = O_HiggsScalarFermionCoupling3251515_nofit;//g2hjtautau_s
  HiggsMassCouplings[12] = 0;//O_HiggsPseudoScalarFermionCoupling3251515_nofit;//g2hjtautau_p
  HiggsMassCouplings[13] = O_HiggsBosonCoupling3252424_nofit;//g2hjWW
  HiggsMassCouplings[14] = O_HiggsBosonCoupling3252323_nofit;//g2hjZZ
  HiggsMassCouplings[15] = O_h0_To_Z_Gamma__nofit / smbr_hzgam_( &Mh );//g2hjZga
  HiggsMassCouplings[16] = O_h0_To_Gamma_Gamma__nofit / smbr_hgamgam_( &Mh );//g2hjgaga
  HiggsMassCouplings[17] = O_HiggsBosonCoupling3252121_nofit;//g2hjgg
  HiggsMassCouplings[18] = O_HiggsBosonCoupling425212123_nofit;//g2hjggZ
  HiggsMassCouplings[19] = O_HiggsBosonCoupling3252523_nofit;//g2hjhiZ ---> ???????????????
  HiggsMassCouplings[20] = 0;//BR_hjinvisible
  HiggsMassCouplings[21] = 0;//BR_hjhihi
  
  return;
}


// == Given experimental values for observables, calculate the chi2 of each point
void calculateChi2(){


  return;
}

// ===================================================================
// == Simple function to calculate the chi2 without messing up
Float_t myChi2( Float_t theo, Float_t exp, Float_t unc ){
  return ( theo - exp ) * ( theo - exp ) / ( unc * unc );
}

// ===================================================================
// == Recalculate the minimal chi2 for a given toy with smeared observables
// == and spot the point of minimal chi2
void makeToyExperiments(){

  r.SetSeed(0);
  Float_t toyVal[size] = {0};
  vector<Float_t> indivToyChi2;


  // Smearing all LEO following a Gaussian centered on the values
  // at the best fit point, and whose width is the total uncertainty
  cout << "   > Smearing low energy observables.." << endl;
  for( int iVal = 1; iVal < size; iVal++ ) toyVal[iVal] = r.Gaus( bestFitVal[iVal], uncLEObs[iVal] );
  

  // Set up the LHC tool and smear the number of observed events (Matthias Hammer)
  cout << "   > Set up LHC tools.." << endl;
  setLHCchi2Tools( StatTesHisto, SignalGrid, bestFitPar[0], bestFitPar[1] );


  // Calculate new chi2 and find the lowest chi2
  cout << "   > Calculate new chi2.." << endl;
  toyBestFitVal[0] = 1E5;
  float newChi2 = 0;
  float LEO_chi2 = 0;
  float LHC_chi2 = 0;
  float Higgs_chi2 = 0;

  for( Int_t ievt = 0; ievt <  1; ++ievt )
    //for( Int_t ievt = 0; ievt <  markovChain_in->GetEntries(); ++ievt )
    {
      markovChain_in->GetEntry( ievt );

      // New chi2 for low energy observables
      newChi2 += myChi2( O_Bsg_npf,  toyVal[1], uncLEObs[1] ) ;
      newChi2 += myChi2( O_dm_s_npf,  toyVal[2], uncLEObs[2] ) ;
      newChi2 += myChi2( O_Btn_npf,  toyVal[3], uncLEObs[3] ) ;
      newChi2 += myChi2( O_gmin2m_npf,  toyVal[4], uncLEObs[4] ) ;
      newChi2 += myChi2( O_omega,  toyVal[5], uncLEObs[5] ) ;
      newChi2 += 0 ;//myChi2( O_Massh0_npf,  toyVal[6], uncLEObs[6] ) ;
      newChi2 += myChi2( O_MassW_npf,  toyVal[7], uncLEObs[7] ) ;
      newChi2 += myChi2( O_sin_th_eff_npf,  toyVal[8], uncLEObs[8] ) ;
      newChi2 += myChi2( O_B_smm_npf,  toyVal[9], uncLEObs[9] ); //if( O_B_smm_npf > toyVal[9] ) newChi2 += myChi2( O_B_smm_npf,  toyVal[9], uncLEObs[9] ) ; else newChi2 += 0 ;
      newChi2 += myChi2( O_massTop,  toyVal[10], uncLEObs[10] ) ;
      LEO_chi2 = newChi2;

      // New chi2 for LHC
      LHC_chi2 = LHCchi2( P_M0, P_M12 );
      newChi2 += LHC_chi2;

      /*
      cout << "LHC  " << LHCchi2( P_M0, P_M12 )<< endl;      
      cout << "Bsg  " << myChi2( O_Bsg_npf,  toyVal[1], uncLEObs[1] ) << endl;
      cout << "Dms  " << myChi2( O_dm_s_npf,  toyVal[2], uncLEObs[2] ) << endl;
      cout << "Btn  " << myChi2( O_Btn_npf,  toyVal[3], uncLEObs[3] ) << endl;
      cout << "gmin2  " << myChi2( O_gmin2m_npf,  toyVal[4], uncLEObs[4] ) << endl;
      cout << "omega  " << myChi2( O_omega,  toyVal[5], uncLEObs[5] ) << endl;
      cout << "MassW  " << myChi2( O_MassW_npf,  toyVal[7], uncLEObs[7] ) << endl;
      cout << "sinThEff  " << myChi2( O_sin_th_eff_npf,  toyVal[8], uncLEObs[8] ) << endl;
      cout << "Bsmm  " << myChi2( O_B_smm_npf,  toyVal[9], uncLEObs[9] ) << endl;
      cout << "masstop  " << myChi2( O_massTop,  toyVal[10], uncLEObs[10] ) << endl;
      */

      // New chi2 for Higgs
      cout << P_M0 << "   " << P_M12 << "    " << P_TanBeta << "    " << P_A0 << endl;
      fillHiggsMassCouplings( O_Massh0_npf );
      Higgs_chi2 = getHiggsChi2( HiggsMassCouplings );
      newChi2 += Higgs_chi2;


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
	toyBestFitVal[11] = LEO_chi2;
	toyBestFitVal[12] = LHC_chi2;
	toyBestFitVal[13] = Higgs_chi2;

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
  return;
}


// ===================================================================
// == simulate toys, for each get the minimal chi2
void simulateToys(){

  cout << endl << " >>> Simulating " << numberToys << " toys.." << endl;

  // Number of observables and parameters
  const Int_t sizeNtuple = size+ParName.size();
  Float_t toyResult[sizeNtuple];

  // Simulate 'numberToys' toys
  for( int iToy = 0; iToy < numberToys; iToy++ ){
    cout << endl << "  >> Toy #" << iToy << " /" << numberToys << endl;

    // Simulate new measurements
    makeToyExperiments();
    cout << "     chi2 = " << toyBestFitVal[0] << endl;

    // Save in ntuple the lowest chi2 point chi2, observables and parameters
    for( int iVal = 0; iVal < size; iVal++ ) toyResult[iVal] = toyBestFitVal[iVal];
    for( int iPar = 0; iPar < ParName.size(); iPar++ ) toyResult[size+iPar] = toyBestFitPar[iPar];
    toyNtuple->Fill( toyResult );
  }
  return;
}

// ===================================================================
// == For the lowest chi2 point of the nominal fit, get observables, parameters and chi2
// == These values are saved in a text file to avoid redundancy
void bestFitPoint(){

  TString bestFitFile = outputDir + "/bestFit_" + fit + ".txt";
  ifstream bestFitStreamIn( bestFitFile );

  // If the file does not exist, create and fill it
  if( !bestFitStreamIn.good() )
    {
      cout << "Creating and filling best fit file.. " << endl << bestFitFile << endl;
      ofstream bestFitStreamOut( bestFitFile );
      bestFitVal[0] = 1E5;
      for( Int_t ievt = 0; ievt <  markovChain_in->GetEntries(); ++ievt )
	{
	  markovChain_in->GetEntry( ievt );
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
      for( int iVal = 0; iVal < size; iVal++ ) bestFitStreamOut << ValName[iVal] << " " << bestFitVal[iVal] << endl;
      for( int iPar = 0; iPar < ParName.size(); iPar++ ){
	bestFitStreamOut << ParName[iPar] << " " << bestFitPar[iPar] << endl;
      }
      bestFitStreamOut.close();
    } 
  else 
    {    
      // If the file exists read it
      cout << endl << " >>> Reading best fit file.. " << endl << bestFitFile << endl;
      int iVal=0;
      Float_t _bestFitVal;
      TString _ValName;
      while( bestFitStreamIn >> _ValName >> _bestFitVal ){
	if( iVal < size ) bestFitVal[iVal] = _bestFitVal;
	if( iVal >= size ) bestFitPar[iVal-size] = _bestFitVal;      
	iVal++;
      }
      bestFitStreamIn.close();
    }
  
  // Display the results
  cout << endl << " >>> Lowest chi2 point for the nominal fit.." << endl;
  for( int iPar = 0; iPar < ParName.size(); iPar++ ){
    cout << ParName[iPar] << " " << bestFitPar[iPar] << endl;
  }
  for( int iVal = 0; iVal < size; iVal++ ) cout << ValName[iVal] << " = " << bestFitVal[iVal] << endl;
  
  // Save in ntuple the lowest chi2 point chi2, observables and parameters
  const Int_t sizeNtuple = size+ParName.size();
  Float_t bestFitResult[sizeNtuple];
  for( int iVal = 0; iVal < size; iVal++ ) bestFitResult[iVal] = bestFitVal[iVal];
  for( int iPar = 0; iPar < ParName.size(); iPar++ ) bestFitResult[size+iPar] = bestFitPar[iPar];
  bestFitNtuple->Fill( bestFitResult );


  return;
}


// == Write all histograms and trees and close files
void writeAndClose(){

  file_out->cd();
  toyNtuple->Write();
  bestFitNtuple->Write();
  file_in->Close();
  file_out->Close();
  finish_higgssignals_();

  return;
}


#endif
