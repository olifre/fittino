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
#include <boost/algorithm/string/predicate.hpp>
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
  : CalculatorBase( model, &ptree ),
     _inputFile( ptree.get_child("InputFile"), model ),
    _EventFile(ptree.get<std::string>( "EventFile" )  ),
    _SLHAFile( ptree.get<std::string>("SLHAFile") ),
    _executor(ptree.get<std::string>("Executable"), "mg5_aMC" )


{
    _BannerFile = ptree.get<std::string>("BannerFile");
    _MGinputFile = ptree.get<std::string>("MGinputFile");
    _Decay_Width=  model->GetCollectionOfQuantities().At("SPheno_GammaTotal_~chi1p")->GetValue();
    _Mt=  model->GetCollectionOfQuantities().At("Mt")->GetValue();
    _executor.AddArgument(_MGinputFile);

AddOutput("XS", _XS);
AddInput("Decay_Width");

}

Fittino::MadGraph5Calculator::~MadGraph5Calculator() {
  
}

void Fittino::MadGraph5Calculator::CalculatePredictions() {

// Converts the Spheno output (SLHA1) to a SLHA2 format required by the model: mssm_full, calls MadGraph internal functions to do so

std:: string converter;
converter = "python /lustre/user/bruegge/fittinoprotected/tools/MG5_aMC_v2_6_0/convert.py" ; 
const char *cstr = converter.c_str();


std:: system( cstr );


// Checks if pythia would crash due to a to small decay width
Check_Chargino_DecayWidth();

// updates the input file with the required event number

_inputFile.Write();

// calls MadGraph
_executor.Execute();

// Checks if MadGraph crashed and has not produced an output file

if (!boost::filesystem::exists (_BannerFile)){
  throw CalculatorException(_name, "MadGraphError"); 

}

// Reads in the XS and eventnumbers of the MadGraph output

else{
  boost::property_tree::ptree bannerFile;
  boost::property_tree::read_xml( _BannerFile, bannerFile );

  std::string info = bannerFile.get<std::string>( "LesHouchesEvents.header.MGGenerationInfo" );
  std::vector<std::string> parts;
  boost::split( parts, info, boost::is_any_of( "\n,:" ) );


  _XS = stod( parts[4] );
  _nevents = stod( parts[2] );

// unzips the eventfile for later use in e.g CheckMate
std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);

}

}

// Checks the Chargino Decay width, which would end up in a crash of pythia otherwise
void Fittino::MadGraph5Calculator::Check_Chargino_DecayWidth() {
std::cout << _Mt;
UpdateInput();
_Decay_Width = GetInput( "Decay_Width" );

if(_Decay_Width <= 1e-15){
  std::cout << _Decay_Width;
  throw CalculatorException(_name, "Decay_Width_Chargino(~chi1p)"); 
}
//else{
//  std::cout << "Test2";
//}

}


void Fittino::MadGraph5Calculator::SetupMeasuredValues() {

}

void Fittino::MadGraph5Calculator::Initialize() {
  
}
