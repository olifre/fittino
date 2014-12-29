/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.cpp                                                    *
*                                                                              *
* Description Base class for Fittino models                                    *
*                                                                              *
* Authors     Matthias  Hamer       <mhamer@gwdg.de>                           *
*             Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>

#include "ModelBase.h"
#include "ModelParameter.h"

Fittino::ModelBase::ModelBase( boost::property_tree::ptree& ptree )
    : _name( "" ),
      _ptree ( ptree ) {

    InitializeParameters( ptree );

}

Fittino::ModelBase::~ModelBase() {

    _collectionOfQuantities.Delete();

    _collectionOfMetaDataDoubleVariables.Delete();
    _collectionOfStringVariables.Delete();

}

double Fittino::ModelBase::GetChi2() {

    bool evaluate = false;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        if ( GetCollectionOfParameters().At( i )->IsUpdated() ) {

            evaluate = true;
            GetCollectionOfParameters().At( i )->SetUpdated( false );

        }

    }

    if ( evaluate ) {

        _chi2 = Evaluate();

    }

    return _chi2;

}

int Fittino::ModelBase::GetNumberOfParameters() const {

    return GetCollectionOfParameters().GetNumberOfElements();

}

void Fittino::ModelBase::UpdatePropertyTree() {

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        GetCollectionOfParameters().At( i )->UpdatePropertyTree();

    }

}

std::string Fittino::ModelBase::GetName() const {

    return _name;

}

boost::property_tree::ptree Fittino::ModelBase::GetPropertyTree() {

    UpdatePropertyTree();
    return _ptree;

}

const Fittino::Collection<Fittino::ModelParameter*>& Fittino::ModelBase::GetCollectionOfParameters() const {

    return _collectionOfParameters;

}

const Fittino::Collection<Fittino::PredictionBase*>& Fittino::ModelBase::GetCollectionOfPredictions() const {

    return _collectionOfPredictions;

}

const Fittino::Collection<const Fittino::Quantity*>& Fittino::ModelBase::GetCollectionOfQuantities() const {

    return _collectionOfQuantities;

}

const Fittino::Collection<const Fittino::VariableBase<double>*>& Fittino::ModelBase::GetCollectionOfMetaDataDoubleVariables() const {

    return _collectionOfMetaDataDoubleVariables;

}

const Fittino::Collection<const Fittino::VariableBase<std::string>*>& Fittino::ModelBase::GetCollectionOfStringVariables() const {

    return _collectionOfStringVariables;

}

const std::vector<Fittino::Observable*>* Fittino::ModelBase::GetObservableVector() const {

    return &_observableVector;

}

void Fittino::ModelBase::AddPrediction( PredictionBase* prediction ) {

    _collectionOfPredictions.AddElement( prediction );
    _collectionOfQuantities.AddElement( prediction );

}

int Fittino::ModelBase::GetNumberOfPredictions() const {

    return _collectionOfPredictions.GetNumberOfElements();

}

void Fittino::ModelBase::AddParameter( ModelParameter* parameter ) {

  if ( ! parameter->IsFixed() ) {

      _collectionOfParameters.AddElement( parameter->GetName(), parameter );

  }

  _collectionOfQuantities.AddElement( parameter->GetName(), parameter );

}

void Fittino::ModelBase::InitializeParameters( boost::property_tree::ptree& ptree ) {

    BOOST_FOREACH( boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "ModelParameter" ) {

            AddParameter( new ModelParameter( node.second ) );

        }

    }

}
