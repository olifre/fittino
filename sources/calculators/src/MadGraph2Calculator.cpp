/* $Id: MadGraphCalculator.cpp 2514 2015-03-30 11:41:07Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

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

#include <boost/filesystem.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>
#include <boost/regex.hpp>
#include "TMath.h"
#include "MadGraph2Calculator.h"
#include "ConfigurationException.h"
#include "PhysicsModel.h"
#include "ModelParameter.h"
#include "Factory.h"
#include "SimplePrediction.h"
#include "Executor.h"
#include <iostream>
#include <fstream>
#include "Redirector.h"


Fittino::MadGraph2Calculator::MadGraph2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model, &ptree ),
    _nevents ( ptree.get<double>( "nevents",10000 ) )                                                                                

 {
  AddOutput("CrossSection", _crossSection);
  AddOutput("Normalized_xs", _normxs);
  AddOutput("Number_of_Events", _nevents);
  AddInput("f_BB");
  AddInput("f_WW");
  AddInput("f_B");
  AddInput("f_W");



fstream datei("madgraphrun.txt", std::ios::out);
datei << "import model ./HIGGSFIT2_UFO" << std::endl;
datei << "generate p p > z h NP=4" << std::endl;
datei << "output dummydir" << std::endl;
datei << "launch dummydir" << std::endl;
datei << "set ebeam1=4000.0" << std::endl;
datei << "set ebeam2=4000.0" << std::endl;
datei << "set nevents=" << _nevents << std::endl;

//Redirector redirector("dummyfile" );
//redirector.Start();

  Executor executor("./MG5/bin/mg5_aMC","mg5_aMC");
  executor.AddArgument("madgraphrun.txt");
  executor.Execute();

  //redirector.Stop();

using boost::property_tree::ptree;
ptree pt;
read_xml("dummydir/Events/run_01/run_01_tag_1_banner.txt",pt);
std::string tag = pt.get<std::string>("LesHouchesEvents.header.MGGenerationInfo");
std::string line1=tag.substr(5,tag.find("\n",5));
std::string line2=tag.substr(43,tag.length());
 std::string  cross=boost::regex_replace(line2,boost::regex("[^0-9]*([0-9,.]+).*"),std::string("\\1"));
 using Fittino::MadGraph2Calculator;
 _SMxs = atof(cross.c_str());


 std::cout << "SM cross section: " << _SMxs << "\n\n" << std::endl;
 }


Fittino::MadGraph2Calculator::~MadGraph2Calculator() {
  
}


void Fittino::MadGraph2Calculator::CalculatePredictions() {
  UpdateInput();
 

  //std::cout << GetInput("f_BB") << std::endl;
  //std::cout << GetInput("f_WW") << std::endl;
  //std::cout << GetInput("f_B") << std::endl;
  //std::cout << GetInput("f_W") << std::endl;



fstream datei("madgraphrun.txt", std::ios::out);
datei << "import model ./HIGGSFIT2_UFO" << std::endl;
datei << "generate p p > z h NP=4" << std::endl;
datei << "output dummydir" << std::endl;
datei << "launch dummydir" << std::endl;
datei << "set ebeam1=4000" << std::endl;
datei << "set ebeam2=4000" << std::endl;
datei << "set cBB=" << GetInput("f_BB") << std::endl;
datei << "set cWW=" << GetInput("f_WW") << std::endl;
datei << "set cHB=" << GetInput("f_B") << std::endl;
datei << "set cHW=" << GetInput("f_W") << std::endl;
datei << "set nevents=" << _nevents << std::endl;

//Redirector redirector("dummyfile" );
//redirector.Start();

  Executor executor("./MG5/bin/mg5_aMC","mg5_aMC");
  executor.AddArgument("madgraphrun.txt");
  executor.Execute();

  //redirector.Stop();


using boost::property_tree::ptree;
ptree pt;
read_xml("dummydir/Events/run_01/run_01_tag_1_banner.txt",pt);
std::string tag = pt.get<std::string>("LesHouchesEvents.header.MGGenerationInfo");
std::string line1=tag.substr(5,tag.find("\n",5));
std::string line2=tag.substr(43,tag.length());

 std::string events=boost::regex_replace(line1,boost::regex("[^0-9]*([0-9,.]+).*"),std::string("\\1"));
 std::string  cross=boost::regex_replace(line2,boost::regex("[^0-9]*([0-9,.]+).*"),std::string("\\1"));
 _crossSection = atof(cross.c_str()); 
 _nevents = atof(events.c_str());
 _normxs=_crossSection/_SMxs;
 using Fittino::MadGraph2Calculator;
 //std::cout << "beam energy      : " << beamenergy << " MeV" << std::endl;
 std::cout << "Number of Events : " << events               << std::endl;
 std::cout << "Cross section    : " << cross      << " pb"  << std::endl;
 std::cout << "normalized xs    : " << _crossSection/_SMxs      << " pb"  << std::endl;
 std::cout << "--------------------------------------------"<< std::endl;



}              
                                                                                                                                                     
void Fittino::MadGraph2Calculator::SetupMeasuredValues() {
  
  
}

void Fittino::MadGraph2Calculator::Initialize() {
  
}
