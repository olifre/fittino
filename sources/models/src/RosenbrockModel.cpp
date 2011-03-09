/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RosenbrockModel.cpp                                              *
*                                                                              *
* Description Implementation of the Rosenbrock model                           *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include "Configuration.h"
#include "RosenbrockModel.h"

Fittino::RosenbrockModel::RosenbrockModel() {

    Configuration* configuration = Configuration::GetInstance();

    _numberOfParameters = 2;
    _name = "Rosenbrock model";
    _parameterVector.push_back( Parameter( "X", configuration->GetSteeringParameter( "X", 0. ) ) );
    _parameterVector.push_back( Parameter( "Y", configuration->GetSteeringParameter( "Y", 0. ) ) );

    ModelBase::InitializeModel();

}

Fittino::RosenbrockModel::~RosenbrockModel() {

}

double Fittino::RosenbrockModel::TestModelFunction() {

    return pow( ( 1 - _parameterVector[0].GetValue() ), 2 ) + 100 * pow( _parameterVector[1].GetValue() - pow( _parameterVector[0].GetValue(), 2 ), 2 );

}

Fittino::RosenbrockModel* Fittino::RosenbrockModel::Clone() const {

    return new RosenbrockModel( *this );

}
