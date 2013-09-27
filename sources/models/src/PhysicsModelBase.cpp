/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsModelBase.cpp                                             *
*                                                                              *
* Description Base class for Fittino physics models                            *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*       published by the Free Software Foundation; either version 3 of   *
*       the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>

#include <cmath>

#include "Factory.h"
#include "Chi2ContributionBase.h"
#include "Messenger.h"
#include "ModelCalculatorBase.h"
#include "ModelParameterBase.h"
#include "Observable.h"
#include "PhysicsModelBase.h"
#include "PredictionBase.h"
#include "SimplePrediction.h"
#include "Collection.h"
#include "Configuration.h"
#include "TreeCalculator.h"
#include "FeynHiggsModelCalculator.h"
#include "FeynHiggsSLHAModelCalculator.h"
#include "HDim6ModelCalculator.h"
#include "HiggsSignalsHadXSModelCalculator.h"
#include "HiggsSignalsSLHAModelCalculator.h"
#include "SPhenoSLHAModelCalculator.h"

Fittino::PhysicsModelBase::PhysicsModelBase() {

    InitializeCalculators();
    InitializeObservables();

}

Fittino::PhysicsModelBase::~PhysicsModelBase() {

}

double Fittino::PhysicsModelBase::Evaluate() {

    // Let the calculators calculate the model predictions.

    for ( unsigned int i = 0; i < _modelCalculatorVector.size(); ++i ) {

        _modelCalculatorVector[i]->CalculatePredictions();

    }

    // Instruct the observables to update their predicted values.

    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        _observableVector[i]->UpdatePrediction();

    }

    // Update any further predictions.

    for ( unsigned int i = 0; i < _predictionVector.size(); ++i ) {

        _predictionVector[i]->Update();

    }

    // Update additional chi2 terms.

    for ( unsigned int i = 0; i < _chi2ContributionVector.size(); ++i ) {

        _chi2ContributionVector[i]->UpdateValue();

    }

    // Calculate and return the resulting chi2.

    return PhysicsModelBase::CalculateChi2();

}

void Fittino::PhysicsModelBase::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "   Set of the " << this->GetName() << " parameters:" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); ++i ) {

        GetParameterVector()->at( i )->PrintStatus();

    }

    if ( _observableVector.size() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of the " << this->GetName() << " observables:"  << Messenger::Endl;
        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "    Observable          Predicted value                 Measured value    Deviation" << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

            _observableVector[i]->PrintStatus();

        }

    }

    if ( _predictionVector.size() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of the " << this->GetName() << " predictions:"  << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _predictionVector.size(); ++i ) {

            _predictionVector[i]->PrintStatus();

        }

    }

    if ( _chi2ContributionVector.size() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of chi2 terms:"  << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _chi2ContributionVector.size(); ++i ) {

            _chi2ContributionVector[i]->PrintStatus();

        }

    }

}

void Fittino::PhysicsModelBase::Initialize() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "   Initializing the list of model parameters" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        GetParameterVector()->at( i )->PrintStatus();

    }

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::ALWAYS << "   Initializing the list of model calculators" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;


    for ( unsigned int i = 0; i < _modelCalculatorVector.size(); i++ ) {

        messenger << Messenger::ALWAYS << "    Initializing " << _modelCalculatorVector[i]->GetName() << Messenger::Endl;

        _modelCalculatorVector[i]->Initialize();

    }

    messenger << Messenger::ALWAYS << Messenger::Endl;

}

double Fittino::PhysicsModelBase::CalculateChi2() {

    double chi2 = 0.;

    // Calculate the chi2 contributions of all observables. Eventually replace
    // this formula to allow for correlated observables.

    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        chi2 += pow( ( _observableVector[i]->GetPrediction()->GetValue() - _observableVector[i]->GetMeasuredValue() ) / _observableVector[i]->GetMeasuredError(), 2 );

    }

    // Add additional chi2 terms.

    for ( unsigned int i = 0; i < _chi2ContributionVector.size(); ++i ) {

        chi2 += _chi2ContributionVector[i]->GetValue();

    }

    return chi2;

}

void Fittino::PhysicsModelBase::SmearObservables( TRandom3* randomGenerator ) {

    for( int i = 0; i < _observableVector.size(); ++i ) {

        _observableVector[i]->SmearMeasuredValue( randomGenerator );

    }
}

std::vector<Fittino::ModelCalculatorBase*>* Fittino::PhysicsModelBase::GetModelCalculatorVector() {

    return &_modelCalculatorVector;

}

void Fittino::PhysicsModelBase::AddObservable( Observable* observable ) {

    _observableVector.push_back( observable );
    AddPrediction( observable->GetPrediction() );

}

void Fittino::PhysicsModelBase::AddCalculator( ModelCalculatorBase* calculator ) {

    _collectionOfCalculators.AddElement( calculator->GetName(), calculator );
    _modelCalculatorVector.push_back( calculator );

}

const Fittino::Collection<Fittino::ModelCalculatorBase*>& Fittino::PhysicsModelBase::GetCollectionOfCalculators() const {

    return _collectionOfCalculators;

}

void Fittino::PhysicsModelBase::InitializeCalculators() {

    const Factory factory;

    Configuration *configuration = Configuration::GetInstance();
    const boost::property_tree::ptree* propertyTree = configuration->GetPropertyTree();

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & v, propertyTree->get_child( "InputFile" ) ) {
        if ( v.first == "Calculator" ) {
            std::string calculatorType = v.second.get<std::string>( "<xmlattr>.Type" );
            if ( calculatorType == "Tree" ) {
                
                AddCalculator( factory.CreateCalculator( Configuration::TREECALCULATOR, this ) );

            }

            else if ( calculatorType == "FeynHiggs" ) {

                AddCalculator( factory.CreateCalculator( Configuration::FEYNHIGGSCALCULATOR, this ) );

            }

            else if ( calculatorType == "FeynHiggsSLHA" ) {

                AddCalculator( factory.CreateCalculator( Configuration::FEYNHIGGSSLHACALCULATOR, this ) );

            }

            else if ( calculatorType == "HDim6" ) {

                AddCalculator( factory.CreateCalculator( Configuration::HDIM6CALCULATOR, this ) );

            }

            else if ( calculatorType == "HiggsSignalsHadXS" ) {

                AddCalculator( factory.CreateCalculator( Configuration::HIGGSSIGNALSHADXSCALCULATOR, this ) );

            }

            else if ( calculatorType == "HiggsSignalsSLHA" ) {

                AddCalculator( factory.CreateCalculator( Configuration::HIGGSSIGNALSSLHACALCULATOR, this ) );

            }

            else if ( calculatorType == "SPhenoSLHA" ) {

                AddCalculator( factory.CreateCalculator( Configuration::SPHENOSLHACALCULATOR, this ) );

            }

        }

    }

}

void Fittino::PhysicsModelBase::InitializeObservables() {

    Configuration *configuration = Configuration::GetInstance();
    const boost::property_tree::ptree* propertyTree = configuration->GetPropertyTree();

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & v, propertyTree->get_child( "InputFile" ) ) {
        if ( v.first == "Observable" ) {

            AddObservable( new Observable( new SimplePrediction( v.second.get<std::string>( "<xmlattr>.Name" ), v.second.get<std::string>( "<xmlattr>.Name" ), "", "", v.second.get<double>( "<xmlattr>.MeasuredValue" ) - 10 * v.second.get<double>( "<xmlattr>.Error1" ), v.second.get<double>( "<xmlattr>.MeasuredValue" ) + 10 * v.second.get<double>( "<xmlattr>.Error1" ), _collectionOfCalculators.At( v.second.get<std::string>( "<xmlattr>.CalculatorName" ) ) ), v.second.get<double>( "<xmlattr>.MeasuredValue" ), v.second.get<double>( "<xmlattr>.Error1" ), v.second.get<double>( "<xmlattr>.BestFitPrediction", 0. ) ) );

        }
    }

}
