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
#include "Measurement.h"
#include "ModelBase.h"
#include "UncertaintyBase.h"


Fittino::Measurement::Measurement( std::string type, const Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
:CalculatorBase( model ){

    _lowerLimit = false;
    _upperLimit = false;

    if ( type == "LowerLimit" ) {

        _lowerLimit = true;

    }
    else if ( type == "UpperLimit" ) {

        _upperLimit = true;

    }
    else if ( type != "Measurement" ) {

        throw ConfigurationException( "Type " + type + " not known." );

    }

    std::string name = ptree.get<std::string>( "Name" );

    _measuredValue = ptree.get<double>( "Measurement" );
    std::string predictionName = ptree.get<std::string>( "Prediction" );
    _prediction = model->GetCollectionOfQuantities().At( predictionName );

    _lowerBound = ptree.get<double>( "LowerBound", - std::numeric_limits<double>::infinity() );
    _upperBound = ptree.get<double>( "UpperBound", + std::numeric_limits<double>::infinity() );

    BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree.get_child("Uncertainties")  ) {

                    UncertaintyBase* uncertainty;

                    if ( node.first == "AbsoluteUncertainty" ) {


                    }
                    else if ( node.first == "RelativeTheoryUncertainty" ) {


                    }
                    else if ( node.first == "AstroExclusion" ) {


                    }

    }



}

Fittino::Measurement::~Measurement() {

}


void Fittino::Measurement::CalculatePredictions()  {

    _deviation = _prediction->GetValue() - _measuredValue;

    if ( ( _lowerLimit && _deviation > 0 ) || ( _upperLimit && _deviation < 0 )  ) {

        _deviation = 0;

    }

    // update all the uncertainties and get their values and calculate the total uncertainty

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
