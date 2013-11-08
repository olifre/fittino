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
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "CMSSMModel.h"
#include "Configuration.h"
#include "ConfigurationException.h"
#include "ContourPlotter.h"
#include "DataStorageBase.h"
#include "Factory.h"
#include "FeynHiggsModelCalculator.h"
#include "GeneticAlgorithmOptimizer.h"
#include "HDim6ModelCalculator.h"
#include "HDim6Model.h"
#include "HECModel.h"
#include "HiggsSignalsHadXSModelCalculator.h"
#include "HiggsSignalsSLHAModelCalculator.h"
#include "MarkovChainSampler.h"
#include "MinuitOptimizer.h"
#include "ModelBase.h"
#include "MSSM3Model.h"
#include "OptimizerBase.h"
#include "ParticleSwarmOptimizer.h"
#include "PlotterBase.h"
#include "RegressionCalculator.h"
#include "RosenbrockModel.h"
#include "SamplerBase.h"
#include "ScatterPlotter.h"
#include "SimpleSampler.h"
#include "SimulatedAnnealingOptimizer.h"
#include "SummaryPlotter.h"
#include "XMLDataStorage.h"
#include "CovariantSampler.h"
#include "CorrelatedSampler.h"
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

    if ( type == "SimpleSampler" ) {

        return new SimpleSampler( model, ptree );

    }
    else if ( type == "MarkovChainSampler" ) {

      return new MarkovChainSampler( model, ptree );

    }
    else {

      throw ConfigurationException( "AnalysisTool type" + type + " not known." );
    
    }

}

Fittino::ModelCalculatorBase* Fittino::Factory::CreateCalculator( const std::string& type, const PhysicsModelBase* model, const boost::property_tree::ptree& ptree ) const {

    if ( type == "HDim6Calculator" ) {

#if defined LHAPDF_FOUND  && defined HIGGSBOUNDS_FOUND && defined HIGGSSIGNALS_FOUND
      
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
        
      return new LHCModelCalculator( model );

    }
    else if ( type == "TreeCalculator" ) {
    
      return new TreeCalculator( model );

    }
    else if ( type == "FeynHiggsCalculator" ) {

#if defined FEYNHIGGS

            return new FeynHiggsModelCalculator( model );

#else

            throw ConfigurationException( "Trying to use FeynHiggsCalculator but Fittino was built without FeynHiggs." );

#endif
    }
    else if ( type == "SPhenoCalculator" ) {

      return new SPhenoSLHAModelCalculator( model );
    
    }

    else {

      throw ConfigurationException( "Calculator type" + type + "not known." );

    }

}


Fittino::DataStorageBase* const Fittino::Factory::CreateDataStorage( const Fittino::Configuration::FileFormat& fileFormat ) const {

    switch ( fileFormat ) {

        case Configuration::XML:
            return new XMLDataStorage();

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

Fittino::ModelBase* const Fittino::Factory::CreateModel( const Fittino::Configuration::ModelType& modelType ) const {

    switch ( modelType ) {

        case Configuration::CMSSM:
            return new CMSSMModel();

        case Configuration::HDIM6:
            return new HDim6Model();

        case Configuration::HEC:

#if defined(HIGGSBOUNDS_FOUND) && defined(HIGGSSIGNALS_FOUND)

            return new HECModel();

#else

            throw ConfigurationException( "Trying to use HECModel but Fittino was built without HIGGSBOUNDS and/or HIGGSSIGNALS." );

#endif

        case Configuration::MSSM3:
            return new MSSM3Model();

        case Configuration::ROSENBROCK:
            return new RosenbrockModel();

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

        case Configuration::FEYNHIGGSCALCULATOR:

#if defined FEYNHIGGS

            return new FeynHiggsModelCalculator( model );

#else

            throw ConfigurationException( "Trying to use FeynHiggsCalculator but Fittino was built without FeynHiggs." );

#endif

        case Configuration::HIGGSSIGNALSSLHACALCULATOR:

#if defined(HIGGSBOUNDS_FOUND) && defined(HIGGSSIGNALS_FOUND)

            return new HiggsSignalsSLHAModelCalculator( model );

#else

            throw ConfigurationException( "Trying to use HiggsSignalsHadXSModelCalculator but Fittino was built without HiggsBounds or HiggsSignals." );

#endif

        case Configuration::TREECALCULATOR:

            return new TreeCalculator( model );

        case Configuration::SPHENOSLHACALCULATOR:

            return new SPhenoSLHAModelCalculator( model );

        case Configuration::LHCCALCULATOR:

            return new LHCModelCalculator( model );

    }

}

Fittino::OptimizerBase* const Fittino::Factory::CreateOptimizer( const Fittino::Configuration::OptimizerType& optimizerType, Fittino::ModelBase* model, int randomSeed ) const {

    switch ( optimizerType ) {

        case Configuration::GENETICALGORITHM:
            return new GeneticAlgorithmOptimizer( model, randomSeed );

        case Configuration::MINUIT:
            return new MinuitOptimizer( model, randomSeed );

        case Configuration::PARTICLESWARM:
            return new ParticleSwarmOptimizer( model, randomSeed );

        case Configuration::SIMULATEDANNEALING:
            return new SimulatedAnnealingOptimizer( model, randomSeed );

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

        case Configuration::TREE:
            return new TreeSampler( model, randomSeed );
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

Fittino::Chi2ContributionBase* const Fittino::Factory::CreateChi2Contribution( const std::string& type, const boost::property_tree::ptree& ptree, const Fittino::Collection<Fittino::ModelCalculatorBase*>& calculators ) const {

    ModelCalculatorBase *calculator = calculators.At( ptree.get<std::string>( "CalculatorName") );

    if( type == "SLHAChi2Contribution" ) {

      return new SLHAChi2Contribution( ptree, static_cast<SLHAModelCalculatorBase*>(calculator) );

    }
    else if( type == "LHCChi2Contribution" ) {

      return new LHCChi2Contribution( ptree, static_cast<LHCModelCalculator*>(calculator) );

    }

}
