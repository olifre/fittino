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

const Fittino::InputFileInterpreterBase* const Fittino::Factory::CreateInputFileInterpreter( const Fittino::InputFileInterpreterBase::InputFileFormat& inputFileFormat ) const {

    switch ( inputFileFormat ) {

        case Fittino::InputFileInterpreterBase::XMLINPUTFILE:
            return new XMLInputFileInterpreter();

        case Fittino::InputFileInterpreterBase::FITTINOINPUTFILE:
            return new FittinoInputFileInterpreter();

    }

}

Fittino::ModelBase* const Fittino::Factory::CreateModel( const Fittino::ModelBase::ModelType& modelType ) const {

    switch ( modelType ) {

        case Fittino::ModelBase::MSUGRA:
            return new MSUGRAModel();

        case Fittino::ModelBase::ROSENBROCK:
            return new RosenbrockModel();

    }

}

Fittino::OptimizerBase* const Fittino::Factory::CreateOptimizer( const Fittino::OptimizerBase::OptimizerType& optimizerType, Fittino::ModelBase* model ) const {

    switch ( optimizerType ) {

        case Fittino::OptimizerBase::MINUIT:
            return new MinuitOptimizer( model );

        case Fittino::OptimizerBase::PARTICLESWARM:
            return new ParticleSwarmOptimizer( model );

        case Fittino::OptimizerBase::SIMULATEDANNEALING:
            return new SimulatedAnnealingOptimizer( model );

    }

}

Fittino::SamplerBase* const Fittino::Factory::CreateSampler( const Fittino::SamplerBase::SamplerType& samplerType, Fittino::ModelBase* model ) const {

    switch ( samplerType ) {

        case Fittino::SamplerBase::MARKOVCHAIN:
            return new MarkovChainSampler( model );

    }

}
