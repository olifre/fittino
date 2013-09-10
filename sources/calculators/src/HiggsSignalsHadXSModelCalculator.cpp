/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsHadXSModelCalculator.cpp                             *
*                                                                              *
* Description Wrapper class for HiggsSignals using whichinput=hadr             *
                                                                               *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "HiggsSignalsHadXSModelCalculator.h"
#include "ModelParameterBase.h"
#include "PhysicsModelBase.h"
#include "SimpleDataStorage.h"

extern "C" {

    double smbr_hss_( double* massh );
    double smbr_hcc_( double* massh );
    double smbr_hbb_( double* massh );
    double smbr_htoptop_( double* massh );
    double smbr_hmumu_( double* massh );
    double smbr_htautau_( double* massh );
    double smbr_hgamgam_( double* massh );
    double smbr_hgg_( double* massh );
    double smbr_hww_( double* massh );
    double smbr_hzgam_( double* massh );
    double smbr_hzz_( double* massh );
    double smgamma_h_( double* massh );

    double __theory_collidersfunctions_MOD_lhc8_rh_bb( double* massh );
    double __theory_collidersfunctions_MOD_lhc8_rh_gg( double* massh );

    void finish_higgssignals_();
    void get_rates_(
                    int*    ii,
                    int*    collider,
                    int*    Nchannels,
                    int*    IDchannels,
                    double* rate
                    ); 
    void get_rvalues_(
                      int*    nH,
                      int*    collider,
                      double* R_H_WW,
                      double* R_H_ZZ,
                      double* R_H_gaga,
                      double* R_H_tautau,
                      double* R_H_bb,
                      double* R_VH_bb
                      );

    void higgsbounds_neutral_input_hadr_(
                                         const double* massh,
                                         const double* GammaTotal,
                                         const double* CP,
                                         const double* CS_lep_bbhj_ratio,
                                         const double* CS_lep_tautauhj_ratio,
                                         const double* CS_lep_hjhi_ratio,
                                         const double* CS_tev_hj_ratio,
                                         const double* CS_tev_hjb_ratio,
                                         const double* CS_tev_hjW_ratio,
                                         const double* CS_tev_hjZ_ratio,
                                         const double* CS_tev_vbf_ratio,
                                         const double* CS_tev_tthj_ratio,
                                         const double* CS_lhc7_hj_ratio,
                                         const double* CS_lhc7_hjb_ratio,
                                         const double* CS_lhc7_hjW_ratio,
                                         const double* CS_lhc7_hjZ_ratio,
                                         const double* CS_lhc7_vbf_ratio,
                                         const double* CS_lhc7_tthj_ratio,
                                         const double* CS_lhc8_hj_ratio,
                                         const double* CS_lhc8_hjb_ratio,
                                         const double* CS_lhc8_hjW_ratio,
                                         const double* CS_lhc8_hjZ_ratio,
                                         const double* CS_lhc8_vbf_ratio,
                                         const double* CS_lhc8_tthj_ratio,
                                         const double* BR_hjss,
                                         const double* BR_hjcc,
                                         const double* BR_hjbb,
                                         const double* BR_hjmumu,
                                         const double* BR_hjtautau,
                                         const double* BR_hjWW,
                                         const double* BR_hjZZ,
                                         const double* BR_hjZga,
                                         const double* BR_hjgaga,
                                         const double* BR_hjgg,
                                         const double* BR_hjinvisible,
                                         const double* BR_hjhihi
                                         );
                                         
  void higgssignals_neutral_input_massuncertainty_( double* dm );
  void initialize_higgssignals_for_fittino_( int* nHzero, int* nHplus );
  void initialize_higgssignals_latestresults_( int* nHzero, int* nHplus );
  void run_higgssignals_(
                         int*    mode,
                         double* Chisq_mu,
                         double* Chisq_mh,
                         double* Chisq,
                         int*    nobs,
                         double* Pvalue
                         );
  void setup_assignmentrange_( double* range );
  void setup_correlations_( int* corr_mu, int* corr_mh);
  void setup_higgs_to_peaks_assignment_iterations_( int* iterations );
  void setup_output_level_( int* output_level );
  void setup_pdf_( int* pdf );
  void setup_rate_uncertainties_( double dCS[], double dBR[] );

}

Fittino::HiggsSignalsHadXSModelCalculator::HiggsSignalsHadXSModelCalculator( const PhysicsModelBase* model )
        :ModelCalculatorBase( model ){

    _name = "HiggsSignalsHadXSModelCalculator";

    InitializeSimpleOutputDataStorage();

}

Fittino::HiggsSignalsHadXSModelCalculator::~HiggsSignalsHadXSModelCalculator() {

}

void Fittino::HiggsSignalsHadXSModelCalculator::CalculatePredictions() {

    ConfigureInput();
    CallFunction();

}

void Fittino::HiggsSignalsHadXSModelCalculator::Initialize() const {

    int nHzero = 1;
    int nHplus = 0;

    initialize_higgssignals_latestresults_( &nHzero, &nHplus );
  
}

void Fittino::HiggsSignalsHadXSModelCalculator::InitializeSimpleOutputDataStorage() {

  //    _simpleOutputDataStorage->AddEntry

}

void Fittino::HiggsSignalsHadXSModelCalculator::CallExecutable() {

}

void Fittino::HiggsSignalsHadXSModelCalculator::CallFunction() {

}

void Fittino::HiggsSignalsHadXSModelCalculator::ConfigureInput() {

    

    higgsbounds_neutral_input_hadr_(
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // massh
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // GammaTotal
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CP
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lep_bbhj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lep_tautauhj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lep_hjhi_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_tev_hj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_tev_hjb_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_tev_hjW_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_tev_hjZ_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_tev_vbf_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_tev_tthj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc7_hj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc7_hjb_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc7_hjW_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc7_hjZ_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc7_vbf_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc7_tthj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc8_hj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc8_hjb_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc8_hjW_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc8_hjZ_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc8_vbf_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // CS_lhc8_tthj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjss
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjcc
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjbb
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjmumu
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjtautau
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjWW
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjZZ
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjZga
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjgaga
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjgg
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue(), // BR_hjinvisible
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("")->GetValue()  // BR_hjhihi
                                    );


  //GetPrediction

}
