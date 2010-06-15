/* $Id: MinuitOptimizer.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MinuitOptimizer.cpp                                              *
*                                                                              *
* Description Class for Minuit optimization                                    *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include "MinuitOptimizer.h"

Fittino::MinuitOptimizer::MinuitOptimizer( Fittino::ModelBase* model )
        : OptimizerBase( model ) {

    _name =  "Minuit optimization algorithm";

}

Fittino::MinuitOptimizer::~MinuitOptimizer() {

    MinuitOptimizer::PrintResult();

}

void Fittino::MinuitOptimizer::Execute() {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Running " << _name                                                              << std::endl;
    std::cout << "                                                                                " << std::endl;

    unsigned int iterationCounter = 0;

    while (  _globalBestChi2 > _abortCriterium && iterationCounter < _numberOfIterations ) {

        iterationCounter++;

        PrintStatus();

    }

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Optimization converged after " << iterationCounter << " iterations            " << std::endl;
    std::cout << "                                                                                " << std::endl;

}

void Fittino::MinuitOptimizer::PrintConfiguration() {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Initializing " << _name                                                         << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Configuration                                                                " << std::endl;
    std::cout << "                                                                                " << std::endl;

}
