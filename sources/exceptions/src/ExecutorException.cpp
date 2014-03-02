/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ExecutorException.cpp                                            *
*                                                                              *
* Description Indicates a problem with the execution of an external program    *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ExecutorException.h"

Fittino::ExecutorException::ExecutorException( const std::string& message )
    : ExceptionBase( "Fittino::ExecutorException: " + message ) {

}
