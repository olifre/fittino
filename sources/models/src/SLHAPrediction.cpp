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

#include <boost/property_tree/ptree.hpp>

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

}

Fittino::SLHAPrediction::SLHAPrediction( const boost::property_tree::ptree& ptree, SLHAModelCalculatorBase* slhaModelCalculator )
       : _columnIndex( ptree.get<int>( "columnIndex" ) ),
         _firstId( ptree.get<std::string>( "firstId" ) ),
         _secondId( ptree.get<std::string>( "secondId", "" ) ),
         _blockName( ptree.get<std::string>( "blockName" ) ),
         _slhaModelCalculator( slhaModelCalculator ),
         PredictionBase( ptree ) {

}

Fittino::SLHAPrediction::~SLHAPrediction() {

}

std::string Fittino::SLHAPrediction::GetPlotUnit() const {

    return _plotUnit;

}

void Fittino::SLHAPrediction::Update() {

    if ( _secondId == "" ) {

        _value = _slhaModelCalculator->GetDataStorage()->GetEntry( _blockName, _firstId, _columnIndex );

    }
    else {

        _value = _slhaModelCalculator->GetDataStorage()->GetEntry( _blockName, _firstId, _secondId, _columnIndex );

    }

}

std::string Fittino::SLHAPrediction::GetPlotName() const {

   std::string plotName = _plotName;

   if ( _plotUnit != "" ) plotName += " [" + this->GetPlotUnit() + "]";

   return plotName;

}
