/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FormulaCalculator.cpp                                            *
*                                                                              *
* Description Wrapper class for TFormula                                       *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <string>

#include <boost/foreach.hpp>

#include "FormulaCalculator.h"
#include "FormulaQuantity.h"
#include "ModelBase.h"

Fittino::FormulaCalculator::FormulaCalculator( const Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model, &ptree ) {

    std::string formula = ptree.get<std::string>( "Formula" );
    _formula = new FormulaQuantity( "", formula, model );
    AddQuantity( _formula );

    CalculatePredictions();

}

Fittino::FormulaCalculator::~FormulaCalculator() {

}

void Fittino::FormulaCalculator::CalculatePredictions() {

    _formula->Update();

}
