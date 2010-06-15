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
        : _abortCriterium( 1e-6 ),
          _globalBestChi2( 1e99 ),
          _numberOfIterations( 10000 ),
          _name( "" ),
          _model( model ) {

    Configuration* configuration = Configuration::GetInstance();

    _abortCriterium = configuration->GetSteeringParameter( "AbortCriterium", 1e-6 );
    _numberOfIterations = configuration->GetSteeringParameter( "NumberOfIterations", 10000 );

}

Fittino::OptimizerBase::~OptimizerBase() {

}

void Fittino::OptimizerBase::PrintResult() {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Terminating " << _name                                                          << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Optimization results                                                          " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Final set of Rosenbrock model parameters                                     " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    X    " << ( *( _model->GetParameterVector() ) )[0]                            << std::endl;
    std::cout << "    Y    " << ( *( _model->GetParameterVector() ) )[1]                            << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "--------------------------------------------------------------------------------" << std::endl;

}

void Fittino::OptimizerBase::PrintStatus() {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Actual best set of Rosenbrock model parameters                                " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    X    " << ( *( _model->GetParameterVector() ) )[0]                            << std::endl;
    std::cout << "    Y    " << ( *( _model->GetParameterVector() ) )[1]                            << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    Chi2 " << _globalBestChi2                                                     << std::endl;
    std::cout << "                                                                                " << std::endl;

}
