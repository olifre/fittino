/* $Id: Factory.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

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

#include "DataStorageBase.h"
#include "Factory.h"
#include "GeneticAlgorithmOptimizer.h"
#include "MarkovChainSampler.h"
#include "MinuitOptimizer.h"
#include "MSUGRAModel.h"
#include "ModelBase.h"
#include "OptimizerBase.h"
#include "ParticleSwarmOptimizer.h"
#include "RosenbrockModel.h"
#include "SamplerBase.h"
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

        case Configuration::MSUGRA:
            return new MSUGRAModel();

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

Fittino::SamplerBase* const Fittino::Factory::CreateSampler( const Fittino::Configuration::SamplerType& samplerType, Fittino::ModelBase* model ) const {

    switch ( samplerType ) {

        case Configuration::MARKOVCHAIN:
            return new MarkovChainSampler( model );

    }

}
