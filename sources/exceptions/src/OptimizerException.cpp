/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        OptimizerException.cpp                                           *
*                                                                              *
* Description Thrown in case of problems with an optimizer                     *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "OptimizerException.h"

Fittino::OptimizerException::OptimizerException( const std::string& message )
    : ExceptionBase( "Fittino::OptimizerException: " + message ) {

}
