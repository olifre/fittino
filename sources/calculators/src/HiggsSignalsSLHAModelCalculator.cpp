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

#include <stdlib.h>

#include <cmath>
#include <iostream>
#include <sstream>

#include "ConfigurationException.h"
#include "HiggsSignalsSLHAModelCalculator.h"
#include "ModelParameterBase.h"
#include "PhysicsModelBase.h"
#include "SLHADataStorageBase.h"

Fittino::HiggsSignalsSLHAModelCalculator::HiggsSignalsSLHAModelCalculator() {

    _name               = "HiggsSignals";
    _slhaOutputFileName = "HS-output.slha";
    //nHzero            = 1;
    //nHplus            = 0;
    //output_level      = 0; // 0: silent, 1: screen output, 2: even more output
    //pdf               = 2; // 1: box, 2: gaussian, 3: both
    //range             = 2.;
    //iterations        = 0;
    nobs                =  1;
    mode                =  1; // 1, 2, 3 for peak-centered, masse-centered chi^2 method or both
    detailed            =  1; // 0: writes only block HiggsSignalsResults, 1: writes all blocks
    nH                  =  1; // Number of Higgs particles
    collider            =  3; // collider = 1, 2, 3 for TEV, LHC7 or LHC8
    NChannels           =  1;
    ChannelID           = 40; // 4 0 = HZ production

}

Fittino::HiggsSignalsSLHAModelCalculator::~HiggsSignalsSLHAModelCalculator() {

}

void Fittino::HiggsSignalsSLHAModelCalculator::Initialize() const {

    int nHzero = 1;
    int nHplus = 0;
    initialize_higgssignals_latestresults_( &nHzero, &nHplus );

    int output_level = 0; // 0: silent, 1: screen output , 2: even more output
    setup_output_level_( &output_level );

    int pdf = 2; // 1: box, 2: gaussian, 3: both
    setup_pdf_( &pdf );

    double dm = 0.;
    higgssignals_neutral_input_massuncertainty_( &dm );

    //int corr_mu = 1;
    //int corr_mh = 1;
    //setup_correlations_( &corr_mu, &corr_mh );

    double range = 2.;
    setup_assignmentrange_( &range );

    int iterations = 0;
    setup_higgs_to_peaks_assignment_iterations_( &iterations );

}

void Fittino::HiggsSignalsSLHAModelCalculator::CallExecutable() {

}

double Fittino::HiggsSignalsSLHAModelCalculator::Linearfunction( double massh, double x2, double x1, double y2, double y1 ) {

    double f = ( y2 - y1 ) / (x2 - x1) * ( massh -  x1 ) + y1 ;

    return f;

}

double Fittino::HiggsSignalsSLHAModelCalculator::CalculateBRhInvisible( double GammaTotal, double GammahInvisible ) {

    if ( GammaTotal <= 1.e-16 ) return 0.;
    else return GammahInvisible / GammaTotal;

}

double Fittino::HiggsSignalsSLHAModelCalculator::CalculateBRhInvisibleLimit( double x ) {
 
    double f;

    if ( x < 1. ) {

       f =    3090.5 * pow( x, 10 ) - 16155 * pow( x, 9 ) + 36200.6 * pow( x, 8 ) - 45432.4 * pow( x, 7 ) 
            + 35006.7 * pow( x, 6 ) - 17068.7 * pow( x, 5 ) + 5228.65 * pow( x, 4 ) - 963.046 * pow( x, 3 )
            + 100.961 * pow( x, 2 );

    }
    else {

        f = 3.322 * pow( x, 2 ) + 4.92 * x;

    }

    return f;

}

//double Fittino::HiggsSignalsSLHAModelCalculator::Scaleg2hgg( std::string column, double massh ) {
//
//    double scale;
//
//    try {
//
//        if ( massh >= 123 && massh <= 129. ) {
//
//            if ( column == "tt" ) { scale = -9.10e-04 * massh +  1.23e00; }
//            if ( column == "bb" ) { scale = -2.86e-04 * massh + 4.74e-02; }      
//            if ( column == "tb" ) { scale =  1.12e-03 * massh - 2.73e-01; } 
//       
//        }
//        else { throw ConfigurationException( "Higgs mass out of range." ); }
//
//    }
//    catch ( const ConfigurationException& configurationException ) {
//
//        std::cout << "\n" << configurationException.what() << "\n" << std::endl;
//        exit( EXIT_FAILURE );
//
//    }
// 
//    return scale;
//
//}

//double Fittino::HiggsSignalsSLHAModelCalculator::Scaleg2hgammagamma( std::string column, double massh ) {
//
//    double scale;
//
//    try {
// 
//        if ( massh >= 123 && massh <= 129. ) {
//
//            if ( column == "tt" )     { scale = -5.85e-04 * massh + 1.45e-01; }
//            if ( column == "bb" )     { scale = -6.74e-07 * massh + 1.04e-04; }
//            if ( column == "WW" )     { scale = -2.48e-03 * massh +  1.90e00; } 
//            if ( column == "tb" )     { scale =  3.51e-05 * massh - 6.16e-03; }
//            if ( column == "tW" )     { scale =  3.30e-03 * massh -  1.09e00; }
//            if ( column == "bW" )     { scale = -1.39e-04 * massh + 2.58e-02; }
//            if ( column == "tautau" ) { scale = -7.89e-07 * massh + 1.22e-04; }
//            if ( column == "ttau" )   { scale =  3.78e-05 * massh - 6.64e-03; }
//            if ( column == "btau" )   { scale = -1.46e-06 * massh + 2.25e-04; }
//            if ( column == "tauW" )   { scale = -1.50e-04 * massh + 2.78e-02; }
//
//        }
//        else { throw ConfigurationException( "Higgs mass out of range." ); }
//
//    }
//    catch ( const ConfigurationException& configurationException ) {
//     
//        std::cout << "\n" << configurationException.what() << "\n" << std::endl;
//        exit( EXIT_FAILURE );
//    
//    }
//    
//    return scale;
//
//}

double Fittino::HiggsSignalsSLHAModelCalculator::Calculateg2hgg( double ghbb,
                                                                 double ghtt,
                                                                 double massh ) {
   
    double g2hgg;

    try {

        if  ( massh >= 123 && massh <= 129. ) {

            g2hgg = ghtt * ghtt * ( -9.10e-04 * massh +  1.23e00 );
                  + ghbb * ghbb * ( -2.86e-04 * massh + 4.74e-02 );
                  + ghtt * ghbb * (  1.12e-03 * massh - 2.73e-01 );

        } 
        else { throw ConfigurationException( "Higgs mass out of range." ); }

    }
    catch ( const ConfigurationException& configurationException ) {

        std::cout << "\n" << configurationException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

    //double g2hgg = ghtt * ghtt * Scaleg2hgg( "tt", massh )
    //             + ghbb * ghbb * Scaleg2hgg( "bb", massh )
    //             + ghtt * ghbb * Scaleg2hgg( "tb", massh );

    return g2hgg;

}

double Fittino::HiggsSignalsSLHAModelCalculator::Calculateg2hgammagamma( double ghbb,
                                                                         double ghtt,
                                                                         double ghtautau,
                                                                         double ghWW,
                                                                         double ghZZ,
                                                                         double massh ) {

    double g2hgammagamma;

    try {

        if  ( massh >= 123 && massh <= 129. ) {

            g2hgammagamma = ghtt     * ghtt     * ( -5.85e-04 * massh + 1.45e-01 );
                          + ghbb     * ghbb     * ( -6.74e-07 * massh + 1.04e-04 );
                          + ghWW     * ghWW     * ( -2.48e-03 * massh +  1.90e00 );
                          + ghtt     * ghbb     * (  3.51e-05 * massh - 6.16e-03 );
                          + ghtt     * ghWW     * (  3.30e-03 * massh -  1.09e00 );
                          + ghbb     * ghWW     * ( -1.39e-04 * massh + 2.58e-02 );
                          + ghtautau * ghtautau * ( -7.89e-07 * massh + 1.22e-04 );
                          + ghtt     * ghtautau * (  3.78e-05 * massh - 6.64e-03 );
                          + ghbb     * ghtautau * ( -1.46e-06 * massh + 2.25e-04 );
                          + ghtautau * ghWW     * ( -1.50e-04 * massh + 2.78e-02 );

        }
        else { throw ConfigurationException( "Higgs mass out of range." ); }

    }
    catch ( const ConfigurationException& configurationException ) {

        std::cout << "\n" << configurationException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

    //double g2hgammagamma = ghtt * ghtt * Scaleg2hgammagamma( "tt", massh )
    //                     + ghbb * ghbb * Scaleg2hgammagamma( "bb", massh )
    //                     + ghWW * ghWW * Scaleg2hgammagamma( "WW", massh )
    //                     + ghtt * ghbb * Scaleg2hgammagamma( "tb", massh )
    //                     + ghtt * ghWW * Scaleg2hgammagamma( "tW", massh )
    //                     + ghbb * ghWW * Scaleg2hgammagamma( "bW", massh )
    //                     + ghtautau * ghtautau * Scaleg2hgammagamma( "tautau", massh )
    //                     + ghtt * ghtautau * Scaleg2hgammagamma( "ttau", massh )
    //                     + ghbb * ghtautau * Scaleg2hgammagamma( "btau", massh )
    //                     + ghtautau * ghWW * Scaleg2hgammagamma( "tauW", massh );

    return g2hgammagamma;

}

double Fittino::HiggsSignalsSLHAModelCalculator::CalculateSinglehUncertainty( double dhbb,
                                                                              double dhgg,
                                                                              double g2hbb,
                                                                              double g2hgg,
                                                                              double massh ) {

    double singlehUncertainty;
    double vsmall = 1.e-16;

    if ( g2hgg <= vsmall && g2hbb <= vsmall ) {

        singlehUncertainty = 0.;

    }
    else {

        singlehUncertainty = ( g2hgg * __theory_collidersfunctions_MOD_lhc8_rh_gg( &massh ) * dhgg
                           +   g2hbb * __theory_collidersfunctions_MOD_lhc8_rh_bb( &massh ) * dhbb )
                           / ( g2hgg * __theory_collidersfunctions_MOD_lhc8_rh_gg( &massh )
                           +   g2hbb * __theory_collidersfunctions_MOD_lhc8_rh_bb( &massh ) );

    }

    return singlehUncertainty;

}

double Fittino::HiggsSignalsSLHAModelCalculator::CalculateGammaTotal( double massh,
                                                                      double g2hjss_s,
                                                                      double g2hjcc_s,
                                                                      double g2hjbb_s,
                                                                      double g2hjtt_s,
                                                                      double g2hjmumu_s,
                                                                      double g2hjtautau_s,
                                                                      double g2hjWW,
                                                                      double g2hjZZ,
                                                                      double g2hjZga,
                                                                      double g2hjgaga,
                                                                      double g2hjgg,
                                                                      double GammaInvisible ) {

    double GammaTotal = smgamma_h_( &massh )
                        * ( 1
                        + ( g2hjss_s - 1 ) * smbr_hss_( &massh )
                        + ( g2hjcc_s - 1 ) * smbr_hcc_( &massh )
                        + ( g2hjbb_s - 1 ) * smbr_hbb_( &massh )
                        + ( g2hjtt_s - 1 ) * smbr_htoptop_( &massh )
                        + ( g2hjmumu_s - 1 ) * smbr_hmumu_( &massh )
                        + ( g2hjtautau_s - 1 ) * smbr_htautau_( &massh )
                        + ( g2hjWW - 1 ) * smbr_hww_( &massh )
                        + ( g2hjZZ - 1 ) * smbr_hzz_( &massh )
                        + ( g2hjZga - 1 ) * smbr_hzgam_( &massh )
                        + ( g2hjgaga - 1 ) * smbr_hgamgam_( &massh )
                        + ( g2hjgg - 1 ) * smbr_hgg_( &massh ) )
                        + GammaInvisible;

    return GammaTotal;

}

void Fittino::HiggsSignalsSLHAModelCalculator::SetRateUncertainties( double g2hjbb_s,
                                                                     double g2hjbb_p,
                                                                     double g2hjgg,
                                                                     double massh ) {

    double dCS[5], dBR[5];

    double g2hjbb = g2hjbb_s + g2hjbb_p;
    double dhbb = 0.2, dhgg = 0.147;

    dCS[0] = 0.147;
    //dCS[0] = 0.2;
    //dCS[0] = CalculateSinglehUncertainty( dhbb, dhgg, g2hjbb, g2hjgg, massh ); // singleH
    dCS[1] = 0.028; // VBF
    dCS[2] = 0.037; // HW
    dCS[3] = 0.051; // HZ
    dCS[4] = 0.12;  // ttH

    dBR[0] = 0.054; // gammagamma
    dBR[1] = 0.048; // WW
    dBR[2] = 0.048; // ZZ
    dBR[3] = 0.061; // tautau
    dBR[4] = 0.028; // bbbar

    setup_rate_uncertainties_( dCS, dBR );

}

double Fittino::HiggsSignalsSLHAModelCalculator::CalculateBR( double g2hjxx,
                                                              double massh,
                                                              double GammaTotal,
                                                              double BR_SM ){

    double BR = g2hjxx * ( smgamma_h_( &massh ) / GammaTotal ) * BR_SM;

    return BR;

}

void Fittino::HiggsSignalsSLHAModelCalculator::CallFunction( PhysicsModelBase* model ) {

    // Identify the model parameters with the variables needed by HiggsSignals.

    double massh          = model->GetParameterVector()->at( 0 )->GetValue();

    // Setting 3 : All up-type quarks and all down-type quarks and leptons are the same.

    double g2hjss_s       = pow( 1 + model->GetParameterVector()->at(  1 )->GetValue(), 2 );
    double g2hjss_p       = pow( 1 + model->GetParameterVector()->at(  2 )->GetValue(), 2 );
    double g2hjcc_s       = pow( 1 + model->GetParameterVector()->at(  3 )->GetValue(), 2 );
    double g2hjcc_p       = pow( 1 + model->GetParameterVector()->at(  4 )->GetValue(), 2 );
    double g2hjbb_s       = g2hjss_s;
    double g2hjbb_p       = pow( 1 + model->GetParameterVector()->at(  5 )->GetValue(), 2 );
    double g2hjtt_s       = g2hjcc_s;
    double g2hjtt_p       = pow( 1 + model->GetParameterVector()->at(  6 )->GetValue(), 2 );
    double g2hjmumu_s     = pow( 1 + model->GetParameterVector()->at(  7 )->GetValue(), 2 );
    double g2hjmumu_p     = pow( 1 + model->GetParameterVector()->at(  8 )->GetValue(), 2 );
    double g2hjtautau_s   = g2hjmumu_s;
    double g2hjtautau_p   = pow( 1 + model->GetParameterVector()->at(  9 )->GetValue(), 2 );
    double g2hjWW         = pow( 1 + model->GetParameterVector()->at( 10 )->GetValue(), 2 );
    double g2hjZZ         = pow( 1 + model->GetParameterVector()->at( 11 )->GetValue(), 2 );
    double g2hjZga        = pow( 1 + model->GetParameterVector()->at( 12 )->GetValue(), 2 );
    double g2hjgaga       = pow( 1 + model->GetParameterVector()->at( 13 )->GetValue(), 2 );
    double g2hjgg         = pow( 1 + model->GetParameterVector()->at( 14 )->GetValue(), 2 );
    double g2hjggZ        = pow( 1 + model->GetParameterVector()->at( 15 )->GetValue(), 2 );
    double g2hjhiZ        = pow( 1 + model->GetParameterVector()->at( 16 )->GetValue(), 2 );

    double BR_hjhihi      = model->GetParameterVector()->at( 17 )->GetValue();
    double GammaInvisible = model->GetParameterVector()->at( 18 )->GetValue();

    // Setting 2 : All up-type quarks are the same.

    //double g2hjss_s       = pow( 1 + model->GetParameterVector()->at(  1 )->GetValue(), 2 );
    //double g2hjss_p       = pow( 1 + model->GetParameterVector()->at(  2 )->GetValue(), 2 );
    //double g2hjcc_s       = pow( 1 + model->GetParameterVector()->at(  3 )->GetValue(), 2 );
    //double g2hjcc_p       = pow( 1 + model->GetParameterVector()->at(  4 )->GetValue(), 2 );
    //double g2hjbb_s       = pow( 1 + model->GetParameterVector()->at(  5 )->GetValue(), 2 );
    //double g2hjbb_p       = pow( 1 + model->GetParameterVector()->at(  6 )->GetValue(), 2 );
    //double g2hjtt_s       = g2hjcc_s;
    //double g2hjtt_p       = pow( 1 + model->GetParameterVector()->at(  7 )->GetValue(), 2 );
    //double g2hjmumu_s     = pow( 1 + model->GetParameterVector()->at(  8 )->GetValue(), 2 );
    //double g2hjmumu_p     = pow( 1 + model->GetParameterVector()->at(  9 )->GetValue(), 2 );
    //double g2hjtautau_s   = pow( 1 + model->GetParameterVector()->at( 10 )->GetValue(), 2 );
    //double g2hjtautau_p   = pow( 1 + model->GetParameterVector()->at( 11 )->GetValue(), 2 );
    //double g2hjWW         = pow( 1 + model->GetParameterVector()->at( 12 )->GetValue(), 2 );
    //double g2hjZZ         = pow( 1 + model->GetParameterVector()->at( 13 )->GetValue(), 2 );
    //double g2hjZga        = pow( 1 + model->GetParameterVector()->at( 14 )->GetValue(), 2 );
    //double g2hjgaga       = pow( 1 + model->GetParameterVector()->at( 15 )->GetValue(), 2 );
    //double g2hjgg         = pow( 1 + model->GetParameterVector()->at( 16 )->GetValue(), 2 );
    //double g2hjggZ        = pow( 1 + model->GetParameterVector()->at( 17 )->GetValue(), 2 );
    //double g2hjhiZ        = pow( 1 + model->GetParameterVector()->at( 18 )->GetValue(), 2 );

    //double BR_hjhihi      = model->GetParameterVector()->at( 19 )->GetValue();
    //double GammaInvisible = model->GetParameterVector()->at( 20 )->GetValue();

    // Setting 1 : No constraints.

    //double g2hjss_s       = pow( 1 + model->GetParameterVector()->at(  1 )->GetValue(), 2 );
    //double g2hjss_p       = pow( 1 + model->GetParameterVector()->at(  2 )->GetValue(), 2 );
    //double g2hjcc_s       = pow( 1 + model->GetParameterVector()->at(  3 )->GetValue(), 2 );
    //double g2hjcc_p       = pow( 1 + model->GetParameterVector()->at(  4 )->GetValue(), 2 );
    //double g2hjbb_s       = pow( 1 + model->GetParameterVector()->at(  5 )->GetValue(), 2 );
    //double g2hjbb_p       = pow( 1 + model->GetParameterVector()->at(  6 )->GetValue(), 2 );
    //double g2hjtt_s       = pow( 1 + model->GetParameterVector()->at(  7 )->GetValue(), 2 );
    //double g2hjtt_p       = pow( 1 + model->GetParameterVector()->at(  8 )->GetValue(), 2 );
    //double g2hjmumu_s     = pow( 1 + model->GetParameterVector()->at(  9 )->GetValue(), 2 );
    //double g2hjmumu_p     = pow( 1 + model->GetParameterVector()->at( 10 )->GetValue(), 2 );
    //double g2hjtautau_s   = pow( 1 + model->GetParameterVector()->at( 11 )->GetValue(), 2 );
    //double g2hjtautau_p   = pow( 1 + model->GetParameterVector()->at( 12 )->GetValue(), 2 );
    //double g2hjWW         = pow( 1 + model->GetParameterVector()->at( 13 )->GetValue(), 2 );
    //double g2hjZZ         = pow( 1 + model->GetParameterVector()->at( 14 )->GetValue(), 2 );
    //double g2hjZga        = pow( 1 + model->GetParameterVector()->at( 15 )->GetValue(), 2 );
    //double g2hjgaga       = pow( 1 + model->GetParameterVector()->at( 16 )->GetValue(), 2 );
    //double g2hjgg         = pow( 1 + model->GetParameterVector()->at( 17 )->GetValue(), 2 );
    //double g2hjggZ        = pow( 1 + model->GetParameterVector()->at( 18 )->GetValue(), 2 );
    //double g2hjhiZ        = pow( 1 + model->GetParameterVector()->at( 19 )->GetValue(), 2 );

    //double BR_hjhihi      = model->GetParameterVector()->at( 20 )->GetValue();
    //double GammaInvisible = model->GetParameterVector()->at( 21 )->GetValue();

    // Calculate the total width of the Higgs boson.

    double GammaTotal = CalculateGammaTotal( massh,
                                             g2hjss_s,
                                             g2hjcc_s,
                                             g2hjbb_s,
                                             g2hjtt_s,
                                             g2hjmumu_s,
                                             g2hjtautau_s,
                                             g2hjWW,
                                             g2hjZZ,
                                             g2hjZga,
                                             g2hjgaga,
                                             g2hjgg,
                                             GammaInvisible );

    // Convert GammaInvisible to the branching ratio BR(h->Invisible).

    double BR_hInvisible = CalculateBRhInvisible( GammaTotal, GammaInvisible );

    // Set the (relative) rate uncertainties.

    SetRateUncertainties( g2hjbb_s, g2hjbb_p, g2hjgg, massh );

    // Setup HiggsBounds.

    higgsbounds_neutral_input_effc_( &massh,
                                     &GammaTotal,
                                     &g2hjss_s,
                                     &g2hjss_p,
                                     &g2hjcc_s,
                                     &g2hjcc_p,
                                     &g2hjbb_s,
                                     &g2hjbb_p,
                                     &g2hjtt_s,
                                     &g2hjtt_p,
                                     &g2hjmumu_s,
                                     &g2hjmumu_p,
                                     &g2hjtautau_s,
                                     &g2hjtautau_p,
                                     &g2hjWW,
                                     &g2hjZZ,
                                     &g2hjZga,
                                     &g2hjgaga,
                                     &g2hjgg,
                                     &g2hjggZ,
                                     &g2hjhiZ,
                                     &BR_hInvisible,
                                     &BR_hjhihi );

    // Run HiggsSignals.

    double Chisq_mu, Chisq_mh, Chisq, Pvalue;
    run_higgssignals_( &mode, &Chisq_mu, &Chisq_mh, &Chisq, &nobs, &Pvalue );

    // Write the HiggsSignals output to file.

    system( "rm HS-output.slha" );

    __io_MOD_higgssignals_create_slha_output_default( &detailed );

    // Calculate additional HiggsSignals predictions.

    // Calculate the R values.

    double R_H_WW, R_H_ZZ, R_H_gammagamma, R_H_tautau, R_H_bb, R_VH_bb;
    get_rvalues_( &nH, &collider, &R_H_WW, &R_H_ZZ, &R_H_gammagamma, &R_H_tautau, &R_H_bb, &R_VH_bb );

    // Calculate the branching fractions.

    //double BR_s_hss       = g2hjss_s     * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_hss_( &massh );
    //double BR_s_hcc       = g2hjcc_s     * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_hcc_( &massh );
    //double BR_s_hbb       = g2hjbb_s     * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_hbb_( &massh );
    //double BR_s_htt       = g2hjtt_s     * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_htoptop_( &massh );
    //double BR_s_hmumu     = g2hjmumu_s   * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_hmumu_( &massh );
    //double BR_s_htautau   = g2hjtautau_s * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_htautau_( &massh );
    //double BR_hWW         = g2hjWW       * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_hww_( &massh );
    //double BR_hZZ         = g2hjZZ       * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_hzz_( &massh );
    //double BR_hZgamma     = g2hjZga      * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_hzgam_( &massh );
    //double BR_hgammagamma = g2hjgaga     * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_hgamgam_( &massh );
    //double BR_hgg         = g2hjgg       * ( smgamma_h_( &massh ) / GammaTotal ) * smbr_hgg_( &massh );

    // SM predictions of the branching fractions.

    double BR_SM_s_hss       = smbr_hss_( &massh );
    double BR_SM_s_hcc       = smbr_hcc_( &massh );
    double BR_SM_s_hbb       = smbr_hbb_( &massh );
    double BR_SM_s_htt       = smbr_htoptop_( &massh );
    double BR_SM_s_hmumu     = smbr_hmumu_( &massh );
    double BR_SM_s_htautau   = smbr_htautau_( &massh );
    double BR_SM_hWW         = smbr_hww_( &massh );
    double BR_SM_hZZ         = smbr_hzz_( &massh );
    double BR_SM_hZgamma     = smbr_hzgam_( &massh );
    double BR_SM_hgammagamma = smbr_hgamgam_( &massh );
    double BR_SM_hgg         = smbr_hgg_( &massh );

    double BR_s_hss       = CalculateBR( g2hjss_s,     massh, GammaTotal, BR_SM_s_hss );
    double BR_s_hcc       = CalculateBR( g2hjcc_s,     massh, GammaTotal, BR_SM_s_hcc ); 
    double BR_s_hbb       = CalculateBR( g2hjbb_s,     massh, GammaTotal, BR_SM_s_hbb ); 
    double BR_s_htt       = CalculateBR( g2hjtt_s,     massh, GammaTotal, BR_SM_s_htt ); 
    double BR_s_hmumu     = CalculateBR( g2hjmumu_s,   massh, GammaTotal, BR_SM_s_hmumu ); 
    double BR_s_htautau   = CalculateBR( g2hjtautau_s, massh, GammaTotal, BR_SM_s_htautau ); 
    double BR_hWW         = CalculateBR( g2hjWW,       massh, GammaTotal, BR_SM_hWW ); 
    double BR_hZZ         = CalculateBR( g2hjZZ,       massh, GammaTotal, BR_SM_hZZ ); 
    double BR_hZgamma     = CalculateBR( g2hjZga,      massh, GammaTotal, BR_SM_hZgamma ); 
    double BR_hgammagamma = CalculateBR( g2hjgaga,     massh, GammaTotal, BR_SM_hgammagamma ); 
    double BR_hgg         = CalculateBR( g2hjgg,       massh, GammaTotal, BR_SM_hgg );

    //double BR_Total = BR_s_hss + BR_s_hcc + BR_s_hbb + BR_s_htt + BR_s_hmumu + BR_s_htautau + BR_hWW + BR_hZZ + BR_hZgamma + BR_hgammagamma + BR_hgg + BR_hInvisible;
 
    //try {

    //    if ( BR_Total > 1. + 1.e-16 && BR_Total < 1. - 1.e-16 ) {
 
    //        throw ConfigurationException( "BR_Total unequal 1" );

    //    }

    //}

    //catch ( const ConfigurationException& configurationException ) {

    //  std::cout << "\n" << configurationException.what() << "\n" << std::endl;
    //  exit( EXIT_FAILURE );

    //}

    // Calculate the SM variations of the loop induced couplings.

    double g2_SM_hgammagamma = Calculateg2hgammagamma( 1 + model->GetParameterVector()->at(  5 )->GetValue(),
                                                       1 + model->GetParameterVector()->at(  7 )->GetValue(),
                                                       1 + model->GetParameterVector()->at( 11 )->GetValue(),
                                                       1 + model->GetParameterVector()->at( 13 )->GetValue(),
                                                       1 + model->GetParameterVector()->at( 14 )->GetValue(), massh );

    double g2_SM_hgg = Calculateg2hgg( 1 + model->GetParameterVector()->at( 5 )->GetValue(),
                                       1 + model->GetParameterVector()->at( 7 )->GetValue(), massh );

    // Set the upper limit of the total width of the Higgs boson.

    double Gamma_hTotal_Penalty = 0;

    if ( GammaTotal > 1. ) { Gamma_hTotal_Penalty = 1000000.; }

    // Calculate the chi2 coming from the measured limit on invisible decays of the Higgs.

    // int NChannels = 1, ChannelID = 40; // 4 0 = HZ production
    double HZrate;
    get_rates_( &nH, &collider, &NChannels, &ChannelID, &HZrate);
    double BR_hInvisible_Limit = CalculateBRhInvisibleLimit( BR_hInvisible * HZrate );

    // Write the additional HiggsSignals predictions to file.

    _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );

    std::string blockName = "HiggsSignalsAdditionalPredictions";

    _slhaOutputDataStorage->AddBlock( blockName + ":BLOCK " + blockName + ":# Additional predictions" );

    _slhaOutputDataStorage->AddLine( blockName +  ":1:" + String( R_H_WW )               + ":# R_H_WW" );
    _slhaOutputDataStorage->AddLine( blockName +  ":2:" + String( R_H_ZZ )               + ":# R_H_ZZ" );
    _slhaOutputDataStorage->AddLine( blockName +  ":3:" + String( R_H_gammagamma )       + ":# R_H_gammagamma" );
    _slhaOutputDataStorage->AddLine( blockName +  ":4:" + String( R_H_tautau )           + ":# R_H_tautau" );
    _slhaOutputDataStorage->AddLine( blockName +  ":5:" + String( R_H_bb )               + ":# R_H_bb" );
    _slhaOutputDataStorage->AddLine( blockName +  ":6:" + String( R_VH_bb )              + ":# R_VH_bb" );
    _slhaOutputDataStorage->AddLine( blockName +  ":7:" + String( GammaTotal )           + ":# GammaTotal" );
    _slhaOutputDataStorage->AddLine( blockName +  ":8:" + String( BR_s_hss )             + ":# BR_s_hss" );
    _slhaOutputDataStorage->AddLine( blockName +  ":9:" + String( BR_s_hcc )             + ":# BR_s_hcc" );
    _slhaOutputDataStorage->AddLine( blockName + ":10:" + String( BR_s_hbb )             + ":# BR_s_hbb" );
    _slhaOutputDataStorage->AddLine( blockName + ":11:" + String( BR_s_htt )             + ":# BR_s_htt" );
    _slhaOutputDataStorage->AddLine( blockName + ":12:" + String( BR_s_hmumu )           + ":# BR_s_hmumu" );
    _slhaOutputDataStorage->AddLine( blockName + ":13:" + String( BR_s_htautau )         + ":# BR_s_htautau" );
    _slhaOutputDataStorage->AddLine( blockName + ":14:" + String( BR_hWW )               + ":# BR_hWW" );
    _slhaOutputDataStorage->AddLine( blockName + ":15:" + String( BR_hZZ )               + ":# BR_hZZ" );
    _slhaOutputDataStorage->AddLine( blockName + ":16:" + String( BR_hZgamma )           + ":# BR_hZgamma" );
    _slhaOutputDataStorage->AddLine( blockName + ":17:" + String( BR_hgammagamma )       + ":# BR_hgammagamma" );
    _slhaOutputDataStorage->AddLine( blockName + ":18:" + String( BR_hgg )               + ":# BR_hgg" );
    _slhaOutputDataStorage->AddLine( blockName + ":19:" + String( BR_SM_s_hss )          + ":# BR_SM_s_hss" );
    _slhaOutputDataStorage->AddLine( blockName + ":20:" + String( BR_SM_s_hcc )          + ":# BR_SM_s_hcc" );
    _slhaOutputDataStorage->AddLine( blockName + ":21:" + String( BR_SM_s_hbb )          + ":# BR_SM_s_hbb" );
    _slhaOutputDataStorage->AddLine( blockName + ":22:" + String( BR_SM_s_htt )          + ":# BR_SM_s_htt" );
    _slhaOutputDataStorage->AddLine( blockName + ":23:" + String( BR_SM_s_hmumu )        + ":# BR_SM_s_hmumu" );
    _slhaOutputDataStorage->AddLine( blockName + ":24:" + String( BR_SM_s_htautau )      + ":# BR_SM_s_htautau" );
    _slhaOutputDataStorage->AddLine( blockName + ":25:" + String( BR_SM_hWW )            + ":# BR_SM_hWW" );
    _slhaOutputDataStorage->AddLine( blockName + ":26:" + String( BR_SM_hZZ )            + ":# BR_SM_hZZ" );
    _slhaOutputDataStorage->AddLine( blockName + ":27:" + String( BR_SM_hZgamma )        + ":# BR_SM_hZgamma" );
    _slhaOutputDataStorage->AddLine( blockName + ":28:" + String( BR_SM_hgammagamma )    + ":# BR_SM_hgammagamma" );
    _slhaOutputDataStorage->AddLine( blockName + ":29:" + String( BR_SM_hgg )            + ":# BR_SM_hgg" );
    _slhaOutputDataStorage->AddLine( blockName + ":30:" + String( BR_hInvisible )        + ":# BR_hjInvisible" );
    _slhaOutputDataStorage->AddLine( blockName + ":31:" + String( g2_SM_hgammagamma )    + ":# g2_SM_hgammagamma" );
    _slhaOutputDataStorage->AddLine( blockName + ":32:" + String( g2_SM_hgg )            + ":# g2_SM_hgg" );
    _slhaOutputDataStorage->AddLine( blockName + ":33:" + String( Gamma_hTotal_Penalty ) + ":# Gamma_hTotal_Penalty" );
    _slhaOutputDataStorage->AddLine( blockName + ":34:" + String( BR_hInvisible_Limit )  + ":# BR_hInvisible_Limit" );

    _slhaOutputDataStorage->WriteFile( _slhaOutputFileName );

}

void Fittino::HiggsSignalsSLHAModelCalculator::ConfigureInput( PhysicsModelBase* model ) {

}
