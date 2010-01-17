/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FittinoInputFileInterpreterFactory.cpp                           *
*                                                                              *
* Description Factory class for Fittino input file interpreter                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "FittinoInputFileInterpreterFactory.h"

Fittino::FittinoInputFileInterpreterFactory::FittinoInputFileInterpreterFactory() {

}

Fittino::FittinoInputFileInterpreterFactory::~FittinoInputFileInterpreterFactory() {

}

FittinoInputFileInterpreter* Fittino::FittinoInputFileInterpreterFactory::CreateInterpreter() {

    return new FittinoInputFileInterpreter();

}
