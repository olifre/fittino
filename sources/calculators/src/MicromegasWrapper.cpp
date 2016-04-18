/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MicromegasWrapper.cpp                                            *
*                                                                              *
* Description Wrapper class for Micromegas                                     *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>
#include <iomanip>
#include <vector>
#include <pthread.h>

#include <complex>

#define complex _Complex

#include "pmodel.h"
#include "micromegas.h"
#include "micromegas_aux.h"
#include "ConfigurationException.h"
#include "CalculatorException.h"
#include "MicromegasWrapper.h"

Fittino::MicromegasWrapper::MicromegasWrapper( std::string name ) {

    _mcname = name;

}

Fittino::MicromegasWrapper::~MicromegasWrapper() {

}

void Fittino::MicromegasWrapper::CalculatePredictions() {
    
    pthread_setcanceltype( PTHREAD_CANCEL_ASYNCHRONOUS,NULL);
    _errorCode = 0;

    std::vector<char> te( _inputFile.c_str(), _inputFile.c_str() + _inputFile.size() + 1 );

    if ( lesHinput( &te[0] ) ) {

        _errorCode = 1;
        return;
    }

    char lspName[128];

    if ( sortOddParticles( lspName ) ) {

        _errorCode = 2;
        return;

    }

    int spin2, charge3, cdim;
    qNumbers( lspName, &spin2, &charge3, &cdim );

    double *Xf = new double(0);
    int fast = 1;
    double Beps = 1e-6;
    double Temperature = 2.726/1.2 * 1.e-13;
    _omegah2 = darkOmega( Xf, fast, Beps );
    _gmin2 = gmuon();
    _vSigma = vSigma( Temperature, Beps, fast );
   
    _vSigma_Contribution_WpWm = 0.;;
    _vSigma_Contribution_ZZ = 0.;;
    _vSigma_Contribution_GG = 0.;;
    _vSigma_Contribution_AA = 0.;;
    _vSigma_Contribution_hh = 0.;;
    _vSigma_Contribution_Zh = 0.;;
    _vSigma_Contribution_tT = 0.;;
    _vSigma_Contribution_bB = 0.;;
    _vSigma_Contribution_cC = 0.;;
    _vSigma_Contribution_sS = 0.;;
    _vSigma_Contribution_dD = 0.;;
    _vSigma_Contribution_uU = 0.;;
    _vSigma_Contribution_lL = 0.;;
    _vSigma_Contribution_eE = 0.;;
    _vSigma_Contribution_mM = 0.;;
    _vSigma_Contribution_nlNl = 0.;;
    _vSigma_Contribution_nmNm = 0.;;
    _vSigma_Contribution_neNe = 0.;;

    int channel = 0;
    while( vSigmaTCh[channel].weight > 0. ) {
        if( !strcmp( vSigmaTCh[channel].prtcl[0], "~o1" ) && !strcmp( vSigmaTCh[channel].prtcl[1], "~o1" ) ) {
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "W+" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "W-" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "W-" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "W+" ) ) ) _vSigma_Contribution_WpWm = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "Z" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "Z" ) ) )   _vSigma_Contribution_ZZ   = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "G" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "G" ) ) )   _vSigma_Contribution_GG   = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "A" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "A" ) ) )   _vSigma_Contribution_AA   = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "h" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "h" ) ) )   _vSigma_Contribution_hh   = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "Z" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "h" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "h" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "Z" ) ) ) _vSigma_Contribution_Zh     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "t" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "T" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "T" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "t" ) ) ) _vSigma_Contribution_tT     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "b" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "B" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "B" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "b" ) ) ) _vSigma_Contribution_bB     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "c" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "C" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "C" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "c" ) ) ) _vSigma_Contribution_cC     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "s" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "S" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "S" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "s" ) ) ) _vSigma_Contribution_sS     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "u" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "U" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "U" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "u" ) ) ) _vSigma_Contribution_uU     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "d" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "D" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "D" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "d" ) ) ) _vSigma_Contribution_dD     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "l" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "L" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "L" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "l" ) ) ) _vSigma_Contribution_lL     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "e" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "E" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "E" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "e" ) ) ) _vSigma_Contribution_eE     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "m" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "M" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "M" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "m" ) ) ) _vSigma_Contribution_mM     = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "nl" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "Nl" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "Nl" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "nl" ) ) ) _vSigma_Contribution_nlNl = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "ne" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "Ne" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "Ne" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "ne" ) ) ) _vSigma_Contribution_neNe = vSigmaTCh[channel].weight;
            
            if( ( !strcmp( vSigmaTCh[channel].prtcl[2], "nm" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "nM" ) )
             || ( !strcmp( vSigmaTCh[channel].prtcl[2], "Nm" ) && !strcmp( vSigmaTCh[channel].prtcl[3], "nm" ) ) ) _vSigma_Contribution_nmNm = vSigmaTCh[channel].weight;

        }
        channel += 1;
    }

    if ( _omegah2 < 0 ) {

        _errorCode = 3;

    }
    delete Xf;
    return;

}
