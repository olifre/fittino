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

#include <boost/property_tree/ptree.hpp>

#include "ModelParameterBase.h"

Fittino::ModelParameterBase::ModelParameterBase( std::string name,
                                                 std::string plotName,
                                                 double      value,
                                                 double      error,
                                                 double      lowerBound,
                                                 double      upperBound,
                                                 bool        fixed )
    : _error( error ),
      _fixed( fixed ),
      _updated( true ),
      ParameterBase( name,
                     plotName,
                     value,
                     lowerBound,
                     upperBound ) {

}

Fittino::ModelParameterBase::ModelParameterBase( const boost::property_tree::ptree& ptree )
    : _error( ptree.get<double>( "Error", 0.1 ) ),
      _fixed( ptree.get<bool>( "Fixed", false ) ),
      _updated( true ),
      ParameterBase( ptree.get<std::string>( "Name" ),
                     ptree.get<std::string>( "PlotName", ptree.get<std::string>( "Name" ) ),
                     ptree.get<double>( "Value", 0 ),
                     ptree.get<double>( "LowerBound", _lowerBound ),
                     ptree.get<double>( "UpperBound", _upperBound ) ) {

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

void Fittino::ModelParameterBase::SetUpdated( bool updated ) {

    _updated = updated;

}

void Fittino::ModelParameterBase::SetValue( double value ) {

    if ( !_fixed ) {

        _value = value;
        _updated = true;

    }

}
