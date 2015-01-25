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
#include "PredictionBase.h"
#include "VariableBase.h"
#include "ModelBase.h"

Fittino::CalculatorBase::CalculatorBase( const ModelBase* model )
    : _name( "" ),
      _tag( "" ),
      _model( model ) {

}

std::string Fittino::CalculatorBase::GetName() const {

    return _name;

}

const Fittino::Collection<Fittino::Quantity*>& Fittino::CalculatorBase::GetCollectionOfQuantities() const {

    return _collectionOfQuantities;

}

const Fittino::Collection<Fittino::VariableBase<std::string>*>& Fittino::CalculatorBase::GetCollectionOfStringVariables() const {

    return _collectionOfStringVariables;

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

    _collectionOfQuantities.AddElement( prediction );

}

void  Fittino::CalculatorBase::AddStringVariable( Fittino::VariableBase<std::string>* variable ) {

    if ( _tag != "" ) {

        variable->SetName( _tag + "_" + variable->GetName() );

    }

    _collectionOfStringVariables.AddElement( variable );

}

Fittino::CalculatorBase::CalculatorBase(Fittino::ModelBase const *model, const boost::property_tree::ptree &ptree) {

    _model = model;
    _name = ptree.get<std::string>( "Name", "" );
    _tag = ptree.get<std::string>( "Tag", "" ); // todo: Decide if tag should be equal to name by default

}
