/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimplePrediction.cpp                                             *
*                                                                              *
* Description Class for simple predictions                                     *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "CalculatorBase.h"
#include "SimplePrediction.h"

#include <boost/property_tree/ptree.hpp>

Fittino::SimplePrediction::SimplePrediction( std::string   name,
                                             std::string   unit,
                                             const double& value )
    : _referenceValue( value ),
      PredictionBase( name,
                      name,
                      unit,
                      unit,
                      0,
                      1 ) {

}

Fittino::SimplePrediction::SimplePrediction( std::string   name,
                                             std::string   plotName,
                                             std::string   unit,
                                             std::string   plotUnit,
                                             double        lowerBound,
                                             double        upperBound,
                                             const double& value )
    : _referenceValue( value ),
      PredictionBase( name,
                      plotName,
                      unit,
                      plotUnit,
                      lowerBound,
                      upperBound ) {

}

Fittino::SimplePrediction::SimplePrediction( const boost::property_tree::ptree& ptree, const CalculatorBase* calculator )
    : _referenceValue( calculator->GetCollectionOfQuantities().At( ptree.get<std::string>( "Name" ) )->GetValue() ),
      PredictionBase( ptree ) {

}

Fittino::SimplePrediction::~SimplePrediction() {

}

void Fittino::SimplePrediction::Update() {

}

const double& Fittino::SimplePrediction::GetValue() const {

    return _referenceValue;

}
