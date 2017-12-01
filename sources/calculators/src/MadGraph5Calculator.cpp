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
//  _inputFile = new InputFile( ptree.get_child("InputFile"), model );
    _BannerFile = ptree.get<std::string>("BannerFile");
    _MGinputFile = ptree.get<std::string>("MGinputFile");
   _executor.AddArgument(_MGinputFile);



boost::regex gogo (".*gogo.*");


if(boost::regex_match(_MGinputFile, gogo)){

AddOutput("XSgogo", _XSgogo);

}

boost::regex b1b1 (".*b1b1.*");


if(boost::regex_match(_MGinputFile, b1b1)){

AddOutput("XSb1b1~", _XSb1b1);



}

boost::regex b2b2 (".*b2b2.*");


if(boost::regex_match(_MGinputFile, b2b2)){

AddOutput("XSb2b2~", _XSb2b2);


}
boost::regex t1t1 (".*t1t1.*");


if(boost::regex_match(_MGinputFile, t1t1)){

AddOutput("XSt1t1~", _XSt1t1);



}
boost::regex t2t2 (".*t2t2.*");


if(boost::regex_match(_MGinputFile, t2t2)){

AddOutput("XSt2t2~", _XSt2t2);



}
boost::regex gosq (".*gosq.*");


if(boost::regex_match(_MGinputFile, gosq)){

AddOutput("XSgosq", _XSgosq);


}
boost::regex sqsq (".*sqsq.*");


if(boost::regex_match(_MGinputFile, sqsq)){

AddOutput("XSsqsq", _XSsqsq);


}
boost::regex sqasq (".*sqasq.*");


if(boost::regex_match(_MGinputFile, sqasq)){

AddOutput("XSsqasq", _XSsqasq);



}


}

Fittino::MadGraph5Calculator::~MadGraph5Calculator() {
  
}

void Fittino::MadGraph5Calculator::CalculatePredictions() {
// _inputFile.Write();
  _executor.Execute();
Executor executor2("/lustre/user/bruegge/fittinoprotected/tools/MG5_aMC_v2_6_0/bin/mg5_aMC","mg5_aMC");
executor2.AddArgument("/lustre/user/bruegge/fittinoprotected/tools/MadGraphtest/SMtest.txt");
//executor2.Execute();

  boost::property_tree::ptree bannerFile;
  boost::property_tree::read_xml( _BannerFile, bannerFile );

  std::string info = bannerFile.get<std::string>( "LesHouchesEvents.header.MGGenerationInfo" );
  std::vector<std::string> parts;
  boost::split( parts, info, boost::is_any_of( "\n,:" ) );



boost::regex gogo (".*gogo.*");


if(boost::regex_match(_MGinputFile, gogo)){

//AddOutput("XSgogo", _XSgogo);
  _XSgogo = stod( parts[4] );
  _nevents = stod( parts[2] );
std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);



}

boost::regex b1b1 (".*b1b1.*");


if(boost::regex_match(_MGinputFile, b1b1)){

//AddOutput("XSb1b1~", _XSb1b1);
  _XSb1b1 = stod( parts[4] );
  _nevents = stod( parts[2] );

std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);
}
boost::regex b2b2 (".*b2b2.*");


if(boost::regex_match(_MGinputFile, b2b2)){

//AddOutput("XSb2b2~", _XSb2b2);
  _XSb2b2 = stod( parts[4] );
  _nevents = stod( parts[2] );

std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);
}
boost::regex t1t1 (".*t1t1.*");


if(boost::regex_match(_MGinputFile, t1t1)){

//AddOutput("XSt1t1~", _XSt1t1);
  _XSt1t1 = stod( parts[4] );
  _nevents = stod( parts[2] );

std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);
}
boost::regex t2t2 (".*t2t2.*");


if(boost::regex_match(_MGinputFile, t2t2)){

//AddOutput("XSt2t2~", _XSt2t2);
  _XSt2t2 = stod( parts[4] );
  _nevents = stod( parts[2] );

std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);
}
boost::regex gosq (".*gosq.*");


if(boost::regex_match(_MGinputFile, gosq)){

//AddOutput("XSgosq", _XSgosq);
  _XSgosq = stod( parts[4] );
  _nevents = stod( parts[2] );

std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);
}
boost::regex sqsq (".*sqsq.*");


if(boost::regex_match(_MGinputFile, sqsq)){

//AddOutput("XSsqsq", _XSsqsq);
  _XSsqsq = stod( parts[4] );
  _nevents = stod( parts[2] );

std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);
}
boost::regex sqasq (".*sqasq.*");


if(boost::regex_match(_MGinputFile, sqasq)){

//AddOutput("XSsqasq", _XSsqasq);
  _XSsqasq = stod( parts[4] );
  _nevents = stod( parts[2] );

std:: string gunzipfile;
gunzipfile = "gunzip " + _EventFile;
const char *cstr = gunzipfile.c_str();

std::system(cstr);
}
/*
  std::string slha = bannerFile.get<std::string>("LesHouchesEvents.header.slha");
  _slhaOutputDataStorage->Clear();
  _slhaOutputDataStorage->ReadString( slha );

  for( const auto& id : _pdgIds ) {

    double width = _slhaOutputDataStorage->GetEntry( std::to_string( id.second ) , 2, "DECAY", "", "", "");
    SetOutput( "Width_" + id.first, width  );
*/
}

void Fittino::MadGraph5Calculator::SetupMeasuredValues() {

}

void Fittino::MadGraph5Calculator::Initialize() {
  
}
