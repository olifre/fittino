

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6ModelCalculator.cpp                                         *
*                                                                              *
* Description Wrapper class for HDim6                                          * 
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "HDim6/CrossSection.h" 
#include "HDim6/CrossSection_had.h" 
#include "HDim6/decay.h" 
#include "HDim6/inputs.h" 
#include "HDim6/VBF.h"

#include "HDim6ModelCalculator.h"



Fittino::HDim6ModelCalculator::HDim6ModelCalculator() {

    _name = "HDim6ModelCalculator";

}

Fittino::HDim6ModelCalculator::~HDim6ModelCalculator() {

}

void Fittino::HDim6ModelCalculator::CalculatePredictions( PhysicsModelBase* model ) {

}

void Fittino::HDim6ModelCalculator::Initialize() const {

}

void Fittino::HDim6ModelCalculator::CallExecutable() {

}

void Fittino::HDim6ModelCalculator::CallFunction( PhysicsModelBase* model ) {

  effinputs effinputs;
  sminputs  SMparam;

  init_(   &SMparam );
  

}


void Fittino::HDim6ModelCalculator::ConfigureInput( PhysicsModelBase* model ) {

}
