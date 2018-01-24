/* $Id: MadGraphCalculator.cpp 2775 2016-11-15 12:41:43Z sarrazin $ */

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
#include <boost/filesystem.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>
#include "TMath.h"
#include "MadGraph5Calculator.h"
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
#include <boost/regex.hpp>




Fittino::MadGraph5Calculator::MadGraph5Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  : SLHACalculatorBase( model, &ptree ),



    _EventFile(ptree.get<std::string>( "EventFile" )  ),
    _SLHAFile( ptree.get<std::string>("SLHAFile") ),
    _executor(ptree.get<std::string>("Executable"), "mg5_aMC" )


{
    _BannerFile = ptree.get<std::string>("BannerFile");
    _MGinputFile = ptree.get<std::string>("MGinputFile");
   _executor.AddArgument(_MGinputFile);

AddOutput("XS", _XS);

}

Fittino::MadGraph5Calculator::~MadGraph5Calculator() {
  
}

void Fittino::MadGraph5Calculator::CalculatePredictions() {
  _executor.Execute();

if (!boost::filesystem::exists (_BannerFile)){
  throw CalculatorException(_name, "MadGraphError"); 

}

else{
  boost::property_tree::ptree bannerFile;
  boost::property_tree::read_xml( _BannerFile, bannerFile );

  std::string info = bannerFile.get<std::string>( "LesHouchesEvents.header.MGGenerationInfo" );
  std::vector<std::string> parts;
  boost::split( parts, info, boost::is_any_of( "\n,:" ) );


  _XS = stod( parts[4] );
  _nevents = stod( parts[2] );
std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);

}
}

void Fittino::MadGraph5Calculator::SetupMeasuredValues() {

}

void Fittino::MadGraph5Calculator::Initialize() {
  
}
