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

#include "ModelParameterBase.h"
#include "Messenger.h"

Fittino::ModelParameterBase::ModelParameterBase( const boost::property_tree::ptree& ptree )
    : _error  ( ptree.get<double>( "Error", 0.1   ) ),
      _fixed  ( ptree.get<bool>  ( "Fixed", false ) ),
      _updated( true ),
      Quantity( ptree ) {

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

void Fittino::ModelParameterBase::PrintStatus() const {

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
              << _value;

    if ( _unit != "" && !_fixed ) {

        messenger << std::right
                  << std::setw( 6 )
                  << _unit;

    }
    else if ( _unit != "" && _fixed ) {

        messenger << std::right
                  << std::setw( 6 )
                  << _unit
                  << std::right
                  << std::setw( 10 )
                  << "(fixed)";

    }
    else if ( _unit == "" && _fixed ) {

        messenger << std::right
                  << std::setw( 16 )
                  << "(fixed)";

    }

    messenger << Messenger::Endl;

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