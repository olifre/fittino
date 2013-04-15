/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelParameterBase.cpp                                           *
*                                                                              *
* Description Base class for model parameters                                  *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iomanip>

#include "Messenger.h"
#include "ModelParameterBase.h"

Fittino::ModelParameterBase::ModelParameterBase( std::string name,
                                                 double      value,
                                                 double      error,
                                                 double      lowerBound,
                                                 double      upperBound,
                                                 bool        fixed )
        : _error( error ),
          _lowerBound( lowerBound ),
          _upperBound( upperBound ),
          _fixed( fixed ),
          ParameterBase( name, value ) {

}

Fittino::ModelParameterBase::~ModelParameterBase() {

}

bool Fittino::ModelParameterBase::IsFixed() const {

    return _fixed;

}

double Fittino::ModelParameterBase::GetError() const {

    return _error;

}

double Fittino::ModelParameterBase::GetLowerBound() const {

    return _lowerBound;

}

double Fittino::ModelParameterBase::GetUpperBound() const {

    return _upperBound;

}

void Fittino::ModelParameterBase::SetValue( double value ) {

    if (!_fixed)
        _value = value;

}

void Fittino::ModelParameterBase::PrintStatus() const {

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
