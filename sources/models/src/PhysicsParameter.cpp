/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsParameter.cpp                                             *
*                                                                              *
* Description Class for model parameters that represent a physical quantity    *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iomanip>

#include "Messenger.h"
#include "PhysicsParameter.h"

Fittino::PhysicsParameter::PhysicsParameter( std::string name,
                                             double      value,
                                             std::string unit,
                                             double      error,
                                             double      lowerBound,
                                             double      upperBound,
                                             bool        fixed )

	: _unit( unit ),
          ParameterBase( name, value, error, lowerBound, upperBound, fixed ) {

}

Fittino::PhysicsParameter::~PhysicsParameter() {

}

std::string Fittino::PhysicsParameter::GetUnit() const {

    return _unit;

}

void Fittino::PhysicsParameter::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 20 )
              << _name
              << std::right
              << std::setw( 9 )
              << std::setprecision( 2 )
              << std::scientific
              << _value;

    if ( _unit != "" && !_fixed) {

        messenger << std::right
                  << std::setw( 6 )
                  << _unit;

    }
    else if ( _unit != "" && _fixed ) {

        messenger << std::right
                  << std::setw( 6 )
                  << _unit
                  << std::right
                  << std::setw( 10 )
                  << "(fixed)";

    }
    else if ( _unit == "" && _fixed ) {

        messenger << std::right
                  << std::setw( 16 )
                  << "(fixed)";

    }

    messenger << Messenger::Endl;

}
