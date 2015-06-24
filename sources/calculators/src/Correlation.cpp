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

#include "Correlation.h"
#include "Quantity.h"
#include "Measurement.h"

Fittino::Correlation::Correlation( const std::vector<Measurement *> &measurements,
                                  const boost::property_tree::ptree &ptree )
: _measurements( measurements ) {

    _correlation = ptree.get<double>( "Value" );

    for ( const auto& node : ptree ) {

        if ( node.first != "Uncertainty" ) continue;

        std::string name = node.second.get_value<std::string>();

        AddUncertainty( name );

    }

    if ( _indices.size() != 2 ) {

        throw ConfigurationException( "Correlation must be specified with two uncertainties." );

    }

    if ( _indices[0] == _indices[1] ) {

        throw ConfigurationException( "Correlation between uncertainties of the same measurement are not allowed.");

    }

    std::sort( _uncertainties.begin(), _uncertainties.end() );
    std::sort( _indices      .begin(), _indices      .end() );

}


Fittino::Correlation::~Correlation() {

}

void Fittino::Correlation::AddUncertainty( std::string name ) {

    bool found = false;

    for ( unsigned int i = 0; i < _measurements.size(); i++ ) {

        auto uncertainties = _measurements[i]->GetNamedUncertainties();

        auto it = uncertainties.find( name );

        if ( it == uncertainties.end() ) continue;

        _uncertainties.push_back( it->second );
        _indices.push_back( i );
        found = true;
        break;

    }

    if ( !found ) {

        throw ConfigurationException( "Uncertainty " + name + " is specified in correlation but does not exists." );

    }

}

double Fittino::Correlation::GetCovariance() const {

    double covariance = _correlation;

    for ( const auto& uncertainty : _uncertainties ) {

        covariance *= uncertainty->GetValue();

    }

    return covariance;

}

const std::vector<const Fittino::Quantity *>& Fittino::Correlation::GetUncertainties() const {

    return _uncertainties;

}

const std::vector<unsigned int>& Fittino::Correlation::GetIndices() const {

    return _indices;

}
