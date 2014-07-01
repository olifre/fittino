/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MadGraphCalculator.cpp                                           *
*                                                                              *
* Description Wrapper around MadGraph                                          *
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
#include "MadGraphCalculator.h"
#include "ConfigurationException.h"
#include "PhysicsModel.h"
#include "ModelParameter.h"
#include "Factory.h"
#include "SimplePrediction.h"
#include "SimpleDataStorage.h"

#include <iostream>

Fittino::MadGraphCalculator::MadGraphCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model ) {
  std::cout<<"Hello World!"<<std::endl;
  
  _name = "MadGraph";
  
  
  Messenger& messenger = Messenger::GetInstance();
  
  messenger << Messenger::ALWAYS << Messenger::Endl;
  messenger << Messenger::ALWAYS << "Testing messenger" << Messenger::Endl;
  messenger << Messenger::ALWAYS << Messenger::Endl;
  messenger << Messenger::ALWAYS << "remember to change verbosity levels" << Messenger::Endl;
  messenger << Messenger::ALWAYS << Messenger::Endl;

  std::string configurationOption1 = ptree.get<std::string>( "MyFirstConfigurationOption" );
  
}

Fittino::MadGraphCalculator::~MadGraphCalculator() {

}


void Fittino::MadGraphCalculator::CalculatePredictions() {
    
}

void Fittino::MadGraphCalculator::SetupMeasuredValues() {
    

}

void Fittino::MadGraphCalculator::Initialize() {

}
