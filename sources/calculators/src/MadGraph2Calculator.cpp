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
#include <string>
#include "Redirector.h"

double readout()
{
    boost::property_tree::ptree pt;
    boost::property_tree::read_xml("Prozess/Events/run_01/run_01_tag_1_banner.txt",pt);
    std::string tag = pt.get<std::string>("LesHouchesEvents.header.MGGenerationInfo");
    std::string line1=tag.substr(5,tag.find("\n",5));
    std::string line2=tag.substr(70,tag.length());
    std::string  cross=boost::regex_replace(line2,boost::regex("[^0-9]*([0-9,.,e,-]+).*"),std::string("\\1"));
    //DEBUG
    std::cout << line1 << std::endl;
    std::cout << "____________________________________"<< std::endl;
    std::cout << line2 << std::endl;
    std::cout << "____________________________________"<< std::endl;
    std::cout << cross << std::endl;
    std::cout << "____________________________________"<< std::endl;
    std::cout << atof(cross.c_str())<< std::endl;
    std::cout << "____________________________________"<< std::endl;
    // DEBUG end
    return atof(cross.c_str());
}



Fittino::MadGraph2Calculator::MadGraph2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model, &ptree ),
    _nevents           ( ptree.get<double>( "nevents",10000  ) ),
    _calculate_xs_Zh   ( ptree.get<bool>  ("calculate_xs_Zh" ) ),
    _calculate_xs_Wh   ( ptree.get<bool>  ("calculate_xs_Wh" ) ),
    _calculate_xs_qqh  ( ptree.get<bool>  ("calculate_xs_qqh") ),
    _calculate_xs_hWW  ( ptree.get<bool>  ("calculate_xs_hWW") ),
    _calculate_xs_hZZ  ( ptree.get<bool>  ("calculate_xs_hZZ") )
 {
  //AddOutput("CrossSection"        , _crossSection);
  if (_calculate_xs_Zh)  {AddOutput("Normalized_xs_zh"    , _normxs_zh);}
  if (_calculate_xs_Wh)  {AddOutput("Normalized_xs_wh"    , _normxs_wh);}
  if (_calculate_xs_qqh) {AddOutput("Normalized_xs_qqh"   , _normxs_qqh);}
  if (_calculate_xs_hWW) {AddOutput("Normalized_width_hww", _normxs_hww);}
  if (_calculate_xs_hZZ) {AddOutput("Normalized_width_hzz", _normxs_hzz);}
  if (_calculate_xs_Zh)  {AddOutput("xs_zh"               , _xs_zh);}    // for debuging
  if (_calculate_xs_Wh)  {AddOutput("xs_wh"               , _xs_wh);}    // for debuging
  if (_calculate_xs_qqh) {AddOutput("xs_qqh"              , _xs_qqh);}   // for debuging
  if (_calculate_xs_hWW) {AddOutput("width_hww"           , _xs_hww);}   // for debuging
  if (_calculate_xs_hZZ) {AddOutput("width_hzz"           , _xs_hzz);}   // for debuging
  if (_calculate_xs_Zh)  {AddOutput("SM_xs_zh"            , _SMxs_zh);}    // for debuging
  if (_calculate_xs_Wh)  {AddOutput("SM_xs_wh"            , _SMxs_wh);}    // for debuging
  if (_calculate_xs_qqh) {AddOutput("SM_xs_qqh"           , _SMxs_qqh);}   // for debuging
  if (_calculate_xs_hWW) {AddOutput("SM_width_hww"        , _SMxs_hww);}   // for debuging
  if (_calculate_xs_hZZ) {AddOutput("SM_width_hzz"        , _SMxs_hzz);}   // for debuging
 // AddOutput("xs_hww"              , _xs_hww);     // for debuging
  AddOutput("Number_of_Events"    , _nevents);
  AddInput("f_B");
  AddInput("f_W");
  AddInput("f_BB");
  AddInput("f_WW");

//Redirector redirector("dummyfile" );
//redirector.Start();
// ------------------------------ PROZESS 1 -----------------------------------------

if (_calculate_xs_Zh) {
  Executor executor("./MG5/bin/mg5_aMC","mg5_aMC");
  executor.AddArgument("mg5_Template_zh.txt");
  executor.Execute();
_SMxs_zh = readout();}

// ------------------------------ PROZESS 2 -----------------------------------------
if (_calculate_xs_Wh) {
  Executor executor2("./MG5/bin/mg5_aMC","mg5_aMC");
  executor2.AddArgument("mg5_Template_wh.txt");
  executor2.Execute();
_SMxs_wh = readout();}

// ------------------------------ PROZESS 3 -----------------------------------------
if (_calculate_xs_qqh) {
  Executor executor3("./MG5/bin/mg5_aMC","mg5_aMC");
  executor3.AddArgument("mg5_Template_qqh.txt");
  executor3.Execute();
_SMxs_qqh = readout();}

// ------------------------------ PROZESS 4 -----------------------------------------
if (_calculate_xs_hWW) {
  Executor executor4("./MG5/bin/mg5_aMC","mg5_aMC");
  executor4.AddArgument("mg5_Template_hww.txt");
  executor4.Execute();
_SMxs_hww = readout();}

// ------------------------------ PROZESS 5 -----------------------------------------
if (_calculate_xs_hZZ) {
  Executor executor5("./MG5/bin/mg5_aMC","mg5_aMC");
  executor5.AddArgument("mg5_Template_hzz.txt");
  executor5.Execute();
_SMxs_hzz = readout();}

// ----------------------------------------------------------------------------------
//redirector.Stop();
 }


Fittino::MadGraph2Calculator::~MadGraph2Calculator() {

}


void Fittino::MadGraph2Calculator::CalculatePredictions() {
  UpdateInput();

//Redirector redirector("dummyfile" );
//redirector.Start();
std::ofstream outfile;
// ------------------------------ PROZESS 1 -----------------------------------------------------
if (_calculate_xs_Zh) {
boost::filesystem::remove("mg5_Run_zh.txt");
boost::filesystem::copy("mg5_Template_zh.txt","mg5_Run_zh.txt");
outfile.open("mg5_Run_zh.txt", std::ios_base::app);
outfile << "set cBB=" << GetInput("f_BB") << std::endl;
outfile << "set cWW=" << GetInput("f_WW") << std::endl;
outfile << "set cHB=" << GetInput("f_B") << std::endl;
outfile << "set cHW=" << GetInput("f_W") << std::endl;
  Executor executor("./MG5/bin/mg5_aMC","mg5_aMC");
  executor.AddArgument("mg5_Run_zh.txt");
  executor.Execute();
  _xs_zh=readout();
_normxs_zh=_xs_zh/_SMxs_zh;}

// ------------------------------ PROZESS 2 -------------------------------------------------------
if (_calculate_xs_Wh) {
boost::filesystem::remove("mg5_Run_wh.txt");
boost::filesystem::copy("mg5_Template_wh.txt","mg5_Run_wh.txt");
outfile.open("mg5_Run_wh.txt", std::ios_base::app);
outfile << "set cBB=" << GetInput("f_BB") << std::endl;
outfile << "set cWW=" << GetInput("f_WW") << std::endl;
outfile << "set cHB=" << GetInput("f_B") << std::endl;
outfile << "set cHW=" << GetInput("f_W") << std::endl;
  Executor executor2("./MG5/bin/mg5_aMC","mg5_aMC");
  executor2.AddArgument("mg5_Run_wh.txt");
  executor2.Execute();
  _xs_wh=readout();
_normxs_wh=_xs_wh/_SMxs_wh;}

// ------------------------------ PROZESS 3 -------------------------------------------------------
if (_calculate_xs_qqh) {
boost::filesystem::remove("mg5_Run_qqh.txt");
boost::filesystem::copy("mg5_Template_qqh.txt","mg5_Run_qqh.txt");
outfile.open("mg5_Run_qqh.txt", std::ios_base::app);
outfile << "set cBB=" << GetInput("f_BB") << std::endl;
outfile << "set cWW=" << GetInput("f_WW") << std::endl;
outfile << "set cHB=" << GetInput("f_B") << std::endl;
outfile << "set cHW=" << GetInput("f_W") << std::endl;
  Executor executor3("./MG5/bin/mg5_aMC","mg5_aMC");
  executor3.AddArgument("mg5_Run_qqh.txt");
  executor3.Execute();
   _xs_qqh=readout();
_normxs_qqh=_xs_qqh/_SMxs_qqh;}

// ------------------------------ PROZESS 4 -------------------------------------------------------
if (_calculate_xs_hWW) {
boost::filesystem::remove("mg5_Run_hww.txt");
boost::filesystem::copy("mg5_Template_hww.txt","mg5_Run_hww.txt");
outfile.open("mg5_Run_hww.txt", std::ios_base::app);
outfile << "set cBB=" << GetInput("f_BB") << std::endl;
outfile << "set cWW=" << GetInput("f_WW") << std::endl;
outfile << "set cHB=" << GetInput("f_B") << std::endl;
outfile << "set cHW=" << GetInput("f_W") << std::endl;
  Executor executor4("./MG5/bin/mg5_aMC","mg5_aMC");
  executor4.AddArgument("mg5_Run_hww.txt");
  executor4.Execute();
  _xs_hww=readout();
_normxs_hww=_xs_hww/_SMxs_hww;}

// ------------------------------ PROZESS 5 -------------------------------------------------------
if (_calculate_xs_hZZ) {
boost::filesystem::remove("mg5_Run_hzz.txt");
boost::filesystem::copy("mg5_Template_hzz.txt","mg5_Run_hzz.txt");
outfile.open("mg5_Run_hzz.txt", std::ios_base::app);
outfile << "set cBB=" << GetInput("f_BB") << std::endl;
outfile << "set cWW=" << GetInput("f_WW") << std::endl;
outfile << "set cHB=" << GetInput("f_B") << std::endl;
outfile << "set cHW=" << GetInput("f_W") << std::endl;
  Executor executor4("./MG5/bin/mg5_aMC","mg5_aMC");
  executor4.AddArgument("mg5_Run_hzz.txt");
  executor4.Execute();
  _xs_hzz=readout();
_normxs_hzz=_xs_hzz/_SMxs_hzz;}
//redirector.Stop();
}

void Fittino::MadGraph2Calculator::SetupMeasuredValues() {


}

void Fittino::MadGraph2Calculator::Initialize() {

}
