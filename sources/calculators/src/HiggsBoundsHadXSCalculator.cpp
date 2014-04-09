/* $Id: HiggsBoundsHadXSCalculator.cpp 2067 2014-04-08 20:40:11Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsBoundsHadXSCalculator.cpp                                     *
*                                                                              *
* Description Wrapper class for HiggsBounds                                    *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include <boost/thread.hpp>

#include "CHiggsSignals.h"
#include "ConfigurationException.h"
#include "HiggsBoundsHadXSCalculator.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "Observable.h"

Fittino::HiggsBoundsHadXSCalculator::HiggsBoundsHadXSCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree ) 
    : HiggsBoundsCalculator( model, ptree ),
     _normSM_Gamma_hgg    ( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_g_g"         )->GetValue() ),
     _normSM_Gamma_htautau( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_tau_tau"     )->GetValue() ),
     _normSM_Gamma_hmumu  ( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_mu_mu"       )->GetValue() ),
     _normSM_Gamma_hgaga  ( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_gamma_gamma" )->GetValue() ),
     _normSM_Gamma_hWW    ( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_W_W"         )->GetValue() ),
     _normSM_Gamma_hZZ    ( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_Z_Z"         )->GetValue() ),
     _normSM_Gamma_hZga   ( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_Z_ga"        )->GetValue() ),
     _normSM_Gamma_hbb    ( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_b_b"         )->GetValue() ),
     _normSM_Gamma_hcc    ( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_c_c"         )->GetValue() ),
     _normSM_Gamma_hss    ( _model->GetCollectionOfQuantities().At( "NormSM_Gamma_h_s_s"         )->GetValue() ),
     _normSM_xs_ggh       ( _model->GetCollectionOfQuantities().At( "NormSM_xs_ggh"              )->GetValue() ),
     _normSM_xs_bbh       ( _model->GetCollectionOfQuantities().At( "NormSM_xs_bbh"              )->GetValue() ),
     _normSM_xs_qqh       ( _model->GetCollectionOfQuantities().At( "NormSM_xs_qqh_2flavor"      )->GetValue() ),
     _normSM_xs_tth       ( _model->GetCollectionOfQuantities().At( "NormSM_xs_tth"              )->GetValue() ),
     _normSM_xs_Wh        ( _model->GetCollectionOfQuantities().At( "NormSM_xs_Wh"               )->GetValue() ),
     _normSM_xs_Zh        ( _model->GetCollectionOfQuantities().At( "NormSM_xs_Zh"               )->GetValue() ),
     _normSM_xs_bh        ( _model->GetCollectionOfQuantities().At( "NormSM_xs_bh"               )->GetValue() ),
     _normSM_xs_lep       ( 1                                                                                  ),
     _normSM_xs_tev       ( 1                                                                                  ),
     _mass_h              ( _model->GetCollectionOfQuantities().At( "mass_h"                )->GetValue()      ),
     _BR_hInvisible       ( 0                                                                                  ),
     _BR_hHH              ( 0                                                                                  ), 
     _CP                  ( 1                                                                                  ) {
     
}

Fittino::HiggsBoundsHadXSCalculator::~HiggsBoundsHadXSCalculator() {

}

void Fittino::HiggsBoundsHadXSCalculator::setupHiggsBounds() {

    _SM_BR_hss       = smbr_hss_                                 ( &_mass_h );
    _SM_BR_hcc       = smbr_hcc_                                 ( &_mass_h );
    _SM_BR_hbb       = smbr_hbb_                                 ( &_mass_h );
    _SM_BR_hmumu     = smbr_hmumu_                               ( &_mass_h );
    _SM_BR_htautau   = smbr_htautau_                             ( &_mass_h );
    _SM_BR_hgaga     = smbr_hgamgam_                             ( &_mass_h );
    _SM_BR_hgg       = smbr_hgg_                                 ( &_mass_h );
    _SM_BR_hWW       = smbr_hww_                                 ( &_mass_h );
    _SM_BR_hZga      = smbr_hzgam_                               ( &_mass_h );
    _SM_BR_hZZ       = smbr_hzz_                                 ( &_mass_h );
    _SM_Gamma_hTotal = smgamma_h_                                ( &_mass_h );
    _SM_xs_ggh       = smcs_lhc8_gg_h_                           ( &_mass_h );
    _SM_xs_bbh       = smcs_lhc8_bb_h_                           ( &_mass_h ); 

    _SM_Gamma_hss     = _SM_Gamma_hTotal * _SM_BR_hss;
    _SM_Gamma_hcc     = _SM_Gamma_hTotal * _SM_BR_hcc;
    _SM_Gamma_hbb     = _SM_Gamma_hTotal * _SM_BR_hbb;
    _SM_Gamma_hmumu   = _SM_Gamma_hTotal * _SM_BR_hmumu;
    _SM_Gamma_htautau = _SM_Gamma_hTotal * _SM_BR_htautau;
    _SM_Gamma_hgaga   = _SM_Gamma_hTotal * _SM_BR_hgaga;
    _SM_Gamma_hgg     = _SM_Gamma_hTotal * _SM_BR_hgg;
    _SM_Gamma_hWW     = _SM_Gamma_hTotal * _SM_BR_hWW;
    _SM_Gamma_hZga    = _SM_Gamma_hTotal * _SM_BR_hZga;
    _SM_Gamma_hZZ     = _SM_Gamma_hTotal * _SM_BR_hZZ;
    
    _Gamma_hss     = _normSM_Gamma_hss     * _SM_Gamma_hss;
    _Gamma_hcc     = _normSM_Gamma_hcc     * _SM_Gamma_hcc;
    _Gamma_hbb     = _normSM_Gamma_hbb     * _SM_Gamma_hbb;
    _Gamma_hmumu   = _normSM_Gamma_hmumu   * _SM_Gamma_hmumu;
    _Gamma_htautau = _normSM_Gamma_htautau * _SM_Gamma_htautau;
    _Gamma_hgaga   = _normSM_Gamma_hgaga   * _SM_Gamma_hgaga;
    _Gamma_hgg     = _normSM_Gamma_hgg     * _SM_Gamma_hgg;
    _Gamma_hWW     = _normSM_Gamma_hWW     * _SM_Gamma_hWW;
    _Gamma_hZga    = _normSM_Gamma_hZga    * _SM_Gamma_hZga;
    _Gamma_hZZ     = _normSM_Gamma_hZZ     * _SM_Gamma_hZZ;

    _Gamma_hTotal = 0;
    _Gamma_hTotal += _Gamma_hss;
    _Gamma_hTotal += _Gamma_hcc;
    _Gamma_hTotal += _Gamma_hbb;
    _Gamma_hTotal += _Gamma_hmumu;
    _Gamma_hTotal += _Gamma_htautau;
    _Gamma_hTotal += _Gamma_hgaga;
    _Gamma_hTotal += _Gamma_hgg;
    _Gamma_hTotal += _Gamma_hWW;
    _Gamma_hTotal += _Gamma_hZga;
    _Gamma_hTotal += _Gamma_hZZ;

    _normSM_Gamma_hTotal = _Gamma_hTotal / _SM_Gamma_hTotal;
    
    _BR_hss     = _Gamma_hss     / _Gamma_hTotal;
    _BR_hcc     = _Gamma_hcc     / _Gamma_hTotal;
    _BR_hbb     = _Gamma_hbb     / _Gamma_hTotal;
    _BR_hmumu   = _Gamma_hmumu   / _Gamma_hTotal;
    _BR_htautau = _Gamma_htautau / _Gamma_hTotal;
    _BR_hgaga   = _Gamma_hgaga   / _Gamma_hTotal;
    _BR_hgg     = _Gamma_hgg     / _Gamma_hTotal;
    _BR_hWW     = _Gamma_hWW     / _Gamma_hTotal;
    _BR_hZga    = _Gamma_hZga    / _Gamma_hTotal;
    _BR_hZZ     = _Gamma_hZZ     / _Gamma_hTotal;

    _normSM_BR_hss     = _BR_hss     / _SM_BR_hss;
    _normSM_BR_hcc     = _BR_hcc     / _SM_BR_hcc;
    _normSM_BR_hbb     = _BR_hbb     / _SM_BR_hbb;
    _normSM_BR_hmumu   = _BR_hmumu   / _SM_BR_hmumu;
    _normSM_BR_htautau = _BR_htautau / _SM_BR_htautau;
    _normSM_BR_hgaga   = _BR_hgaga   / _SM_BR_hgaga;
    _normSM_BR_hgg     = _BR_hgg     / _SM_BR_hgg;
    _normSM_BR_hWW     = _BR_hWW     / _SM_BR_hWW;
    _normSM_BR_hZga    = _BR_hZga    / _SM_BR_hZga;
    _normSM_BR_hZZ     = _BR_hZZ     / _SM_BR_hZZ;
    
    _SM_xs_h       = _SM_xs_ggh + _SM_xs_bbh; 
    _weight_xs_ggh = _SM_xs_ggh / _SM_xs_h;
    _weight_xs_bbh = _SM_xs_bbh / _SM_xs_h;
    _normSM_xs_h   = _weight_xs_ggh * _normSM_xs_ggh + _weight_xs_bbh * _normSM_xs_bbh; 

    higgsbounds_neutral_input_hadr_(
                                    &_mass_h,        // massh
                                    &_Gamma_hTotal,  // GammaTotal
                                    &_CP,            // CP
                                    &_normSM_xs_lep, // CS_lep_bbhj_ratio
                                    &_normSM_xs_lep, // CS_lep_tautauhj_ratio
                                    &_normSM_xs_lep, // CS_lep_hjhi_ratio
                                    &_normSM_xs_lep, // CS_lep_hjhi_ratio ?
                                    &_normSM_xs_tev, // CS_tev_hj_ratio
                                    &_normSM_xs_tev, // CS_tev_hjb_ratio
                                    &_normSM_xs_tev, // CS_tev_hjW_ratio
                                    &_normSM_xs_tev, // CS_tev_hjZ_ratio
                                    &_normSM_xs_tev, // CS_tev_vbf_ratio
                                    &_normSM_xs_tev, // CS_tev_tthj_ratio
                                    &_normSM_xs_h,   // CS_lhc7_hj_ratio
                                    &_normSM_xs_bh,  // CS_lhc7_hjb_ratio
                                    &_normSM_xs_Wh,  // CS_lhc7_hjW_ratio
                                    &_normSM_xs_Zh,  // CS_lhc7_hjZ_ratio
                                    &_normSM_xs_qqh, // CS_lhc7_vbf_ratio
                                    &_normSM_xs_tth, // CS_lhc7_tthj_ratio
                                    &_normSM_xs_h,   // CS_lhc8_hj_ratio
                                    &_normSM_xs_bh,  // CS_lhc8_hjb_ratio
                                    &_normSM_xs_Wh,  // CS_lhc8_hjW_ratio
                                    &_normSM_xs_Zh,  // CS_lhc8_hjZ_ratio
                                    &_normSM_xs_qqh, // CS_lhc8_vbf_ratio
                                    &_normSM_xs_tth, // CS_lhc8_tthj_ratio
                                    &_BR_hss,        // BR_hjss
                                    &_BR_hcc,        // BR_hjcc
                                    &_BR_hbb,        // BR_hjbb
                                    &_BR_hmumu,      // BR_hjmumu
                                    &_BR_htautau,    // BR_hjtautau
                                    &_BR_hWW,        // BR_hjWW
                                    &_BR_hZZ,        // BR_hjZZ
                                    &_BR_hZga,       // BR_hjZga
                                    &_BR_hgaga,      // BR_hjgaga
                                    &_BR_hgg,        // BR_hjgg
                                    &_BR_hInvisible, // BR_hjinvisible  
                                    &_BR_hHH         // BR_hjhihi
                                    );

    
}
