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

#include "SLHAPrediction.h"
#include "SLHADataStorageBase.h"
#include "SLHAModelCalculatorBase.h"

Fittino::SLHAPrediction::SLHAPrediction( std::string              name,
                                         SLHAModelCalculatorBase* slhaModelCalculator,
                                         std::string              blockName,
                                         int                      id,
                                         int                      columnIndex )
        : _columnIndex( columnIndex ),
          _id( id ),
          _blockName( blockName ),
          _slhaModelCalculator( slhaModelCalculator ),
          PredictionBase( name ) {

    _predictedValue = 0.;

}

Fittino::SLHAPrediction::~SLHAPrediction() {

}

void Fittino::SLHAPrediction::UpdatePrediction() {

    _predictedValue = _slhaModelCalculator->GetDataStorage()->GetEntry( _blockName, _id, _columnIndex );

    //this->CalculateDeviation();

}
