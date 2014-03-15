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
#include "SLHAPrediction.h"
#include "boost/property_tree/ptree.hpp"



Fittino::SLHAPrediction::SLHAPrediction( std::string         name,
                                        std::string         unit,
                                        SLHADataStorageBase* slhadatastorage,
                                        std::string         blockName,
                                        int columnIndex,
                                        std::string         firstId,
                                        std::string         secondId,
                                        std::string         thirdId,
                                        std::string         fourthId        )
: _columnIndex( columnIndex ),
_firstId( firstId ),
_secondId( secondId ),
_thirdId( thirdId ),
_fourthId( fourthId),
_blockName( blockName ),
_slhadatastorage( slhadatastorage ),
PredictionBase( name,
               name,
               unit,
               unit,
               0,
               0 ) {

}


Fittino::SLHAPrediction::SLHAPrediction( const boost::property_tree::ptree& ptree, SLHADataStorageBase* slhadatastorage )
    : _columnIndex( ptree.get<int>( "ColumnIndex" ) ),
      _firstId( ptree.get<std::string>( "FirstId" ) ),
      _secondId( ptree.get<std::string>( "SecondId", "" ) ),
      _blockName( ptree.get<std::string>( "BlockName" ) ),
      _slhadatastorage( slhadatastorage ),
      PredictionBase( ptree ) {

}

Fittino::SLHAPrediction::~SLHAPrediction() {

}


void Fittino::SLHAPrediction::Update() {

    if ( _secondId == "" ) {

        _value = _slhadatastorage->GetEntry( _blockName, _firstId, _columnIndex );

    }
    else if ( _thirdId == "" ){

        _value = _slhadatastorage->GetEntry( _blockName, _firstId, _secondId, _columnIndex );

    }
    else {

        _value = _slhadatastorage->GetEntry( _blockName, _columnIndex,_firstId, _secondId, _thirdId, _fourthId );
    }

}

