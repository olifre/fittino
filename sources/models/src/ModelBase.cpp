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
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>

#include "Configuration.h"
#include "ConfigurationException.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PredictionBase.h"
#include "SLHAParameter.h"
#include <iostream>

const Fittino::Collection<const Fittino::Quantity*>&  Fittino::ModelBase::GetCollectionOfQuantities() const{


  return _collectionOfQuantities;

}

Fittino::ModelBase::ModelBase()
    : _name( "" ) {

    InitializeParameters();

}

Fittino::ModelBase::ModelBase( const boost::property_tree::ptree& ptree )
    : _name("") {
    
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

int Fittino::ModelBase::GetNumberOfPredictions() const {

    return _collectionOfPredictions.GetNumberOfElements();

}

void Fittino::ModelBase::AddParameter( ModelParameterBase* parameter ) {

    _collectionOfParameters.AddElement( parameter->GetName(), parameter );

    _collectionOfQuantities.AddElement( parameter->GetName(), parameter );
}

void Fittino::ModelBase::AddPrediction( const PredictionBase* prediction ) {

    _collectionOfPredictions.AddElement( prediction );
    _collectionOfQuantities.AddElement( prediction );

}

std::string Fittino::ModelBase::GetName() const {

    return _name;

}

const Fittino::Collection<Fittino::ModelParameterBase*>& Fittino::ModelBase::GetCollectionOfParameters() const {

    return _collectionOfParameters;

}

void Fittino::ModelBase::InitializeParameters() {

    Configuration *configuration = Configuration::GetInstance();
    const boost::property_tree::ptree* propertyTree = configuration->GetPropertyTree();

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & v, propertyTree->get_child( "InputFile" ) ) {
        if ( v.first == "Parameter" ) {

            std::string name = v.second.get<std::string>( "<xmlattr>.Name" );
            std::string plotName = v.second.get<std::string>( "<xmlattr>.PlotName", name );
            std::string unit = v.second.get<std::string>( "<xmlattr>.Unit", "" );
            std::string plotUnit = v.second.get<std::string>( "<xmlattr>.PlotUnit", unit );
            std::string id = v.second.get<std::string>( "<xmlattr>.ID", "" );
            double value = v.second.get<double>( "<xmlattr>.Value" );
            double error = v.second.get<double>( "<xmlattr>.Error" );
            double lowerBound = v.second.get<double>( "<xmlattr>.LowerBound", 0. );
            double upperBound = v.second.get<double>( "<xmlattr>.UpperBound", 0. );
            double plotLowerBound = v.second.get<double>( "<xmlattr>.PlotLowerBound", 0. );
            double plotUpperBound = v.second.get<double>( "<xmlattr>.PlotUpperBound", 0. );
            bool fixed = v.second.get<bool>( "<xmlattr>.Fixed", false );

            if ( v.second.get<std::string>( "<xmlattr>.Type" ) == "SLHA" ) {

                AddParameter( new SLHAParameter( name, plotName, value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, id, fixed ) );

            }

            else if ( v.second.get<std::string>( "<xmlattr>.Type" ) == "Base" ) {

                AddParameter( new ModelParameterBase( name, plotName, value, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, fixed ) );

            }

            else if ( v.second.get<std::string>( "<xmlattr>.Type" ) == "Physics" ) {

                AddParameter( new PhysicsParameter( name, plotName, value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, fixed ) );

            }

        }

    }

}

void Fittino::ModelBase::InitializeParameters( const boost::property_tree::ptree& ptree ) {

    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {
    
      if( node.first == "ModelParameter" ) {

        AddParameter( new ModelParameterBase( node.second ) );

      }

    }

}
