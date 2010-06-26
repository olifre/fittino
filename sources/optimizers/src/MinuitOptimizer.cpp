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

#include "Minuit2/FunctionMinimum.h"
#include "Minuit2/MnMigrad.h"
#include "Minuit2/MnPrint.h"

#include "MinuitOptimizer.h"
#include "RosenbrockModel.h"

Fittino::MinuitOptimizer::MinuitOptimizer( Fittino::ModelBase* model )
        : OptimizerBase( model ) {

    _name =  "Minuit optimization algorithm";

    double x, y;

    _minuitUserParameters.Add("X", x, 2.56);
    _minuitUserParameters.Add("Y", y, -1.54);

}

Fittino::MinuitOptimizer::~MinuitOptimizer() {

}

double Fittino::MinuitOptimizer::UpdateChi2() {

    std::vector<double> pos;
    std::vector<double> meas;
    std::vector<double> var;

    RosenbrockFCN rosenbrockFCN( meas, pos, var );
    ROOT::Minuit2::MnMigrad _migrad( rosenbrockFCN, _minuitUserParameters );

    ROOT::Minuit2::FunctionMinimum minuitResult = _migrad();

    for ( unsigned int i = 0; i < _model->GetParameterVector()->size(); i++ ) {

        ( *( _model->GetParameterVector() ) )[i] = minuitResult.UserParameters().Value(i);

    }

    _iterationCounter =  minuitResult.NFcn();

    return 1e-7;

}

void Fittino::MinuitOptimizer::PrintSteeringParameters() const {

    std::cout << "    Default configuration " << std::endl;

}
