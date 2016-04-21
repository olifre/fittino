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
    //double Temperature = 2.726/1.1605 * 1.e-13;
    _omegah2 = darkOmega( Xf, fast, Beps );
    _gmin2 = gmuon();
    //_vSigma = vSigma( Temperature, Beps, fast );
    int err = 0;
    _vSigma = calcSpectrum( 3, NULL, NULL, NULL, NULL, NULL, NULL, &err );

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
    while( vSigmaCh[channel].weight > 0. ) {
        if( !strcmp( vSigmaCh[channel].prtcl[0], "~o1" ) && !strcmp( vSigmaCh[channel].prtcl[1], "~o1" ) ) {
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "W+" ) && !strcmp( vSigmaCh[channel].prtcl[3], "W-" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "W-" ) && !strcmp( vSigmaCh[channel].prtcl[3], "W+" ) ) ) _vSigma_Contribution_WpWm += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "Z" ) && !strcmp( vSigmaCh[channel].prtcl[3], "Z" ) ) )   _vSigma_Contribution_ZZ   += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "G" ) && !strcmp( vSigmaCh[channel].prtcl[3], "G" ) ) )   _vSigma_Contribution_GG   += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "A" ) && !strcmp( vSigmaCh[channel].prtcl[3], "A" ) ) )   _vSigma_Contribution_AA   += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "h" ) && !strcmp( vSigmaCh[channel].prtcl[3], "h" ) ) )   _vSigma_Contribution_hh   += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "Z" ) && !strcmp( vSigmaCh[channel].prtcl[3], "h" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "h" ) && !strcmp( vSigmaCh[channel].prtcl[3], "Z" ) ) ) _vSigma_Contribution_Zh     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "t" ) && !strcmp( vSigmaCh[channel].prtcl[3], "T" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "T" ) && !strcmp( vSigmaCh[channel].prtcl[3], "t" ) ) ) _vSigma_Contribution_tT     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "b" ) && !strcmp( vSigmaCh[channel].prtcl[3], "B" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "B" ) && !strcmp( vSigmaCh[channel].prtcl[3], "b" ) ) ) _vSigma_Contribution_bB     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "c" ) && !strcmp( vSigmaCh[channel].prtcl[3], "C" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "C" ) && !strcmp( vSigmaCh[channel].prtcl[3], "c" ) ) ) _vSigma_Contribution_cC     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "s" ) && !strcmp( vSigmaCh[channel].prtcl[3], "S" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "S" ) && !strcmp( vSigmaCh[channel].prtcl[3], "s" ) ) ) _vSigma_Contribution_sS     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "u" ) && !strcmp( vSigmaCh[channel].prtcl[3], "U" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "U" ) && !strcmp( vSigmaCh[channel].prtcl[3], "u" ) ) ) _vSigma_Contribution_uU     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "d" ) && !strcmp( vSigmaCh[channel].prtcl[3], "D" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "D" ) && !strcmp( vSigmaCh[channel].prtcl[3], "d" ) ) ) _vSigma_Contribution_dD     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "l" ) && !strcmp( vSigmaCh[channel].prtcl[3], "L" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "L" ) && !strcmp( vSigmaCh[channel].prtcl[3], "l" ) ) ) _vSigma_Contribution_lL     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "e" ) && !strcmp( vSigmaCh[channel].prtcl[3], "E" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "E" ) && !strcmp( vSigmaCh[channel].prtcl[3], "e" ) ) ) _vSigma_Contribution_eE     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "m" ) && !strcmp( vSigmaCh[channel].prtcl[3], "M" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "M" ) && !strcmp( vSigmaCh[channel].prtcl[3], "m" ) ) ) _vSigma_Contribution_mM     += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "nl" ) && !strcmp( vSigmaCh[channel].prtcl[3], "Nl" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "Nl" ) && !strcmp( vSigmaCh[channel].prtcl[3], "nl" ) ) ) _vSigma_Contribution_nlNl += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "ne" ) && !strcmp( vSigmaCh[channel].prtcl[3], "Ne" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "Ne" ) && !strcmp( vSigmaCh[channel].prtcl[3], "ne" ) ) ) _vSigma_Contribution_neNe += vSigmaCh[channel].weight;
            
            if( ( !strcmp( vSigmaCh[channel].prtcl[2], "nm" ) && !strcmp( vSigmaCh[channel].prtcl[3], "nM" ) )
             || ( !strcmp( vSigmaCh[channel].prtcl[2], "Nm" ) && !strcmp( vSigmaCh[channel].prtcl[3], "nm" ) ) ) _vSigma_Contribution_nmNm += vSigmaCh[channel].weight;

        }
        channel += 1;
    }

    if ( _omegah2 < 0 ) {

        _errorCode = 3;

    }
    delete Xf;
    return;

}
