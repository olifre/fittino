/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsSLHAModelCalculator.cpp                                 *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "FeynHiggsSLHAModelCalculator.h"
#include "CFeynHiggs.h"
#include "CSLHA.h"


Fittino::FeynHiggsSLHAModelCalculator::FeynHiggsSLHAModelCalculator(  const PhysicsModelBase* model, const boost::property_tree::ptree& ptree)
  : FeynHiggsModelCalculatorBase(model, ptree) {

    _name = "FeynHiggs";

}

Fittino::FeynHiggsSLHAModelCalculator::~FeynHiggsSLHAModelCalculator() {

}

void Fittino::FeynHiggsSLHAModelCalculator::Initialize() const {

}

void Fittino::FeynHiggsSLHAModelCalculator::ConfigureInput() {

  int error;
  COMPLEX slhadata[nslhadata];
  std::string filename;

  SLHARead(&error, slhadata, filename.c_str(), 1);
  // if( error ) 
  //exit(error);

  FHSetSLHA(&error, slhadata);
  // if( error )
  //exit(error);
  
}
