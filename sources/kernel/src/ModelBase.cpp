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
*             Matthias Hamer        <mhamer@gwdg.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>
#include <boost/property_tree/ptree.hpp>

#include "ConfigurationException.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PredictionBase.h"

Fittino::ModelBase::ModelBase( const boost::property_tree::ptree& ptree )
    : _name( "" ) {

    _ptree = ptree;
    InitializeParameters( ptree );

}

Fittino::ModelBase::~ModelBase() {

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

    BOOST_FOREACH( boost::property_tree::ptree::value_type & node, _ptree ) {

        if ( node.first == "ModelParameter" ) {

            node.second.put( "Value", _collectionOfParameters.At( node.second.get<std::string>( "Name" ) )->GetValue() );

        }
    }

}

std::string Fittino::ModelBase::GetName() const {

    return _name;

}

boost::property_tree::ptree Fittino::ModelBase::GetPropertyTree() {

    UpdatePropertyTree();
    return _ptree;

}

const Fittino::Collection<Fittino::Chi2ContributionBase*>& Fittino::ModelBase::GetCollectionOfChi2Contributions() const {

    return _collectionOfChi2Contributions;

}

const Fittino::Collection<Fittino::ModelParameterBase*>& Fittino::ModelBase::GetCollectionOfParameters() const {

    return _collectionOfParameters;

}

const Fittino::Collection<Fittino::PredictionBase*>&  Fittino::ModelBase::GetCollectionOfPredictions() const {

    return _collectionOfPredictions;

}

const Fittino::Collection<const Fittino::Quantity*>&  Fittino::ModelBase::GetCollectionOfQuantities() const {

    return _collectionOfQuantities;

}

void Fittino::ModelBase::AddPrediction( PredictionBase* prediction ) {

    _collectionOfPredictions.AddElement( prediction );
    _collectionOfQuantities.AddElement( prediction );

}

int Fittino::ModelBase::GetNumberOfPredictions() const {

    return _collectionOfPredictions.GetNumberOfElements();

}

void Fittino::ModelBase::AddParameter( ModelParameterBase* parameter ) {

    _collectionOfParameters.AddElement( parameter->GetName(), parameter );
    _collectionOfQuantities.AddElement( parameter->GetName(), parameter );

}

void Fittino::ModelBase::InitializeParameters( const boost::property_tree::ptree& ptree ) {

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "ModelParameter" ) {

            AddParameter( new ModelParameterBase( node.second ) );

        }

    }

}
