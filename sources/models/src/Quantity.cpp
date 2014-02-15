/* $Id: Quantity.cpp 1432 2013-07-12 22:04:21Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Quantity.cpp                                                     *
*                                                                              *
* Description Base class for quantities                                        *
*                                                                              *
* Authors     Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iomanip>

#include <boost/property_tree/ptree.hpp>

#include "Messenger.h"
#include "Quantity.h"

Fittino::Quantity::Quantity( std::string name,
                             std::string plotName,
                             double      value,
                             double      lowerBound,
                             double      upperBound )
        : _name( name ),
          _plotName( plotName ),
          _value( value ),
          _lowerBound( lowerBound ),
          _upperBound( upperBound ) {

}

Fittino::Quantity::Quantity( const boost::property_tree::ptree& ptree ) 
        : _name( ptree.get<std::string>( "Name" ) ), 
          _plotName( ptree.get<std::string>( "PlotName" ) ),
          _value( ptree.get<double>( "Value", 0. ) ),
          _lowerBound( ptree.get<double>( "LowerBound" ) ),
          _upperBound( ptree.get<double>( "UpperBound" ) ) {

}

Fittino::Quantity::~Quantity() {

}

double Fittino::Quantity::GetLowerBound() const {

    return _lowerBound;

}

double Fittino::Quantity::GetUpperBound() const {

    return _upperBound;

}

const double& Fittino::Quantity::GetValue() const {

    return _value;

}

void Fittino::Quantity::SetValue( double value ) {

    _value = value;

}

std::string Fittino::Quantity::GetName() const {

    return _name;

}

void Fittino::Quantity::PrintStatus() const {

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
              << _value
              << Messenger::Endl;

}

std::string Fittino::Quantity::GetPlotName() const {

    return _plotName;

}
