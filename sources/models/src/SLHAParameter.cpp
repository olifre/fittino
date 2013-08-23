/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAParameter.cpp                                                *
*                                                                              *
* Description Class for SLHA model parameters                                  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "SLHAParameter.h"

Fittino::SLHAParameter::SLHAParameter( std::string name,
                                       std::string plotName,
                                       double      value,
                                       std::string unit,
                                       std::string plotUnit,
                                       double      error,
                                       double      lowerBound,
                                       double      upperBound,
                                       double      plotLowerBound,
                                       double      plotUpperBound,
                                       std::string id,
                                       bool        fixed )

        : _id( id ),
          PhysicsParameter( name,
                            plotName,
                            value,
                            unit,
                            plotUnit,
                            error,
                            lowerBound,
                            upperBound,
                            plotLowerBound,
                            plotUpperBound,
                            fixed ) {

}

Fittino::SLHAParameter::~SLHAParameter() {

}

std::string Fittino::SLHAParameter::GetID() const {

    return _id;

}
