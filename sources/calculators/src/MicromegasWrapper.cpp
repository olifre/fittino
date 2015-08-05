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
#include <vector>

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

    double Xf;
    int fast = 1;
    double Beps = 1e-6;
    _omegah2 = darkOmega( &Xf, fast, Beps );
    _gmin2 = gmuon();

    if ( _omegah2 < 0 ) {

        _errorCode = 3;

    }
    return;

}
