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
#include "RosenbrockModel.h"

Fittino::Configuration* Fittino::Configuration::GetInstance() {

    if ( !_instance ) {

        _instance = new Configuration();

    }

    return _instance;

}

//void Fittino::Configuration::SetExecutionMode( ExecutionMode::Mode executionMode ) {
//
//    _executionMode = executionMode;
//
//}

//void Fittino::Configuration::SetOptimizer( OptimizerBase* optimizer ) {
//
//    _optimizer = optimizer;
//
//}

Fittino::SteeringParameterMap* Fittino::Configuration::GetSteeringParameterMap() const {

    return _steeringParameterMap;

}

//Fittino::ExecutionMode::Mode Fittino::Configuration::GetExecutionMode() const {
//    /*!
//     *  Returns configured execution mode
//     */
//    return _executionMode;
//
//}

//Fittino::OptimizerBase* Fittino::Configuration::GetOptimizer() const {
//    /*!
//     *  Returns configured parameter optimizer
//     */
//    //return _optimizer;
//
//}

Fittino::Configuration::Configuration() {
    /*!
     *  Sets default execution mode (optimization)
     */
    //_executionMode = ExecutionMode::OPTIMIZATION;
    /*!
     *  Sets default optimizer (particle swarm optimizer)
     */
    //_optimizer = new OptimizerBase();

}

Fittino::Configuration::~Configuration() {

    //delete _optimizer;

}

Fittino::Configuration* Fittino::Configuration::_instance = 0;
