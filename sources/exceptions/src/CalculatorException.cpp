/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CalculatorException.cpp                                          *
*                                                                              *
* Description Thrown in case of problems with calculations performed by one of *
*             the calculators                                                  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "CalculatorException.h"

Fittino::CalculatorException::CalculatorException( const std::string& calculator, const std::string& error )
    : _calculator( calculator ),
      _error( error ),
      ExceptionBase( "Fittino::CalculatorException: In calculator " + calculator + " the following error occured: " + error + "." ) {

}

const std::string& Fittino::CalculatorException::GetCalculator() const {

    return _calculator;

}

const std::string& Fittino::CalculatorException::GetError() const {

    return _error;

}

Fittino::CalculatorException::~CalculatorException() throw() {

}
