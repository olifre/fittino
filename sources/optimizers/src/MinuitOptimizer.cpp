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

#include "Minuit2/FCNBase.h"
#include "Minuit2/FunctionMinimum.h"
#include "Minuit2/MnMigrad.h"
#include "Minuit2/MnPrint.h"

#include "MinuitOptimizer.h"
#include "RosenbrockModel.h"

Fittino::MinuitOptimizer::MinuitOptimizer( Fittino::ModelBase* model )
        : OptimizerBase( model ) {

    _name =  "Minuit optimization algorithm";

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        double x;
        _minuitUserParameters.Add( ( *_model->GetParameterVector() )[i].GetName(), x, ( *_model->GetParameterVector() )[i].GetValue() );

    }

}

Fittino::MinuitOptimizer::~MinuitOptimizer() {

}

void Fittino::MinuitOptimizer::PrintSteeringParameters() const {

    std::cout << "    Default configuration " << std::endl;

}

void Fittino::MinuitOptimizer::UpdateModel() {

    std::vector<double> pos;
    std::vector<double> meas;
    std::vector<double> var;

    RosenbrockFCN rosenbrockFCN( meas, pos, var );

    ROOT::Minuit2::MnStrategy minuitStrategy;
    //minuitStrategy.SetGradientNCycles(0);
    //minuitStrategy.SetHessianNCycles(0);

    ROOT::Minuit2::MnMigrad _migrad( rosenbrockFCN, _minuitUserParameters, minuitStrategy );

    ROOT::Minuit2::FunctionMinimum minuitResult = _migrad();

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        ( *_model->GetParameterVector() )[i].SetValue( minuitResult.UserParameters().Value( i ) );

    }

}
