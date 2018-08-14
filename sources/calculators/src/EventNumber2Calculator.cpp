/* $Id: EventNumber2Calculator.cpp 2775 2016-11-15 12:41:43Z sarrazin $ */

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

#include <boost/algorithm/string.hpp>
#include <boost/algorithm/string/predicate.hpp>
#include <boost/filesystem.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>
#include "TMath.h"
#include "EventNumber2Calculator.h"
#include "ConfigurationException.h"
#include "PhysicsModel.h"
#include "ModelParameter.h"
#include "Factory.h"
#include "SimplePrediction.h"
#include "SLHADataStorageBase.h"
#include "Executor.h"
#include <iostream>
#include <fstream>
#include <CalculatorException.h>
#include <CalculatorBase.h>
#include <boost/regex.hpp>
#include <ModelBase.h>



Fittino::EventNumber2Calculator::EventNumber2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model, &ptree ),

    _executor(ptree.get<std::string>("Executable"), "mg5_aMC" )


{

AddOutput("N");
AddOutput("NXS");
AddInput("XS");

}

Fittino::EventNumber2Calculator::~EventNumber2Calculator() {
  
}

void Fittino::EventNumber2Calculator::CalculatePredictions() {

UpdateInput();
double _XS;
_XS = GetInput( "XS" );
std::cout << "XS" << std::endl;
std::cout << _XS << std::endl;


double test; 
int event;
event = 4000 * _XS *5;
test = _XS;


if(event < 10){
event =1;
std::cout << "test" << std::endl;
std::cout << test << std::endl;
test = _XS - _XS;
}

if(event < 2000 and event > 10){
event =2000; 
}

if(event > 50000){
event = 45000;
}

_N = event;
std::cout << "N" << std::endl;
std::cout << event << std::endl;
SetOutput( "N", event  );
SetOutput( "NXS", test  );

}


void Fittino::EventNumber2Calculator::SetupMeasuredValues() {

}

void Fittino::EventNumber2Calculator::Initialize() {
  
}
