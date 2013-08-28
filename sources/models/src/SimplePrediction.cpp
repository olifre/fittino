/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimplePrediction.cpp                                               *
*                                                                              *
* Description Class for simple predictions                                     *
*                                                                              *
* Authors     Bjoern Sarrazin <sarrazin@physik.uni-bonn.de>                    *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelCalculatorBase.h"
#include "SimpleDataStorage.h"
#include "SimplePrediction.h"

Fittino::SimplePrediction::SimplePrediction( std::string   name,
					     std::string   plotName,
					     std::string   unit,
					     std::string   plotUnit,
					     double        plotLowerBound,
					     double        plotUpperBound,
					     const double& value )
    : _referenceValue( value ),
      PredictionBase( name,
		      plotName,
		      unit,
		      plotUnit,
		      plotLowerBound,
		      plotUpperBound ) {

}

Fittino::SimplePrediction::SimplePrediction( std::string                name,
					     std::string                plotName,
					     std::string                unit,
					     std::string                plotUnit,
					     double                     plotLowerBound,
					     double                     plotUpperBound,
					     const ModelCalculatorBase* calculator )
    : _referenceValue( calculator->GetSimpleOutputDataStorage()->GetMap()->at( name ) ),
      PredictionBase( name,
		      plotName,
		      unit,
		      plotUnit,
		      plotLowerBound,
		      plotUpperBound ) {

}

Fittino::SimplePrediction::~SimplePrediction() {

}

void Fittino::SimplePrediction::Update() {

    _value = _referenceValue;

}