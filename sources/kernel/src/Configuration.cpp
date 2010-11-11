/* $Id: Configuration.cpp,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Configuration.cpp                                                *
*                                                                              *
* Description Singleton class for storing and providing access to user-defined *
*             configuration settings                                           *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wiene@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Configuration.h"
#include "ConfigurationException.h"

Fittino::Configuration* Fittino::Configuration::GetInstance() {

    if ( !_instance ) {

        _instance = new Configuration::Configuration();

    }

    return _instance;

}

void Fittino::Configuration::AddSteeringParameter( const std::string& key, const std::string& value ) {

    ( *_steeringParameterMap )[key] = value;

}

Fittino::ExecutionMode::Mode Fittino::Configuration::GetExecutionMode() const {

    const std::string key = "Mode";

    if ( ( *_steeringParameterMap )[key] == "OPTIMIZATION" ) {

        return ExecutionMode::OPTIMIZATION;

    }
    else if ( ( *_steeringParameterMap )[key] == "SCAN" ) {

        return ExecutionMode::SCAN;

    }
    else if ( ( *_steeringParameterMap )[key] == "SAMPLING" ) {

        return ExecutionMode::SAMPLING;

    }
    else {

        throw ConfigurationException( "Configured execution mode unknown." );

    }

}

Fittino::ModelBase::ModelType Fittino::Configuration::GetModelType() const {

    const std::string key = "ModelType";

    if ( ( *_steeringParameterMap )[key] == "MSUGRA" ) {

        return ModelBase::MSUGRA;

    }
    else if ( ( *_steeringParameterMap )[key] == "Rosenbrock" ) {

        return ModelBase::ROSENBROCK;

    }
    else {

        throw ConfigurationException( "Configured model type unknown." );

    }

}

Fittino::OptimizerBase::OptimizerType Fittino::Configuration::GetOptimizerType() const {

    const std::string key = "OptimizerType";

    if ( ( *_steeringParameterMap )[key] == "GeneticAlgorithm" ) {

        return OptimizerBase::GENETICALGORITHM;

    }
    else if ( ( *_steeringParameterMap )[key] == "Minuit" ) {

        return OptimizerBase::MINUIT;

    }
    else if ( ( *_steeringParameterMap )[key] == "ParticleSwarm" ) {

        return OptimizerBase::PARTICLESWARM;

    }
    else if ( ( *_steeringParameterMap )[key] == "SimulatedAnnealing" ) {

        return OptimizerBase::SIMULATEDANNEALING;

    }
    else {

        throw ConfigurationException( "Configured optimizer type unknown." );

    }

}

Fittino::SamplerBase::SamplerType Fittino::Configuration::GetSamplerType() const {

    const std::string key = "SamplerType";

    if ( ( *_steeringParameterMap )[key] == "MarkovChain" ) {

        return SamplerBase::MARKOVCHAIN;

    }
    else {

        throw ConfigurationException( "Configured sampler type unknown." );

    }

}

Fittino::Configuration* Fittino::Configuration::_instance = 0;

Fittino::Configuration::Configuration()
        : _steeringParameterMap( new SteeringParameterMap() ) {

}

Fittino::Configuration::~Configuration() {

    delete _steeringParameterMap;

}
