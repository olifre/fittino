/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHACalculatorBase.cpp                                           *
*                                                                              *
* Description Base class for SLHA compatible model calculators                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Factory.h"
#include "PhysicsModel.h"
#include "SLHACalculatorBase.h"
#include "SLHAeaSLHADataStorage.h"

Fittino::SLHACalculatorBase::SLHACalculatorBase( const PhysicsModel* model )
    : CalculatorBase( model ),
      _slhaInputFileName( "" ),
      _slhaOutputFileName( "" ) {

    Factory factory;

    _slhaInputDataStorage  = factory.CreateSLHAeaSLHADataStorage();
    _slhaOutputDataStorage = factory.CreateSLHAeaSLHADataStorage();

}

Fittino::SLHACalculatorBase::~SLHACalculatorBase() {

}

std::string Fittino::SLHACalculatorBase::String( double x ) {

    std::stringstream tmpStream_x;
    std::string tmpString_x;

    tmpStream_x << x;
    tmpStream_x >> tmpString_x;

    return tmpString_x;

}

Fittino::SLHADataStorageBase* Fittino::SLHACalculatorBase::GetDataStorage() {

    return _slhaOutputDataStorage;

}
