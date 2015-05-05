/* $Id$ */

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

#ifndef FITTINO_CHIGGSSIGNALS_H
#define FITTINO_CHIGGSSIGNALS_H

#include <string>

extern "C" {

  void __theory_brfunctions_MOD_setup_brsm();

  double smbr_hww_    ( const double* massh );
  double smbr_hzz_    ( const double* massh );
  double smbr_hbb_    ( const double* massh );
  double smbr_htautau_( const double* massh );
  double smbr_hgamgam_( const double* massh );
  double smbr_hgg_    ( const double* massh );
  double smbr_htoptop_( const double* massh );
  double smbr_hcc_    ( const double* massh );
  double smbr_hss_    ( const double* massh );
  double smbr_hmumu_  ( const double* massh );
  double smbr_hzgam_  ( const double* massh );

  double smgamma_h_   ( const double* massh );
  double smgamma_twpb_( const double* masst );

  double smcs_tev_hw_   ( const double* massh );
  double smcs_tev_hz_   ( const double* massh );
  double smcs_tev_gg_h_ ( const double* massh );
  double smcs_tev_bb_h_ ( const double* massh );
  double smcs_tev_vbf_h_( const double* massh );
  double smcs_tev_bg_hb_( const double* massh );
  double smcs_tev_tth_  ( const double* massh );

  double smcs_lhc7_hw_   ( const double* massh );
  double smcs_lhc7_hz_   ( const double* massh );
  double smcs_lhc7_gg_h_ ( const double* massh );
  double smcs_lhc7_bb_h_ ( const double* massh );
  double smcs_lhc7_vbf_h_( const double* massh );
  double smcs_lhc7_tth_  ( const double* massh );

  double smcs_lhc8_hw_   ( const double* massh );
  double smcs_lhc8_hz_   ( const double* massh );
  double smcs_lhc8_gg_h_ ( const double* massh );
  double smcs_lhc8_bb_h_ ( const double* massh );
  double smcs_lhc8_vbf_h_( const double* massh );
  double smcs_lhc8_tth_  ( const double* massh );

  //double __theory_collidersfunctions_MOD_lhc8_rh_bb( const double* massh );
  //double __theory_collidersfunctions_MOD_lhc8_rh_gg( const double* massh );

  void __io_MOD_get_id_of_peakobservable( int* ii, int* ID );
  void __io_MOD_get_number_of_observables( int* ntotal, int* npeakmu, int* npeakmh, int* nmpred, int* nanalyses );
  void __io_MOD_get_peakinfo_from_hsresults( int* ID, double* mupred, int* domH, int* nHcomb );
  void __io_MOD_get_peakinfo( int* obsID, double* muobs, double* dmuup, double *dmulow, double* mpeak, double* dm );
  void __io_MOD_get_more_peakinfo( int* obsID, int* mhchisq );
  // void __io_MOD_higgssignals_create_slha_output_default( int* detailed );

  void __pc_chisq_MOD_get_peakchi2( int* obsID, double* csqmu, double* csqmh, double* csqmax, double* csqtot );
  void __pc_chisq_MOD_print_cov_mh_to_file( int* nH );
  void __pc_chisq_MOD_print_inverse_cov_mh_to_file( int* nH );
  void __pc_chisq_MOD_print_cov_mu_to_file();
  void __pc_chisq_MOD_print_inverse_cov_mu_to_file();

  void assign_toyvalues_to_peak_( int* obsID, double* mu_obs, double* mh_obs );

  void finish_higgssignals_();

  void get_rates_( const int* ii,
                   const int* collider,
                   const int* Nchannels,
                   const int* IDchannels,
                   double*    rate );

  void get_rvalues_( const int* nH,
                     const int* collider,
                     double*    R_H_WW,
                     double*    R_H_ZZ,
                     double*    R_H_gaga,
                     double*    R_H_tautau,
                     double*    R_H_bb,
                     double*    R_VH_bb );

  //void initialize_higgsbounds_( int* nH, int* nHplus, char *whichexpt );
  void initialize_higgsbounds_( const int* nH, const int* nHplus, const char *whichexpt, int whichexpt_length );
  void initialize_higgsbounds_chisqtables_();

  void initialize_higgssignals_( const int* nHzero, const int* nHplus, const char* expdata, int expdata_length );
  //void initialize_higgssignals_( const int* nHzero, const int* nHplus, const char* expdata );//, int expdata_length );
  void initialize_higgssignals_for_fittino_( const int* nHzero, const int* nHplus );
  void initialize_higgssignals_latestresults_( const int* nHzero, const int* nHplus );

  void hb_calc_stats_( double* theoryUncertainty1s, double* chi2WithoutTheory, double* chi2WithTheory, int* bestChannelChi2 );

  void higgsbounds_charged_input_( const double* massh,
                                   const double* GammaTot,
                                   const double* CS_lep_HpjHmi_ratio,
                                   const double* BR_tWpb,
                                   const double* BR_tHpjb,
                                   const double* BR_Hpjcs,
                                   const double* BR_Hpjcb,
                                   const double* BR_Hptaunu );

  void higgsbounds_input_slha_( char* filename, int* len );

  void higgsbounds_neutral_input_effc_( const double* mass_h,
                                        const double* GammaTotal,
                                        const double* g2hjss_s,
                                        const double* g2hjss_p,
                                        const double* g2hjcc_s,
                                        const double* g2hjcc_p,
                                        const double* g2hjbb_s,
                                        const double* g2hjbb_p,
                                        const double* g2hjtt_s,
                                        const double* g2hjtt_p,
                                        const double* g2hjmumu_s,
                                        const double* g2hjmumu_p,
                                        const double* g2hjtautau_s,
                                        const double* g2hjtautau_p,
                                        const double* g2hjWW,
                                        const double* g2hjZZ,
                                        const double* g2hjZga,
                                        const double* g2hjgaga,
                                        const double* g2hjgg,
                                        const double* g2hjggZ,
                                        const double* g2hjhiZ,
                                        const double* BR_hjinvisible,
                                        const double* BR_hjhihi );

  void higgsbounds_neutral_input_hadr_( const double* massh,
                                        const double* GammaTotal,
                                        const double* CP,
                                        const double* CS_lep_bbhj_ratio,
                                        const double* CS_lep_tautauhj_ratio,
                                        const double* CS_lep_hjhi_ratio,
                                        const double* CS_lep_hjhi_ratio1,
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
                                        const double* BR_hjhihi );

  void higgsbounds_neutral_input_part_( const double* massh,
                                        const double* GammaTot,
                                        const double* CP,
                                        const double* CS_lep_hjZ_ratio,
                                        const double* CS_lep_bbhj_ratio,
                                        const double* CS_lep_tautauhj_ratio,
                                        const double* CS_lep_hjhi_ratio,
                                        const double* CS_gg_hj_ratio,
                                        const double* CS_bb_hj_ratio,
                                        const double* CS_bg_hj_ratio,
                                        const double* CS_ud_hjWp_ratio,
                                        const double* CS_cs_hjWp_ratio,
                                        const double* CS_ud_hjWm_ratio,
                                        const double* CS_cs_hjWm_ratio,
                                        const double* CS_gg_hjZ_ratio,
                                        const double* CS_dd_hjZ_ratio,
                                        const double* CS_uu_hjZ_ratio,
                                        const double* CS_ss_hjZ_ratio,
                                        const double* CS_cc_hjZ_ratio,
                                        const double* CS_bb_hjZ_ratio,
                                        const double* CS_tev_vbf_ratio,
                                        const double* CS_tev_tthj_ratio,
                                        const double* CS_lhc7_vbf_ratio,
                                        const double* CS_lhc7_tthj_ratio,
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
                                        const double* BR_hjhihi );

  void higgssignals_neutral_input_massuncertainty_( const double* dm );
  void higgsbounds_set_mass_uncertainties_( const double* dmn, const double* dmc );

  void run_higgsbounds_( int* HBresult, int* channel, double* obsratio, int* ncombined );

  void run_higgssignals_( const int* mode,
                          double*    Chisq_mu,
                          double*    Chisq_mh,
                          double*    Chisq,
                          int*       nobs,
                          double*    Pvalue );

  void setup_assignmentrange_( const double* range );
  void setup_assignmentrange_massobservables_( const double* lambda );
  void setup_correlations_( const int* corr_mu, const int* corr_mh );
  void setup_higgs_to_peaks_assignment_iterations_( const int* iterations );
  void setup_output_level_( const int* output_level );
  void setup_pdf_( const int* pdf );
  void setup_rate_uncertainties_( const double dCS[], const double dBR[] );

}

#endif // FITTINO_CHIGGSSIGNALS_H
