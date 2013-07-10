/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParameterBase.cpp                                                *
*                                                                              *
* Description Base class for parameters                                        *
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

//#include "ConfigurationException.h"
#include "Messenger.h"
#include "ParameterBase.h"

Fittino::ParameterBase::ParameterBase( std::string name,
                                       std::string plotName,
	                               double      value,
                                       double      plotLowerBound,
                                       double      plotUpperBound )
        : _name( name ),
          _plotName( plotName ),
          _value( value ),
          _plotLowerBound( plotLowerBound ),
          _plotUpperBound( plotUpperBound ) {

    //CheckConsistency();

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
              << std::setw( 43 )
              << _name
              << std::right
              << std::setw( 9 )
              << std::setprecision( 2 )
              << std::scientific
              << _value
              << Messenger::Endl;

}

void Fittino::ParameterBase::SetValue( double value ) {

    _value = value;

}

std::string Fittino::ParameterBase::GetName() const {

    return _name;

}

std::string Fittino::ParameterBase::GetPlotName() const {

    return _plotName;

}

double Fittino::ParameterBase::GetPlotLowerBound( double plotLowerBound) {

    return _plotLowerBound;

}

double Fittino::ParameterBase::GetPlotUpperBound( double plotUpperBound) {

    return _plotUpperBound;

}

//void Fittino::ParameterBase::CheckConsistency() const {
//
//    // Check whether the parameter error is positive.
//
//    if ( _error < 0. ) {
//
//        throw ConfigurationException( "ERROR: Parameter " + _name + ": Parameter error is negative." );
//
//    }
//
//    // Check whether the lower bound is smaller than the upper bound.
//
//    if ( _lowerBound > _upperBound ) {
//
//        throw ConfigurationException( "ERROR: Parameter " + _name + ": The lower bound is larger than the upper bound." );
//
//    }
//
//    // Check whether the starting value is within the allowed range.
//
//    if ( _lowerBound > _value || _value > _upperBound ) {
//
//        throw ConfigurationException( "ERROR: Parameter " + _name + ": Parameter value is not within the allowed range." );
//
//    }
//
//}
