/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6Model.cpp                                                   *
*                                                                              *
* Description Implementation of the HDim6 model                                *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "HDim6Model.h"
#include "HDim6ModelCalculator.h"
#include "PhysicsParameter.h"

Fittino::HDim6Model::HDim6Model() {

    _name = "HDim6 model";

    double      value          = 0;
    std::string unit           = "GeV-2";
    std::string plotUnit       = "GeV^{-2}";
    double      lowerBound     = 0;
    double      upperBound     = 1e-4;
    double      plotLowerBound = 0;
    double      plotUpperBound = 1e-4;
    
    // these will parametrize our grid
    AddParameter( new PhysicsParameter( "F_B", "F_{B}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, false ) );
    AddParameter( new PhysicsParameter( "F_W", "F_{W}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, false ) );
    AddParameter( new PhysicsParameter( "F_WW", "F_{WW}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, false ) );

    // these will be free in the fit as well
    AddParameter( new PhysicsParameter( "F_gg", "F_{gg}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_b", "F_{b}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_tau", "F_{#tau}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    
    // these we keep fixed
    AddParameter( new PhysicsParameter( "F_BB", "F_{BB}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_u", "F_{u}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_d", "F_{d}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_c", "F_{c}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_s", "F_{s}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_t", "F_{t}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_e", "F_{e}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_mu", "F_{#mu}", value, unit, plotUnit, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );

    HDim6ModelCalculator* hdim6ModelCalculator = new HDim6ModelCalculator( this );
    _modelCalculatorVector.push_back( hdim6ModelCalculator );

    PhysicsModelBase::Initialize();

}

Fittino::HDim6Model::~HDim6Model() {

}

Fittino::HDim6Model* Fittino::HDim6Model::Clone() const {

    return new HDim6Model( *this );

}
