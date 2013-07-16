/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAObservable.cpp                                               *
*                                                                              *
* Description Class for SLHA observables                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "SLHAObservable.h"
#include "SLHADataStorageBase.h"
#include "SLHAModelCalculatorBase.h"

Fittino::SLHAObservable::SLHAObservable( std::string              name,
                                         std::string              plotName,
                                         std::string              unit,
                                         std::string              plotUnit,
                                         double                   plotLowerBound,
                                         double                   plotUpperBound,
                                         double                   measuredValue,
                                         double                   measuredError,
                                         SLHAModelCalculatorBase* slhaModelCalculator,
                                         std::string              blockName,
                                         std::string              id,
                                         int                      columnIndex )
        : _columnIndex( columnIndex ),
          _id( id ),
          _blockName( blockName ),
          _slhaModelCalculator( slhaModelCalculator ),
          ObservableBase( name,
                          plotName,
                          unit,
                          plotUnit,
                          plotLowerBound,
                          plotUpperBound,
                          measuredValue,
                          measuredError ) {

    _deviation = 0.;
    _predictedValue = 0.;

}

Fittino::SLHAObservable::~SLHAObservable() {

}

void Fittino::SLHAObservable::UpdatePrediction() {

    _predictedValue = _slhaModelCalculator->GetDataStorage()->GetEntry( _blockName, _id, _columnIndex );

    this->CalculateDeviation();

}
