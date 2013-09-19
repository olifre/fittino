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
     _f_BB   ( _model->GetParameterMap()->at( "F_BB"   )->GetValue() ),
     _f_WW   ( _model->GetParameterMap()->at( "F_WW"   )->GetValue() ),
     _f_gg   ( _model->GetParameterMap()->at( "F_gg"   )->GetValue() ),
     _f_B    ( _model->GetParameterMap()->at( "F_B"    )->GetValue() ),
     _f_W    ( _model->GetParameterMap()->at( "F_W"    )->GetValue() ),
     _f_u    ( _model->GetParameterMap()->at( "F_u"    )->GetValue() ),
     _f_d    ( _model->GetParameterMap()->at( "F_d"    )->GetValue() ),
     _f_c    ( _model->GetParameterMap()->at( "F_c"    )->GetValue() ),
     _f_s    ( _model->GetParameterMap()->at( "F_s"    )->GetValue() ),
     _f_t    ( _model->GetParameterMap()->at( "F_t"    )->GetValue() ),
     _f_b    ( _model->GetParameterMap()->at( "F_b"    )->GetValue() ),
     _f_e    ( _model->GetParameterMap()->at( "F_e"    )->GetValue() ),
     _f_mu   ( _model->GetParameterMap()->at( "F_mu"   )->GetValue() ),
     _f_tau  ( _model->GetParameterMap()->at( "F_tau"  )->GetValue() ),
     _mass_h ( _model->GetParameterMap()->at( "mass_h" )->GetValue() ) {

    _name = "HDim6ModelCalculator";

    // lhapdf-getdata CT10.LHgrid
    _pdfSet = "CT10";

    _effsmvalues       = new effinputs();

    _previousEffValues = new effinputs();
    _previousEffValues->override_unitarity = -1;

    _previousSMValues  = new sminputs();
    _previousSMValues->s = -1;

    _effvalues         = new effinputs();
    _effvalues->override_unitarity = 1; // 0: use coefficients to preserve unitarity, 1: unitarity violated

    _smvalues          = new sminputs();
    _smvalues->mel    = 0.511e-3;
    _smvalues->mmu    = 0.10565;
    _smvalues->mta    = 1.777;
    _smvalues->mup    = 0.0023;
    _smvalues->mdo    = 0.0048;
    _smvalues->mch    = 1.275;
    _smvalues->mst    = 0.095;
    _smvalues->mto    = 173.5;
    _smvalues->mbo    = 4.18;
    _smvalues->mz     = 91.1876;
    _smvalues->mw     = 80.385;
    _smvalues->Gf     = 1.16637e-5;
    _smvalues->alphae = 0.0078186;
    _smvalues->alphas = 0.11819;
    _smvalues->sw     = 0.48079;
    _smvalues->vud    = 0.97483;
    _smvalues->vus    = 0.2229;
    _smvalues->vub    = 0.0036;
    _smvalues->vcd    = 0.23;
    _smvalues->vcs    = 0.97389;
    _smvalues->vcb    = 40.9e-3;
    _smvalues->vtd    = 8.4e-3;
    _smvalues->vts    = 42.9e-3;
    _smvalues->vtb    = 0.89;
    _smvalues->s      = pow( 7000,2 );
    
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
    _collectionOfDoubles.AddElement( "normSM_xs_qqh",  &_normSM_xs_qqh );
    _collectionOfDoubles.AddElement( "normSM_xs_tth",  &_normSM_xs_tth );
    _collectionOfDoubles.AddElement( "normSM_xs_Wh",  &_normSM_xs_Wh );
    _collectionOfDoubles.AddElement( "normSM_xs_Zh",  &_normSM_xs_Zh );
    _collectionOfDoubles.AddElement( "normSM_xs_bh",  &_normSM_xs_bh );

}

Fittino::HDim6ModelCalculator::~HDim6ModelCalculator() {

    delete _effvalues;
    delete _effsmvalues;
    delete _smvalues;
    delete _previousEffValues;
    delete _previousSMValues;

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

    bool gridParametersChanged
      = (    _previousEffValues->fb  != _effvalues->fb
          || _previousEffValues->fw  != _effvalues->fw
          || _previousEffValues->fww != _effvalues->fww );

    *_previousEffValues = *_effvalues;

    bool smValuesChanged 
      = ( *_previousSMValues != *_smvalues );

    if ( smValuesChanged ) {

        _smvalues->vev   = 2.0 * _smvalues->mw * _smvalues->sw
                         / sqrt( 4.0 * TMath::Pi()*_smvalues->alphae );

        *_previousSMValues = *_smvalues;

        hglgl_      ( _smvalues, _effsmvalues, &_SM_Gamma_hgg,     &error       );
        hgaga_      ( _smvalues, _effsmvalues, &_SM_Gamma_hgaga,   &error       );
        hgaz_       ( _smvalues, _effsmvalues, &_SM_Gamma_hZga,    &error       );
        hmumu_      ( _smvalues, _effsmvalues, &_SM_Gamma_hmumu,   &error       );
        htata_      ( _smvalues, _effsmvalues, &_SM_Gamma_htautau, &error       );
        hchch_      ( _smvalues, _effsmvalues, &_SM_Gamma_hcc,     &error       );
        hstst_      ( _smvalues, _effsmvalues, &_SM_Gamma_hss,     &error       );
        hbobo_      ( _smvalues, _effsmvalues, &_SM_Gamma_hbb,     &error       );
        hzz_        ( _smvalues, _effsmvalues, &_SM_Gamma_hZZ,     &error, &chi2 ); 
        hww_        ( _smvalues, _effsmvalues, &_SM_Gamma_hWW,     &error, &chi2 ); 
        Gluonfusion_( _smvalues, _effsmvalues, &_SM_xs_ggh,        &error, &chi2 );
        udcsb_jjh_  ( _smvalues, _effsmvalues, &_SM_xs_qqh,        &error, &chi2 );
        HWRadiation_( _smvalues, _effsmvalues, &_SM_xs_Wh,         &error, &chi2 );
        HZRadiation_( _smvalues, _effsmvalues, &_SM_xs_Zh,         &error, &chi2 );

    }

    if ( smValuesChanged || gridParametersChanged ) {
      
        hzz_        ( _smvalues, _effvalues, &_Gamma_hZZ, &error, &chi2 ); 
        hww_        ( _smvalues, _effvalues, &_Gamma_hWW, &error, &chi2 ); 
        udcsb_jjh_  ( _smvalues, _effvalues, &_xs_qqh,    &error, &chi2 );
        HWRadiation_( _smvalues, _effvalues, &_xs_Wh,     &error, &chi2 );
        HZRadiation_( _smvalues, _effvalues, &_xs_Zh,     &error, &chi2 );

    }

    hglgl_      ( _smvalues, _effvalues, &_Gamma_hgg,        &error       ); 
    hgaga_      ( _smvalues, _effvalues, &_Gamma_hgaga,      &error       );
    hgaz_       ( _smvalues, _effvalues, &_Gamma_hZga,       &error       );
    hmumu_      ( _smvalues, _effvalues, &_Gamma_hmumu,      &error       );
    htata_      ( _smvalues, _effvalues, &_Gamma_htautau,    &error       );
    hchch_      ( _smvalues, _effvalues, &_Gamma_hcc,        &error       );
    hstst_      ( _smvalues, _effvalues, &_Gamma_hss,        &error       );
    hbobo_      ( _smvalues, _effvalues, &_Gamma_hbb,        &error       );
    Gluonfusion_( _smvalues, _effvalues, &_xs_ggh,           &error, &chi2 );
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
    _normSM_xs_qqh        = _xs_qqh        / _SM_xs_qqh;
    _normSM_xs_Wh         = _xs_Wh         / _SM_xs_Wh;
    _normSM_xs_Zh         = _xs_Zh         / _SM_xs_Zh;

}

void Fittino::HDim6ModelCalculator::ComparePreviousEffValues() {


}

void Fittino::HDim6ModelCalculator::ComparePreviousSMValues() {


}

void Fittino::HDim6ModelCalculator::CallExecutable() {

}


void Fittino::HDim6ModelCalculator::ConfigureInput() {

    _effvalues->fbb  = _f_BB;
    _effvalues->fww  = _f_WW;
    _effvalues->fgg  = _f_gg;
    _effvalues->fb   = _f_B;
    _effvalues->fw   = _f_W;
    _effvalues->fuph = _f_u;
    _effvalues->fdoh = _f_d;
    _effvalues->fchh = _f_c;
    _effvalues->fsth = _f_s;
    _effvalues->ftoh = _f_t;
    _effvalues->fboh = _f_b;
    _effvalues->felh = _f_e;
    _effvalues->fmuh = _f_mu;
    _effvalues->ftah = _f_tau;
    _smvalues ->mh   = _mass_h;

}
