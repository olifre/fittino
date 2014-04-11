/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Factory.cpp                                                      *
*                                                                              *
* Description Factory class for creating input file interpreters, models,      *
*             optimizers and samplers                                          *
*                                                                              *
* Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "AstroCalculator.h"
#include "AstroFitCalculator.h"
#include "CheckVacuumCalculator.h"
#include "ContourPlotter.h"
#include "CorrelatedSampler.h"
#include "CovariantSampler.h"
#include "Factory.h"

#ifdef FEYNHIGGS
#include "FeynHiggsCalculator.h"
#endif

#include "FormulaCalculator.h"
#include "GeneticAlgorithmOptimizer.h"
#include "HDim6Calculator.h"
#include "HECCalculator.h"
#include "HiggsSignalsHadXSCalculator.h"
#include "HiggsSignalsSLHACalculator.h"
#include "LHCLimitCalculator.h"
#include "MarkovChainSampler.h"
#include "MicromegasCalculator.h"
#include "MinuitOptimizer.h"
#include "NewCorrelatedSampler.h"
#include "Observable.h"
#include "ParticleSwarmOptimizer.h"
#include "PhysicsModel.h"
#include "RegressionCalculator.h"
#include "RosenbrockModel.h"
#include "ScatterPlotter.h"
#include "SimpleOptimizer.h"
#include "SimplePrediction.h"
#include "SimpleSampler.h"
#include "SimulatedAnnealingOptimizer.h"
#include "SLHAeaSLHADataStorage.h"
#include "SPhenoSLHACalculator.h"
#include "SummaryPlotter.h"
#include "SuperIsoCalculator.h"
#include "TreeCalculator.h"
#include "TreeSampler.h"

Fittino::Factory::Factory() {

}

Fittino::Factory::~Factory() {

}

Fittino::AnalysisTool* const Fittino::Factory::CreateAnalysisTool( const std::string& type, ModelBase* model,
                                                                   const boost::property_tree::ptree& ptree ) const {

    if ( type == "ContourPlotter" ) {

        return new ContourPlotter( model, ptree );

    }
    else if ( type == "GeneticAlgorithmOptimizer" ) {

        return new GeneticAlgorithmOptimizer( model, ptree );

    }
    else if ( type == "MinuitOptimizer" ) {

        return new MinuitOptimizer( model, ptree );

    }
    else if ( type == "MarkovChainSampler" ) {

        return new MarkovChainSampler( model, ptree );

    }
    else if ( type == "ParticleSwarmOptimizer" ) {

        return new ParticleSwarmOptimizer( model, ptree );

    }
    else if ( type == "ScatterPlotter" ) {

        return new ScatterPlotter( model, ptree );
    }
    else if ( type == "SimpleOptimizer" ) {

        return new SimpleOptimizer( model, ptree );

    }
    else if ( type == "SimpleSampler" ) {

        return new SimpleSampler( model, ptree );

    }
    else if ( type == "SummaryPlotter" ) {

        return new SummaryPlotter( model, ptree );

    }
    else if ( type == "SimulatedAnnealingOptimizer" ) {

        return new SimulatedAnnealingOptimizer( model, ptree );

    }
    else if ( type == "TreeSampler" ) {

        return new TreeSampler( model, ptree );

    }
    else {

        throw ConfigurationException( "AnalysisTool type " + type + " not known." );

    }

}

Fittino::SLHADataStorageBase* Fittino::Factory::CreateSLHAeaSLHADataStorage() {

#if defined SLHAEA

    return new SLHAeaSLHADataStorage();

#else

    throw ConfigurationException( "Trying to use SLHAeaSLHADataStorage but Fittino was built without SLHAEA." );

#endif

}

Fittino::CalculatorBase* Fittino::Factory::CreateCalculator( const std::string& type, const PhysicsModel* model, const boost::property_tree::ptree& ptree ) const {

    if ( type == "AstroFitCalculator" ) {

        return new AstroFitCalculator( model, ptree );

    }

    else if ( type == "CheckVacuumCalculator" ) {

        return new CheckVacuumCalculator( model, ptree );

    }

    else if ( type == "HDim6Calculator" ) {

#if defined LHAPDF_FOUND  && defined HIGGSBOUNDS_FOUND && defined HIGGSSIGNALS_FOUND && defined GSL

        return new HDim6Calculator( model, ptree );

#else

        throw ConfigurationException( "Trying to use HDim6Calculator but Fittino was built without LHAPDF." );

#endif

    }
    else if ( type == "HECCalculator" ) {

        return new HECCalculator( model, ptree );

    }
    else if ( type == "HiggsSignalsCalculator" ) {

#if defined HIGGSBOUNDS_FOUND && defined HIGGSSIGNALS_FOUND

        return new HiggsSignalsHadXSCalculator( model, ptree );

#else

        throw ConfigurationException( "Trying to use HiggsSignalsHadXSCalculator but Fittino was built without HiggsBounds or HiggsSignals." );

#endif

    }
    else if ( type == "HiggsSignalsSLHACalculator" ) {

#if defined HIGGSBOUNDS_FOUND && defined HIGGSSIGNALS_FOUND

        return new HiggsSignalsSLHACalculator( model, ptree );

#else

        throw ConfigurationException( "Trying to use HiggsSignalsSLHACalculator but Fittino was built without HiggsBounds or HiggsSignals." );

#endif

    }
    else if ( type == "FormulaCalculator" ) {

        return new FormulaCalculator( model, ptree );

    }
    else if ( type == "MicromegasCalculator" ) {

#ifdef MICROMEGAS

        return new MicromegasCalculator( model, ptree );

#else

        throw ConfigurationException( " Trying to use MicromegasCalculator but Fittino was built without Micromegas." );

#endif

    }
    else if ( type == "RegressionCalculator" ) {

        return new RegressionCalculator( model, ptree );

    }
    else if ( type == "LHCCalculator" ) {

        return new LHCLimitCalculator( model, ptree );

    }
    else if ( type == "TreeCalculator" ) {

        return new TreeCalculator( model, ptree );

    }
    else if( type == "AstroCalculator" ) {

        return new AstroCalculator( model, ptree );

    }
    else if ( type == "FeynHiggsNativeCalculator" )  {

#if defined FEYNHIGGS

        return new FeynHiggsCalculator( model, ptree, "FeynHiggs" );

#else

        throw ConfigurationException( "Trying to use FeynHiggsCalculator but Fittino was built without FeynHiggs." );

#endif

    }
    else if ( type == "FeynHiggsSLHACalculator" ) {

#if defined FEYNHIGGS

        return new FeynHiggsCalculator( model, ptree, "SLHA" );

#else

        throw ConfigurationException( "Trying to use FeynHiggsSLHACalculator but Fittino was built without FeynHiggs." );

#endif

    }
    else if ( type == "SPhenoCalculator" ) {

        return new SPhenoSLHACalculator( model, ptree );

    }
    else if ( type == "SuperIsoCalculator" ) {

#ifdef SUPERISO

        return new SuperIsoCalculator( model, ptree );

#else

        throw ConfigurationException( "Trying to use SuperIsoCalculator but Fittino was built without SuperIso." );

#endif

    }
    else {

        throw ConfigurationException( "Calculator type" + type + "not known." );

    }

}

Fittino::ModelBase* const Fittino::Factory::CreateModel( const std::string& type, const boost::property_tree::ptree& ptree ) const {

    if ( type == "PhysicsModel" ) {

        return new PhysicsModel( ptree );

    }
    else if ( type == "RosenbrockModel" ) {

        return new RosenbrockModel( ptree );

    }

}

Fittino::PredictionBase* const Fittino::Factory::CreatePrediction( const boost::property_tree::ptree& ptree, const Fittino::CalculatorBase* calculator ) {

    std::string type = ptree.get<std::string>( "PredictionType", "NONE" );

    if ( type == "Simple" ) {

        return new SimplePrediction( ptree, calculator );

    }
    else {

        throw ConfigurationException( "Prediction type " + type + " not known, or requires a more specific definition of the calculator than CalculatorBase." );

    }

}

Fittino::Observable* const Fittino::Factory::CreateObservable( const boost::property_tree::ptree& ptree, const Fittino::Collection<Fittino::CalculatorBase*>& calculators ) const {

    std::string type = ptree.get<std::string>( "PredictionType" );

    CalculatorBase *calculator = calculators.At( ptree.get<std::string>( "CalculatorName" ) );

    if ( type == "Simple" ) {

        return new Observable( ptree, new SimplePrediction( ptree, calculator ) );

    }
    else {

        throw ConfigurationException( "Prediction type" + type + " not known." );

    }

}

Fittino::Observable* const Fittino::Factory::CreateObservable( const boost::property_tree::ptree& ptree, const Fittino::Collection<Fittino::PredictionBase*>& predictions, const Fittino::Collection<Fittino::CalculatorBase*>& calculators ) const {

    std::string name = ptree.get<std::string>( "PredictionName", "NONE" );
    for ( unsigned int i = 0; i < predictions.GetNumberOfElements(); ++i ) {

        if ( name == predictions.At( i )->GetName() ) {

            return new Observable( ptree, predictions.At( i ) );

        }

    }

    return CreateObservable( ptree, calculators );

}
