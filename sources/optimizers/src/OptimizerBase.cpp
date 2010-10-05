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

#include <iomanip>
#include <iostream>
#include <sstream>

#include "Messenger.h"
#include "OptimizerBase.h"

Fittino::OptimizerBase::OptimizerBase( ModelBase* model )
        : AnalysisTool( model ) {

}

Fittino::OptimizerBase::~OptimizerBase() {

}

void Fittino::OptimizerBase::PrintResult() const {

    Messenger* messenger = Messenger::GetInstance();

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

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        std::cout << "    "
                  << std::left
                  << std::setw( 11 )
                  << std::setiosflags( std::ios::fixed )
                  << std::setprecision( 6 )
                  << ( *_model->GetParameterVector() )[i].GetName()
                  << std::right
                  << std::setw( 9 )
                  << ( *_model->GetParameterVector() )[i].GetValue()                                << std::endl;

    }

    std::cout << "                                                                                " << std::endl;
    std::cout << "--------------------------------------------------------------------------------" << std::endl;

}
