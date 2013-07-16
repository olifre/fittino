/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAPrediction.cpp                                               *
*                                                                              *
* Description Class for SLHA predictions                                       *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "SLHADataStorageBase.h"
#include "SLHAModelCalculatorBase.h"
#include "SLHAPrediction.h"

Fittino::SLHAPrediction::SLHAPrediction( std::string              name,
                                         std::string              plotName,
                                         std::string              unit,
                                         std::string              plotUnit,
                                         double                   plotLowerBound,
                                         double                   plotUpperBound,
                                         SLHAModelCalculatorBase* slhaModelCalculator,
                                         std::string              blockName,
                                         std::string              id,
                                         int                      columnIndex )
        : _columnIndex( columnIndex ),
          _firstId( id ),
          _blockName( blockName ),
          _slhaModelCalculator( slhaModelCalculator ),
          PredictionBase( name,
                          plotName,
                          unit,
                          plotUnit,
                          plotLowerBound,
                          plotUpperBound ) {

    _predictedValue = 0.;
    _secondId = "";

}

Fittino::SLHAPrediction::SLHAPrediction( std::string              name,
                                         std::string              plotName,
                                         std::string              unit,
                                         std::string              plotUnit,
                                         double                   plotLowerBound,
                                         double                   plotUpperBound,
                                         SLHAModelCalculatorBase* slhaModelCalculator,
                                         std::string              blockName,
                                         std::string              firstId,
                                         std::string              secondId,
                                         int                      columnIndex )
        : _columnIndex( columnIndex ),
          _firstId( firstId ),
          _secondId( secondId ),
          _blockName( blockName ),
          _slhaModelCalculator( slhaModelCalculator ),
          PredictionBase( name,
                          plotName,
                          unit,
                          plotUnit,
                          plotLowerBound,
                          plotUpperBound ) {

    _predictedValue = 0.;

}

Fittino::SLHAPrediction::~SLHAPrediction() {

}

void Fittino::SLHAPrediction::UpdatePrediction() {

    if ( _secondId == "" ) {

        _predictedValue = _slhaModelCalculator->GetDataStorage()->GetEntry( _blockName, _firstId, _columnIndex );

    }
    else {

        _predictedValue = _slhaModelCalculator->GetDataStorage()->GetEntry( _blockName, _firstId, _secondId, _columnIndex );

    }

}
