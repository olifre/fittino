/* $Id: TestModelBase.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TestModelBase.cpp                                                *
*                                                                              *
* Description Base class for Fittino test models                               *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TestModelBase.h"

Fittino::TestModelBase::TestModelBase() {

}

Fittino::TestModelBase::~TestModelBase() {

}

double Fittino::TestModelBase::Evaluate() {

    return this->TestModelFunction();

}
