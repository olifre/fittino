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

#include <set>
#include <string>

#include <boost/property_tree/ptree.hpp>

#include "TDecompBK.h"
#include "TMath.h"

#include "CalculatorException.h"
#include "Chi2Calculator.h"
#include "Correlation.h"
#include "Factory.h"
#include "ModelBase.h"
#include "Measurement.h"
#include "RandomGenerator.h"
#include "SimplePrediction.h"

Fittino::Chi2Calculator::Chi2Calculator( const Fittino::ModelBase* model, const boost::property_tree::ptree &ptree )
        : CalculatorBase( model, &ptree ) {
            
    SetName( "Chi2Calculator" );

    AddOutput( "Chi2"          , _chi2);
    AddOutput( "CorrelatedChi2",  _correlatedChi2 );

    for ( const auto& node : *GetConfiguration() ) {

        if ( node.first != "Observable" ) continue;

        AddObservable( node.second );

    }

    for ( const auto& node : *GetConfiguration() ) {

        if ( node.first != "Correlation" ) continue;

        AddCorrelation( node.second );

    }

    _inverted = false;

    _cov                 .ResizeTo( _observables.size(), _observables.size() );
    _invCov              .ResizeTo( _observables.size(), _observables.size() );
    _lastCov             .ResizeTo( _observables.size(), _observables.size() );
    _deviations          .ResizeTo( _observables.size()                       );
    _deviationsTransposed.ResizeTo( _observables.size()                       );
    _initialPredictions  .ResizeTo( _observables.size()                       );
    _initialUncertainties.resize  ( _observables.size()                       );

    for ( unsigned int i = 0; i < _observables.size(); ++i ) {

        _initialPredictions  [i] = _observables.at(i)->GetPrediction();
        _initialUncertainties[i] = _observables.at(i)->GetTotalUncertainty();

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

    _lastCov = _cov;
    _cov.Zero();

    _chi2 = 0;

    for ( unsigned int i = 0; i < _observables.size(); i++ ) {

        auto obs = _observables[i];

        obs->Update();

        _chi2 += obs->GetChi2();

        _deviations[i] = obs->GetDeviation();
        _cov[i][i] = TMath::Power( obs->GetTotalUncertainty(), 2 );

    }

    _correlatedChi2 = _chi2;

    if ( _correlations.empty() ) return;

    for ( auto correlation : _correlations ) {

        correlation->Update();

        auto i = correlation->GetID().second.first;
        auto j = correlation->GetID().second.second;

        _cov[i][j] += correlation->GetCovariance();
        _cov[j][i] += _cov[i][j];

    }

    _inverted = _inverted && _cov == _lastCov;
    if ( !_inverted ) InvertCovarianceMatrix();
    _inverted = true;

    _deviationsTransposed = _deviations;
    _deviationsTransposed *= _invCov;
    _correlatedChi2 = _deviationsTransposed * _deviations;

}

void Fittino::Chi2Calculator::SmearMeasurements() {

    for ( unsigned int i = 0; i < _observables.size(); i++ ) {

        double smearedMeasurement = RandomGenerator::GetInstance()->Gaus(_initialPredictions[i], _initialUncertainties[i]);

        _observables[i]->SetMeasurement(smearedMeasurement);

    }

}

bool Fittino::Chi2Calculator::MeasurementsAreWithinBounds() {

    for ( unsigned int i = 0; i < _observables.size(); i ++ ) {

        if ( ! _observables.at( i )->IsWithinBounds() ) return false;

    }

    return true;

}

void Fittino::Chi2Calculator::AddCorrelation(boost::property_tree::ptree ptree) {

    auto correlation = new Correlation( _constObservables, ptree );

    _correlations.push_back( correlation );

    auto id = correlation->GetID();

    if ( _correlationIDs.insert( id ).second ) return;

    std::string message = "Correlation " + id.first + " configured multiple times between the observables ";
    message+= _observables[ id.second.first ]->GetName() + " and " + _observables[ id.second.second ]->GetName() + ".";

    throw ConfigurationException( message );

}

void Fittino::Chi2Calculator::AddObservable( boost::property_tree::ptree ptree ) {

    auto observable = new Measurement( _model, ptree );

    if ( !_observableNames.insert( observable->GetName() ).second ) {

        throw ConfigurationException( "Measurement with name " + observable->GetName() + " declared multiple times." );

    }

    AddOutput(  "Measurement_" + observable->GetName(), observable->GetMeasurement() );
    AddOutput(  "Deviation_" + observable->GetName(), observable->GetDeviation() );
    AddOutput(  "Pull_" + observable->GetName(), observable->GetPull() );
    AddOutput(  "Chi2_" + observable->GetName(), observable->GetChi2() );

    _observables.push_back(observable);
    _constObservables.push_back( observable );

}

void Fittino::Chi2Calculator::InvertCovarianceMatrix() {

    TDecompBK decomp( _cov );

    if ( !decomp.Invert( _invCov ) ) {

        throw CalculatorException( _name, "Matrix inversion failed.");

    }

}
