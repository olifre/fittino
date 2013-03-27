/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RosenbrockModel.cpp                                              *
*                                                                              *
* Description Implementation of the Rosenbrock model                           *
*                                                                              *
* Authors     Pia     Kullik      <pkullik@uni-bonn.de>                        *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>
#include <sstream>

#include "Configuration.h"
#include "RosenbrockModel.h"

Fittino::RosenbrockModel::RosenbrockModel() {

    Configuration* configuration = Configuration::GetInstance();

    _name = "Rosenbrock model";

    _numberOfParameters = configuration->GetSteeringParameter( "Dimensions", 1. );

    std::stringstream parameterName;
    for ( unsigned int i = 0; i < _numberOfParameters; i++ ) {

        parameterName.str( "" );
        parameterName << "X" << i + 1;
        _parameterVector.push_back( new ParameterBase( parameterName.str(), configuration->GetSteeringParameter( parameterName.str(), 0. ), 1., -10., 10. ) );

    }

    TestModelBase::Initialize();

}

Fittino::RosenbrockModel::~RosenbrockModel() {

}

double Fittino::RosenbrockModel::TestModelFunction() {

    double rosenbrock = 0;

    for ( unsigned int i = 1; i < _parameterVector.size(); i++ ) {

        rosenbrock += pow( 1 - _parameterVector.at( i - 1 )->GetValue(), 2 ) + 100 * pow( _parameterVector.at( i )->GetValue() - pow( _parameterVector.at( i - 1 )->GetValue(), 2 ), 2 );
    }

    return rosenbrock;

}

Fittino::RosenbrockModel* Fittino::RosenbrockModel::Clone() const {

    return new RosenbrockModel( *this );

}
