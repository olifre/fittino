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
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "CMSSMModel.h"
//#include "ContourPlotter.h"
#include "DataStorageBase.h"
#include "Factory.h"
#include "GeneticAlgorithmOptimizer.h"
#include "HECModel.h"
#include "MarkovChainSampler.h"
#include "MinuitOptimizer.h"
#include "ModelBase.h"
#include "OptimizerBase.h"
#include "ParticleSwarmOptimizer.h"
//#include "PlotterBase.h"
#include "RosenbrockModel.h"
#include "SamplerBase.h"
//#include "ScatterPlotter.h"
#include "SimpleSampler.h"
#include "SimulatedAnnealingOptimizer.h"
#include "XMLDataStorage.h"

Fittino::Factory::Factory() {

}

Fittino::Factory::~Factory() {

}

Fittino::DataStorageBase* const Fittino::Factory::CreateDataStorage( const Fittino::Configuration::FileFormat& fileFormat ) const {

    switch ( fileFormat ) {

        case Configuration::XML:
            return new XMLDataStorage();

    }

}

Fittino::ModelBase* const Fittino::Factory::CreateModel( const Fittino::Configuration::ModelType& modelType ) const {

    switch ( modelType ) {

        case Configuration::HEC:
            return new HECModel();

        case Configuration::CMSSM:
            return new CMSSMModel();

        case Configuration::ROSENBROCK:
            return new RosenbrockModel();

    }

}

Fittino::OptimizerBase* const Fittino::Factory::CreateOptimizer( const Fittino::Configuration::OptimizerType& optimizerType, Fittino::ModelBase* model ) const {

    switch ( optimizerType ) {

        case Configuration::GENETICALGORITHM:
            return new GeneticAlgorithmOptimizer( model );

        case Configuration::MINUIT:
            return new MinuitOptimizer( model );

        case Configuration::PARTICLESWARM:
            return new ParticleSwarmOptimizer( model );

        case Configuration::SIMULATEDANNEALING:
            return new SimulatedAnnealingOptimizer( model );

    }

}

//Fittino::PlotterBase* const Fittino::Factory::CreatePlotter( const Fittino::Configuration::PlotterType& plotterType, Fittino::ModelBase* model, std::string dataFileName ) const {
//
//    switch ( plotterType ) {
//
//        case Configuration::CONTOUR:
//            return new ContourPlotter( model, dataFileName );
//
//        case Configuration::SCATTER:
//            return new ScatterPlotter( model, dataFileName );
//
//    }
//
//}

Fittino::SamplerBase* const Fittino::Factory::CreateSampler( const Fittino::Configuration::SamplerType& samplerType, Fittino::ModelBase* model ) const {

    switch ( samplerType ) {

        case Configuration::MARKOVCHAIN:
            return new MarkovChainSampler( model );

        case Configuration::SIMPLE:
            return new SimpleSampler( model );

    }

}
