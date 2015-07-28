/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Correlation.cpp                                                  *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <string>

#include <boost/property_tree/ptree.hpp>

#include "ConfigurationException.h"
#include "Correlation.h"
#include "Quantity.h"
#include "Measurement.h"

Fittino::Correlation::Correlation( const std::vector<const Fittino::Measurement*> &observables,
                                   const boost::property_tree::ptree &ptree )
: _observables( observables ) {

    _id.first = ptree.get<std::string>( "Name" );

    _correlation = ptree.get<double>( "Value" );

    std::vector<unsigned int> indices;

    for ( const auto& node : ptree ) {

        if ( node.first != "Observable") continue;

        std::string observableName = node.second.get_value<std::string>();

        indices.push_back( GetIndex( observableName ) );

    }

    if ( indices[0] == indices[1] ) {

        throw ConfigurationException( "Correlation " + _id.first + " configured to be between one and the same observable " + _observables[indices[0]]->GetName() + "." );

    }

    std::sort( indices.begin(), indices.end() );

    _id.second.first = indices[0];
    _id.second.second = indices[1];

    Update();

}

Fittino::Correlation::~Correlation() {

}

const double& Fittino::Correlation::GetCovariance() const {

    return _covariance;

}

unsigned int Fittino::Correlation::GetIndex( std::string observable ) const {

    for ( unsigned int i = 0; i < _observables.size(); ++i ) {

        if ( _observables[i]->GetName() == observable ) return i;

    }

    throw ConfigurationException( "Correlation " + _id.first + " configured with an observable " + observable + " which does not exist." );

}

const std::pair<std::string, std::pair<unsigned int, unsigned int>> &Fittino::Correlation::GetID() const {

    return _id;

}

void Fittino::Correlation::Update() {

    _covariance = _correlation;

    _covariance *= _observables.at( _id.second.first  )->GetUncertainty( _id.first );
    _covariance *= _observables.at( _id.second.second )->GetUncertainty( _id.first );

}
