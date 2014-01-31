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

#include "Configuration.h"
#include "ConfigurationException.h"
#include "ContourPlotter.h"
#include "DataStorageBase.h"
#include "Factory.h"
#include "FeynHiggsModelCalculator.h"
#include "FeynHiggsSLHAModelCalculator.h"
#include "GeneticAlgorithmOptimizer.h"
#include "HDim6ModelCalculator.h"
#include "HECModel.h"
#include "HiggsSignalsHadXSModelCalculator.h"
#include "HiggsSignalsSLHAModelCalculator.h"
#include "MarkovChainSampler.h"
#include "MinuitOptimizer.h"
#include "ModelBase.h"
#include "OptimizerBase.h"
#include "ParticleSwarmOptimizer.h"
#include "PlotterBase.h"
#include "RegressionCalculator.h"
#include "RosenbrockModel.h"
#include "SamplerBase.h"
#include "ScatterPlotter.h"
#include "SimpleSampler.h"
#include "SimulatedAnnealingOptimizer.h"
#include "SLHAeaSLHADataStorage.h"
#include "SummaryPlotter.h"
#include "XMLDataStorage.h"
#include "CovariantSampler.h"
#include "CorrelatedSampler.h"
#include "NewCorrelatedSampler.h"
#include "TreeSampler.h"
#include "TreeCalculator.h"
#include "SPhenoSLHAModelCalculator.h"
#include "LHCModelCalculator.h"
#include "SimplePrediction.h"
#include "SLHAPrediction.h"
#include "Observable.h"
#include "SLHAChi2Contribution.h"
#include "LHCChi2Contribution.h"


Fittino::Factory::Factory() {

}

Fittino::Factory::~Factory() {

}

Fittino::AnalysisTool* const Fittino::Factory::CreateAnalysisTool( const std::string& type, ModelBase* model, const boost::property_tree::ptree& ptree ) const {

    if ( type == "GeneticAlgorithmOptimizer" ) {

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
    else if ( type == "SimpleSampler" ) {

        return new SimpleSampler( model, ptree );

    }
    if ( type == "SimulatedAnnealingOptimizer" ) {

        return new SimulatedAnnealingOptimizer( model, ptree );

    }
    else if ( type == "TreeSampler" ) {

        return new TreeSampler( model, ptree );

    }
    else {

        throw ConfigurationException( "AnalysisTool type " + type + " not known." );

    }

}

Fittino::SLHADataStorageBase* Fittino::Factory::CreateSLHAeaSLHADataStorage(){

#if defined SLHAEA
      
      return new SLHAeaSLHADataStorage();

#else

    throw ConfigurationException( "Trying to use SLHAeaSLHADataStorage but Fittino was built without SLHAEA." );

#endif

}

Fittino::ModelCalculatorBase* Fittino::Factory::CreateCalculator( const std::string& type, const PhysicsModelBase* model, const boost::property_tree::ptree& ptree ) const {

    if ( type == "HDim6Calculator" ) {

#if defined LHAPDF_FOUND  && defined HIGGSBOUNDS_FOUND && defined HIGGSSIGNALS_FOUND && defined GSL
      
      return new HDim6ModelCalculator( model, ptree );

#else

    throw ConfigurationException( "Trying to use HDim6Calculator but Fittino was built without LHAPDF." );

#endif

    }
    else if ( type == "HiggsSignalsCalculator" ) {

#if defined HIGGSBOUNDS_FOUND && defined HIGGSSIGNALS_FOUND

      return new HiggsSignalsHadXSModelCalculator( model, ptree );

#else

      throw ConfigurationException( "Trying to use HiggsSignalsHadXSModelCalculator but Fittino was built without HiggsBounds or HiggsSignals." );

#endif

    }
    else if ( type == "RegressionCalculator" ) {
      
      return new RegressionCalculator( model, ptree );

    }
    else if ( type == "LHCCalculator" ) {
        
      return new LHCModelCalculator( model, ptree );

    }
    else if ( type == "TreeCalculator" ) {
    
      return new TreeCalculator( model, ptree );

    }
    else if ( type == "FeynHiggsCalculator" ) {

#if defined FEYNHIGGS

      return new FeynHiggsModelCalculator( model, ptree );

#else

            throw ConfigurationException( "Trying to use FeynHiggsCalculator but Fittino was built without FeynHiggs." );

#endif
    }
    else if ( type == "FeynHiggsSLHACalculator" ) {

#if defined FEYNHIGGS

      return new FeynHiggsSLHAModelCalculator( model, ptree );

#else

            throw ConfigurationException( "Trying to use FeynHiggsSLHACalculator but Fittino was built without FeynHiggs." );

#endif
    }
    else if ( type == "SPhenoCalculator" ) {

      return new SPhenoSLHAModelCalculator( ptree, model );
    
    }

    else {

      throw ConfigurationException( "Calculator type" + type + "not known." );

    }

}

Fittino::ModelBase* const Fittino::Factory::CreateModel( const std::string& type, const boost::property_tree::ptree& ptree ) const {

    if ( type == "PhysicsModel" ) {

      return new PhysicsModelBase( ptree );

    }
    else if ( type == "RosenbrockModel" ) {
                  
        return new RosenbrockModel( ptree );

    }

}

Fittino::ModelCalculatorBase* const Fittino::Factory::CreateCalculator( const Fittino::Configuration::CalculatorType& calculatorType, const PhysicsModelBase* model ) const {

    switch ( calculatorType ) {

//         case Configuration::HDIM6CALCULATOR:

// #if defined LHAPDF_FOUND  && defined HIGGSBOUNDS_FOUND && defined HIGGSSIGNALS_FOUND

//             return new HDim6ModelCalculator( model );

// #else

//             throw ConfigurationException( "Trying to use HDim6Calculator but Fittino was built without LHAPDF." );

// #endif

//         case Configuration::HIGGSSIGNALSHADXSCALCULATOR:

// #if defined HIGGSBOUNDS_FOUND && defined HIGGSSIGNALS_FOUND

//             return new HiggsSignalsHadXSModelCalculator( model );

// #else

//             throw ConfigurationException( "Trying to use HiggsSignalsHadXSModelCalculator but Fittino was built without HiggsBounds or HiggsSignals." );

// #endif

        case Configuration::HIGGSSIGNALSSLHACALCULATOR:

#if defined(HIGGSBOUNDS_FOUND) && defined(HIGGSSIGNALS_FOUND)

            return new HiggsSignalsSLHAModelCalculator( model );

#else

            throw ConfigurationException( "Trying to use HiggsSignalsHadXSModelCalculator but Fittino was built without HiggsBounds or HiggsSignals." );

#endif

        case Configuration::TREECALCULATOR:

            return new TreeCalculator( model );

        // case Configuration::SPHENOSLHACALCULATOR:

        //     return new SPhenoSLHAModelCalculator( model );

        case Configuration::LHCCALCULATOR:

            return new LHCModelCalculator( model );

    }

}

Fittino::PlotterBase* const Fittino::Factory::CreatePlotter( const Fittino::Configuration::PlotterType& plotterType, Fittino::ModelBase* model, std::string dataFileName, int randomSeed ) const {

    switch ( plotterType ) {

        case Configuration::CONTOUR:
            return new ContourPlotter( model, dataFileName, randomSeed );

        case Configuration::SCATTER:
            return new ScatterPlotter( model, dataFileName, randomSeed );

        case Configuration::SUMMARY:
            return new SummaryPlotter( model, dataFileName, randomSeed );

    }

}

Fittino::SamplerBase* const Fittino::Factory::CreateSampler( const Fittino::Configuration::SamplerType& samplerType, Fittino::ModelBase* model, int randomSeed ) const {

    switch ( samplerType ) {

        case Configuration::MARKOVCHAIN:
            return new MarkovChainSampler( model, randomSeed );

        case Configuration::SIMPLE:
            return new SimpleSampler( model, randomSeed );

        case Configuration::COVARIANT:
            return new CovariantSampler( model, randomSeed );

        case Configuration::CORRELATED :
            return new CorrelatedSampler( model, randomSeed );

        case Configuration::NEWCORRELATED :
            return new NewCorrelatedSampler( model, randomSeed );

        case Configuration::TREE:
            return new TreeSampler( model, randomSeed );
    }

}

Fittino::PredictionBase* const Fittino::Factory::CreatePrediction( const boost::property_tree::ptree& ptree, const Fittino::ModelCalculatorBase* calculator ) {

    std::string type = ptree.get<std::string>( "PredictionType", "NONE" );
    
    if ( type == "Simple" ) {
        
        return new SimplePrediction( ptree, calculator );

    }
    else {

        throw ConfigurationException( "Prediction type " + type + " not known, or requires a more specific definition of the calculator than ModelCalculatorBase." );
    
    }

}

Fittino::PredictionBase* const Fittino::Factory::CreatePrediction( const boost::property_tree::ptree& ptree, Fittino::SLHAModelCalculatorBase* calculator ) {

    std::string type = ptree.get<std::string>( "PredictionType", "NONE" );
    
    if ( type == "SLHA" ) {
        
        return new SLHAPrediction( ptree, calculator );

    }
    else {

        throw ConfigurationException( "Prediction type " + type + " not known, or incompatible with SLHAModelCalculatorBase." );
    
    }
    
}

Fittino::Observable* const Fittino::Factory::CreateObservable( const boost::property_tree::ptree& ptree, const Fittino::Collection<Fittino::ModelCalculatorBase*>& calculators ) const {

    std::string type = ptree.get<std::string>( "PredictionType" );
    
    ModelCalculatorBase *calculator = calculators.At( ptree.get<std::string>( "CalculatorName" ) );
   
    if( type == "Simple" ) {

      return new Observable( ptree, new SimplePrediction( ptree, calculator ) );

    }
    else if( type == "SLHA" ) {
  
      return new Observable( ptree, new SLHAPrediction( ptree, static_cast<SLHAModelCalculatorBase*>(calculator) ) );

    }
    else {

      throw ConfigurationException( "Prediction type" + type + " not known." );
    
    }
    
}

Fittino::Observable* const Fittino::Factory::CreateObservable( const boost::property_tree::ptree& ptree, const Fittino::Collection<Fittino::PredictionBase*>& predictions, const Fittino::Collection<Fittino::ModelCalculatorBase*>& calculators ) const { 

    std::string name = ptree.get<std::string>( "PredictionName", "NONE" );
    for( unsigned int i = 0; i < predictions.GetNumberOfElements(); ++i ) {
        
        if( name == predictions.At( i )->GetName() ) {
            
            return new Observable( ptree, predictions.At( i ) );

        }

    }

    return CreateObservable( ptree, calculators );

}

Fittino::Chi2ContributionBase* const Fittino::Factory::CreateChi2Contribution( const std::string& type, const boost::property_tree::ptree& ptree, const Fittino::Collection<Fittino::ModelCalculatorBase*>& calculators ) const {

    ModelCalculatorBase *calculator = calculators.At( ptree.get<std::string>( "CalculatorName") );

    if( type == "SLHAChi2Contribution" ) {

      return new SLHAChi2Contribution( ptree, static_cast<SLHAModelCalculatorBase*>(calculator) );

    }
    else if( type == "LHCChi2Contribution" ) {

      return new LHCChi2Contribution( ptree, static_cast<LHCModelCalculator*>(calculator) );

    }

}

Fittino::Chi2ContributionBase* const Fittino::Factory::CreateChi2Contribution( const boost::property_tree::ptree& ptree, Fittino::LHCModelCalculator* calculator ) {

    return new LHCChi2Contribution( ptree, calculator );

}
