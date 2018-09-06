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
#include "EventNumber3Calculator.h"
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



Fittino::EventNumber3Calculator::EventNumber3Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model, &ptree ),

    _executor(ptree.get<std::string>("Executable"), "mg5_aMC" )


{

AddOutput("N");
AddOutput("NXS");
AddInput("XS");

}

Fittino::EventNumber3Calculator::~EventNumber3Calculator() {
  
}

void Fittino::EventNumber3Calculator::CalculatePredictions() {

UpdateInput();
double _XS;
_XS = GetInput( "XS" );
std::cout << "XS" << std::endl;
std::cout << _XS << std::endl;


double test; 
double event;
int event_2;
event_2 = 4000 * _XS *20;
test = _XS;

if(event_2 < 10){
event_2 =10;
std::cout << "test" << std::endl;
std::cout << test << std::endl;
test = _XS - _XS;
}

if(event_2 < 8000 and event_2 > 10){
event_2 =8000; 
}

if(event_2 > 50000){
event_2 = 45000;
}

_N = event_2;
std::cout << _N << std::endl;
std::cout << "N" << std::endl;
std::cout << event_2 << std::endl;
SetOutput( "N", _N  );
SetOutput( "NXS", test  );

}


void Fittino::EventNumber3Calculator::SetupMeasuredValues() {

}

void Fittino::EventNumber3Calculator::Initialize() {
  
}
