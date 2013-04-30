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

double Fittino::HiggsSignalsSLHAModelCalculator::Linearslope( double y1, double y2) {

    double m = y2 - y1;

    return m;

}

double Fittino::HiggsSignalsSLHAModelCalculator::Scaleg2hgg( std::string column, double massh ) {

    double scale;

    try {

        if ( column == "tt" ) {
    
                 if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( 1.112305225, 1.113237058 ) - 123 * 1.113237058; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( 1.111385465, 1.112305525 ) - 124 * 1.112305525; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( 1.110471156, 1.111385465 ) - 125 * 1.111385465; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( 1.109564189, 1.110471156 ) - 126 * 1.110471156; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( 1.108663766, 1.109564189 ) - 127 * 1.109564189; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( 1.107775663, 1.108663766 ) - 128 * 1.108663766; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }
        }

        if ( column == "bb" ) {

                 if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( 0.1186383935e-01, 0.1217362210e-01 ) - 123 * 0.1217362210e-01; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( 0.1156395457e-01, 0.1186383935e-01 ) - 124 * 0.1186383935e-01; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( 0.1127364780E-01, 0.1156395457E-01 ) - 125 * 0.1156395457E-01; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( 0.1099182783E-01, 0.1127364780E-01 ) - 126 * 0.1127364780E-01; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( 0.1071899652E-01, 0.1099182783E-01 ) - 127 * 0.1099182783E-01; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( 0.1045447756E-01, 0.1071899652E-01 ) - 128 * 0.1071899652E-01; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }
        }

        if ( column == "tb" ) {

                 if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( -0.1241690646, -0.1254106798 ) - 123 * -0.1254106798; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( -0.1229494194, -0.1241690646 ) - 124 * -0.1241690646; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( -0.1217448033, -0.1229494194 ) - 125 * -0.1229494194; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( -0.1205560165, -0.1217448033 ) - 126 * -0.1217448033; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( -0.1193827622, -0.1205560165 ) - 127 * -0.1205560165; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( -0.1182301408, -0.1193827622 ) - 128 * -0.1193827622; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }
        }

    }

    catch ( const ConfigurationException& configurationException ) {

      std::cout << "\n" << configurationException.what() << "\n" << std::endl;
      exit( EXIT_FAILURE );

        } 
 
    return scale;
      
}

double Fittino::HiggsSignalsSLHAModelCalculator::Scaleg2hgammagamma( std::string column, double massh ) {

    double scale;

    try {

        if ( column == "tt" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( 0.72048e-01, 0.72602e-01 ) - 123. * 0.72602e-01; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( 0.71482e-01, 0.72048e-01 ) - 124. * 0.72048e-01; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( 0.70904e-01, 0.71482e-01 ) - 125. * 0.71482e-01; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( 0.70312e-01, 0.70904e-01 ) - 126. * 0.70904e-01; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( 0.69708e-01, 0.70312e-01 ) - 127. * 0.70312e-01; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( 0.69090e-01, 0.69708e-01 ) - 128. * 0.69708e-01; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }
        
        }

        if ( column == "bb" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }        
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( 0.20152e-04, 0.20885e-04 ) - 123. * 0.20885e-04; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( 0.19444e-04, 0.20152e-04 ) - 124. * 0.20152e-04; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( 0.18760e-04, 0.19444e-04 ) - 125. * 0.19444e-04; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( 0.18099e-04, 0.18760e-04 ) - 126. * 0.18760e-04; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( 0.17460e-04, 0.18099e-04 ) - 127. * 0.18099e-04; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( 0.16842e-04, 0.17460e-04 ) - 128. * 0.17460e-04; } 
            else { throw ConfigurationException( "Higgs mass out of range." ); }

        }

        if ( column == "WW" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( 1.5911, 1.5934 ) - 123. * 1.5934; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( 1.5887, 1.5911 ) - 124. * 1.5911; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( 1.5863, 1.5887 ) - 125. * 1.5887; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( 1.5838, 1.5863 ) - 126. * 1.5863; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( 1.5812, 1.5838 ) - 127. * 1.5838; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( 1.5785, 1.5812 ) - 128. * 1.5812; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }

        }

        if ( column == "tb" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( -0.18029e-02, -0.18391e-02 ) - 123. * -0.18391e-02; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( -0.17672e-02, -0.18029e-02 ) - 124. * -0.18029e-02; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( -0.17319e-02, -0.17672e-02 ) - 125. * -0.17672e-02; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( -0.16970e-02, -0.17319e-02 ) - 126. * -0.17319e-02; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( -0.16625e-02, -0.16970e-02 ) - 127. * -0.16970e-02; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( -0.16283e-02, -0.16625e-02 ) - 128. * -0.16625e-02; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }

        }

        if ( column == "tW" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( -0.67717, -0.68026 ) - 123. * -0.68026; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( -0.67400, -0.67717 ) - 124. * -0.67717; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( -0.67074, -0.67400 ) - 125. * -0.67400; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( -0.66741, -0.67074 ) - 126. * -0.67074; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( -0.66399, -0.66741 ) - 127. * -0.66741; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( -0.66048, -0.66399 ) - 128. * -0.66399; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }

        }

        if ( column == "bW" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( 0.84914e-02, 0.86351e-02 ) - 123. * 0.86351e-02; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( 0.83495e-02, 0.84914e-02 ) - 124. * 0.84914e-02; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( 0.82093e-02, 0.83495e-02 ) - 125. * 0.83495e-02; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( 0.80708e-02, 0.82093e-02 ) - 126. * 0.82093e-02; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( 0.79339e-02, 0.80708e-02 ) - 127. * 0.80708e-02; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( 0.77984e-02, 0.79339e-02 ) - 128. * 0.79339e-02; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }

        }

        if ( column == "tautau" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( 0.24292e-04, 0.25148e-04 ) - 123. * 0.25148e-04; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( 0.23464e-04, 0.24292e-04 ) - 124. * 0.24292e-04; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( 0.22663e-04, 0.23464e-04 ) - 125. * 0.23464e-04; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( 0.21888e-04, 0.22663e-04 ) - 126. * 0.22663e-04; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( 0.21138e-04, 0.21888e-04 ) - 127. * 0.21888e-04; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( 0.20411e-04, 0.21138e-04 ) - 128. * 0.21138e-04; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }

        }

        if ( column == "ttau" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( -0.19461e-02, -0.19851e-02 ) - 123. * -0.19851e-02; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( -0.19077e-02, -0.19461e-02 ) - 124. * -0.19461e-02; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( -0.18696e-02, -0.19077e-02 ) - 125. * -0.19077e-02; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( -0.18321e-02, -0.18696e-02 ) - 126. * -0.18696e-02; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( -0.17949e-02, -0.18321e-02 ) - 127. * -0.18321e-02; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( -0.17581e-02, -0.17949e-02 ) - 128. * -0.17949e-02; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }

        }

        if ( column == "btau" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( 0.44253e-04, 0.45838e-04 ) - 123. * 0.45838e-04; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( 0.42720e-04, 0.44253e-04 ) - 124. * 0.44253e-04; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( 0.41239e-04, 0.42720e-04 ) - 125. * 0.42720e-04; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( 0.39806e-04, 0.41239e-04 ) - 126. * 0.41239e-04; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( 0.38421e-04, 0.39806e-04 ) - 127. * 0.39806e-04; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( 0.37079e-04, 0.38421e-04 ) - 128. * 0.38421e-04; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }

        }

        if ( column == "tauW" ) {

            if ( massh < 123. ) { throw ConfigurationException( "Higgs mass out of range." ); }
            else if ( massh >= 123. && massh < 124. ) { scale = massh * Linearslope( 0.91672e-02, 0.93221e-02 ) - 123. * 0.93221e-02; }
            else if ( massh >= 124. && massh < 125. ) { scale = massh * Linearslope( 0.90143e-02, 0.91672e-02 ) - 124. * 0.91672e-02; }
            else if ( massh >= 125. && massh < 126. ) { scale = massh * Linearslope( 0.88634e-02, 0.90143e-02 ) - 125. * 0.90143e-02; }
            else if ( massh >= 126. && massh < 127. ) { scale = massh * Linearslope( 0.87144e-02, 0.88634e-02 ) - 126. * 0.88634e-02; }
            else if ( massh >= 127. && massh < 128. ) { scale = massh * Linearslope( 0.85671e-02, 0.87144e-02 ) - 127. * 0.87144e-02; }
            else if ( massh >= 128. && massh < 129. ) { scale = massh * Linearslope( 0.84215e-02, 0.85671e-02 ) - 128. * 0.85671e-02; }
            else { throw ConfigurationException( "Higgs mass out of range." ); }

        }

    }
    
    catch ( const ConfigurationException& configurationException ) {
     
      std::cout << "\n" << configurationException.what() << "\n" << std::endl;
      exit( EXIT_FAILURE );
    
    }
    
    return scale;

}

double Fittino::HiggsSignalsSLHAModelCalculator::Calculateg2hgg( double ghbb,
                                                                 double ghtt,
                                                                 double massh ) {

    double g2hgg = ghtt * ghtt * Scaleg2hgg( "tt", massh )
                 + ghbb * ghbb * Scaleg2hgg( "bb", massh )
                 + ghtt * ghbb * Scaleg2hgg( "tb", massh );

    return g2hgg;

}

double Fittino::HiggsSignalsSLHAModelCalculator::Calculateg2hgammagamma( double ghbb,
                                                                         double ghtt,
                                                                         double ghtautau,
                                                                         double ghWW,
                                                                         double ghZZ,
                                                                         double massh ) {

    //double g2hgammagamma = ghtt * ghtt * 0.070904
                         //+ ghbb * ghbb * 0.18760e-04
                         //+ ghWW * ghWW * 1.5863
                         //+ ghtt * ghbb * -0.17319e-02
                         //+ ghtt * ghWW * -0.67074
                         //+ ghbb * ghWW * 0.82093e-02
                         //+ ghtautau * ghtautau * 0.22663e-04
                         //+ ghtt * ghtautau * -0.18696e-02
                         //+ ghbb * ghtautau * 0.41239e-04
                         //+ ghtautau * ghWW * 0.88634e-02;

    double g2hgammagamma = ghtt * ghtt * Scaleg2hgammagamma( "tt", massh )
                         + ghbb * ghbb * Scaleg2hgammagamma( "bb", massh )
                         + ghWW * ghWW * Scaleg2hgammagamma( "WW", massh )
                         + ghtt * ghbb * Scaleg2hgammagamma( "tb", massh )
                         + ghtt * ghWW * Scaleg2hgammagamma( "tW", massh )
                         + ghbb * ghWW * Scaleg2hgammagamma( "bW", massh )
                         + ghtautau * ghtautau * Scaleg2hgammagamma( "tautau", massh )
                         + ghtt * ghtautau * Scaleg2hgammagamma( "ttau", massh )
                         + ghbb * ghtautau * Scaleg2hgammagamma( "btau", massh )
                         + ghtautau * ghWW * Scaleg2hgammagamma( "tauW", massh );

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

    dCS[0] = CalculateSinglehUncertainty( dhbb, dhgg, g2hjbb, g2hjgg, massh ); // singleH
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

void Fittino::HiggsSignalsSLHAModelCalculator::CallFunction( PhysicsModelBase* model ) {

    // Identify the model parameters with the variables needed by HiggsSignals.

    double massh          = model->GetParameterVector()->at( 0 )->GetValue();

    double g2hjss_s       = pow( 1 + model->GetParameterVector()->at(  1 )->GetValue(), 2 );
    double g2hjss_p       = pow( 1 + model->GetParameterVector()->at(  2 )->GetValue(), 2 );
    double g2hjcc_s       = pow( 1 + model->GetParameterVector()->at(  3 )->GetValue(), 2 );
    double g2hjcc_p       = pow( 1 + model->GetParameterVector()->at(  4 )->GetValue(), 2 );
    double g2hjbb_s       = pow( 1 + model->GetParameterVector()->at(  5 )->GetValue(), 2 );
    double g2hjbb_p       = pow( 1 + model->GetParameterVector()->at(  6 )->GetValue(), 2 );
    double g2hjtt_s       = pow( 1 + model->GetParameterVector()->at(  7 )->GetValue(), 2 );
    double g2hjtt_p       = pow( 1 + model->GetParameterVector()->at(  8 )->GetValue(), 2 );
    double g2hjmumu_s     = pow( 1 + model->GetParameterVector()->at(  9 )->GetValue(), 2 );
    double g2hjmumu_p     = pow( 1 + model->GetParameterVector()->at( 10 )->GetValue(), 2 );
    double g2hjtautau_s   = pow( 1 + model->GetParameterVector()->at( 11 )->GetValue(), 2 );
    double g2hjtautau_p   = pow( 1 + model->GetParameterVector()->at( 12 )->GetValue(), 2 );
    double g2hjWW         = pow( 1 + model->GetParameterVector()->at( 13 )->GetValue(), 2 );
    double g2hjZZ         = pow( 1 + model->GetParameterVector()->at( 14 )->GetValue(), 2 );
    double g2hjZga        = pow( 1 + model->GetParameterVector()->at( 15 )->GetValue(), 2 );
    double g2hjgaga       = pow( 1 + model->GetParameterVector()->at( 16 )->GetValue(), 2 );
    double g2hjgg         = pow( 1 + model->GetParameterVector()->at( 17 )->GetValue(), 2 );
    double g2hjggZ        = pow( 1 + model->GetParameterVector()->at( 18 )->GetValue(), 2 );
    double g2hjhiZ        = pow( 1 + model->GetParameterVector()->at( 19 )->GetValue(), 2 );

    double BR_hjhihi      = model->GetParameterVector()->at( 20 )->GetValue();
    double GammaInvisible = model->GetParameterVector()->at( 21 )->GetValue();
    //double BR_hjinvisible = model->GetParameterVector()->at( 21 )->GetValue();

    // Set the (relative) rate uncertainties.

    SetRateUncertainties( g2hjbb_s, g2hjbb_p, g2hjgg, massh ); // depend only on g2hjbb, g2hjgg
                                                               // and the Higgs boson mass
                                                               // use fixed values for the other rates

    // Set the upper limit of the total width of the Higgs boson.

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

    double vsmall = 1.e-16;

    double BR_hjinvisible;

    if ( GammaTotal <= vsmall ) {

        BR_hjinvisible= 0.;

    }

    else {

        BR_hjinvisible = GammaInvisible/GammaTotal;

    }

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
                                     &BR_hjinvisible,
                                     &BR_hjhihi );

    // Run HiggsSignals.

    int nobs, mode = 1; // mode = 1, 2, 3 for peak-centered, masse-centered chi^2 method or both
    double Chisq_mu, Chisq_mh, Chisq, Pvalue;

    run_higgssignals_( &mode, &Chisq_mu, &Chisq_mh, &Chisq, &nobs, &Pvalue );

    // Write the HiggsSignals output to file.

    system( "rm HS-output.slha" );

    int detailed = 1; // 0: writes only block HiggsSignalsResults, 1: writes all blocks
    __io_MOD_higgssignals_create_slha_output_default( &detailed );

    // Write additional HiggsSignals predictions to file.

    //double g2hjgaga = Calculateg2hgammagamma( sqrt( g2hjbb_s ), sqrt( g2hjtt_s ), sqrt( g2hjtautau_s ), sqrt( g2hjWW ), sqrt( g2hjZZ ) );

    int nH = 1, collider = 3; // collider = 1, 2, 3 for TEV, LHC7 or LHC8
    double R_H_WW, R_H_ZZ, R_H_gammagamma, R_H_tautau, R_H_bb, R_VH_bb;

    get_rvalues_( &nH, &collider, &R_H_WW, &R_H_ZZ, &R_H_gammagamma, &R_H_tautau, &R_H_bb, &R_VH_bb );

    _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );

    _slhaOutputDataStorage->AddBlock( "HiggsSignalsAdditionalPredictions:BLOCK HiggsSignalsAdditionalPredictions:# Additional predictions" );

    std::stringstream tmpStream_R_H_WW;
    std::string tmpString_R_H_WW;

    tmpStream_R_H_WW << R_H_WW; 
    tmpStream_R_H_WW >> tmpString_R_H_WW;

    _slhaOutputDataStorage->AddLine( "HiggsSignalsAdditionalPredictions:1:" + tmpString_R_H_WW + ":# R_H_WW" );

    std::stringstream tmpStream_R_H_ZZ;
    std::string tmpString_R_H_ZZ;

    tmpStream_R_H_ZZ << R_H_ZZ;
    tmpStream_R_H_ZZ >> tmpString_R_H_ZZ;

    _slhaOutputDataStorage->AddLine( "HiggsSignalsAdditionalPredictions:2:" + tmpString_R_H_ZZ + ":# R_H_ZZ" );

    std::stringstream tmpStream_R_H_gammagamma;
    std::string tmpString_R_H_gammagamma;

    tmpStream_R_H_gammagamma << R_H_gammagamma;
    tmpStream_R_H_gammagamma >> tmpString_R_H_gammagamma;

    _slhaOutputDataStorage->AddLine( "HiggsSignalsAdditionalPredictions:3:" + tmpString_R_H_gammagamma + ":# R_H_gammagamma" );

    std::stringstream tmpStream_R_H_tautau;
    std::string tmpString_R_H_tautau;

    tmpStream_R_H_tautau << R_H_tautau;
    tmpStream_R_H_tautau >> tmpString_R_H_tautau;

    _slhaOutputDataStorage->AddLine( "HiggsSignalsAdditionalPredictions:4:" + tmpString_R_H_tautau + ":# R_H_tautau" );

    std::stringstream tmpStream_R_H_bb;
    std::string tmpString_R_H_bb;

    tmpStream_R_H_bb << R_H_bb;
    tmpStream_R_H_bb >> tmpString_R_H_bb;

    _slhaOutputDataStorage->AddLine( "HiggsSignalsAdditionalPredictions:5:" + tmpString_R_H_bb + ":# R_H_bb" );

    std::stringstream tmpStream_R_VH_bb;
    std::string tmpString_R_VH_bb;

    tmpStream_R_VH_bb << R_VH_bb;
    tmpStream_R_VH_bb >> tmpString_R_VH_bb;

    _slhaOutputDataStorage->AddLine( "HiggsSignalsAdditionalPredictions:6:" + tmpString_R_H_bb + ":# R_VH_bb" );

    std::stringstream tmpStream_GammaTotal;
    std::string tmpString_GammaTotal;

    tmpStream_GammaTotal << GammaTotal;
    tmpStream_GammaTotal >> tmpString_GammaTotal;

    _slhaOutputDataStorage->AddLine( "HiggsSignalsAdditionalPredictions:7:" + tmpString_GammaTotal + ":# GammaTotal" );

    std::stringstream tmpStream_BR_hjinvisible;
    std::string tmpString_BR_hjinvisible;

    tmpStream_BR_hjinvisible << BR_hjinvisible;
    tmpStream_BR_hjinvisible >> tmpString_BR_hjinvisible;

    _slhaOutputDataStorage->AddLine( "HiggsSignalsAdditionalPredictions:8:" + tmpString_BR_hjinvisible + ":# BR_hjInvisible" );

    _slhaOutputDataStorage->WriteFile( _slhaOutputFileName );

}

void Fittino::HiggsSignalsSLHAModelCalculator::ConfigureInput( PhysicsModelBase* model ) {

}
