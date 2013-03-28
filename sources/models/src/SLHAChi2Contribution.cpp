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
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "SLHAChi2Contribution.h"
#include "SLHADataStorageBase.h"
#include "SLHAModelCalculatorBase.h"

Fittino::SLHAChi2Contribution::SLHAChi2Contribution( std::string name,
                                                     SLHAModelCalculatorBase* slhaModelCalculator,
                                                     std::string              blockName,
                                                     int                      id,
                                                     int                      columnIndex )
        : _columnIndex( columnIndex ),
          _id( id ),
	  _blockName( blockName ),
	  _slhaModelCalculator( slhaModelCalculator ),
          Chi2ContributionBase( name ) {

}

Fittino::SLHAChi2Contribution::~SLHAChi2Contribution() {

}

void Fittino::SLHAChi2Contribution::UpdateValue() {

    _chi2 = _slhaModelCalculator->GetDataStorage()->GetEntry( _blockName, _id, _columnIndex );

}
