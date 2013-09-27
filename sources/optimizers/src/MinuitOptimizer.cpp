/* $Id$ */

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

#include "Messenger.h"
#include "MinuitOptimizer.h"
#include "MinuitAdapter.h"
#include "ModelParameterBase.h"

Fittino::MinuitOptimizer::MinuitOptimizer( Fittino::ModelBase* model, int randomSeed )
    : OptimizerBase( model, randomSeed ) {

    _name =  "Minuit optimization algorithm";

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        double x;
        _minuitUserParameters.Add( _model->GetParameterVector()->at( i )->GetName(), x, _model->GetParameterVector()->at( i )->GetValue() );

    }

}

Fittino::MinuitOptimizer::~MinuitOptimizer() {

}

void Fittino::MinuitOptimizer::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Abort criterium       " << _abortCriterium     << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Number of iterations  " << _numberOfIterations << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Default configuration"                         << Messenger::Endl;

}

void Fittino::MinuitOptimizer::UpdateModel() {

    MinuitAdapter minuitAdapter( _model );

    ROOT::Minuit2::MnStrategy minuitStrategy;
    //minuitStrategy.SetGradientNCycles(0);
    //minuitStrategy.SetHessianNCycles(0);

    ROOT::Minuit2::MnMigrad _migrad( minuitAdapter, _minuitUserParameters, minuitStrategy );

    ROOT::Minuit2::FunctionMinimum minuitResult = _migrad();

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        _model->GetParameterVector()->at( i )->SetValue( minuitResult.UserParameters().Value( i ) );

    }

}
