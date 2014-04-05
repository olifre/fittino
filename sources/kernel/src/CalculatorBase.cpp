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
#include "Chi2ContributionBase.h"
#include "PredictionBase.h"
#include "SimpleDataStorage.h"

Fittino::CalculatorBase::CalculatorBase( const PhysicsModel* model )
    : _name( "" ),
      _tag( "" ),
      _model( model ) {

    _simpleOutputDataStorage = new SimpleDataStorage();

}

Fittino::CalculatorBase::~CalculatorBase() {

    delete _simpleOutputDataStorage;

}

std::string Fittino::CalculatorBase::GetName() const {

    return _name;

}

const Fittino::Collection<Fittino::Chi2ContributionBase*>& Fittino::CalculatorBase::GetCollectionOfChi2Contributions() const {

    return _collectionOfChi2Contributions;

}

const Fittino::Collection<Fittino::PredictionBase*>& Fittino::CalculatorBase::GetCollectionOfQuantities() const {

    return _collectionOfQuantities;

}

const Fittino::SimpleDataStorage* Fittino::CalculatorBase::GetSimpleOutputDataStorage() const {

    return _simpleOutputDataStorage;

}

void Fittino::CalculatorBase::Initialize() {

}

void Fittino::CalculatorBase::SetupMeasuredValues() {

}

void  Fittino::CalculatorBase::AddChi2Contribution( Fittino::Chi2ContributionBase* chi2Contribution ) {

    _collectionOfChi2Contributions.AddElement( chi2Contribution );

}

void  Fittino::CalculatorBase::AddQuantity( Fittino::PredictionBase* prediction ) {

    if ( _tag != "" ) {

        prediction->SetName( _tag + "_" + prediction->GetName() );

    }

    _collectionOfQuantities.AddElement( prediction );

}
