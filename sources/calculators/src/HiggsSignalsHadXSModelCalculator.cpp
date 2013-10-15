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

#include <boost/property_tree/ptree.hpp>

#include <iostream>

#include "CHiggsSignals.h"
#include "Configuration.h"
#include "HiggsSignalsHadXSModelCalculator.h"
#include "ModelParameterBase.h"
#include "PhysicsModelBase.h"
#include "SimpleDataStorage.h"

Fittino::HiggsSignalsHadXSModelCalculator::HiggsSignalsHadXSModelCalculator( const PhysicsModelBase* model )
    :ModelCalculatorBase  ( model                                                                                    ),
     _normSM_Gamma_hgg    ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_hgg"      )->GetValue() ),
     _normSM_Gamma_htautau( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_htautau"  )->GetValue() ),
     _normSM_Gamma_hmumu  ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_hmumu"    )->GetValue() ),
     _normSM_Gamma_hgaga  ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_hgaga"    )->GetValue() ),
     _normSM_Gamma_hWW    ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_hWW"      )->GetValue() ),
     _normSM_Gamma_hZZ    ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_hZZ"      )->GetValue() ),
     _normSM_Gamma_hZga   ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_hZga"     )->GetValue() ),
     _normSM_Gamma_hbb    ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_hbb"      )->GetValue() ),
     _normSM_Gamma_hcc    ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_hcc"      )->GetValue() ),
     _normSM_Gamma_hss    ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_Gamma_hss"      )->GetValue() ),
     _normSM_xs_ggh       ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_xs_ggh"         )->GetValue() ),
     _normSM_xs_bbh       ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_xs_bbh"         )->GetValue() ),
     _normSM_xs_qqh       ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_xs_qqh_2flavor" )->GetValue() ),
     _normSM_xs_tth       ( model->GetCollectionOfPredictions().GetMap()->at(  "HDim6_normSM_xs_tth"         )->GetValue() ),
     _normSM_xs_Wh        ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_xs_Wh"          )->GetValue() ),
     _normSM_xs_Zh        ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_xs_Zh"          )->GetValue() ),
     _normSM_xs_bh        ( _model->GetCollectionOfPredictions().GetMap()->at( "HDim6_normSM_xs_bh"          )->GetValue() ),
     _normSM_xs_lep       ( 0                                                                                        ),
     _normSM_xs_tev       ( 0                                                                                        ),
     _mass_h              ( _model->GetParameterMap()                     ->at( "mass_h"               )->GetValue() ),
     _mode                ( 1                                                                                        ),
     _BR_hInvisible       ( 0                                                                                        ),
     _BR_hHH              ( 0                                                                                        ), 
     _CP                  ( 1                                                                                        ) {

    _name = "HiggsSignalsHadXSModelCalculator";

    _collectionOfDoubles.AddElement( "normSM_BR_hbb"      , &_normSM_BR_hbb);  
    _collectionOfDoubles.AddElement( "normSM_BR_hcc"      , &_normSM_BR_hcc);
    _collectionOfDoubles.AddElement( "normSM_BR_hgaga"    , &_normSM_BR_hgaga);
    _collectionOfDoubles.AddElement( "normSM_BR_hgg"      , &_normSM_BR_hgg);
    _collectionOfDoubles.AddElement( "normSM_BR_hmumu"    , &_normSM_BR_hmumu);
    _collectionOfDoubles.AddElement( "normSM_BR_hss"      , &_normSM_BR_hss);
    _collectionOfDoubles.AddElement( "normSM_BR_htautau"  , &_normSM_BR_htautau);
    _collectionOfDoubles.AddElement( "normSM_BR_hWW"      , &_normSM_BR_hWW);
    _collectionOfDoubles.AddElement( "normSM_BR_hZga"     , &_normSM_BR_hZga);
    _collectionOfDoubles.AddElement( "normSM_BR_hZZ"      , &_normSM_BR_hZZ);
    _collectionOfDoubles.AddElement( "normSM_Gamma_hTotal", &_normSM_Gamma_hTotal);
    _collectionOfDoubles.AddElement( "normSM_xs_h"        , &_normSM_xs_h);
    _collectionOfDoubles.AddElement( "weight_xs_ggh"      , &_weight_xs_ggh);
    _collectionOfDoubles.AddElement( "weight_xs_ggh_2"    , &_weight_xs_ggh_2);
    _collectionOfDoubles.AddElement( "weight_xs_bbh"      , &_weight_xs_bbh);
    _collectionOfDoubles.AddElement( "weight_xs_bbh_2"    , &_weight_xs_bbh_2);
    _collectionOfDoubles.AddElement( "chi2"               , &_chi2);
    _collectionOfDoubles.AddElement( "chi2_mass_h"        , &_chi2_mass_h);
    _collectionOfDoubles.AddElement( "chi2_mu"            , &_chi2_mu);
    _collectionOfDoubles.AddElement( "pvalue"             , &_pvalue);

    Configuration *configuration = Configuration::GetInstance();
    const boost::property_tree::ptree* propertyTree = configuration->GetPropertyTree();
    


    int nHzero = 1;
    int nHplus = 0;
    //std::string expdata = "LHC_mail_14_07_2013_HS_new_observable_set";

    std::string expdata = propertyTree->get<std::string>( "InputFile.HiggsSignalsHadXSCalculator.ExpData" );
    std::cout<<"Using ExpData = "<<expdata<<std::endl;
    initialize_higgssignals_( &nHzero, &nHplus, expdata );
    
    int output_level = 0; 
    setup_output_level_( &output_level );

    int pdf = 2; 
    setup_pdf_( &pdf );

    double dm = 0.;
    higgssignals_neutral_input_massuncertainty_( &dm );

    double range = 1000.;
    setup_assignmentrange_( &range );
                                                           
}

Fittino::HiggsSignalsHadXSModelCalculator::~HiggsSignalsHadXSModelCalculator() {

}

void Fittino::HiggsSignalsHadXSModelCalculator::CalculatePredictions() {

    ConfigureInput(); 
    CallFunction();

}

void Fittino::HiggsSignalsHadXSModelCalculator::Initialize() const {

  
}


void Fittino::HiggsSignalsHadXSModelCalculator::CallExecutable() {

}

void Fittino::HiggsSignalsHadXSModelCalculator::CallFunction() {

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
    _weight_xs_ggh_2 = __theory_collidersfunctions_MOD_lhc8_rh_gg( &_mass_h ); 
    _weight_xs_bbh_2 = __theory_collidersfunctions_MOD_lhc8_rh_bb( &_mass_h ); 

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

    
    run_higgssignals_( &_mode, &_chi2_mu, &_chi2_mass_h, &_chi2, &_nobs, &_pvalue );

}

void Fittino::HiggsSignalsHadXSModelCalculator::ConfigureInput() {

    
}

