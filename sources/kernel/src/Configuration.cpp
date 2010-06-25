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

Fittino::Configuration* Fittino::Configuration::GetInstance() {

    if ( !_instance ) {

        _instance = new Configuration();

    }

    return _instance;

}

void Fittino::Configuration::AddSteeringParameter( std::string key, std::string value ) {

    ( *_steeringParameterMap )[key] = value;

}

Fittino::ExecutionMode::Mode Fittino::Configuration::GetExecutionMode() {

    /*!
     *  Returns configured execution mode
     */
    if ( ( *_steeringParameterMap )["Mode"] == "OPTIMIZATION" ) {

        _executionMode = ExecutionMode::OPTIMIZATION;

    }
    else if ( ( *_steeringParameterMap )["Mode"] == "SCAN" ) {

        _executionMode = ExecutionMode::SCAN;

    }

    return _executionMode;

}

Fittino::ModelBase::ModelType Fittino::Configuration::GetModelType() {

    /*!
     *  Returns configured model type
     */
    if ( ( *_steeringParameterMap )["ModelType"] == "RosenbrockModel" ) {

        _modelType = ModelBase::ROSENBROCKMODEL;

    }

    return _modelType;

}

Fittino::OptimizerBase::OptimizerType Fittino::Configuration::GetOptimizerType() {

    /*!
     *  Returns configured optimizer type
     */
    if ( ( *_steeringParameterMap )["OptimizerType"] == "MinuitOptimizer" ) {

        _optimizerType = OptimizerBase::MINUITOPTIMIZER;

    }
    else if ( ( *_steeringParameterMap )["OptimizerType"] == "ParticleSwarmOptimizer" ) {

        _optimizerType = OptimizerBase::PARTICLESWARMOPTIMIZER;

    }

    return _optimizerType;

}

Fittino::Configuration::Configuration()
        : _executionMode( ExecutionMode::OPTIMIZATION ),
          _steeringParameterMap( new SteeringParameterMap() ),
          _modelType( ModelBase::ROSENBROCKMODEL ), 
          _optimizerType( OptimizerBase::MINUITOPTIMIZER ) {

    /*!
     *  Sets default execution mode (optimization)
     *  Sets default model (Rosenbrock model)
     *  Sets default optimizer (Minuit optimizer)
     */

}

Fittino::Configuration::~Configuration() {

}

Fittino::Configuration* Fittino::Configuration::_instance = 0;
