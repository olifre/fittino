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

        SetName( "FormulaCalculator" );
        
        for ( const auto& node : *GetConfiguration() ) {
                
                if ( node.first == "Quantity" ) AddFormula( node.second );
            
            }
        
        _nonZerosRequired = GetConfiguration()->get<bool>( "NonZerosRequired", false );

    CalculatePredictions();

}

Fittino::FormulaCalculator::~FormulaCalculator() {

}

void Fittino::FormulaCalculator::CalculatePredictions() {

    for( auto formula : _formulas ) {
    
        formula->Update();
        
        if( _nonZerosRequired && !formula->GetValue() ) {
            
         _requirementsFulfilled = false;
            
        }
        
    }

}

void Fittino::FormulaCalculator::AddFormula( boost::property_tree::ptree ptree ) {
    
    std::string name = ptree.get<std::string>( "Name" );
    std::string value = ptree.get<std::string>( "Value" );
    auto formula = new FormulaQuantity( name, value, _model );

    _formulas.push_back( formula );
    AddQuantity( formula );

}
