/* $Id: IOptimization.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        IOptimization.cpp                                                *
*                                                                              *
* Description Interface class for optimization algorithms                      *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "IOptimization.h"

Fittino::IOptimization::IOptimization() {

}

Fittino::IOptimization::~IOptimization() {

}

double Fittino::IOptimization::EvaluateModel( ModelBase* model ) {

    double chi2 = model->Evaluate();
    return chi2;

}
