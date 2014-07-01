/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CheckMATECalculator.cpp                                          *
*                                                                              *
* Description Wrapper around CheckMATE                                         *
* Authors                                                                      *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/


#include <boost/property_tree/ptree.hpp>
#include <boost/foreach.hpp>

#include "TMath.h"

#include "CheckMATECalculator.h"
#include "ConfigurationException.h"
#include "PhysicsModel.h"
#include "ModelParameter.h"
#include "Factory.h"
#include "SimplePrediction.h"
#include "SimpleDataStorage.h"

#include <iostream>

Fittino::CheckMATECalculator::CheckMATECalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model ) {
  std::cout<<"No Hello World! this time"<<std::endl;
   
  _name = "CheckMATE";

  Messenger& messenger = Messenger::GetInstance();

  messenger << Messenger::ALWAYS << Messenger::Endl;
  messenger << Messenger::ALWAYS << "Test line 1" << Messenger::Endl;
  messenger << Messenger::ALWAYS << Messenger::Endl;
  messenger << Messenger::ALWAYS << "test line 2" << Messenger::Endl;
  messenger << Messenger::ALWAYS << Messenger::Endl;
}

Fittino::CheckMATECalculator::~CheckMATECalculator() {

}

void Fittino::CheckMATECalculator::CalculatePredictions() {
    
}

void Fittino::CheckMATECalculator::SetupMeasuredValues() {
    

}

void Fittino::CheckMATECalculator::Initialize() {

}
