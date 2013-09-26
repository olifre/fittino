/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.cpp                                                    *
*                                                                              *
* Description Base class for Fittino models                                    *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Chi2ContributionBase.h"
#include "ConfigurationException.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PredictionBase.h"
#include "Observable.h"
#include <iostream>

Fittino::ModelBase::ModelBase()
    : _name( "" ) {

}

Fittino::ModelBase::~ModelBase() {

}

double Fittino::ModelBase::GetChi2() {

    bool evaluate = false;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        if ( GetParameterVector()->at( i )->IsUpdated() ) {

            evaluate = true;
            GetParameterVector()->at( i )->SetUpdated( false );

        }

    }

    if ( evaluate ) {

        _chi2 = Evaluate();

    }

    return _chi2;

}

int Fittino::ModelBase::GetNumberOfChi2Contributions() const {

    return _chi2ContributionVector.size();

}

int Fittino::ModelBase::GetNumberOfParameters() const {

    return _parameterVector.size();

}

int Fittino::ModelBase::GetNumberOfPredictions() const {

    return _predictionVector.size();

}

int Fittino::ModelBase::GetNumberOfObservables() const {

    return _observableVector.size();

}

void Fittino::ModelBase::AddParameter( ModelParameterBase* parameter ) {

    _parameterVector.push_back( parameter );

    if ( !_parameterMap.insert( std::make_pair( parameter->GetName(), parameter ) ).second ) {

        std::string message = "Parameter with name " + parameter->GetName() + " has already been added to model " + GetName();

        throw ConfigurationException( message ); //TODO: Dedicated exception class ?

    }

}

void Fittino::ModelBase::AddPrediction( PredictionBase* prediction ) {

    _collectionOfPredictions.AddElement( prediction->GetName(), prediction );
    _predictionVector.push_back( prediction );

}

std::string Fittino::ModelBase::GetName() const {

    return _name;

}

const std::map<std::string, Fittino::ModelParameterBase*>* Fittino::ModelBase::GetParameterMap() const {

    return &_parameterMap;

}

const std::vector<Fittino::Chi2ContributionBase*>* Fittino::ModelBase::GetChi2ContributionVector() const {

    return &_chi2ContributionVector;

}

const std::vector<Fittino::ModelParameterBase*>* Fittino::ModelBase::GetParameterVector() const {

    return &_parameterVector;

}

const std::vector<Fittino::PredictionBase*>* Fittino::ModelBase::GetPredictionVector() const {

    return &_predictionVector;

}

const std::vector<Fittino::Observable*>* Fittino::ModelBase::GetObservableVector() const {

    return &_observableVector;

}

const Fittino::Collection<Fittino::PredictionBase*>& Fittino::ModelBase::GetCollectionOfPredictions() const {

    return _collectionOfPredictions;

}
