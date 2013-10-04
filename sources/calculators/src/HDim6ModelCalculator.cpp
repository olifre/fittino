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
     _a_minus       ( _model->GetParameterMap()->at( "a_minus" )->GetValue() ),
     _a_plus        ( _model->GetParameterMap()->at( "a_plus" )->GetValue() ),
     _c_H           ( _model->GetParameterMap()->at( "c_H" )->GetValue()   ),
     _c_y_b         ( _model->GetParameterMap()->at( "c_y_b" )->GetValue() ),
     _c_y_t         ( _model->GetParameterMap()->at( "c_y_t" )->GetValue() ),
     _c_y_tau       ( _model->GetParameterMap()->at( "c_y_tau" )->GetValue() ),
     _kappa_BB      ( _model->GetParameterMap()->at( "kappa_BB" )->GetValue() ),
     _kappa_GG      ( _model->GetParameterMap()->at( "kappa_GG" )->GetValue() ),
     _kappa_HV_plus ( _model->GetParameterMap()->at( "kappa_HV_plus" )->GetValue() ),
     _mass_h        ( _model->GetParameterMap()->at( "mass_h" )->GetValue()        ) {

    _name = "HDim6ModelCalculator";

    // lhapdf-getdata CT10.LHgrid
    _pdfSet = "CT10";
    _pdfDirectory = "";

    _first = true;

    _effsmvalues        = new effinputs();
    _effvalues          = new effinputs();
    _pomvalues          = new pominput();
    _smvalues           = new sminputs();
    
    _collectionOfDoubles.AddElement( "normSM_Gamma_hgg",     &_normSM_Gamma_hgg );
    _collectionOfDoubles.AddElement( "normSM_Gamma_htautau", &_normSM_Gamma_htautau );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hmumu",   &_normSM_Gamma_hmumu );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hgaga",   &_normSM_Gamma_hgaga );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hWW",     &_normSM_Gamma_hWW );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hZZ", &_normSM_Gamma_hZZ );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hZga",  &_normSM_Gamma_hZga );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hbb",  &_normSM_Gamma_hbb );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hcc",  &_normSM_Gamma_hcc );
    _collectionOfDoubles.AddElement( "normSM_Gamma_hss",  &_normSM_Gamma_hss );
    _collectionOfDoubles.AddElement( "normSM_xs_ggh",  &_normSM_xs_ggh );
    _collectionOfDoubles.AddElement( "normSM_xs_bbh",  &_normSM_xs_bbh );
    _collectionOfDoubles.AddElement( "normSM_xs_qqh_2flavor",  &_normSM_xs_qqh_2flavor );
    _collectionOfDoubles.AddElement( "normSM_xs_qqh_5flavor",  &_normSM_xs_qqh_5flavor );
    _collectionOfDoubles.AddElement( "normSM_xs_tth",  &_normSM_xs_tth );
    _collectionOfDoubles.AddElement( "normSM_xs_Wh",  &_normSM_xs_Wh );
    _collectionOfDoubles.AddElement( "normSM_xs_Zh",  &_normSM_xs_Zh );
    _collectionOfDoubles.AddElement( "normSM_xs_bh",  &_normSM_xs_bh );

    _collectionOfDoubles.AddElement( "c_V_minus",       &_c_V_minus );
    _collectionOfDoubles.AddElement( "kappa_HV_minus",  &_kappa_HV_minus );
    _collectionOfDoubles.AddElement( "kappa_Zgamma",    &_kappa_Zgamma );

    _collectionOfDoubles.AddElement( "f_BB",    &_effvalues->fbb );
    _collectionOfDoubles.AddElement( "f_WW",    &_effvalues->fww );
    _collectionOfDoubles.AddElement( "f_GG",    &_effvalues->fgg );
    _collectionOfDoubles.AddElement( "f_B",     &_effvalues->fb );    
    _collectionOfDoubles.AddElement( "f_W",     &_effvalues->fw );
    _collectionOfDoubles.AddElement( "f_t",     &_effvalues->ftoh );
    _collectionOfDoubles.AddElement( "f_b",     &_effvalues->fboh );
    _collectionOfDoubles.AddElement( "f_tau",   &_effvalues->ftah );
    _collectionOfDoubles.AddElement( "f_phi_2", &_effvalues->fp2 );

    _collectionOfDoubles.AddElement( "cputime_gridNoVBF",   &_cputime_gridNoVBF   );
    _collectionOfDoubles.AddElement( "cputime_ggh",         &_cputime_ggh         );
    _collectionOfDoubles.AddElement( "cputime_qqh_2flavor", &_cputime_qqh_2flavor );
    _collectionOfDoubles.AddElement( "cputime_qqh_5flavor", &_cputime_qqh_5flavor );
    _collectionOfDoubles.AddElement( "cputime_remaining",   &_cputime_remaining   );

    _SM_Gamma_hZZ = 1;
    _SM_Gamma_hWW = 1;
    _SM_xs_qqh_2flavor = 1;
    _SM_xs_qqh_5flavor = 1;
    _SM_xs_Wh = 1;
    _SM_xs_Zh = 1;

    _Gamma_hZZ = 1;
    _Gamma_hWW = 1;
    _xs_qqh_2flavor = 1;
    _xs_qqh_5flavor = 1;
    _xs_Wh = 1;
    _xs_Zh = 1;

}

Fittino::HDim6ModelCalculator::~HDim6ModelCalculator() {

    delete _effvalues;
    delete _pomvalues;
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

    double error, chi2;

    bool _new_mh = ( _first || _previous_mass_h != _mass_h );

    bool _new_gridParameters
        = (    _first
            || _previous_a_minus       != _a_minus
            || _previous_a_plus        != _a_plus
            || _previous_c_H           != _c_H
            || _previous_kappa_BB      != _kappa_BB   
            || _previous_kappa_HV_plus != _kappa_HV_plus );

    bool _new_kappa_GG = ( _first || _previous_kappa_GG != _kappa_GG );
    
    if ( _new_mh ) {

        _previous_mass_h = _mass_h;

        ud_jjh_     ( _smvalues, _effsmvalues, &_SM_xs_qqh_2flavor,        &error, &chi2 );
        udcsb_jjh_  ( _smvalues, _effsmvalues, &_SM_xs_qqh_5flavor,        &error, &chi2 );
        hzz_        ( _smvalues, _effsmvalues, &_SM_Gamma_hZZ,     &error, &chi2 ); 
        hww_        ( _smvalues, _effsmvalues, &_SM_Gamma_hWW,     &error, &chi2 ); 
        HWRadiation_( _smvalues, _effsmvalues, &_SM_xs_Wh,         &error, &chi2 );
        HZRadiation_( _smvalues, _effsmvalues, &_SM_xs_Zh,         &error, &chi2 );
        Gluonfusion_( _smvalues, _effsmvalues, &_SM_xs_ggh,        &error, &chi2 );
        hglgl_      ( _smvalues, _effsmvalues, &_SM_Gamma_hgg,     &error       );
        hgaga_      ( _smvalues, _effsmvalues, &_SM_Gamma_hgaga,   &error       );
        hgaz_       ( _smvalues, _effsmvalues, &_SM_Gamma_hZga,    &error       );
        hmumu_      ( _smvalues, _effsmvalues, &_SM_Gamma_hmumu,   &error       );
        htata_      ( _smvalues, _effsmvalues, &_SM_Gamma_htautau, &error       );
        hchch_      ( _smvalues, _effsmvalues, &_SM_Gamma_hcc,     &error       );
        hstst_      ( _smvalues, _effsmvalues, &_SM_Gamma_hss,     &error       );
        hbobo_      ( _smvalues, _effsmvalues, &_SM_Gamma_hbb,     &error       );
        
    }

    if ( _new_gridParameters ) {

        _previous_a_minus       = _a_minus;
        _previous_a_plus        = _a_plus;
        _previous_c_H           = _c_H;
        _previous_kappa_BB      = _kappa_BB;
        _previous_kappa_HV_plus = _kappa_HV_plus; 

    }

    if ( _new_kappa_GG ) {
      
        _previous_kappa_GG = _kappa_GG ;

    }

    if ( _new_mh || _new_gridParameters ) {

        _stopwatch.Start();

        ud_jjh_  ( _smvalues, _effvalues, &_xs_qqh_2flavor,    &error, &chi2 );

        _stopwatch.Stop();
        _cputime_qqh_2flavor = _stopwatch.CpuTime();
        _stopwatch.Start();

        udcsb_jjh_  ( _smvalues, _effvalues, &_xs_qqh_5flavor,    &error, &chi2 );

        _stopwatch.Stop();
        _cputime_qqh_5flavor = _stopwatch.CpuTime();
        _stopwatch.Start();

        hzz_        ( _smvalues, _effvalues, &_Gamma_hZZ, &error, &chi2 ); 
        hww_        ( _smvalues, _effvalues, &_Gamma_hWW, &error, &chi2 ); 
        HWRadiation_( _smvalues, _effvalues, &_xs_Wh,     &error, &chi2 );
        HZRadiation_( _smvalues, _effvalues, &_xs_Zh,     &error, &chi2 );

        _stopwatch.Stop();
        _cputime_gridNoVBF = _stopwatch.CpuTime();

    }


    if ( _new_mh || _new_kappa_GG ) {

        _stopwatch.Start();

        Gluonfusion_( _smvalues, _effvalues, &_xs_ggh,           &error, &chi2 );

        _stopwatch.Stop();
        _cputime_ggh = _stopwatch.CpuTime();

    }

    
    _stopwatch.Start();

    hglgl_      ( _smvalues, _effvalues, &_Gamma_hgg,        &error       ); 
    hgaga_      ( _smvalues, _effvalues, &_Gamma_hgaga,      &error       );
    hgaz_       ( _smvalues, _effvalues, &_Gamma_hZga,       &error       );
    hmumu_      ( _smvalues, _effvalues, &_Gamma_hmumu,      &error       );
    htata_      ( _smvalues, _effvalues, &_Gamma_htautau,    &error       );
    hchch_      ( _smvalues, _effvalues, &_Gamma_hcc,        &error       );
    hstst_      ( _smvalues, _effvalues, &_Gamma_hss,        &error       );
    hbobo_      ( _smvalues, _effvalues, &_Gamma_hbb,        &error       );
    ratio_bb_h_ ( _smvalues, _effvalues, &_normSM_xs_bbh,    &error, &chi2 );
    ratio_tth_  ( _smvalues, _effvalues, &_normSM_xs_tth,    &error, &chi2 );
    ratio_bg_bh_( _smvalues, _effvalues, &_normSM_xs_bh,     &error, &chi2 );

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

    _stopwatch.Stop();
    _cputime_remaining = _stopwatch.CpuTime();

    _normSM_Gamma_hZZ     = _Gamma_hZZ     / _SM_Gamma_hZZ;
    _normSM_Gamma_hWW     = _Gamma_hWW     / _SM_Gamma_hWW;
    _normSM_Gamma_hgg     = _Gamma_hgg     / _SM_Gamma_hgg;
    _normSM_Gamma_hgaga   = _Gamma_hgaga   / _SM_Gamma_hgaga;
    _normSM_Gamma_hZga    = _Gamma_hZga    / _SM_Gamma_hZga;
    _normSM_Gamma_hmumu   = _Gamma_hmumu   / _SM_Gamma_hmumu;
    _normSM_Gamma_htautau = _Gamma_htautau / _SM_Gamma_htautau;
    _normSM_Gamma_hcc     = _Gamma_hcc     / _SM_Gamma_hcc;
    _normSM_Gamma_hss     = _Gamma_hss     / _SM_Gamma_hss;
    _normSM_Gamma_hbb     = _Gamma_hbb     / _SM_Gamma_hbb;
    _normSM_xs_ggh        = _xs_ggh        / _SM_xs_ggh;
    _normSM_xs_qqh_2flavor        = _xs_qqh_2flavor        / _SM_xs_qqh_2flavor;
    _normSM_xs_qqh_5flavor        = _xs_qqh_5flavor        / _SM_xs_qqh_5flavor;
    _normSM_xs_Wh         = _xs_Wh         / _SM_xs_Wh;
    _normSM_xs_Zh         = _xs_Zh         / _SM_xs_Zh;

    _first = false;

}

void Fittino::HDim6ModelCalculator::ComparePreviousEffValues() {


}

void Fittino::HDim6ModelCalculator::ComparePreviousSMValues() {


}

void Fittino::HDim6ModelCalculator::CallExecutable() {

}


void Fittino::HDim6ModelCalculator::ConfigureInput() {

    _c_V_minus      = ( _a_plus + _a_minus ) / 2.;
    _kappa_HV_minus = ( _a_plus - _a_minus ) / 2.;
    _kappa_Zgamma   = - _kappa_HV_minus / 2. - 2 * TMath::Power( _smvalues->sw, 2) * _kappa_BB;

    _smvalues ->mh      = _mass_h;
    _pomvalues->ch      = _c_H;
    _pomvalues->cvm     = _c_V_minus;
    _pomvalues->c_y_toh = _c_y_t;
    _pomvalues->c_y_boh = _c_y_b;
    _pomvalues->c_y_tah = _c_y_tau;
    _pomvalues->kbb     = _kappa_BB;
    _pomvalues->kgg     = _kappa_GG;
    _pomvalues->khvm    = _kappa_HV_minus;
    _pomvalues->khvp    = _kappa_HV_plus;

    pom_to_eboli( _pomvalues, _effvalues, _smvalues );    

}
