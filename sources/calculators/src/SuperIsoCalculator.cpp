/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SuperIsoCalculator.cpp                                           *
*                                                                              *
* Description Wrapper class for SuperIso                                       * 
*                                                                              *
* Authors     Bjoern  Sarrazin  <sarrazin@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/property_tree/ptree.hpp>

extern "C" {
#include "include.h"
}
#include "SimplePrediction.h"
#include "SuperIsoCalculator.h"

Fittino::SuperIsoCalculator::SuperIsoCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
  :CalculatorBase( model ) {

      _name = "SuperIsoCalculator";
      AddQuantity(new SimplePrediction( "bsgamma", "", _bsgamma));
    
}

Fittino::SuperIsoCalculator::~SuperIsoCalculator() {

}

void Fittino::SuperIsoCalculator::CalculatePredictions() {

  test_slha("SPheno.spc");
  _bsgamma = bsgamma_calculator("SPheno.spc");

}
