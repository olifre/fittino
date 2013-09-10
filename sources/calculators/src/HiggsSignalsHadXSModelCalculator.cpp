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

    
    int output_level = 0; // 0: silent, 1: screen output , 2: even more output
    setup_output_level_( &output_level );

    int pdf = 2; // 1: box, 2: gaussian, 3: both
    setup_pdf_( &pdf );

    double dm = 0.;
    higgssignals_neutral_input_massuncertainty_( &dm );

    //int corr_mu = 1;
    //int corr_mh = 1;
    //setup_correlations_( &corr_mu, &corr_mh );

    double range = 1000.;
    setup_assignmentrange_( &range );

    int iterations = 0;
    setup_higgs_to_peaks_assignment_iterations_( &iterations );

    double dCS[5], dBR[5];
    dCS[0] = 0.147;  // single higgs
    dCS[1] = 0.028; // VBF
    dCS[2] = 0.037; // HW
    dCS[3] = 0.051; // HZ
    dCS[4] = 0.12;  // ttH
    dBR[0] = 0.054; // gammagamma
    dBR[1] = 0.048; // WW
    dBR[2] = 0.048; // ZZ
    dBR[3] = 0.061; // tautau
    dBR[4] = 0.028; // bbbar
    setup_rate_uncertainties_( dCS, dBR );

  
}

void Fittino::HiggsSignalsHadXSModelCalculator::InitializeSimpleOutputDataStorage() {

  //    _simpleOutputDataStorage->AddEntry

}

void Fittino::HiggsSignalsHadXSModelCalculator::CallExecutable() {

}

void Fittino::HiggsSignalsHadXSModelCalculator::CallFunction() {
  
    int nobs = 1;
    int mode = 1; // 1, 2, 3 for peak-centered, masse-centered chi^2 method or both
    double Chisq_mu, Chisq_mh, Chisq, Pvalue;
    //    run_higgssignals_( &mode, &Chisq_mu, &Chisq_mh, &Chisq, &nobs, &Pvalue );

}

void Fittino::HiggsSignalsHadXSModelCalculator::ConfigureInput() {

  //    double CP = 0;
  double CP = 1;
    double CS_lep_X = 0;
    double CS_lhc8_hj_ratio = _model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_ggh")->GetValue()
                            + _model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_bbh")->GetValue();
    double BR_hjinvisible = 0;
    double BR_hjhihi = 0;

    higgsbounds_neutral_input_hadr_(
                                    &_model->GetParameterMap()->at("mass_h")->GetValue(),                             // massh
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("Gamma_hTotal")->GetValue(),  // GammaTotal
                                    &CP,                                                                              // CP
                                    &CS_lep_X,                                                                        // CS_lep_bbhj_ratio
                                    &CS_lep_X,                                                                        // CS_lep_tautauhj_ratio
                                    &CS_lep_X,                                                                        // CS_lep_hjhi_ratio
                                    &CS_lhc8_hj_ratio,                                                                // CS_tev_hj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_bh")->GetValue(),  // CS_tev_hjb_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_Wh")->GetValue(),  // CS_tev_hjW_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_Zh")->GetValue(),  // CS_tev_hjZ_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_qqh")->GetValue(), // CS_tev_vbf_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_tth")->GetValue(), // CS_tev_tthj_ratio
                                    &CS_lhc8_hj_ratio,                                                                // CS_lhc7_hj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_bh")->GetValue(),  // CS_lhc7_hjb_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_Wh")->GetValue(),  // CS_lhc7_hjW_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_Zh")->GetValue(),  // CS_lhc7_hjZ_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_qqh")->GetValue(), // CS_lhc7_vbf_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_tth")->GetValue(), // CS_lhc7_tthj_ratio
                                    &CS_lhc8_hj_ratio,                                                                // CS_lhc8_hj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_bh")->GetValue(),  // CS_lhc8_hjb_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_Wh")->GetValue(),  // CS_lhc8_hjW_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_Zh")->GetValue(),  // CS_lhc8_hjZ_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_qqh")->GetValue(), // CS_lhc8_vbf_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("XS_normSM_tth")->GetValue(), // CS_lhc8_tthj_ratio
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_hss")->GetValue(),        // BR_hjss
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_hcc")->GetValue(),        // BR_hjcc
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_hbb")->GetValue(),        // BR_hjbb
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_hmumu")->GetValue(),      // BR_hjmumu
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_htautau")->GetValue(),    // BR_hjtautau
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_hWW")->GetValue(),        // BR_hjWW
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_hZZ")->GetValue(),        // BR_hjZZ
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_hZga")->GetValue(),       // BR_hjZga
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_hgaga")->GetValue(),      // BR_hjgaga
                                    &_model->GetCollectionOfPredictions()->GetMap()->at("BR_hgg")->GetValue(),        // BR_hjgg
                                    &BR_hjinvisible,                                                                  // BR_hjinvisible  
                                    &BR_hjhihi                                                                        // BR_hjhihi
                                    );


}
