/* $Id: SLHAFileException.h 582 2010-04-15 23:00:32Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAFileException.h                                              *
*                                                                              *
* Description Fittino SLHA file exception class. It is thrown in case of       *
*             problems with the SLHA file (syntax errors, etc.).               *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*             Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "SLHAFileException.h"

Fittino::SLHAFileException::SLHAFileException( const std::string& message )
        : ExceptionBase( "Fittino::SLHAFileException: " + message ) {

}
