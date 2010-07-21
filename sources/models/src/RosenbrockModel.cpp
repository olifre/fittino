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
#include <iomanip>
#include <iostream>

#include "Configuration.h"
#include "RosenbrockModel.h"

Fittino::RosenbrockModel::RosenbrockModel() {

    Configuration* configuration = Configuration::GetInstance();

    _numberOfParameters = 2;
    _name = "Rosenbrock model";
    _parameterVector.push_back( Parameter( "X", configuration->GetSteeringParameter( "X", 0. ) ) );
    _parameterVector.push_back( Parameter( "Y", configuration->GetSteeringParameter( "Y", 0. ) ) );

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Initializing " << _name                                                         << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Starting values                                                              " << std::endl;
    std::cout << "                                                                                " << std::endl;

    for ( unsigned int i = 0; i < _numberOfParameters; i++ ) {

        std::cout << "    "
                  << std::left
                  << std::setw( 11 )
                  << std::setiosflags( std::ios::fixed )
                  << std::setprecision( 6 )
                  << _parameterVector[i].GetName()
                  << std::right
                  << std::setw( 12 )
                  << _parameterVector[i].GetValue()                                                 << std::endl;

    }

    std::cout << "                                                                                " << std::endl;

}

Fittino::RosenbrockModel::~RosenbrockModel() {

}

double Fittino::RosenbrockModel::Evaluate() {

    return pow( ( 1 - _parameterVector[0].GetValue() ), 2 ) + 100 * pow( _parameterVector[1].GetValue() - pow( _parameterVector[0].GetValue(), 2 ), 2 );

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
