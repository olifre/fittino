/* $Id: Observable.cpp 1444 2013-07-16 16:54:46Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Observable.cpp                                                   *
*                                                                              *
* Description Class for observables                                            *
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

#include "Messenger.h"
#include "Observable.h"
#include "PredictionBase.h"

Fittino::Observable::Observable( PredictionBase* prediction,
                                 double          measuredValue,
                                 double          measuredError )
        : _deviation( 0. ),
          _measuredError( measuredError ),
          _measuredValue( measuredValue ),
					_bestFitPrediction( 0. ),
          _prediction( prediction ) {
}

Fittino::Observable::~Observable() {

}

void Fittino::Observable::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 18 )
              << _prediction->GetName()
              << std::right
              << std::setw( 17 )
              << std::setprecision( 5 )
              << std::scientific
              << _prediction->GetValue()
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

double Fittino::Observable::GetMeasuredError() const {

    return _measuredError;
}

double Fittino::Observable::GetMeasuredValue() const {

    return _measuredValue;
}

double Fittino::Observable::CalculateDeviation() {

    _deviation = ( _prediction->GetValue() - _measuredValue ) / _measuredError;

}

Fittino::PredictionBase* Fittino::Observable::GetPrediction() {

   return _prediction;

}

void Fittino::Observable::SetBestFitPrediction( double value ) {
		
		_bestFitPrediction = value;

}

void Fittino::Observable::UpdatePrediction() {

    _prediction->Update();

    this->CalculateDeviation();

}

void Fittino::Observable::SmearMeasuredValue( TRandom *randomGenerator ) {

		_measuredValue = randomGenerator->Gaus( _bestFitPrediction, _measuredError );

}
