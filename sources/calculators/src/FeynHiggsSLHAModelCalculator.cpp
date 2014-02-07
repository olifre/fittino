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

#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "FeynHiggsSLHAModelCalculator.h"

Fittino::FeynHiggsSLHAModelCalculator::FeynHiggsSLHAModelCalculator(  const PhysicsModel* model, const boost::property_tree::ptree& ptree )
  : FeynHiggsModelCalculatorBase( model, ptree ) {

    _name = "FeynHiggs";
    _fileName = "SPheno.spc";

}

Fittino::FeynHiggsSLHAModelCalculator::~FeynHiggsSLHAModelCalculator() {

}

void Fittino::FeynHiggsSLHAModelCalculator::CalculatePredictions() {

  SetFlags();

  COMPLEX slhadata[nslhadata];

  SLHARead( &_error, slhadata, _fileName.c_str(), 1 );
  // if( error ) 
  //exit(error);

  FHSetSLHA( &_error, slhadata );
  // if( error )
  //exit(error);

  Calculate();
  
}
