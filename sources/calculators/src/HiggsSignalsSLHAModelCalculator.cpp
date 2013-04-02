/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSLHAModelCalculator.cpp                              *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>
#include <cstring>
#include <iostream>
#include <sstream>

#include "HiggsSignalsSLHAModelCalculator.h"
#include "PhysicsModelBase.h"
#include "SLHADataStorageBase.h"

Fittino::HiggsSignalsSLHAModelCalculator::HiggsSignalsSLHAModelCalculator() {

    _name = "HiggsSignals";

}

Fittino::HiggsSignalsSLHAModelCalculator::~HiggsSignalsSLHAModelCalculator() {

}

void Fittino::HiggsSignalsSLHAModelCalculator::Initialize() const {

    int nHzero = 1;
    int nHplus = 0;

    initialize_higgssignals_latestresults_( &nHzero, &nHplus );

    int output_level = 0; //(1: box, 2: gaussian, 3: both)

    setup_output_level_( &output_level );

    int pdf = 2;

    setup_pdf_( &pdf );

    double dm = 0.0;

    higgssignals_neutral_input_massuncertainty_( &dm );

    int iterations = 0;

    setup_higgs_to_peaks_assignment_iterations_( &iterations );

}

void Fittino::HiggsSignalsSLHAModelCalculator::CallExecutable() {

}

double Fittino::HiggsSignalsSLHAModelCalculator::get_g2hgaga( double ghbb, double ghtt, double ghtautau, double ghWW, double ghZZ ) {

    double get_g2hgaga = ghtt * ghtt * 0.070904 + ghbb * ghbb * 0.18760e-04 + ghWW * ghWW * 1.5863 +
                         ghtt * ghbb * ( -0.17319e-02 ) + ghtt * ghWW * ( -0.67074 ) + ghbb * ghWW * 0.82093e-02 +
                         ghtautau * ghtautau * 0.22663e-04 + ghtt * ghtautau * ( -0.18696e-02 ) + ghbb * ghtautau * 0.41239e-04 +
                         ghtautau * ghWW * 0.88634e-02;

    return get_g2hgaga;

}

double Fittino::HiggsSignalsSLHAModelCalculator::get_singleh_uncertainty( double dggh, double dbbh, double g2hgg, double g2hbb, double mh ) {

    dggh = 0.147;
    dbbh = 0.2;
    double get_singleh_uncertainty;

    if ( g2hgg <= 1.0e-16/*vsmall=1.0e-16 */  && g2hbb <= 1.0e-16/*vsmall=1.0e-16*/ ) {

        get_singleh_uncertainty = 0.0;

    } else {

        get_singleh_uncertainty = ( g2hgg * __theory_collidersfunctions_MOD_lhc8_rh_gg( &mh ) * dggh + g2hbb * __theory_collidersfunctions_MOD_lhc8_rh_bb( &mh ) * dbbh )
                                  / ( g2hgg * __theory_collidersfunctions_MOD_lhc8_rh_gg( &mh ) + g2hbb * __theory_collidersfunctions_MOD_lhc8_rh_bb( &mh ) );

    }

    return get_singleh_uncertainty;

}

void Fittino::HiggsSignalsSLHAModelCalculator::CallFunction( PhysicsModelBase* model ) {

    double Mh = model->GetParameterVector()->at( 0 )->GetValue();
    double g2hjss_s = model->GetParameterVector()->at( 1 )->GetValue();
    double g2hjss_p = model->GetParameterVector()->at( 2 )->GetValue();
    double g2hjcc_s = model->GetParameterVector()->at( 3 )->GetValue();
    double g2hjcc_p = model->GetParameterVector()->at( 4 )->GetValue();
    double g2hjbb_s = model->GetParameterVector()->at( 5 )->GetValue();
    double g2hjbb_p = model->GetParameterVector()->at( 6 )->GetValue();
    double g2hjtt_s = model->GetParameterVector()->at( 7 )->GetValue();
    double g2hjtt_p = model->GetParameterVector()->at( 8 )->GetValue();
    double g2hjmumu_s = model->GetParameterVector()->at( 9 )->GetValue();
    double g2hjmumu_p = model->GetParameterVector()->at( 10 )->GetValue();
    double g2hjtautau_s = model->GetParameterVector()->at( 11 )->GetValue();
    double g2hjtautau_p = model->GetParameterVector()->at( 12 )->GetValue();
    double g2hjWW = model->GetParameterVector()->at( 13 )->GetValue();
    double g2hjZZ = model->GetParameterVector()->at( 14 )->GetValue();
    double g2hjZga = model->GetParameterVector()->at( 15 )->GetValue();
    double g2hjgg = model->GetParameterVector()->at( 16 )->GetValue();
    double g2hjggZ = model->GetParameterVector()->at( 17 )->GetValue();
    double g2hjhiZ = model->GetParameterVector()->at( 18 )->GetValue();
    double g2hjgaga = get_g2hgaga( sqrt( g2hjbb_s ), sqrt( g2hjtt_s ), sqrt( g2hjtautau_s ), sqrt( g2hjWW ), sqrt( g2hjZZ ) );

    double BR_hjhihi = 0.0, BR_hjinvisible = 0.0;
    double SMGammaTotal;

    SMGammaTotal = smgamma_h_( &Mh );

    //Calculate the new total decay width:
    double GammaTotal = SMGammaTotal * ( 1 + ( g2hjWW - 1 ) * smbr_hww_( &Mh ) + ( g2hjZZ - 1 ) * smbr_hzz_( &Mh ) +
                                         ( g2hjgg - 1 ) * smbr_hgg_( &Mh ) + ( g2hjtt_s - 1 ) * smbr_htoptop_( &Mh ) + ( g2hjbb_s - 1 ) * smbr_hbb_( &Mh ) +
                                         ( g2hjtautau_s -  1 ) * smbr_htautau_( &Mh ) + ( g2hjgaga - 1 ) * smbr_hgamgam_( &Mh ) );

    //Set the (relative) rate uncertainties
    double dCS[5], dBR[5];

    dCS[0] = 0.147; //singleH
    dCS[1] = 0.028; //VBF
    dCS[2] = 0.037; //HW
    dCS[3] = 0.051; //HZ
    dCS[4] = 0.12;  //ttH

    dBR[0] = 0.054; //gamma gamma
    dBR[1] = 0.048; //W W
    dBR[2] = 0.048; //Z Z
    dBR[3] = 0.061; //tau tau
    dBR[4] = 0.028;  //b bbar

    double dggh = 0.147, dbbh = 0.2;
    double g2hjbb = g2hjbb_s + g2hjbb_p;

    dCS[0] = get_singleh_uncertainty( dggh, dbbh, g2hjgg, g2hjbb, Mh );

    setup_rate_uncertainties_( dCS, dBR );

    higgsbounds_neutral_input_effc_( &Mh, &GammaTotal, &g2hjss_s, &g2hjss_p, &g2hjcc_s, &g2hjcc_p,
                                     &g2hjbb_s, &g2hjbb_p, &g2hjtt_s, &g2hjtt_p, &g2hjmumu_s, &g2hjmumu_p, &g2hjtautau_s, &g2hjtautau_p,
                                     &g2hjWW, &g2hjZZ, &g2hjZga, &g2hjgaga, &g2hjgg, &g2hjggZ, &g2hjhiZ, &BR_hjinvisible, &BR_hjhihi );

    double Chisq_mu, Chisq_mh, Chisq, Pvalue;
    int nobs, mode = 1;   //"mode" (= 1, 2, 3 for peak-centered, masse-centered chi^2 method or both)

    run_higgssignals_( &mode, &Chisq_mu, &Chisq_mh, &Chisq, &nobs, &Pvalue );

    _slhaOutputDataStorage->AddBlock( "HIGGSSIGNALSOUTPUT:BLOCK HIGGSSIGNALSOUTPUT:# Output parameters" );

    std::stringstream tmpStream_Chisq_mu;
    std::string tmpString_Chisq_mu;
   
    tmpStream_Chisq_mu << Chisq_mu; 

    tmpStream_Chisq_mu >> tmpString_Chisq_mu;

    _slhaOutputDataStorage->AddLine( "HIGGSSIGNALSOUTPUT:1:" + tmpString_Chisq_mu + ":# Chisq_mu" );

    std::stringstream tmpStream_Chisq_mh;
    std::string tmpString_Chisq_mh;

    tmpStream_Chisq_mh << Chisq_mh;                                     

    tmpStream_Chisq_mh >> tmpString_Chisq_mh;

    _slhaOutputDataStorage->AddLine( "HIGGSSIGNALSOUTPUT:2:" + tmpString_Chisq_mh + ":# Chisq_mh" );
 
    std::stringstream tmpStream_Chisq;
    std::string tmpString_Chisq;

    tmpStream_Chisq << Chisq;                                     

    tmpStream_Chisq >> tmpString_Chisq;

    _slhaOutputDataStorage->AddLine( "HIGGSSIGNALSOUTPUT:3:" + tmpString_Chisq + ":# Chisq" );

    std::stringstream tmpStream_Pvalue;
    std::string tmpString_Pvalue;

    tmpStream_Pvalue << Pvalue;                                     

    tmpStream_Pvalue >> tmpString_Pvalue;

    _slhaOutputDataStorage->AddLine( "HIGGSSIGNALSOUTPUT:4:" + tmpString_Pvalue + ":# Pvalue" );

    _slhaOutputDataStorage->WriteFile("HiggsSignals.out.txt");

    int ii, collider = 3; // "collider" (= 1, 2, 3 for TEV, LHC7 or LHC8)
    int Nchannels = 1, IDchannels = 10; //Nchannels = dimension (IDchannels)
    double singleH_rate, Htobb_rate;

    //get_rates_( &ii, &collider, &Nchannels, &IDchannels, &singleH_rate );
    //IDchannels = 15;
    //get_rates_( &ii, &collider, &Nchannels, &IDchannels, &Htobb_rate );

}

void Fittino::HiggsSignalsSLHAModelCalculator::ConfigureInput( PhysicsModelBase* model ) {

}
