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

#include "HiggsSignalsSLHAModelCalculator.h"

Fittino::HiggsSignalsSLHAModelCalculator::HiggsSignalsSLHAModelCalculator() {

    _name = "HiggsSignals";

}

Fittino::HiggsSignalsSLHAModelCalculator::~HiggsSignalsSLHAModelCalculator() {

}

void Fittino::HiggsSignalsSLHAModelCalculator::Initialize() const {

    int nHzero = 1;
    int nHplus = 0;

    initialize_higgssignals_latestresults_( &nHzero, &nHplus );

    int output_level = 1;

    setup_output_level_( &output_level );

    int pdf = 2;

    setup_pdf_( &pdf );

    double dm = 0.0;

    higgssignals_neutral_input_massuncertainty_( &dm );

    int iterations = 0;

    setup_higgs_to_peaks_assignment_iterations_( &iterations );

}

void Fittino::HiggsSignalsSLHAModelCalculator::ConfigureInput( PhysicsModelBase* model ) {

}

void Fittino::HiggsSignalsSLHAModelCalculator::CallExecutable() {

}

double Fittino::HiggsSignalsSLHAModelCalculator::get_g2hgaga(double ghbb, double ghtt, double ghtautau, double ghWW, double ghZZ){

    double get_g2hgaga = ghtt*ghtt*0.070904 + ghbb*ghbb*0.18760e-04 + ghWW*ghWW*1.5863 +
    ghtt*ghbb*(-0.17319e-02) + ghtt*ghWW*(-0.67074) + ghbb*ghWW*0.82093e-02 +
    ghtautau*ghtautau*0.22663e-04 + ghtt*ghtautau*(-0.18696e-02) + ghbb*ghtautau*0.41239e-04 +
    ghtautau*ghWW*0.88634e-02;

    return get_g2hgaga;

}

double Fittino::HiggsSignalsSLHAModelCalculator::get_singleh_uncertainty(double dggh, double dbbh, double g2hgg, double g2hbb, double mh){

    dggh = 0.147;
    dbbh = 0.2;
    double get_singleh_uncertainty;

    if (g2hgg <= 0/*vsmall*/  && g2hbb <= 0/*vsmall*/) {

        get_singleh_uncertainty = 0.0;

    }
    else {

     //  get_singleh_uncertainty = ( g2hgg * lhc8_rh_gg_( &mh ) * dggh + g2hbb * lhc8_rh_bb_( &mh ) * dbbh )
       // / ( g2hgg * lhc8_rh_gg_( &mh ) + g2hbb * lhc8_rh_bb_( &mh ) );  

    }
    
    return get_singleh_uncertainty;

}


void Fittino::HiggsSignalsSLHAModelCalculator::CallFunction( PhysicsModelBase* model ) {
	
    int i = 21;
    int j = 6;
    double scale_ggh = (i-1)*0.05;
    double scale_bbh = (j-1)*0.20;

    double g2hjss_s = 1.0, g2hjss_p = 0.0;
    double g2hjcc_s = 1.0, g2hjcc_p = 0.0;
    double g2hjbb_s = scale_bbh*scale_bbh, g2hjbb_p = 0.0, g2hjbb = g2hjbb_s = g2hjbb_p;
    double g2hjtt_s = 1.0, g2hjtt_p = 0.0;
    double g2hjmumu_s = 1.0, g2hjmumu_p = 0.0;  
    double g2hjtautau_s = 1.0, g2hjtautau_p = 0.0;
    double g2hjWW = 1.0, g2hjZZ = 1.0;
    double g2hjZga = 1.0;
    double g2hjgg = scale_ggh*scale_ggh;
    double g2hjggZ = 1.0, g2hjhiZ = 0.0;
    double g2hjgaga = get_g2hgaga( scale_bbh, sqrt( g2hjtt_s ), sqrt( g2hjtautau_s ), sqrt( g2hjWW ), sqrt( g2hjZZ ) ); 
    double BR_hjhihi = 0.0, BR_hjinvisible = 0.0;
    double Mh = 126.0, SMGammaTotal;

    SMGammaTotal = smgamma_h_( &Mh );

    //Calculate the new total decay width:
    double GammaTotal = SMGammaTotal * ( 1 + ( g2hjWW - 1 ) * smbr_hww_( &Mh ) + ( g2hjZZ - 1 ) * smbr_hzz_( &Mh ) + 
    ( g2hjgg - 1 ) * smbr_hgg_( &Mh ) + ( g2hjtt_s - 1 ) * smbr_htoptop_( &Mh ) + ( g2hjbb_s - 1 ) * smbr_hbb_( &Mh ) + 
    ( g2hjtautau_s -  1 ) * smbr_htautau_( &Mh ) + ( g2hjgaga - 1 ) * smbr_hgamgam_( &Mh ) );

     double k;

    //model->SetParameterVector()->at( k )->SetValue( /*_model*/->GetParameterVector()->at( k )->GetValue() 	);

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

    dCS[0] = get_singleh_uncertainty( dggh, dbbh, g2hjgg, g2hjbb, Mh);

    //setup_rate_uncertainty_( &dCS, &dBR );    

    higgsbounds_neutral_input_effc_( &Mh, &GammaTotal, &g2hjss_s, &g2hjss_p, &g2hjcc_s, &g2hjcc_p,
    &g2hjbb_s, &g2hjbb_p, &g2hjtt_s, &g2hjtt_p, &g2hjmumu_s, &g2hjmumu_p, &g2hjtautau_s, &g2hjtautau_p,
    &g2hjWW, &g2hjZZ, &g2hjZga, &g2hjgaga, &g2hjgg, &g2hjggZ, &g2hjhiZ, &BR_hjinvisible, &BR_hjhihi );

    double Chisq_mu, Chisq_mh, Chisq, Pvalue;
    int ndf, a = 1;   

    run_higgssignals_( &a, &Chisq_mu, &Chisq_mh, &Chisq, &ndf, &Pvalue );

    int b = 3, c = 1, d = 10;
    double singleH_rate, Htobb_rate;

    get_rates_( &a, &b, &c, &d, &singleH_rate );
    d = 15;
    get_rates_( &a, &b, &c, &d, &Htobb_rate );


    finish_higgssignals_();
}
