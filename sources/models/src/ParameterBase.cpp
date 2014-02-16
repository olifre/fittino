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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ParameterBase.h"

Fittino::ParameterBase::ParameterBase( std::string name,
                                       std::string plotName,
                                       double      value,
                                       double      lowerBound,
                                       double      upperBound )
    : Quantity( name,
                plotName,
                value,
                lowerBound,
                upperBound ) {

    //CheckConsistency();

}

Fittino::ParameterBase::ParameterBase( const boost::property_tree::ptree& ptree ) 
    : Quantity( ptree ) {

}

Fittino::ParameterBase::~ParameterBase() {

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
