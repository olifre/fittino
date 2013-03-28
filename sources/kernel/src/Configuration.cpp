/* $Id$ */

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
*	      Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
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

        _instance = new Configuration;

    }

    return _instance;

}

void Fittino::Configuration::AddSteeringParameter( const std::string& key, const std::string& value ) {

    ( *_steeringParameterMap )[key] = value;

}

Fittino::Configuration::ExecutionMode Fittino::Configuration::GetExecutionMode() const {

    const std::string key = "Mode";

    if ( ( *_steeringParameterMap )[key] == "OPTIMIZATION" ) {

        return Configuration::OPTIMIZATION;

    }
    else if ( ( *_steeringParameterMap )[key] == "SAMPLING" ) {

        return Configuration::SAMPLING;

    }
    else {

        throw ConfigurationException( "Configured execution mode unknown." );

    }

}

Fittino::Configuration::ModelType Fittino::Configuration::GetModelType() const {

    const std::string key = "ModelType";

    if ( ( *_steeringParameterMap )[key] == "HEC" ) {

        return Configuration::HEC;

    }
    else if ( ( *_steeringParameterMap )[key] == "MSUGRA" ) {

        return Configuration::MSUGRA;

    }
    else if ( ( *_steeringParameterMap )[key] == "Rosenbrock" ) {

        return Configuration::ROSENBROCK;

    }
    else {

        throw ConfigurationException( "Configured model type unknown." );

    }

}

Fittino::Configuration::OptimizerType Fittino::Configuration::GetOptimizerType() const {

    const std::string key = "OptimizerType";

    if ( ( *_steeringParameterMap )[key] == "GeneticAlgorithm" ) {

        return Configuration::GENETICALGORITHM;

    }
    else if ( ( *_steeringParameterMap )[key] == "Minuit" ) {

        return Configuration::MINUIT;

    }
    else if ( ( *_steeringParameterMap )[key] == "ParticleSwarm" ) {

        return Configuration::PARTICLESWARM;

    }
    else if ( ( *_steeringParameterMap )[key] == "SimulatedAnnealing" ) {

        return Configuration::SIMULATEDANNEALING;

    }
    else {

        throw ConfigurationException( "Configured optimizer type unknown." );

    }

}

Fittino::Configuration::SamplerType Fittino::Configuration::GetSamplerType() const {

    const std::string key = "SamplerType";

    if ( ( *_steeringParameterMap )[key] == "MarkovChain" ) {

        return Configuration::MARKOVCHAIN;

    }
    else if ( ( *_steeringParameterMap )[key] == "Simple" ) {

        return Configuration::SIMPLE;

    }
    else {

        throw ConfigurationException( "Configured sampler type unknown." );

    }

}

Fittino::Messenger::VerbosityLevel Fittino::Configuration::GetVerbosityLevel() const {

    const std::string key = "Level";

    if ( ( *_steeringParameterMap )[key] == "INFO" ) {

        return Messenger::INFO;

    }
    else if ( ( *_steeringParameterMap )[key] == "DEBUG" ) {

        return Messenger::DEBUG;

    }
    else if ( ( *_steeringParameterMap )[key] == "VERBOSE" ) {

        return Messenger::VERBOSE;

    }
    else if ( ( *_steeringParameterMap )[key] == "ALWAYS" ) {

        return Messenger::ALWAYS;

    }
    else {

        throw ConfigurationException( "Configured verbosity level unknown." );

    }

}

Fittino::Configuration* Fittino::Configuration::_instance = 0;

Fittino::Configuration::Configuration()
        : _steeringParameterMap( new SteeringParameterMap() ) {

}

Fittino::Configuration::~Configuration() {

    delete _steeringParameterMap;

}
