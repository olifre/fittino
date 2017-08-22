/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Measurement.cpp                                                  *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <string>

#include <boost/property_tree/ptree.hpp>

#include "TMath.h"

#include "CalculatorBase.h"
#include "FormulaQuantity.h"
#include "Measurement.h"
#include "ModelBase.h"
#include "UncertaintyBase.h"

Fittino::Measurement::Measurement(const ModelBase *model, const boost::property_tree::ptree &ptree) {

    _name = ptree.get<std::string>( "Name" );

    if ( _name.empty() ) {

        throw ConfigurationException( "Measurement with empty name." );

    }

    _prediction = new FormulaQuantity( "Prediction", ptree.get<std::string>( "Prediction" ), model );
    _measurement = new Quantity( "Measurement", "", ptree.get<double>( "Measurement" ) );
    _isLowerLimit = ptree.get<bool>( "IsLowerLimit", false );
    _isUpperLimit = ptree.get<bool>( "IsUpperLimit", false );
    _lowerBound = ptree.get<double>( "LowerBound", -std::numeric_limits<double>::infinity() );
    _upperBound = ptree.get<double>( "UpperBound", +std::numeric_limits<double>::infinity() );

    if ( _isLowerLimit && _isUpperLimit ) {

        throw ConfigurationException( "Observable " + _name + " declared as both lower limit and upper limit." );

    }

    for( const auto& node : ptree ) {

        if ( node.first != "Uncertainty" ) continue;

        AddUncertainty( model, node.second );

    }

    Update();

}

Fittino::Measurement::~Measurement() {

}

void Fittino::Measurement::Update()  {

    _prediction->Update();

    _deviation = _prediction->GetValue() - _measurement->GetValue();

    if ( ( _isLowerLimit && _deviation > 0 ) || ( _isUpperLimit && _deviation < 0 )  ) {

        _deviation = 0;

    }

    _totalUncertainty = 0;

    std::vector< Quantity* >::iterator it;

    for (  it = _uncertainties.begin(); it != _uncertainties.end(); ++it ) {

        (*it)->Update();
        _totalUncertainty += TMath::Power( (*it)->GetValue(), 2 );

    }

    _totalUncertainty = TMath::Sqrt( _totalUncertainty );

    _pull = _deviation / _totalUncertainty;

    if ( _totalUncertainty == 0 && _deviation == 0 ) {

        _pull = 0;

    }

    _chi2 = TMath::Power( _pull, 2 );

}

double const & Fittino::Measurement::GetPrediction() const {

    return _prediction->GetValue();
    
}

const double& Fittino::Measurement::GetTotalUncertainty() const {

    return _totalUncertainty;

}

const double& Fittino::Measurement::GetDeviation() const {

    return _deviation;

}

void Fittino::Measurement::SetMeasurement(double value) {

    _measurement->SetValue( value );
}

bool Fittino::Measurement::IsWithinBounds() const {

    return ( _measurement->GetValue() <= _upperBound ) && ( _measurement->GetValue() >= _lowerBound );

}

const double& Fittino::Measurement::GetMeasurement() const {

    return _measurement->GetValue();

}

const double& Fittino::Measurement::GetChi2() const {

    return _chi2;

}

const double &Fittino::Measurement::GetUncertainty( std::string name ) const {

    try {

        return _namedUncertainties.at( name )->GetValue();

    }
    catch ( const std::out_of_range& e ) {

        throw ConfigurationException( "Observable " + _name + " does not have an uncertainty with name " + name + " ." );

    }

}

const double &Fittino::Measurement::GetPull() const {

    return _pull;

}

void Fittino::Measurement::AddUncertainty( const ModelBase* model, const boost::property_tree::ptree &ptree) {

    auto name = ptree.get<std::string>( "Name", "" );

    auto formula = ptree.get<std::string>( "Value" );

    std::map<std::string, const Quantity*> map;
    map[ "Prediction" ] = _prediction;
    map[ "Measurement" ] = _measurement;

    Quantity* uncertainty= new FormulaQuantity( name, formula, model, map );

    if ( !uncertainty->GetName().empty() && !_namedUncertainties.insert( std::make_pair( name, uncertainty ) ).second ) {

        throw ConfigurationException( "Several uncertainties with same name " + uncertainty->GetName() + "." );

    }

    _uncertainties.push_back( uncertainty );

}

const std::string &Fittino::Measurement::GetName() const {

    return _name;

}
