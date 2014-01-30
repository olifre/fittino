/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelCalculatorBase.cpp                                          *
*                                                                              *
* Description Base class for model calculators                                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelCalculatorBase.h"
#include "PredictionBase.h"
#include "Chi2ContributionBase.h"
#include "SimpleDataStorage.h"

Fittino::ModelCalculatorBase::ModelCalculatorBase( const PhysicsModelBase* model )
        : _name( "" ),
          _model( model ) {

  _simpleOutputDataStorage = new SimpleDataStorage();

}

Fittino::ModelCalculatorBase::~ModelCalculatorBase() {

  delete _simpleOutputDataStorage;

}

void Fittino::ModelCalculatorBase::Initialize() const {

}

std::string Fittino::ModelCalculatorBase::GetName() const {

    return _name;

}

const Fittino::SimpleDataStorage* Fittino::ModelCalculatorBase::GetSimpleOutputDataStorage() const {

  return _simpleOutputDataStorage;

}

const Fittino::Collection<Fittino::PredictionBase*>& Fittino::ModelCalculatorBase::GetCollectionOfQuantities() const { 

  return _collectionOfQuantities;

}

const Fittino::Collection<Fittino::Chi2ContributionBase*>& Fittino::ModelCalculatorBase::GetCollectionOfChi2Contributions() const {

  return _collectionOfChi2Contributions;

}

void  Fittino::ModelCalculatorBase::AddQuantity( Fittino::PredictionBase* prediction ) {

    _collectionOfQuantities.AddElement( prediction );

}

void  Fittino::ModelCalculatorBase::AddChi2Contribution( Fittino::Chi2ContributionBase* chi2Contribution ) {

    _collectionOfChi2Contributions.AddElement( chi2Contribution );

}
