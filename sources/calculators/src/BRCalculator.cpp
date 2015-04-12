/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        BRCalculator.cpp                                                 *
*                                                                              *
* Description see header file                                                  *
                                                                               *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>
#include <boost/property_tree/ptree.hpp>

#include "BRCalculator.h"
#include "ModelBase.h"
#include "SimplePrediction.h"


Fittino::BRCalculator::BRCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    :CalculatorBase( model, &ptree ) {

    SetName( "BRCalculator" );
    SetTag ( "" );

    AddOutput( "Gamma_" + ptree.get<std::string>( "Mother" ) + "_Total", _GammaTotal );

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first != "Channel") continue;

        std::string name = ptree.get<std::string>( "Mother" );

        BOOST_FOREACH( const boost::property_tree::ptree::value_type & daughternode, node.second ) {

                        if ( daughternode.first != "Daughter" ) continue;

                        name += "_" + daughternode.second.get_value<std::string>();

        }

        std::string value = node.second.get<std::string>( "Gamma" );

        _channels.push_back( name );

        AddInput( name, value );

        AddOutput( "BR_" + name  );

    }

}

Fittino::BRCalculator::~BRCalculator() {

}

void Fittino::BRCalculator::CalculatePredictions() {

    UpdateInput();

    _GammaTotal = 0;

    for ( unsigned int i = 0; i < _channels.size(); i++ ) {

        _GammaTotal += GetInput( _channels[i] );

    }

    for ( unsigned int i = 0; i < _channels.size(); i++ ) {

        SetOutput( "BR_" + _channels[i], GetInput( _channels[i] ) / _GammaTotal );

    }

}
