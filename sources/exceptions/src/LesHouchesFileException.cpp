/* $Id: LesHouchesFileException.cpp 582 2010-04-15 23:00:32Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LesHouchesFileException.cpp                                      *
*                                                                              *
* Description Fittino Les Houches file exception class. It is thrown in case   *
*             of problems with Les Houches file (syntax errors, etc.) from     *
*             model calculators.                                               *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "LesHouchesFileException.h"

Fittino::LesHouchesFileException::LesHouchesFileException( const std::string& message )
        : ExceptionBase( message ) {

}

const char* Fittino::LesHouchesFileException::what() const throw() {

    return ( "Fittino::LesHouchesFileException: " + _message ).c_str();

}
