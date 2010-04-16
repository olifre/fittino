/* $Id: ModelCalculatorException.cpp 582 2010-04-15 23:00:32Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelCalculatorException.cpp                                     *
*                                                                              *
* Description Fittino input file exception class. It is thrown in case of      *
*             problems with calculations performed by model calculators.       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelCalculatorException.h"

Fittino::ModelCalculatorException::ModelCalculatorException( const std::string& message )
        : ExceptionBase( message ) {

}

const char* Fittino::ModelCalculatorException::what() const throw() {

    return ( "Fittino::ModelCalculatorException: " + _message ).c_str();

}
