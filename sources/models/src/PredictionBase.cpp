/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PredictionBase.cpp                                               *
*                                                                              *
* Description Base class for predictions                                       *
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
#include "PredictionBase.h"

Fittino::PredictionBase::PredictionBase( std::string name, 
                                         std::string unit)
         : _predictedValue( 0. ),
           _name( name ) {

}

Fittino::PredictionBase::~PredictionBase() {

}

std::string Fittino::PredictionBase::GetName() const {

    return _name;

}

std::string Fittino::PredictionBase::GetUnit() const {

    return _unit;

}

void Fittino::PredictionBase::PrintStatus() const {

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
              << _predictedValue
              << Messenger::Endl;

}

double Fittino::PredictionBase::GetPredictedValue() const {

    return _predictedValue;

}
