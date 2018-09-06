/* $Id: FormulaPropCalculator.cpp 3063 2018-05-20 11:49:41Z sarrazin $ */

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

#include "FormulaPropCalculator.h"
#include "FormulaQuantity.h"
#include "ModelBase.h"

Fittino::FormulaPropCalculator::FormulaPropCalculator( const Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model, &ptree ) {

        SetName( "FormulaPropCalculator" );
        
        for ( const auto& node : *GetConfiguration() ) {
                
                if ( node.first == "Quantity" ) AddFormula( node.second );
            
            }
        
        _nonZerosRequired = GetConfiguration()->get<bool>( "NonZerosRequired", false );

    CalculatePredictions();

}

Fittino::FormulaPropCalculator::~FormulaPropCalculator() {

}

void Fittino::FormulaPropCalculator::CalculatePredictions() {

    for( auto formula : _formulas ) {
    
        formula->Update();
        int number;
        number = std::rand() % 100;
        std::cout << "random" << std::endl;
        std::cout << number << std::endl;
        if( _nonZerosRequired && !formula->GetValue() && number <= 80) {
            
         _requirementsFulfilled = false;
            
        }
        
    }

}

void Fittino::FormulaPropCalculator::AddFormula( boost::property_tree::ptree ptree ) {
    
    std::string name = ptree.get<std::string>( "Name" );
    std::string value = ptree.get<std::string>( "Value" );
    auto formula = new FormulaQuantity( name, value, _model );

    _formulas.push_back( formula );
    AddQuantity( formula );

}
