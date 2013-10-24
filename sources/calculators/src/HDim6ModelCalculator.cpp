/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6ModelCalculator.cpp                                         *
*                                                                              *
* Description Wrapper class for HDim6                                          * 
*                                                                              *
* Authors     Bastian Heller    <bastian.heller@rwth-aachen.de>                *
*             Bjoern  Sarrazin  <sarrazin@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TMath.h"
#include "TStopwatch.h"

#include <LHAPDF/LHAPDF.h>

#include "HDim6/CrossSection.h" 
#include "HDim6/CrossSection_had.h" 
#include "HDim6/decay.h" 
#include "HDim6/gaugecpl.h"
#include "HDim6/inputs.h" 
#include "HDim6/VBF.h"

#include "HDim6ModelCalculator.h"
#include "ModelParameterBase.h"
#include "PhysicsModelBase.h"
#include "SimpleDataStorage.h"

Fittino::HDim6ModelCalculator::HDim6ModelCalculator( const PhysicsModelBase* model )
    :ModelCalculatorBase( model ),

     _f_B         ( _model->GetParameterMap()->at( "f_B"     )->GetValue() ),
     _f_BB_p_f_WW ( _model->GetParameterMap()->at( "f_BB_p_f_WW"    )->GetValue() ),
     _f_W         ( _model->GetParameterMap()->at( "f_W"     )->GetValue() ),
     _f_BB_m_f_WW ( _model->GetParameterMap()->at( "f_BB_m_f_WW"    )->GetValue() ),
     _f_gg        ( _model->GetParameterMap()->at( "f_GG"    )->GetValue() ),
     _f_phi_2     ( _model->GetParameterMap()->at( "f_Phi_2" )->GetValue() ),
     _f_t         ( _model->GetParameterMap()->at( "f_t"     )->GetValue() ),
     _f_b         ( _model->GetParameterMap()->at( "f_b"     )->GetValue() ),
     _f_tau       ( _model->GetParameterMap()->at( "f_tau"   )->GetValue() ),
     _mass_h      ( _model->GetParameterMap()->at( "mass_h"  )->GetValue() ) {

    _calculate_xs_qqh_2flavor = true;
    _calculate_xs_qqh_5flavor = false;

    _name = "HDim6ModelCalculator";

    // lhapdf-getdata CT10.LHgrid
    _pdfSet = "CT10";
    _pdfDirectory = "";

    _first = true;

    _effsmvalues        = new effinputs();
    _effvalues          = new effinputs();
    _smvalues           = new sminputs();

    if ( _calculate_xs_qqh_2flavor ) {

        _collectionOfDoubles.AddElement( "normSM_xs_qqh_2flavor", &_normSM_xs_qqh_2flavor );

    }

    if ( _calculate_xs_qqh_5flavor ) {

        _collectionOfDoubles.AddElement( "normSM_xs_qqh_5flavor", &_normSM_xs_qqh_5flavor );

    }

    _collectionOfDoubles.AddElement( "f_BB",                  &_f_BB                  );
    _collectionOfDoubles.AddElement( "f_WW",                  &_f_WW                  );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hgg",      &_normSM_Gamma_hgg      );
    _collectionOfDoubles.AddElement( "normSM_Gamma_htautau",  &_normSM_Gamma_htautau  );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hmumu",    &_normSM_Gamma_hmumu    );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hgaga",    &_normSM_Gamma_hgaga    );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hWW",      &_normSM_Gamma_hWW      );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hZZ",      &_normSM_Gamma_hZZ      );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hZga",     &_normSM_Gamma_hZga     );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hbb",      &_normSM_Gamma_hbb      );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hcc",      &_normSM_Gamma_hcc      );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hss",      &_normSM_Gamma_hss      );
    _collectionOfDoubles.AddElement( "normSM_xs_ggh",         &_normSM_xs_ggh         );
    _collectionOfDoubles.AddElement( "normSM_xs_bbh",         &_normSM_xs_bbh         );
    _collectionOfDoubles.AddElement( "normSM_xs_tth",         &_normSM_xs_tth         );
    _collectionOfDoubles.AddElement( "normSM_xs_Wh",          &_normSM_xs_Wh          );
    _collectionOfDoubles.AddElement( "normSM_xs_Zh",          &_normSM_xs_Zh          );
    _collectionOfDoubles.AddElement( "normSM_xs_bh",          &_normSM_xs_bh          );
    //     _collectionOfDoubles.AddElement( "P_c_V_minus",           &_P_c_V_minus           );
    //     _collectionOfDoubles.AddElement( "P_kappa_HV_minus",      &_P_kappa_HV_minus      );
    //     _collectionOfDoubles.AddElement( "P_kappa_Zgamma",        &_P_kappa_Zgamma        );

}

Fittino::HDim6ModelCalculator::~HDim6ModelCalculator() {

    delete _effvalues;
    delete _effsmvalues;
    delete _smvalues;

}

void Fittino::HDim6ModelCalculator::CalculatePredictions() {

    ConfigureInput();
    CallFunction();

}

void Fittino::HDim6ModelCalculator::Initialize() const{

    if ( _pdfDirectory !="" ){

        LHAPDF::setPDFPath( _pdfDirectory );

    }
    
    LHAPDF::initPDFSet( _pdfSet, LHAPDF::LHGRID, 0 );  

}

void Fittino::HDim6ModelCalculator::CallFunction() {

    bool new_mh = ( _first || _previous_mass_h != _mass_h );

    if ( new_mh )  _previous_mass_h = _mass_h;

    bool new_gridParameters
        = (    _first
            || new_mh
            || _previous_f_B     != _f_B
            || _previous_f_BB    != _f_BB
            || _previous_f_W     != _f_W
            || _previous_f_WW    != _f_WW
            || _previous_f_phi_2 != _f_phi_2 );

    
    if ( new_gridParameters ) {

        _previous_f_B     = _f_B;
        _previous_f_BB    = _f_BB;
        _previous_f_W     = _f_W;
        _previous_f_WW    = _f_WW;
        _previous_f_phi_2 = _f_phi_2;

    }

    if ( _first )  _first = false;  

    // todo: calculate pomerol coefficients here

    _P_a_minus        = 0;
    _P_a_plus         = 0;
    _P_c_H            = 0;
    _P_c_V_minus      = ( _P_a_plus + _P_a_minus ) / 2.;
    _P_c_y_b          = 0;
    _P_c_y_t          = 0;
    _P_c_y_tau        = 0;
    _P_kappa_BB       = 0;
    _P_kappa_GG       = 0;
    _P_kappa_HV_plus  = 0;
    _P_kappa_HV_minus = ( _P_a_plus - _P_a_minus ) / 2.;
    _P_kappa_Zgamma   = - _P_kappa_HV_minus / 2. - 2 * TMath::Power( _smvalues->sw, 2) * _P_kappa_BB;

    _f_BB = _effvalues->fbb;  
    _f_WW = _effvalues->fww;  

    _Delta_g1_WW       = HDim6::d_g1_ww  ( _smvalues, _effvalues );
    _Delta_g2_WW       = HDim6::d_g2_ww  ( _smvalues, _effvalues );
    _Delta_g1_gaga     = HDim6::d_g1_yy  ( _smvalues, _effvalues );
    _Delta_g2_gaga     = HDim6::d_g2_yy  ( _smvalues, _effvalues );
    _Delta_g1_ZZ       = HDim6::d_g1_zz  ( _smvalues, _effvalues );
    _Delta_g2_ZZ       = HDim6::d_g2_zz  ( _smvalues, _effvalues );
    _Delta_g1_Zga      = HDim6::d_g1_zy  ( _smvalues, _effvalues );
    _Delta_g2_Zga      = HDim6::d_g2_zy  ( _smvalues, _effvalues );
    _Delta_kappa_Gamma = HDim6::d_kappa_y( _smvalues, _effvalues );
    _Delta_kappa_Z     = HDim6::d_kappa_z( _smvalues, _effvalues );
    _Delta_g1_Gamma    = HDim6::d_g1_y   ( _smvalues, _effvalues );
    _Delta_g1_Z        = HDim6::d_g1_z   ( _smvalues, _effvalues );

    double error, chi2;

    if ( new_mh ) hglgl_( _smvalues, _effsmvalues, &_SM_Gamma_hgg,           &error        );
    hglgl_( _smvalues, _effvalues, &_Gamma_hgg,           &error        );
    _normSM_Gamma_hgg = _Gamma_hgg / _SM_Gamma_hgg;

    if ( new_mh ) hgaga_( _smvalues, _effsmvalues, &_SM_Gamma_hgaga,         &error        );
    hgaga_( _smvalues, _effvalues, &_Gamma_hgaga,         &error        );
    _normSM_Gamma_hgaga = _Gamma_hgaga / _SM_Gamma_hgaga;

    if ( new_mh ) hgaz_( _smvalues, _effsmvalues, &_SM_Gamma_hZga,          &error        );
    hgaz_( _smvalues, _effvalues, &_Gamma_hZga,          &error        );
    _normSM_Gamma_hZga = _Gamma_hZga / _SM_Gamma_hZga;

    if ( new_mh ) hmumu_( _smvalues, _effsmvalues, &_SM_Gamma_hmumu,         &error        );
    hmumu_( _smvalues, _effvalues, &_Gamma_hmumu,         &error        );
    _normSM_Gamma_hmumu = _Gamma_hmumu / _SM_Gamma_hmumu;

    if ( new_mh ) htata_( _smvalues, _effsmvalues, &_SM_Gamma_htautau,       &error        );
    htata_( _smvalues, _effvalues, &_Gamma_htautau,       &error        );
    _normSM_Gamma_htautau = _Gamma_htautau / _SM_Gamma_htautau;

    if ( new_mh ) hchch_ ( _smvalues, _effsmvalues, &_SM_Gamma_hcc,           &error        );
    hchch_ ( _smvalues, _effvalues, &_Gamma_hcc,           &error        );
    _normSM_Gamma_hcc = _Gamma_hcc / _SM_Gamma_hcc;

    if ( new_mh ) hstst_ ( _smvalues, _effsmvalues, &_SM_Gamma_hss,           &error        );
    hstst_ ( _smvalues, _effvalues, &_Gamma_hss,           &error        );
    _normSM_Gamma_hss = _Gamma_hss / _SM_Gamma_hss;

    if ( new_mh ) hbobo_ ( _smvalues, _effsmvalues, &_SM_Gamma_hbb,           &error        );
    hbobo_ ( _smvalues, _effvalues, &_Gamma_hbb,           &error        );
    _normSM_Gamma_hbb = _Gamma_hbb / _SM_Gamma_hbb;

    if ( new_gridParameters )  {

        if ( new_mh ) hzz_  ( _smvalues, _effsmvalues, &_SM_Gamma_hZZ, &error, &chi2 ); 
        hzz_  ( _smvalues, _effvalues, &_Gamma_hZZ, &error, &chi2 ); 
        _normSM_Gamma_hZZ = _Gamma_hZZ / _SM_Gamma_hZZ;
        

        if ( new_mh ) hww_  ( _smvalues, _effsmvalues, &_SM_Gamma_hWW, &error, &chi2 ); 
        hww_  ( _smvalues, _effvalues, &_Gamma_hWW, &error, &chi2 ); 
        _normSM_Gamma_hWW = _Gamma_hWW / _SM_Gamma_hWW;
        
    }

    // todo: calc xs in own class, possible to set cms

    k_ggh_      ( _smvalues, _effvalues, &_normSM_xs_ggh,    &error, &chi2 );
    ratio_bb_h_ ( _smvalues, _effvalues, &_normSM_xs_bbh,    &error, &chi2 );
    ratio_tth_  ( _smvalues, _effvalues, &_normSM_xs_tth,    &error, &chi2 );
    ratio_bg_bh_( _smvalues, _effvalues, &_normSM_xs_bh,     &error, &chi2 );
    
    if ( new_gridParameters ) {

      if ( new_mh ) HWRadiation_( _smvalues, _effsmvalues, &_SM_xs_Wh, &error, &chi2 );
      HWRadiation_( _smvalues, _effvalues, &_xs_Wh, &error, &chi2 );
      _normSM_xs_Wh  = _xs_Wh / _SM_xs_Wh;

      if ( new_mh ) HZRadiation_( _smvalues, _effsmvalues, &_SM_xs_Zh, &error, &chi2 );
      HZRadiation_( _smvalues, _effvalues, &_xs_Zh, &error, &chi2 );
      _normSM_xs_Zh = _xs_Zh / _SM_xs_Zh;

    }

    if ( _calculate_xs_qqh_2flavor && new_gridParameters ) {

      if ( new_mh )  ud_jjh_( _smvalues, _effsmvalues, &_SM_xs_qqh_2flavor, &error, &chi2 );
      ud_jjh_( _smvalues, _effvalues, &_xs_qqh_2flavor,    &error, &chi2 );
      _normSM_xs_qqh_2flavor = _xs_qqh_2flavor / _SM_xs_qqh_2flavor;

    }

    if ( _calculate_xs_qqh_5flavor && new_gridParameters ) {

      if ( new_mh )  ud_jjh_( _smvalues, _effsmvalues, &_SM_xs_qqh_5flavor, &error, &chi2 );
      ud_jjh_( _smvalues, _effvalues,   &_xs_qqh_5flavor,    &error, &chi2 );
      _normSM_xs_qqh_5flavor = _xs_qqh_5flavor / _SM_xs_qqh_5flavor;

    }
    
}


void Fittino::HDim6ModelCalculator::ComparePreviousEffValues() {


}

void Fittino::HDim6ModelCalculator::ComparePreviousSMValues() {


}

void Fittino::HDim6ModelCalculator::CallExecutable() {

}


void Fittino::HDim6ModelCalculator::ConfigureInput() {

    _effvalues->fb   = _f_B;
    _effvalues->fbb  = ( _f_BB_p_f_WW + _f_BB_m_f_WW )/2.;
    _effvalues->fw   = _f_W;
    _effvalues->fww  = ( _f_BB_p_f_WW - _f_BB_m_f_WW )/2.;
    _effvalues->fgg  = _f_gg;
    _effvalues->fp2  = _f_phi_2;
    _effvalues->fboh = _f_b;
    _effvalues->ftoh = _f_t;
    _effvalues->ftah = _f_tau;
    _smvalues ->mh   = _mass_h;

}
