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
                                             std::string plotName,
                                             double      value,
                                             std::string unit,
                                             std::string plotUnit,
                                             double      error,
                                             double      lowerBound,
                                             double      upperBound,
                                             double      plotLowerBound,
                                             double      plotUpperBound,
                                             bool        fixed )

	: _unit( unit ),
          _plotUnit( plotUnit ),
          ModelParameterBase( name, plotName, value, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, fixed ) {

}

Fittino::PhysicsParameter::~PhysicsParameter() {

}

std::string Fittino::PhysicsParameter::GetUnit() const {

    return _unit;

}

std::string Fittino::PhysicsParameter::GetPlotName() const {

   std::string plotName = _plotName;

   if ( _plotUnit != "" ) plotName += " [" + this->GetPlotUnit() + "]";

   return plotName;

}

std::string Fittino::PhysicsParameter::GetPlotUnit() const {

    return _plotUnit;

}

void Fittino::PhysicsParameter::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 43 )
              << _name
              << std::right
              << std::setw( 9 )
              << std::setprecision( 2 )
              << std::scientific
              << _value;

    if ( _unit != "" && !_fixed ) {

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
