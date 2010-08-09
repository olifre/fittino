/* $Id: FittinoOptimizerTemplate.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FittinoOptimizerTemplate.cpp                                     *
*                                                                              *
* Description Fittino optimizer template                                       *
*                                                                              *
* Authors     Name Surname  <email@domain>                                     *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "FittinoOptimizerTemplate.h"
// Include additional needed classes here (remove this comment when done).

Fittino::FittinoOptimizerTemplate::FittinoOptimizerTemplate( Fittino::ModelBase* model )
        : OptimizerBase( model ) {

    _name = "name of your optimizer";

    //_parameterName = Configuration::GetInstance()->GetSteeringParameter( "ParameterName", defaultValue );

}

Fittino::FittinoOptimizerTemplate::~FittinoOptimizerTemplate() {

}

void Fittino::FittinoOptimizerTemplate::PrintSteeringParameters() const {

    // Insert a sorted list of the steering parameters of your optimizer to be printed here (remove
    // this comment when done).
    // std::cout << "    Parameter name               " << _parameterName << std::endl;

}

void Fittino::FittinoOptimizerTemplate::UpdateModel() {

    // Here the implementation of how your optimizer selects a new candidate position in the
    // parameter space is done (remove this comment when done).

}
