/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Chi2Calculator.cpp                                               *
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
#include <boost/foreach.hpp>

#include "TMath.h"

#include "Factory.h"
#include "ModelBase.h"
#include "Chi2Calculator.h"
#include "Measurement.h"
#include "RandomGenerator.h"
#include "SimplePrediction.h"
#include "LHCChi2Calculator.h"

Fittino::Chi2Calculator::Chi2Calculator( const Fittino::ModelBase* model, const boost::property_tree::ptree &ptree )
        : CalculatorBase( model ) {

    _name = ptree.get<std::string>( "Name", "Chi2Calculator" );
    _tag = ptree.get<std::string>( "Tag", _name );

    _chi2 = new Quantity( "Chi2", "", 0, 0, 0 );
    AddQuantity( _chi2 );

    Factory factory;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree ) {

                    if ( node.first == "UpperLimit" || node.first == "LowerLimit" || node.first == "Measurement" ) {

                        Measurement *measurement = new Measurement(node.first, _measurements.size(), model, node.second);

                        for (unsigned int iQuantity = 0; iQuantity < measurement->GetCollectionOfQuantities().GetNumberOfElements(); iQuantity++) {

                            AddQuantity(measurement->GetCollectionOfQuantities().At(iQuantity));

                        }

                        _measurements.push_back(measurement);

                    }

                }

    _initialPredictions.ResizeTo( _measurements.size() );
    _initialUncertainties.resize( _measurements.size() );

    for ( unsigned int i = 0; i < _measurements.size(); i++ ) {

        _initialPredictions[i] = _measurements.at(i)->GetPredictedValue();
        _initialUncertainties[i] = _measurements.at(i)->GetTotalUncertainty();

    }

    bool toyRun = ptree.get<bool>( "ToyRun", false );

    bool smear = toyRun;

    while ( smear ) {

        SmearMeasurements();
        smear = ! MeasurementsAreWithinBounds();

    }

    CalculatePredictions();

}

Fittino::Chi2Calculator::~Chi2Calculator() {

}

void Fittino::Chi2Calculator::CalculatePredictions() {

    double chi2 = 0;

    for ( unsigned int i = 0; i < _measurements.size(); i++ ) {

        _measurements[i]->CalculatePredictions();
        chi2 += _measurements[i]->GetCollectionOfQuantities().At( "Chi2" )->GetValue();

    }

    _chi2->SetValue( chi2 );

}

void Fittino::Chi2Calculator::SmearMeasurements() {


    for ( unsigned int i = 0; i < _measurements.size(); i++ ) {

        double smearedMeasurement = RandomGenerator::GetInstance()->Gaus(_initialPredictions[i], _initialUncertainties[i]);

        _measurements[i]->SetMeasuredValue( smearedMeasurement );

    }

}

bool Fittino::Chi2Calculator::MeasurementsAreWithinBounds() {

    for ( unsigned int i = 0; i < _measurements.size(); i ++ ) {

        if ( ! _measurements.at( i )->IsWithinBounds() ) {

            return false;
        }

    }

    return true;

}
