/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PredictionBase.cpp                                               *
*                                                                              *
* Description Base class for predictions                                       *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "PredictionBase.h"

Fittino::PredictionBase::PredictionBase( std::string name,
                                         std::string plotName,
                                         std::string unit,
                                         std::string plotUnit,
                                         double      lowerBound,
                                         double      upperBound )
    : Quantity( name,
                plotName,
                0.,
                unit,
                plotUnit,
                lowerBound,
                upperBound ) {

}

Fittino::PredictionBase::PredictionBase( const boost::property_tree::ptree& ptree ) 
    : Quantity( ptree ) {

}

Fittino::PredictionBase::~PredictionBase() {

}
