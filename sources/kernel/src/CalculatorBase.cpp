/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CalculatorBase.cpp                                               *
*                                                                              *
* Description Base class for calculators                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "CalculatorBase.h"
#include "FormulaQuantity.h"
#include "LogicException.h"
#include "ModelBase.h"

Fittino::CalculatorBase::CalculatorBase( const ModelBase* model, const boost::property_tree::ptree* ptree )
    : _name( "" ),
      _tag( "" ),
      _model( model ),
      _ptree( ptree ) {

}

const std::string& Fittino::CalculatorBase::GetName() const {

    return _name;

}

const Fittino::Collection<Fittino::Quantity*>& Fittino::CalculatorBase::GetCollectionOfQuantities() const {

    return _collectionOfQuantities;

}

Fittino::CalculatorBase::~CalculatorBase() {

}

void Fittino::CalculatorBase::Initialize() {

}

void Fittino::CalculatorBase::SetupMeasuredValues() {

}

void  Fittino::CalculatorBase::AddQuantity( Fittino::Quantity* prediction ) {

    if ( _tag != "" ) {

        prediction->SetName( _tag + "_" + prediction->GetName() );

    }

    _collectionOfQuantities.AddElement( prediction->GetName(), prediction );

}

void Fittino::CalculatorBase::AddInput( std::string name, std::string defaultValue ) {

    std::string formula;

    if ( defaultValue.empty() ) {

        formula = GetConfiguration()->get<std::string>( name );

    }
    else {

        formula = GetConfiguration()->get<std::string>( name, defaultValue );

    }

    FormulaQuantity* quantity = new FormulaQuantity( name, formula , _model );

    _input.insert( std::make_pair( name, quantity ) );

}

void Fittino::CalculatorBase::UpdateInput() {

    std::map<std::string, FormulaQuantity*>::const_iterator it;

    for ( it = _input.begin(); it != _input.end(); ++it ) {

        it->second->Update();

    }

}

const double& Fittino::CalculatorBase::GetInput( std::string name ) const {

    return _input.at( name )->GetValue() ;

}

void Fittino::CalculatorBase::PrintInput() const {

    std::map<std::string, FormulaQuantity*>::const_iterator it;

    for ( it = _input.begin(); it != _input.end(); ++it ) {

        it->second->PrintStatus();

    }

}

const boost::property_tree::ptree* Fittino::CalculatorBase::GetConfiguration() const {

    if ( _ptree ) {

        return _ptree;

    }
    else {

        throw LogicException( "Trying to access non existing configuration object of calculator " + _name + "." );

    }

}
