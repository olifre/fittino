/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAChi2Contribution.cpp                                         *
*                                                                              *
* Description Class for SLHA chi2 contributions                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/property_tree/ptree.hpp>

#include "TRandom3.h"

#include "SLHAChi2Contribution.h"
#include "SLHADataStorageBase.h"
#include "SLHACalculatorBase.h"

Fittino::SLHAChi2Contribution::SLHAChi2Contribution( std::string name,
                                                     SLHACalculatorBase* slhaCalculator,
                                                     std::string         blockName,
                                                     std::string         id,
                                                     int                 columnIndex )
        : _columnIndex( columnIndex ),
          _id( id ),
          _blockName( blockName ),
          _slhaCalculator( slhaCalculator ),
          Chi2ContributionBase( name ) {

}

Fittino::SLHAChi2Contribution::SLHAChi2Contribution( const boost::property_tree::ptree& ptree, SLHACalculatorBase* slhaCalculator )
                             : _columnIndex( ptree.get<int>( "ColumnIndex" ) ),
                               _id( ptree.get<std::string>( "ID" ) ),
                               _blockName( ptree.get<std::string>( "BlockName" ) ),
                               _slhaCalculator( slhaCalculator ),
                               Chi2ContributionBase( ptree ) {

}

Fittino::SLHAChi2Contribution::~SLHAChi2Contribution() {

}

void Fittino::SLHAChi2Contribution::UpdateValue() {

    _chi2 = _slhaCalculator->GetDataStorage()->GetEntry( _blockName, _id, _columnIndex );

}

void Fittino::SLHAChi2Contribution::SmearObservation( TRandom3* rndm ) {

}
