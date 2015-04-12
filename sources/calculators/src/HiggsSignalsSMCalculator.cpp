/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSMCalculator.cpp                                     *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
                                                                               *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/property_tree/ptree.hpp>

#include "CHiggsSignals.h"
#include "HiggsSignalsSMCalculator.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"


Fittino::HiggsSignalsSMCalculator::HiggsSignalsSMCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    :CalculatorBase( model, &ptree ) {

    SetName( "HiggsSignalsSM" );
    SetTag ( "HiggsSignals_SM" );

    __theory_brfunctions_MOD_setup_brsm();

    AddInput( "Mass_h" );
    AddInput( "Mass_t" );

    AddOutput( "BR_h_W_W"        , _BR_h_W_W         );
    AddOutput( "BR_h_Z_Z"        , _BR_h_Z_Z         );
    AddOutput( "BR_h_b_b"        , _BR_h_b_b         );
    AddOutput( "BR_h_tau_tau"    , _BR_h_tau_tau     );
    AddOutput( "BR_h_gamma_gamma", _BR_h_gamma_gamma );
    AddOutput( "BR_h_g_g"        , _BR_h_g_g         );
    AddOutput( "BR_h_t_t"        , _BR_h_t_t         );
    AddOutput( "BR_h_c_c"        , _BR_h_c_c         );
    AddOutput( "BR_h_s_s"        , _BR_h_s_s         );
    AddOutput( "BR_h_mu_mu"      , _BR_h_mu_mu       );
    AddOutput( "BR_h_Z_gamma"    , _BR_h_Z_gamma     );
    AddOutput( "BR_h_Others"     , _BR_h_Others      );

    AddOutput( "Gamma_h_Total", _Gamma_h_Total );
    AddOutput( "Gamma_t_W_b"  , _Gamma_t_W_b   );

    AddOutput( "xs_TEV_hW" , _xs_TEV_Wh);
    AddOutput( "xs_TEV_hZ" , _xs_TEV_Zh);
    AddOutput( "xs_TEV_ggh", _xs_TEV_ggh );
    AddOutput( "xs_TEV_bbh", _xs_TEV_bbh );
    AddOutput( "xs_TEV_qqh", _xs_TEV_qqh );
    AddOutput( "xs_TEV_bh" , _xs_TEV_bh  );
    AddOutput( "xs_TEV_tth", _xs_TEV_tth );

    AddOutput( "xs_LHC_7TeV_hW" , _xs_LHC_7TeV_Wh);
    AddOutput( "xs_LHC_7TeV_hZ" , _xs_LHC_7TeV_Zh);
    AddOutput( "xs_LHC_7TeV_ggh", _xs_LHC_7TeV_ggh );
    AddOutput( "xs_LHC_7TeV_bbh", _xs_LHC_7TeV_bbh );
    AddOutput( "xs_LHC_7TeV_qqh", _xs_LHC_7TeV_qqh );
    AddOutput( "xs_LHC_7TeV_tth", _xs_LHC_7TeV_tth );

    AddOutput( "xs_LHC_8TeV_hW" , _xs_LHC_8TeV_Wh);
    AddOutput( "xs_LHC_8TeV_hZ" , _xs_LHC_8TeV_Zh);
    AddOutput( "xs_LHC_8TeV_ggh", _xs_LHC_8TeV_ggh );
    AddOutput( "xs_LHC_8TeV_bbh", _xs_LHC_8TeV_bbh );
    AddOutput( "xs_LHC_8TeV_qqh", _xs_LHC_8TeV_qqh );
    AddOutput( "xs_LHC_8TeV_tth", _xs_LHC_8TeV_tth );

    // int output_level = 0;
   // setup_output_level_( &output_level );

}

Fittino::HiggsSignalsSMCalculator::~HiggsSignalsSMCalculator() {

}


void Fittino::HiggsSignalsSMCalculator::CalculatePredictions() {

    UpdateInput();

    double mass_h = GetInput( "Mass_h" );
    double mass_t = GetInput( "Mass_t" );

    _BR_h_W_W         = smbr_hww_    ( &mass_h );
    _BR_h_Z_Z         = smbr_hzz_    ( &mass_h );
    _BR_h_b_b         = smbr_hbb_    ( &mass_h );
    _BR_h_tau_tau     = smbr_htautau_( &mass_h );
    _BR_h_gamma_gamma = smbr_hgamgam_( &mass_h );
    _BR_h_g_g         = smbr_hgg_    ( &mass_h );
    _BR_h_t_t         = smbr_htoptop_( &mass_h );
    _BR_h_c_c         = smbr_hcc_    ( &mass_h );
    _BR_h_s_s         = smbr_hss_    ( &mass_h );
    _BR_h_mu_mu       = smbr_hmumu_  ( &mass_h );
    _BR_h_Z_gamma     = smbr_hzgam_  ( &mass_h );

    _BR_h_Others  = 1;
    _BR_h_Others -= _BR_h_W_W;
    _BR_h_Others -= _BR_h_Z_Z;
    _BR_h_Others -= _BR_h_b_b;
    _BR_h_Others -= _BR_h_tau_tau;
    _BR_h_Others -= _BR_h_gamma_gamma;
    _BR_h_Others -= _BR_h_g_g;
    _BR_h_Others -= _BR_h_t_t;
    _BR_h_Others -= _BR_h_c_c;
    _BR_h_Others -= _BR_h_s_s;
    _BR_h_Others -= _BR_h_mu_mu;
    _BR_h_Others -= _BR_h_Z_gamma;

    _Gamma_h_Total = smgamma_h_   ( &mass_h );
    _Gamma_t_W_b   = smgamma_twpb_( &mass_t );

    _xs_TEV_Wh  = smcs_tev_hw_   ( &mass_h );
    _xs_TEV_Zh  = smcs_tev_hz_   ( &mass_h );
    _xs_TEV_ggh = smcs_tev_gg_h_ ( &mass_h );
    _xs_TEV_bbh = smcs_tev_bb_h_ ( &mass_h );
    _xs_TEV_qqh = smcs_tev_vbf_h_( &mass_h );
    _xs_TEV_bh  = smcs_tev_bg_hb_( &mass_h );
    _xs_TEV_tth = smcs_tev_tth_  ( &mass_h );

    _xs_LHC_7TeV_Wh  = smcs_lhc7_hw_   ( &mass_h );
    _xs_LHC_7TeV_Zh  = smcs_lhc7_hz_   ( &mass_h );
    _xs_LHC_7TeV_ggh = smcs_lhc7_gg_h_ ( &mass_h );
    _xs_LHC_7TeV_bbh = smcs_lhc7_bb_h_ ( &mass_h );
    _xs_LHC_7TeV_qqh = smcs_lhc7_vbf_h_( &mass_h );
    _xs_LHC_7TeV_tth = smcs_lhc7_tth_  ( &mass_h );

    _xs_LHC_8TeV_Wh  = smcs_lhc8_hw_   ( &mass_h );
    _xs_LHC_8TeV_Zh  = smcs_lhc8_hz_   ( &mass_h );
    _xs_LHC_8TeV_ggh = smcs_lhc8_gg_h_ ( &mass_h );
    _xs_LHC_8TeV_bbh = smcs_lhc8_bb_h_ ( &mass_h );
    _xs_LHC_8TeV_qqh = smcs_lhc8_vbf_h_( &mass_h );
    _xs_LHC_8TeV_tth = smcs_lhc8_tth_  ( &mass_h );

 //   _SM_Gamma_hss     = _SM_Gamma_hTotal * _SM_BR_hss;
 //   _SM_Gamma_hcc     = _SM_Gamma_hTotal * _SM_BR_hcc;
 //   _SM_Gamma_hbb     = _SM_Gamma_hTotal * _SM_BR_hbb;
 //   _SM_Gamma_hmumu   = _SM_Gamma_hTotal * _SM_BR_hmumu;
 //   _SM_Gamma_htautau = _SM_Gamma_hTotal * _SM_BR_htautau;
 //   _SM_Gamma_hgaga   = _SM_Gamma_hTotal * _SM_BR_hgaga;
 //   _SM_Gamma_hgg     = _SM_Gamma_hTotal * _SM_BR_hgg;
 //   _SM_Gamma_hWW     = _SM_Gamma_hTotal * _SM_BR_hWW;
 //   _SM_Gamma_hZga    = _SM_Gamma_hTotal * _SM_BR_hZga;
 //   _SM_Gamma_hZZ     = _SM_Gamma_hTotal * _SM_BR_hZZ;
//    _SM_xs_h       = _SM_xs_ggh + _SM_xs_bbh;
//    _weight_xs_ggh = _SM_xs_ggh / _SM_xs_h;
//    _weight_xs_bbh = _SM_xs_bbh / _SM_xs_h;
  //  _normSM_xs_h   = _weight_xs_ggh * _normSM_xs_ggh + _weight_xs_bbh * _normSM_xs_bbh;

}


