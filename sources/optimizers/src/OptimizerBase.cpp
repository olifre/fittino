/* $Id: OptimizerBase.cpp,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        OptimizerBase.cpp                                                *
*                                                                              *
* Description Base class for Fittino parameter optimizers                      *
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

#include <iostream>

#include "Configuration.h"
#include "OptimizerBase.h"

Fittino::OptimizerBase::OptimizerBase( ModelBase* model )
        : _chi2( 1e99 ),
          _iterationCounter( 0 ),
          _name( "" ),
          _model( model ) {

    _abortCriterium = Configuration::GetInstance()->GetSteeringParameter( "AbortCriterium", 1e-6 );
    _numberOfIterations = Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", 10000 );

}

Fittino::OptimizerBase::~OptimizerBase() {

}

void Fittino::OptimizerBase::PerformOptimization() {

    OptimizerBase::InitializeOptimizer();
    OptimizerBase::ExecuteOptimizer();
    OptimizerBase::TerminateOptimizer();

}

void Fittino::OptimizerBase::PrintStatus() const {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Actual best set of " << _model->GetName() << " parameters                     " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    X    " << ( *( _model->GetParameterVector() ) )[0]                            << std::endl;
    std::cout << "    Y    " << ( *( _model->GetParameterVector() ) )[1]                            << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    Chi2 " << _chi2                                                               << std::endl;
    std::cout << "                                                                                " << std::endl;

}

void Fittino::OptimizerBase::ExecuteOptimizer() {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Running " << _name                                                              << std::endl;
    std::cout << "                                                                                " << std::endl;

    while (  _chi2 > _abortCriterium && _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;

        _chi2 = _model->Evaluate();

        PrintStatus();

        this->UpdateModel();

    }

}

void Fittino::OptimizerBase::InitializeOptimizer() {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Initializing " << _name                                                         << std::endl;
    std::cout << "                                                                                " << std::endl;

    OptimizerBase::PrintConfiguration();

}

void Fittino::OptimizerBase::PrintConfiguration() const {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Configuration                                                                " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    Abort criterium              " << _abortCriterium                             << std::endl;
    std::cout << "    Number of Iterations         " << _numberOfIterations                         << std::endl;

    this->PrintSteeringParameters();

    std::cout << "                                                                                " << std::endl;

}

void Fittino::OptimizerBase::PrintResult() const {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Optimization converged after " << _iterationCounter << " iterations           " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Optimization results                                                          " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Final set of " << _model->GetName() << " parameters                          " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    X    " << ( *( _model->GetParameterVector() ) )[0]                            << std::endl;
    std::cout << "    Y    " << ( *( _model->GetParameterVector() ) )[1]                            << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "--------------------------------------------------------------------------------" << std::endl;

}

void Fittino::OptimizerBase::TerminateOptimizer() const {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Terminating " << _name                                                          << std::endl;
    std::cout << "                                                                                " << std::endl;
    
    OptimizerBase::PrintResult();

}
