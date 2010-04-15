/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        InputFileException.cpp                                           *
*                                                                              *
* Description Fittino input file exception class. It is thrown in case of      *
*             problems with input file (syntax error, unknown type, etc.).     *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "InputFileException.h"

Fittino::InputFileException::InputFileException( const std::string& text ) {

    _message = "InputFileException: " + text;

}
