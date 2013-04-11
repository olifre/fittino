/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParameterBase.cpp                                                *
*                                                                              *
* Description Base class for model parameters                                  *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iomanip>

#include "Messenger.h"
#include "ParameterBase.h"

Fittino::ParameterBase::ParameterBase( std::string name,
	                               double      value)
        : _name( name ),
          _value( value ){

}

Fittino::ParameterBase::~ParameterBase() {

}

double Fittino::ParameterBase::GetValue() const {

    return _value;

}

void Fittino::ParameterBase::PrintStatus() const {

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
              << _value
              << Messenger::Endl;

}

//void Fittino::ParameterBase::SetValue( double value ) {
//
//    if (!_fixed)
//        _value = value;
//
//}

std::string Fittino::ParameterBase::GetName() const {

    return _name;

}
