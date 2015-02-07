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
    : CalculatorBase( model ) {

    _name = ptree.get<std::string>( _name, "FormulaCalculator" );
    _tag = ptree.get<std::string>( _tag, "" );

    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {

        if ( node.first == "Quantity" ) {

            std::string name = node.second.get<std::string>( "Name" );
            std::string formula = node.second.get<std::string>( "Formula" );
            FormulaQuantity* quantity = new FormulaQuantity( name, formula, model );
            _formulas.push_back( quantity );
            AddQuantity( quantity );

        }

    }

    CalculatePredictions();

}

Fittino::FormulaCalculator::~FormulaCalculator() {

}


void Fittino::FormulaCalculator::CalculatePredictions() {

    for ( unsigned int i = 0; i < _formulas.size(); i++ ) {

        _formulas[i]->Update();

    }

}
