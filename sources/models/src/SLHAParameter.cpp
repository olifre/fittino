/* $Id: SLHAParameter.cpp 844 2011-01-10 13:52:15Z uhlenbrock $ */

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
                                       double      value,
                                       double      error,
                                       double      lowerBound,
                                       double      upperBound,
                                       int         id,
                                       bool        fixed )

	: _id( id ),
          ParameterBase( name, value, error, lowerBound, upperBound, fixed ) {

}

Fittino::SLHAParameter::~SLHAParameter() {

}

int Fittino::SLHAParameter::GetID() const {

    return _id;

}
