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
#include <iostream>

#include "Configuration.h"
#include "RosenbrockModel.h"

Fittino::RosenbrockModel::RosenbrockModel()
        : _x ( 0. ),
          _y ( 0. ) {

    Configuration* configuration = Configuration::GetInstance();

    _numberOfParameters = 2;
    _x = configuration->GetSteeringParameter( "X", 0. );
    _y = configuration->GetSteeringParameter( "Y", 0. );

    _parameterVector.push_back( _x );
    _parameterVector.push_back( _y );

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Initializing Rosenbrock model                                                 " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Starting values                                                              " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    X    " << _x                                                                  << std::endl;
    std::cout << "    Y    " << _y                                                                  << std::endl;
    std::cout << "                                                                                " << std::endl;

}

Fittino::RosenbrockModel::~RosenbrockModel() {

}

double Fittino::RosenbrockModel::Evaluate() {

    //double functionValue = pow( ( 1 - _x ), 2 ) + 100 * pow( _y - pow( _x, 2 ), 2 );
    double functionValue = pow( ( 1 - _parameterVector[0] ), 2 ) + 100 * pow( _parameterVector[1] - pow( _parameterVector[0], 2 ), 2 );
    return functionValue;

}

Fittino::RosenbrockModel* Fittino::RosenbrockModel::Clone() const {

    return new RosenbrockModel( *this );

}

Fittino::RosenbrockFCN::RosenbrockFCN( const std::vector<double>& meas, const std::vector<double>& pos, const std::vector<double>& mvar )
        : theMeasurements( meas ),
          thePositions( pos ),
          theMVariances( mvar ),
          theErrorDef( 1. ) {

}

Fittino::RosenbrockFCN::~RosenbrockFCN() {

}

double Fittino::RosenbrockFCN::Up() const {

    return theErrorDef;

}

double Fittino::RosenbrockFCN::operator()( const std::vector<double>& parameterVector ) const {

    return pow( ( 1 - parameterVector[0] ), 2 ) + 100 * pow( parameterVector[1] - pow( parameterVector[0], 2 ), 2 );

}
