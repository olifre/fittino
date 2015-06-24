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
#include <boost/foreach.hpp>

#include "TMath.h"

#include "CalculatorBase.h"
#include "Factory.h"
#include "Measurement.h"
#include "ModelBase.h"
#include "SimplePrediction.h"
#include "UncertaintyBase.h"


Fittino::Measurement::Measurement(std::string type, unsigned int index, const ModelBase *model, const boost::property_tree::ptree &ptree)
:CalculatorBase( model, &ptree ) {

    _name = ptree.get<std::string>( "Name" );

    if ( _name.empty() ) {

        throw ConfigurationException( "Measurement with empty name." );

    }

    _index = index;

    _measuredValue = ptree.get<double>( "Value" );
    _lowerBound = ptree.get<double>( "LowerBound", -std::numeric_limits<double>::infinity() );
    _upperBound = ptree.get<double>( "UpperBound", +std::numeric_limits<double>::infinity() );

    _isLowerLimit = ptree.get<bool>( "IsLowerLimit", false );
    _isUpperLimit = ptree.get<bool>( "IsUpperLimit", false );

    if ( _isLowerLimit && _isUpperLimit ) {

        throw ConfigurationException( "Observable " + _name + " declared as both lower limit and upper limit." );

    }

    AddInput( "Prediction" );

    AddQuantity( new SimplePrediction( "MeasuredValue"    , "", _measuredValue ) );
    AddQuantity( new SimplePrediction( "Deviation", "", _deviation     ) );
    AddQuantity( new SimplePrediction( "Pull"     , "", _pull          ) );
    AddQuantity( new SimplePrediction( "Chi2"     , "", _chi2          ) );

    Factory factory;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree ) {

                    if (node.first == "AstroUncertainty" || node.first == "AbsoluteUncertainty" || node.first == "RelativeTheoryUncertainty") {

                        UncertaintyBase *uncertainty = factory.CreateUncertainty(node.first, model, this, node.second);

                        if ( !uncertainty->GetName().empty() && !_namedUncertainties.insert( std::make_pair( _name + "_" + uncertainty->GetName(), uncertainty ) ).second ) {

                            throw ConfigurationException("Several uncertainties with same name " + uncertainty->GetName() + "." );

                        }

                        _uncertainties.push_back(uncertainty);

                    }

                }

    CalculatePredictions();

}

Fittino::Measurement::~Measurement() {

}


void Fittino::Measurement::CalculatePredictions()  {

    UpdateInput();

    _deviation = GetInput( "Prediction" ) - _measuredValue;

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

    _chi2 = TMath::Power( _pull, 2 );

}


double const & Fittino::Measurement::GetPredictedValue() const {

    return GetInput( "Prediction" );
    
}

const double& Fittino::Measurement::GetTotalUncertainty() const {

    return _totalUncertainty;

}

void Fittino::Measurement::SetMeasuredValue( double value ) {

    _measuredValue = value;
}

bool Fittino::Measurement::IsWithinBounds() const {

    return _measuredValue <= _upperBound && _measuredValue >= _lowerBound;

}

const std::map<std::string, const Fittino::Quantity *>& Fittino::Measurement::GetNamedUncertainties() const {

    return _namedUncertainties;

}

const double& Fittino::Measurement::GetMeasuredValue() const {

    return _measuredValue;

}

const double& Fittino::Measurement::GetChi2() const {

    return _chi2;

}
