/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MinuitAdapter.cpp                                                *
*                                                                              *
* Description Adapter class for Minuit                                         *
*                                                                              *
* Authors     Peter Wienemann <wienemann@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "MinuitAdapter.h"

double Fittino::MinuitAdapter::operator()( const std::vector< double >& parameterVector ) const {

    return _model->Evaluate();

}
