/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LinearInterpolationCalculator                                    *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <string>

#include <boost/property_tree/ptree.hpp>

#include "ModelBase.h"
#include "LinearInterpolationCalculator.h"
#include "SimplePrediction.h"

Fittino::LinearInterpolationCalculator::LinearInterpolationCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : LinearInterpolationCalculatorBase( model, ptree ) {

  AddQuantity( new SimplePrediction( "" , "", "", "", 0., 1.e6, _value ) );

  GetHistogram();

  CalculatePredictions();

}

Fittino::LinearInterpolationCalculator::~LinearInterpolationCalculator() {

}
