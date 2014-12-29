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

#include "TFormula.h"

#include "FormulaCalculator.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"

Fittino::FormulaCalculator::FormulaCalculator( const Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ),
      _defaultValue( 0 ),
      _result( 0 ),
      _unit( ptree.get<std::string>( "Unit", "" ) ),
      _x( &_defaultValue ),
      _y( &_defaultValue ),
      _z( &_defaultValue ),
      _t( &_defaultValue ),
      _ptree( ptree ),
      _formula( new TFormula( ptree.get<std::string>( "Name" ).c_str(), ptree.get<std::string>( "Formula" ).c_str() ) ) {

    InitializeVariable( "x", _x );
    InitializeVariable( "y", _y );
    InitializeVariable( "z", _z );
    InitializeVariable( "t", _t );

    _name = _formula->GetName();

    if ( _formula->GetNdim() < 1 ) {

        throw ConfigurationException( "Invalid formula." );

    }

    AddQuantity( new SimplePrediction( _name, _unit , _result ) );

}

Fittino::FormulaCalculator::~FormulaCalculator() {

    delete _formula;

}

void Fittino::FormulaCalculator::InitializeVariable( std::string name, const double*& variable ) {

    if ( _ptree.count( name ) < 1 ) return;

    variable = &_model->GetCollectionOfQuantities().At( _ptree.get<std::string>( name ) )->GetValue();

}

void Fittino::FormulaCalculator::CalculatePredictions() {

    _result = _formula->Eval( *_x, *_y, *_z, *_t );

}

void Fittino::FormulaCalculator::Initialize() {

}
