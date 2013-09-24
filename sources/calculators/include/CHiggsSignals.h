/* $Id: HiggsSignalsHadXSModelCalculator.cpp 1567 2013-09-11 12:04:18Z sarrazin $ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CHiggsSignals.h                                                  *
*                                                                              *
* Description Declaration of HiggsSignals functions                            *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

extern "C" {

  double smgamma_h_      ( const double* massh );
  double smbr_hww_       ( const double* massh );
  double smbr_hzz_       ( const double* massh );
  double smbr_hbb_       ( const double* massh );
  double smbr_htautau_   ( const double* massh );
  double smbr_hgamgam_   ( const double* massh );
  double smbr_hgg_       ( const double* massh );
  double smbr_htoptop_   ( const double* massh );
  double smbr_hcc_       ( const double* massh );
  double smbr_hss_       ( const double* massh );
  double smbr_hmumu_     ( const double* massh );
  double smbr_hzgam_     ( const double* massh );
  double smcs_lhc8_hw_   ( const double* massh );
  double smcs_lhc8_hz_   ( const double* massh );
  double smcs_lhc8_gg_h_ ( const double* massh ); 
  double smcs_lhc8_bb_h_ ( const double* massh );
  double smcs_lhc8_vbf_h_( const double* massh );
  double smcs_lhc8_tth_  ( const double* massh );

  double __theory_collidersfunctions_MOD_lhc8_rh_bb( const double* massh );
  double __theory_collidersfunctions_MOD_lhc8_rh_gg( const double* massh );

  void finish_higgssignals_();

  void get_rates_(
                  const int*    ii,
                  const int*    collider,
                  const int*    Nchannels,
                  const int*    IDchannels,
                  double* rate
                  ); 

  void get_rvalues_(
                    const int*    nH,
                    const int*    collider,
                    double* R_H_WW,
                    double* R_H_ZZ,
                    double* R_H_gaga,
                    double* R_H_tautau,
                    double* R_H_bb,
                    double* R_VH_bb
                    );

  void initialize_higgssignals_for_fittino_  ( const int* nHzero, const int* nHplus );
  void initialize_higgssignals_latestresults_( const int* nHzero, const int* nHplus );

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
                                         
  void higgssignals_neutral_input_massuncertainty_( const double* dm );

  void run_higgssignals_(
                         const int*    mode,
                         double* Chisq_mu,
                         double* Chisq_mh,
                         double* Chisq,
                         int*    nobs,
                         double* Pvalue
                         );

  void setup_assignmentrange_( const double* range );
  void setup_correlations_( const int* corr_mu, const int* corr_mh);
  void setup_higgs_to_peaks_assignment_iterations_( const int* iterations );
  void setup_output_level_( const int* output_level );
  void setup_pdf_( const int* pdf );
  void setup_rate_uncertainties_( const double dCS[], const double dBR[] );

}