/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ConfigurationException.cpp                                       *
*                                                                              *
* Description Thrown in case of problems with the configuration of Fittino     *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ConfigurationException.h"

Fittino::ConfigurationException::ConfigurationException( const std::string& message )
    : ExceptionBase( "Fittino::ConfigurationException: " + message ) {

}
