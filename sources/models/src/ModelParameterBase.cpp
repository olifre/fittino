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

#include "ModelParameterBase.h"

Fittino::ModelParameterBase::ModelParameterBase( std::string name,
                                                 std::string plotName,
                                                 double      value,
                                                 double      error,
                                                 double      lowerBound,
                                                 double      upperBound,
                                                 double      plotLowerBound,
                                                 double      plotUpperBound,
                                                 bool        fixed )
        : _error( error ),
          _lowerBound( lowerBound ),
          _upperBound( upperBound ),
          _fixed( fixed ),
	  _updated( true ),
          ParameterBase( name,
                         plotName,
                         value,
                         plotLowerBound,
                         plotUpperBound ) {

}

Fittino::ModelParameterBase::~ModelParameterBase() {

}

bool Fittino::ModelParameterBase::IsFixed() const {

    return _fixed;

}

bool Fittino::ModelParameterBase::IsUpdated() const {

    return _updated;

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

void Fittino::ModelParameterBase::SetUpdated( bool updated ) {

    _updated = updated;

}

void Fittino::ModelParameterBase::SetValue( double value ) {

    if ( !_fixed ) {

        _value = value;
	_updated = true;

    }

}
