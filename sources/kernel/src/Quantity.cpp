/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Quantity.cpp                                                     *
*                                                                              *
* Description Base class for quantities                                        *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iomanip>
#include <limits>

#include <boost/property_tree/ptree.hpp>

#include "Messenger.h"
#include "Quantity.h"

Fittino::Quantity::Quantity( std::string name,
                             std::string plotName,
                             double      value,
                             double      lowerBound,
                             double      upperBound )
    : _lowerBound( lowerBound ),
      _upperBound( upperBound ),
      _value( value ),
      _name( name ),
      _plotName( plotName ) {

}

Fittino::Quantity::Quantity( std::string name,
                             std::string plotName,
                             double      value,
                             std::string unit,
                             std::string plotUnit,
                             double      lowerBound,
                             double      upperBound )
    : _lowerBound( lowerBound ),
      _upperBound( upperBound ),
      _value( value ),
      _name( name ),
      _unit( unit ),
      _plotName( plotName ),
      _plotUnit( plotUnit ) {

}

Fittino::Quantity::Quantity( const boost::property_tree::ptree& ptree )
    : _lowerBound( ptree.get<double>     ( "LowerBound", - std::numeric_limits<double>::infinity()  ) ),
      _upperBound( ptree.get<double>     ( "UpperBound",  std::numeric_limits<double>::infinity()  ) ),
      _value     ( ptree.get<double>     ( "Value", 0.    ) ),
      _name      ( ptree.get<std::string>( "Name"         ) ),
      _unit      ( ptree.get<std::string>( "Unit", ""     ) ),
      _plotName  ( ptree.get<std::string>( "PlotName", "" ) ),
      _plotUnit  ( ptree.get<std::string>( "PlotUnit", "" ) ) {

}

Fittino::Quantity::~Quantity() {

}

bool Fittino::Quantity::IsInBounds() const {

  if (  GetValue() <= GetUpperBound() && GetValue() >= GetLowerBound() ) return true;

  return false;

}

double Fittino::Quantity::GetLowerBound() const {

    return _lowerBound;

}

double Fittino::Quantity::GetUpperBound() const {

    return _upperBound;

}

void Fittino::Quantity::SetName( std::string name ) {

    _name = name;

}

std::string Fittino::Quantity::GetName() const {

    return _name;

}

std::string Fittino::Quantity::GetPlotName() const {

    std::string plotName = _plotName;

    if ( _plotUnit != "" ) plotName += " [" + _plotUnit + "]";

    return plotName;

}

const double& Fittino::Quantity::GetValue() const {

    return _value;

}

void Fittino::Quantity::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 50 )
              << _name
              << std::right
              << std::setw( 9 )
              << std::setprecision( 2 )
              << std::scientific
              << GetValue();

    if ( _unit != "" ) {

        messenger << std::right
                  << std::setw( 6 )
                  << _unit;

    }

    messenger << Messenger::Endl;

}

void Fittino::Quantity::SetValue( double value ) {

    _value = value;

}

void Fittino::Quantity::Update() {

}

Fittino::Quantity::Quantity(std::string name) {

    _name  = name;

}
