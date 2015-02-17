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
#include "Factory.h"
#include "Measurement.h"
#include "ModelBase.h"
#include "SimplePrediction.h"
#include "UncertaintyBase.h"


Fittino::Measurement::Measurement(std::string type, unsigned int index, const ModelBase *model, const boost::property_tree::ptree &ptree)
:CalculatorBase( model ) {

    _lowerLimit = false;
    _upperLimit = false;

    if (type == "LowerLimit") {

        _lowerLimit = true;

    }
    else if (type == "UpperLimit") {

        _upperLimit = true;

    }
    else if (type != "Measurement") {

        throw ConfigurationException("Type " + type + " not known.");

    }

    _index = index;

    _name = ptree.get<std::string>( "Name" );
    _tag = ptree.get<std::string>( "Tag", _name );

    _measuredValue = ptree.get<double>("Value");

    std::string predictionName = ptree.get<std::string>("Prediction");
    _prediction = model->GetCollectionOfQuantities().At(predictionName);

    _lowerBound = ptree.get<double>("LowerBound", -std::numeric_limits<double>::infinity());
    _upperBound = ptree.get<double>("UpperBound", +std::numeric_limits<double>::infinity());

    AddQuantity( "Chi2", new SimplePrediction( "Chi2", "", _chi2  ) );
    AddQuantity( "Measurement", new SimplePrediction( "Value", "", _measuredValue  ) );
    AddQuantity( "Deviation", new SimplePrediction( "Deviation", "", _deviation  ) );
    AddQuantity( "Pull", new SimplePrediction( "Pull", "", _pull  ) );

    Factory factory;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree ) {

                    if (node.first == "AstroExclusion" || node.first == "AbsoluteUncertainty" || node.first == "RelativeTheoryUncertainty") {

                        UncertaintyBase *uncertainty = factory.CreateUncertainty(node.first, model, this, node.second);

                        if (!uncertainty->GetName().empty() && !_namedUncertainties.insert(std::make_pair(uncertainty->GetName(), uncertainty)).second) {

                            throw ConfigurationException("Several uncertainties with same name " + uncertainty->GetName() + ".");

                        }

                        _uncertainties.push_back(uncertainty);
                    }

                }

    CalculatePredictions();

}

Fittino::Measurement::~Measurement() {

}


void Fittino::Measurement::CalculatePredictions()  {

    _deviation = _prediction->GetValue() - _measuredValue;

    if ( ( _lowerLimit && _deviation > 0 ) || ( _upperLimit && _deviation < 0 )  ) {

        _deviation = 0;

    }

    _totalUncertainty = 0;

    std::vector< UncertaintyBase* >::iterator it;

    for (  it = _uncertainties.begin(); it != _uncertainties.end(); ++it ) {

        (*it)->Update();
        _totalUncertainty += TMath::Power( (*it)->GetValue(), 2 );

    }

    _totalUncertainty = TMath::Sqrt( _totalUncertainty );

    _pull = _deviation / _totalUncertainty;

    _chi2 = TMath::Power( _pull, 2 );

}


const Fittino::Quantity* Fittino::Measurement::GetPrediction() const {

    return _prediction;
}

double Fittino::Measurement::GetTotalUncertainty() const {

    return _totalUncertainty;

}

void Fittino::Measurement::SetMeasuredValue(double value) {

    _measuredValue = value;
}

bool Fittino::Measurement::IsWithinBounds() {

    return _measuredValue <= _upperBound && _measuredValue >= _lowerBound;

}

const std::map<std::string, const Fittino::UncertaintyBase *> &Fittino::Measurement::GetNamedUncertainties() const {

    return _namedUncertainties;

}
