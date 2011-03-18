/* $Id: Parameter.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Parameter.cpp                                                    *
*                                                                              *
* Description Class for model parameters                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Parameter.h"

Fittino::Parameter::Parameter( std::string name, double value, int id )
        : _name( name ),
	  _id( id ),
          _value( value ) {

}

Fittino::Parameter::~Parameter() {

}

double Fittino::Parameter::GetValue() const {

    return _value;

}

int Fittino::Parameter::GetID() const {

    return _id;

}

void Fittino::Parameter::SetValue( double value ) {

    _value = value;

}

std::string Fittino::Parameter::GetName() const {

    return _name;

}
