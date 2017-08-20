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
#include "SimplePrediction.h"
#include "../../variables/include/ReferenceVariable.h"

Fittino::CalculatorBase::CalculatorBase( const ModelBase* model, const boost::property_tree::ptree* ptree )
    : _name( "" ),
      _tag( "" ),
      _model( model ),
      _ptree( ptree ) {

    if ( ptree != nullptr ) {

        _name = _ptree->get<std::string>( "Name", "" );
        _tag = _name;

    }

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

const double& Fittino::CalculatorBase::GetInput( std::string name ) const {

    try {

        return _input.at( name )->GetValue();

    }
    catch ( const std::out_of_range& e ) {

        std::cout << _name << ": No input " << name << std::endl;
        throw;

    }

}

const double& Fittino::CalculatorBase::GetOutput( std::string name ) const {

    try {

        return _settableOutput.at( name )->GetValue();

    }
    catch ( const std::out_of_range& e ) {

        std::cout << _name << ": No output " << name << std::endl;
        throw;

    }

}
void Fittino::CalculatorBase::AddInput( std::string name ) {

    std::string formula = GetConfiguration()->get<std::string>( name );

    AddInput( name, formula );

}

void Fittino::CalculatorBase::AddInput( std::string name, std::string value ) {

    FormulaQuantity* quantity = new FormulaQuantity( name, value , _model );

    _input.insert( std::make_pair( name, quantity ) );

}

void Fittino::CalculatorBase::AddOutput( std::string name, const double &value ) {

    AddQuantity( new SimplePrediction( name, "", value ) );

}

void Fittino::CalculatorBase::AddOutput( std::string name ) {

    Quantity* quantity = new Quantity( name );

    _settableOutput.insert( std::make_pair( name, quantity ) ) ;

    AddQuantity( quantity );

}

void  Fittino::CalculatorBase::AddQuantity( Fittino::Quantity* prediction ) {

    std::string name;

    if ( _tag.empty() && prediction->GetName().empty() ) {

        throw ConfigurationException( "Name and tag of a quantity empty at the same time." );

    }

    if ( _tag.empty() ) {

        name = prediction->GetName();

    }
    else if ( prediction->GetName().empty() ) {

        name = _tag;

    }
    else {

        name = _tag + "_" + prediction->GetName();

    }

    prediction->SetName( name );
    _collectionOfQuantities.AddElement( name, prediction );

}

void Fittino::CalculatorBase::PrintInput() const {

    std::map<std::string, FormulaQuantity*>::const_iterator it;

    for ( it = _input.begin(); it != _input.end(); ++it ) {

        it->second->PrintStatus();

    }

}

void Fittino::CalculatorBase::UpdateInput() {

    std::map<std::string, FormulaQuantity*>::const_iterator it;

    for ( it = _input.begin(); it != _input.end(); ++it ) {

        it->second->Update();

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

void Fittino::CalculatorBase::SetOutput( std::string name, const double &value ) {

    _settableOutput.at( name )->SetValue( value );

}

const Fittino::Collection<const Fittino::VariableBase<std::string> *> &
Fittino::CalculatorBase::GetCollectionOfStringVariables() const {

    return _collectionOfStringVariables;

}

template<class T>
void Fittino::CalculatorBase::ModifyVariableName( VariableBase<T>* prediction ) {

    std::string name;

    if (_tag.empty() && prediction->GetName().empty()) {

        throw ConfigurationException("Name and tag of a quantity empty at the same time.");

    }

    if (_tag.empty()) {

        name = prediction->GetName();

    } else if (prediction->GetName().empty()) {

        name = _tag;

    } else {

        name = _tag + "_" + prediction->GetName();

    }

    prediction->SetName(name);

}

void Fittino::CalculatorBase::AddStringVariable(Fittino::VariableBase<std::string> *variable) {

    ModifyVariableName( variable );
    _collectionOfStringVariables.AddElement( variable );

}

void Fittino::CalculatorBase::AddStringVariable(const std::string& name, const std::string& value) {

    AddStringVariable( new ReferenceVariable<std::string>( name, value ) );

}
