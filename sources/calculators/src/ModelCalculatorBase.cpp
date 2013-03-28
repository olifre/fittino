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

Fittino::ModelCalculatorBase::ModelCalculatorBase()
        : _name( "" ),
          _callMethod( FUNCTION ),
          _executableName( "" ) {

}

Fittino::ModelCalculatorBase::~ModelCalculatorBase() {

}

std::string Fittino::ModelCalculatorBase::GetName() const {

    return _name;

}
