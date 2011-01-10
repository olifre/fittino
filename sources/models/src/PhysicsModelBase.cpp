/* $Id: PhysicsModelBase.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsModelBase.cpp                                             *
*                                                                              *
* Description Base class for Fittino physics models                            *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "PhysicsModelBase.h"

Fittino::PhysicsModelBase::PhysicsModelBase() {

}

Fittino::PhysicsModelBase::~PhysicsModelBase() {

}

double Fittino::PhysicsModelBase::Evaluate() {

    PhysicsModelBase::UpdateSLHAConfiguration();
    PhysicsModelBase::UpdateObservablePredictions();
    return PhysicsModelBase::CalculateChi2();

}

double Fittino::PhysicsModelBase::CalculateChi2() {

    return 1.e-6;

}

void Fittino::PhysicsModelBase::UpdateObservablePredictions() {

}

void Fittino::PhysicsModelBase::UpdateSLHAConfiguration() {

    //SLHAFileInterpreter* _inputSLHAFileInterpreter = new SLHAFileInterpreter();
    //_inputSLHAFileInterpreter->ReadFile( "SPheno.spc" );
    //std::cout << _inputSLHAFileInterpreter->GetMODSEL() << std::endl;

}
