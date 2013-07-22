/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CMSSMModel.cpp                                                   *
*                                                                              *
* Description Implementation of the CMSSM model                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Configuration.h"
#include "CMSSMModel.h"
#include "Observable.h"
#include "SLHAParameter.h"
#include "SLHAPrediction.h"
#include "SPhenoSLHAModelCalculator.h"

Fittino::CMSSMModel::CMSSMModel() {

    Configuration* configuration = Configuration::GetInstance();

    _name = "CMSSM model";

    _parameterVector.push_back( new SLHAParameter( "P_A0",      "A_{0}",    configuration->GetSteeringParameter( "A0" ,     0. ), "GeV", "GeV", 1., -1.e5, 1.e5, -1.e5,  1.e5, "5" ) );
    _parameterVector.push_back( new SLHAParameter( "P_M0",      "M_{0}",    configuration->GetSteeringParameter( "M0" ,     0. ), "GeV", "GeV", 1., -1.e5, 1.e5,    0., 2300., "1" ) );
    _parameterVector.push_back( new SLHAParameter( "P_M12",     "M_{1/2}",  configuration->GetSteeringParameter( "M12" ,    0. ), "GeV", "GeV", 1., -1.e5, 1.e5,  500., 3500., "2" ) );
    _parameterVector.push_back( new SLHAParameter( "P_TanBeta", "tan#beta", configuration->GetSteeringParameter( "TanBeta", 0. ),    "",    "", 1.,    0., 1.e3,    0.,  1.e3, "3" ) );

    SPhenoSLHAModelCalculator* slhaModelCalculator = new SPhenoSLHAModelCalculator();
    _modelCalculatorVector.push_back( slhaModelCalculator );

    _observableVector.push_back( new Observable( new SLHAPrediction( "O_Bsg_npf" , "BR(b#rightarrows#gamma)", "", "", 0., 1.e6, slhaModelCalculator, "SPhenoLowEnergy", " 1", 1 ), 3.55e-04, 0.53e-04 ) );

    PhysicsModelBase::Initialize();

}

Fittino::CMSSMModel::~CMSSMModel() {

}

Fittino::CMSSMModel* Fittino::CMSSMModel::Clone() const {

    return new CMSSMModel( *this );

}
