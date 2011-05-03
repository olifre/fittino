/* $Id: ObservableBase.cpp 844 2011-01-10 13:52:15Z uhlenbrock $ */

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

#include "Messenger.h"
#include "ObservableBase.h"

Fittino::ObservableBase::ObservableBase( std::string name, int id )
        : _chi2( 0. ),
          _deviation( 0. ),
          _measuredError( 0. ),
          _measuredValue( 0. ),
          _predictedValue( 0. ),
          _id( id ),
          _name( name ) {

}

Fittino::ObservableBase::~ObservableBase() {

}

double Fittino::ObservableBase::GetChi2() const {

    return _chi2;

}

void Fittino::ObservableBase::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 17 )
              << _name 
              << std::right
              << std::setw( 18 )
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

void Fittino::ObservableBase::CalculateDeviation() {

    if ( _measuredError != 0. ) {

        _deviation = ( _measuredValue - _predictedValue ) / _measuredError;

    }
    else {

        _deviation = ( _measuredValue - _predictedValue );

    }

}
