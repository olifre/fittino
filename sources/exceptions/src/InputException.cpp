/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        InputException.cpp                                               *
*                                                                              *
* Description Fittino input exception class. It is thrown in case of erroneous *
*             input.                                                           *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "InputException.h"

Fittino::InputException::InputException( const std::string& message )
        : ExceptionBase( "Fittino::InputException: " + message ) {

}
