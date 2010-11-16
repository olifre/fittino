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

#include "Factory.h"
#include "FittinoInputFileInterpreter.h"
#include "GeneticAlgorithmOptimizer.h"
#include "MarkovChainSampler.h"
#include "MinuitOptimizer.h"
#include "MSUGRAModel.h"
#include "ParticleSwarmOptimizer.h"
#include "RosenbrockModel.h"
#include "SimulatedAnnealingOptimizer.h"
#include "XMLInputFileInterpreter.h"

Fittino::Factory::Factory() {

}

Fittino::Factory::~Factory() {

}

const Fittino::InputFileInterpreterBase* const Fittino::Factory::CreateInputFileInterpreter( const Fittino::Configuration::InputFileFormat& inputFileFormat ) const {

    switch ( inputFileFormat ) {

        case Configuration::FITTINOINPUTFILE:
            return new FittinoInputFileInterpreter();

        case Configuration::XMLINPUTFILE:
            return new XMLInputFileInterpreter();

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
