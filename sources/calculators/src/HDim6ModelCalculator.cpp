/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6ModelCalculator.cpp                                         *
*                                                                              *
* Description Wrapper class for HDim6                                          * 
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

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
        :ModelCalculatorBase( model ){

    _name = "HDim6ModelCalculator";

    // lhapdf-getdata CT10.LHgrid
    _pdfSet = "CT10";

    _smvalues  = new sminputs();

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
    _smvalues->mh     = 125;

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
    _smvalues->vev    = _smvalues->mw*_smvalues->sw/sqrt(4.0*3.14159*_smvalues->alphae)*2.0;
    _smvalues->s      = pow( 7000,2 );

    // Standardmodell-Higgs-Breiten nach CERN LHC Higgs Cross-Section Working Group (Yellow Report Pages)

    _smvalues->br_h_bb      = 0.577;
    _smvalues->br_h_cc      = 0.0291;
    _smvalues->br_h_ss      = 0.015;      //Wert angenommen
    _smvalues->br_h_mm      = 2.2e-4;
    _smvalues->br_h_tautau  = 0.0632;
    _smvalues->br_h_zz      = 0.0264;
    _smvalues->br_h_ww      = 0.215;
    _smvalues->br_h_yy      = 2.28e-3;
    _smvalues->br_h_gg      = 0.0857;
    _smvalues->sm_width     = 4.07e-3;
    _smvalues->sm_width_err = 0.16e-3;
    _smvalues->br_h_yz      = 1.54e-3;

    _smvalues->err_h_bb     = 0.577*0.033;
    _smvalues->err_h_cc     = 0.0291*0.122;
    _smvalues->err_h_ss     = 0.015*0.05;  //Wert angenommen
    _smvalues->err_h_mm     = 2.2e-4*0.06;
    _smvalues->err_h_tautau = 0.0632*0.058;
    _smvalues->err_h_zz     = 0.0264*0.043;
    _smvalues->err_h_ww     = 0.215*0.043;
    _smvalues->err_h_yy     = 2.28e-3*0.05;
    _smvalues->err_h_gg     = 0.0857*0.1;
    _smvalues->err_h_yz     = 1.54e-3*0.09;

    _effvalues = new effinputs();

    InitializeSimpleOutputDataStorage();

}

Fittino::HDim6ModelCalculator::~HDim6ModelCalculator() {

    delete _effvalues;
    delete _smvalues;

}

void Fittino::HDim6ModelCalculator::CalculatePredictions() {

    ConfigureInput();
    CallFunction();

}

void Fittino::HDim6ModelCalculator::Initialize() const {

    if ( _pdfDirectory !="" ){

        LHAPDF::setPDFPath( _pdfDirectory );

    }
    
    LHAPDF::initPDFSet( _pdfSet, LHAPDF::LHGRID, 0 );  

    // Initialisiere VBF SM-Werte...
    vbf_init_cs_( _smvalues );

    // Initialisiere Hadronische CS...    
    init_hadronic_cs_( _smvalues );

    // Initialisiere Standardmodell-Breiten...
    initsmwidths_( _smvalues );
  
}

void Fittino::HDim6ModelCalculator::CalculateGamma(){

    initeffwidths_( _smvalues, _effvalues );

    totalwidth_( _smvalues, _effvalues,
                 & _simpleOutputDataStorage->GetMap()->at("GammaTot_h"),
                 & _simpleOutputDataStorage->GetMap()->at("GammaTot_h_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("GammaTot_h_chi2") );

    _simpleOutputDataStorage->GetMap()->at("GammaTot_normSM_h") = _simpleOutputDataStorage->GetMap()->at("GammaTot_h") / _smvalues->sm_width;

    br_hss_    ( _smvalues, _effvalues, 
                 & _simpleOutputDataStorage->GetMap()->at("BR_hss"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hss_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hss_chi2") );

    _simpleOutputDataStorage->GetMap()->at("BR_normSM_hss") = _simpleOutputDataStorage->GetMap()->at("BR_hss") / _smvalues->br_h_ss;

    br_hcc_    ( _smvalues, _effvalues, 
                 & _simpleOutputDataStorage->GetMap()->at("BR_hcc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hcc_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hcc_chi2") );

    _simpleOutputDataStorage->GetMap()->at("BR_normSM_hcc") = _simpleOutputDataStorage->GetMap()->at("BR_hcc") / _smvalues->br_h_cc;

    br_hbb_    ( _smvalues, _effvalues, 
                 & _simpleOutputDataStorage->GetMap()->at("BR_hbb"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hbb_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hbb_chi2") );

    _simpleOutputDataStorage->GetMap()->at("BR_normSM_hbb") = _simpleOutputDataStorage->GetMap()->at("BR_hbb") / _smvalues->br_h_bb;

    br_htautau_( _smvalues, _effvalues, 
                 & _simpleOutputDataStorage->GetMap()->at("BR_htautau"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_htautau_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_htautau_chi2") );

    _simpleOutputDataStorage->GetMap()->at("BR_normSM_htautau") = _simpleOutputDataStorage->GetMap()->at("BR_htautau") / _smvalues->br_h_tautau;

    br_hww_    ( _smvalues, _effvalues, 
                 & _simpleOutputDataStorage->GetMap()->at("BR_hWW"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hWW_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hWW_chi2") );

    _simpleOutputDataStorage->GetMap()->at("BR_normSM_hWW") = _simpleOutputDataStorage->GetMap()->at("BR_hWW") / _smvalues->br_h_ww;

    br_hzz_    ( _smvalues, _effvalues, 
                 & _simpleOutputDataStorage->GetMap()->at("BR_hZZ"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hZZ_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hZZ_chi2") );

    _simpleOutputDataStorage->GetMap()->at("BR_normSM_hZZ") = _simpleOutputDataStorage->GetMap()->at("BR_hZZ") / _smvalues->br_h_zz;

    br_hglgl_  ( _smvalues, _effvalues, 
                 & _simpleOutputDataStorage->GetMap()->at("BR_hgg"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hgg_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hgg_chi2") );

    _simpleOutputDataStorage->GetMap()->at("BR_normSM_hgg") = _simpleOutputDataStorage->GetMap()->at("BR_hgg") / _smvalues->br_h_gg;

    br_hgaga_  ( _smvalues, _effvalues, 
                 & _simpleOutputDataStorage->GetMap()->at("BR_hgaga"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hgaga_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hgaga_chi2") );

    _simpleOutputDataStorage->GetMap()->at("BR_normSM_hgaga") = _simpleOutputDataStorage->GetMap()->at("BR_hgaga") / _smvalues->br_h_yy;

    br_hgaz_   ( _smvalues, _effvalues, 
                 & _simpleOutputDataStorage->GetMap()->at("BR_hZga"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hZga_unc"),
                 & _simpleOutputDataStorage->GetMap()->at("BR_hZga_chi2") );

    _simpleOutputDataStorage->GetMap()->at("BR_normSM_hZga") = _simpleOutputDataStorage->GetMap()->at("BR_hZga") / _smvalues->br_h_yz;

}

void Fittino::HDim6ModelCalculator::CalculateTripleGaugeCouplings() {

    _simpleOutputDataStorage->GetMap()->at("Delta_kappa_ga") = d_kappa_y ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_kappa_Z" ) = d_kappa_z ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_ga"   ) = d_g1_y    ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_Z"    ) = d_g1_z    ( _smvalues, _effvalues );

}

void Fittino::HDim6ModelCalculator::CalculateQuarticGaugeCouplings() {

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_WW"  ) = d_g1_ww ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g2_WW"  ) = d_g2_ww ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_gaga") = d_g1_yy ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g2_gaga") = d_g2_yy ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_ZZ"  ) = d_g1_zz ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g2_ZZ"  ) = d_g2_zz ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_Zga" ) = d_g1_zy ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g2_Zga" ) = d_g2_zy ( _smvalues, _effvalues );

}

void Fittino::HDim6ModelCalculator::CalculateXS() {

    ratio_ggh_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_ggh"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_ggh_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_ggh_chi2") );

    ratio_bb_h_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bbh"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bbh_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bbh_chi2") );

    ratio_tth_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_tth"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_tth_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_tth_chi2") );

    ratio_bg_bh_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bh"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bh_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bh_chi2") );

    ratio_vbf_5flav_( _smvalues, _effvalues,
		      & _simpleOutputDataStorage->GetMap()->at("XS_normSM_qqh"),
                      & _simpleOutputDataStorage->GetMap()->at("XS_normSM_qqh_error"), 
                      & _simpleOutputDataStorage->GetMap()->at("XS_normSM_qqh_chi2") );

    ratio_pphw_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_Wh"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_Wh_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_Wh_chi2") );

    ratio_pphz_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_Zh"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_Zh_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_Zh_chi2") );

}

void Fittino::HDim6ModelCalculator::InitializeSimpleOutputDataStorage() {

    _simpleOutputDataStorage->AddEntry("GammaTot_h", -1);
    _simpleOutputDataStorage->AddEntry("GammaTot_h_unc", -1);
    _simpleOutputDataStorage->AddEntry("GammaTot_h_chi2", -1);
    _simpleOutputDataStorage->AddEntry("GammaTot_normSM_h", -1);

    _simpleOutputDataStorage->AddEntry("BR_hss", -1);
    _simpleOutputDataStorage->AddEntry("BR_hss_unc", -1);
    _simpleOutputDataStorage->AddEntry("BR_hss_chi2", -1);
    _simpleOutputDataStorage->AddEntry("BR_normSM_hss",-1 );

    _simpleOutputDataStorage->AddEntry("BR_hcc", -1);
    _simpleOutputDataStorage->AddEntry("BR_hcc_unc", -1);
    _simpleOutputDataStorage->AddEntry("BR_hcc_chi2", -1);
    _simpleOutputDataStorage->AddEntry("BR_normSM_hcc", -1);

    _simpleOutputDataStorage->AddEntry("BR_hbb", -1);
    _simpleOutputDataStorage->AddEntry("BR_hbb_unc", -1);
    _simpleOutputDataStorage->AddEntry("BR_hbb_chi2", -1);
    _simpleOutputDataStorage->AddEntry("BR_normSM_hbb", -1);

    _simpleOutputDataStorage->AddEntry("BR_htautau", -1);
    _simpleOutputDataStorage->AddEntry("BR_htautau_unc", -1);
    _simpleOutputDataStorage->AddEntry("BR_htautau_chi2", -1);
    _simpleOutputDataStorage->AddEntry("BR_normSM_htautau", -1);

    _simpleOutputDataStorage->AddEntry("BR_hWW", -1);
    _simpleOutputDataStorage->AddEntry("BR_hWW_unc", -1);
    _simpleOutputDataStorage->AddEntry("BR_hWW_chi2", -1);
    _simpleOutputDataStorage->AddEntry("BR_normSM_hWW", -1);

    _simpleOutputDataStorage->AddEntry("BR_hZZ", -1);
    _simpleOutputDataStorage->AddEntry("BR_hZZ_unc", -1);
    _simpleOutputDataStorage->AddEntry("BR_hZZ_chi2", -1);
    _simpleOutputDataStorage->AddEntry("BR_normSM_hZZ", -1);

    _simpleOutputDataStorage->AddEntry("BR_hgg", -1);
    _simpleOutputDataStorage->AddEntry("BR_hgg_unc", -1);
    _simpleOutputDataStorage->AddEntry("BR_hgg_chi2", -1);
    _simpleOutputDataStorage->AddEntry("BR_normSM_hgg", -1);

    _simpleOutputDataStorage->AddEntry("BR_hgaga", -1);
    _simpleOutputDataStorage->AddEntry("BR_hgaga_unc", -1);
    _simpleOutputDataStorage->AddEntry("BR_hgaga_chi2", -1);
    _simpleOutputDataStorage->AddEntry("BR_normSM_hgaga", -1);

    _simpleOutputDataStorage->AddEntry("BR_hZga", -1);
    _simpleOutputDataStorage->AddEntry("BR_hZga_unc", -1);
    _simpleOutputDataStorage->AddEntry("BR_hZga_chi2", -1);
    _simpleOutputDataStorage->AddEntry("BR_normSM_hZga", -1);

    _simpleOutputDataStorage->AddEntry("XS_normSM_ggh", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_ggh_error", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_ggh_chi2", -1);

    _simpleOutputDataStorage->AddEntry("XS_normSM_bbh", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_bbh_error", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_bbh_chi2", -1);
    
    _simpleOutputDataStorage->AddEntry("XS_normSM_tth", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_tth_error", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_tth_chi2", -1);

    _simpleOutputDataStorage->AddEntry("XS_normSM_bh", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_bh_error", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_bh_chi2", -1);
    
    _simpleOutputDataStorage->AddEntry("XS_normSM_qqh", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_qqh_error", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_qqh_chi2", -1);
    
    _simpleOutputDataStorage->AddEntry("XS_normSM_Wh", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_Wh_error", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_Wh_chi2", -1);

    _simpleOutputDataStorage->AddEntry("XS_normSM_Zh", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_Zh_error", -1);
    _simpleOutputDataStorage->AddEntry("XS_normSM_Zh_chi2", -1);

    _simpleOutputDataStorage->AddEntry("Delta_kappa_ga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_kappa_Z", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_ga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_Z", -1);

    _simpleOutputDataStorage->AddEntry("Delta_g1_WW", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g2_WW", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_gaga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g2_gaga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_ZZ", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g2_ZZ", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_Zga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g2_Zga", -1);

}


void Fittino::HDim6ModelCalculator::CallExecutable() {

}

void Fittino::HDim6ModelCalculator::CallFunction() {

    CalculateGamma();  
    CalculateXS();
    CalculateTripleGaugeCouplings();
    CalculateQuarticGaugeCouplings();

}

void Fittino::HDim6ModelCalculator::ConfigureInput() {

    _effvalues->fbb  = _model->GetParameterMap()->at( "F_BB"  )->GetValue();
    _effvalues->fww  = _model->GetParameterMap()->at( "F_WW"  )->GetValue();
    _effvalues->fgg  = _model->GetParameterMap()->at( "F_gg"  )->GetValue();
    _effvalues->fb   = _model->GetParameterMap()->at( "F_B"   )->GetValue();
    _effvalues->fw   = _model->GetParameterMap()->at( "F_W"   )->GetValue();
    _effvalues->fuph = _model->GetParameterMap()->at( "F_u"   )->GetValue();
    _effvalues->fdoh = _model->GetParameterMap()->at( "F_d"   )->GetValue();
    _effvalues->fchh = _model->GetParameterMap()->at( "F_c"   )->GetValue();
    _effvalues->fsth = _model->GetParameterMap()->at( "F_s"   )->GetValue();
    _effvalues->ftoh = _model->GetParameterMap()->at( "F_t"   )->GetValue();
    _effvalues->fboh = _model->GetParameterMap()->at( "F_b"   )->GetValue();
    _effvalues->felh = _model->GetParameterMap()->at( "F_e"   )->GetValue();
    _effvalues->fmuh = _model->GetParameterMap()->at( "F_mu"  )->GetValue();
    _effvalues->ftah = _model->GetParameterMap()->at( "F_tau" )->GetValue();

    // Calculate Triple-Vertex Couplings in effvalues
    update_effinputs_( _smvalues, _effvalues );

}
