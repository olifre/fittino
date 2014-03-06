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

#include<iostream>

#include "pmodel.h"
#include "micromegas.h"
#include "micromegas_aux.h"

#include "MicromegasWrapper.h"


Fittino::MicromegasWrapper::MicromegasWrapper( const PhysicsModel* model )
:CalculatorBase( model ) {

   

}

Fittino::MicromegasWrapper::~MicromegasWrapper() {

}

void Fittino::MicromegasWrapper::CalculatePredictions() {

    std::vector<char> te( _inputFile.c_str(), _inputFile.c_str() + _inputFile.size() + 1);

    if ( lesHinput( &te[0] ) ) {

        std::cerr << "runmicromegas failed to open Les Houches file" << std::endl;

    }

    char lspName[128];

    if ( sortOddParticles( lspName ) ) {

        std::cerr << "runmicromegas cannot calculate relic density for " << lspName << " LSPs" << std::endl;
    }

    int spin2, charge3, cdim;
    qNumbers( lspName, &spin2, &charge3, &cdim);

    double Xf;
    int fast = 1;
    double Beps = 1e-6;
    _omegah2 = darkOmega(&Xf, fast, Beps);

    if (_omegah2 < 0) {

        std::cerr << "Problem with DM relic density calculation" << std::endl;
    }

    std::cout << "omega h^2 = " << _omegah2 << std::endl;

}
