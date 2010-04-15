/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ExceptionBase.cpp                                                *
*                                                                              *
* Description Fittino exception base class                                     *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ExceptionBase.h"

Fittino::ExceptionBase::ExceptionBase() {

}

Fittino::ExceptionBase::ExceptionBase( const std::string& message )
    : _message( message ) {

}

Fittino::ExceptionBase::~ExceptionBase() throw() {

}

const char* Fittino::ExceptionBase::what() const throw() {

    return ( "Fittino::ExceptionBase: " + _message ).c_str();

}
