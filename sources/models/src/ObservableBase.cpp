/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ObservableBase.cpp                                               *
*                                                                              *
* Description Base class for observables                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iomanip>

#include "TString.h"

#include "Messenger.h"
#include "ObservableBase.h"

Fittino::ObservableBase::ObservableBase( std::string name,
                                         double      measuredValue,
                                         double      measuredError )
        : _deviation( 0. ),
          _measuredError( measuredError ),
          _measuredValue( measuredValue ),
          PredictionBase( name ) {

   _predictedValue = 0.;

}

Fittino::ObservableBase::~ObservableBase() {

}

void Fittino::ObservableBase::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 18 )
              << _name 
              << std::right
              << std::setw( 17 )
              << std::setprecision( 5 )
              << std::scientific
              << _predictedValue
              << std::right
              << std::setw( 15 )
              << _measuredValue
              << std::setw( 5 )
              << " +/- "
              << std::right
              << std::setw( 10 )
              << _measuredError
              << std::right
              << std::setw( 7 )
              << std::setprecision( 1 )
              << std::fixed
              << _deviation
              << std::right
              << std::setw( 6 )
              << " sigma"
              << Messenger::Endl;

}

double Fittino::ObservableBase::GetMeasuredError() const {

    return _measuredError;
}

double Fittino::ObservableBase::GetMeasuredValue() const {

    return _measuredValue;
}

double Fittino::ObservableBase::CalculateDeviation() {

    _deviation = ( _predictedValue - _measuredValue ) / _measuredError;

}
