/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelCalculatorBase.cpp                                          *
*                                                                              *
* Description Base class for model calculators                                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelCalculatorBase.h"
#include "SimpleDataStorage.h"

Fittino::ModelCalculatorBase::ModelCalculatorBase( const PhysicsModelBase* model )
        : _name( "" ),
          _callMethod( FUNCTION ),
          _executableName( "" ),
          _model( model ) {

  _simpleOutputDataStorage = new SimpleDataStorage();

}

Fittino::ModelCalculatorBase::~ModelCalculatorBase() {

  delete _simpleOutputDataStorage;

}

std::string Fittino::ModelCalculatorBase::GetName() const {

    return _name;

}

const Fittino::SimpleDataStorage* Fittino::ModelCalculatorBase::GetSimpleOutputDataStorage() const {

  return _simpleOutputDataStorage;

};
