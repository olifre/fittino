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

#include "TGraph.h"
#include "TMath.h"

#include "CalculatorBase.h"
#include "ConfigurationException.h"
#include "Factory.h"
#include "Measurement.h"
#include "ModelBase.h"
#include "SimplePrediction.h"
#include "UncertaintyBase.h"


Fittino::Measurement::Measurement( std::string type, const Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
:CalculatorBase( model ) {

    _lowerLimit = false;
    _upperLimit = false;

    if ( _name == "" ) _name = "Measurement";
    if ( _tag == "" ) _tag = "Measurement";

    if (type == "LowerLimit") {

        _lowerLimit = true;

    }
    else if (type == "UpperLimit") {

        _upperLimit = true;

    }
    else if (type != "Measurement") {

        throw ConfigurationException("Type " + type + " not known.");

    }

    _measuredValue = ptree.get<double>("Measurement");
    std::string predictionName = ptree.get<std::string>("Prediction");
    _prediction = model->GetCollectionOfQuantities().At(predictionName);

    _lowerBound = ptree.get<double>("LowerBound", -std::numeric_limits<double>::infinity());
    _upperBound = ptree.get<double>("UpperBound", +std::numeric_limits<double>::infinity());

    Factory factory;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree.get_child("Uncertainties") ) {

                    UncertaintyBase *uncertainty = factory.CreateUncertainty( node.first, this, node.second );

                    if (!_uncertainties.insert( std::make_pair( uncertainty->GetName(), uncertainty ) ).second ) {

                        throw ConfigurationException("Several uncertainties with same name " + uncertainty->GetName() + ".");

                    }

                }

    AddQuantity( new SimplePrediction( "Chi2", "", _chi2  ) );
    AddQuantity( new SimplePrediction( "Measurement", "", _measuredValue  ) );
    AddQuantity( new SimplePrediction( "Deviation", "", _deviation  ) );
    AddQuantity( new SimplePrediction( "Pull", "", _pull  ) );

}

Fittino::Measurement::~Measurement() {

}


void Fittino::Measurement::CalculatePredictions()  {

    _deviation = _prediction->GetValue() - _measuredValue;

    if ( ( _lowerLimit && _deviation > 0 ) || ( _upperLimit && _deviation < 0 )  ) {

        _deviation = 0;

    }

    _totalUncertainty = 0;

    std::map<std::string, UncertaintyBase* >::iterator it;

    for (  it = _uncertainties.begin(); it != _uncertainties.end(); it++ ) {

        it->second->Update();
        _totalUncertainty += TMath::Power( it->second->GetValue(), 2 );

    }

    _totalUncertainty = TMath::Sqrt( _totalUncertainty );

    _pull = _deviation / _totalUncertainty;

    _chi2 = TMath::Power( _pull, 2 );

}


const Fittino::Quantity* Fittino::Measurement::GetPrediction() const {

    return _prediction;
}

void Fittino::Measurement::AddUncertainty( double &variable, double uncertainty ) {

    variable = TMath::Power( variable, 2 );
    variable += TMath::Power( uncertainty, 2);
    variable = TMath::Sqrt( variable );

}

Fittino::ModelBase const *Fittino::Measurement::GetModel() const {

    return _model;

}

double Fittino::Measurement::GetTotalUncertainty() const {

    return _totalUncertainty;

}

void Fittino::Measurement::SetMeasuredValue(double value) {

    _measuredValue = value;
}

bool Fittino::Measurement::IsWithinBounds() {

    if ( _measuredValue < _upperBound && _measuredValue > _lowerBound ) {

        return true;

    }
    else {

        return false;

    }

}
