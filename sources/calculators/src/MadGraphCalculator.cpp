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

#include <boost/algorithm/string.hpp>
#include <boost/filesystem.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>
#include "TMath.h"
#include "MadGraphCalculator.h"
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

Fittino::MadGraphCalculator::MadGraphCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  : SLHACalculatorBase( model, &ptree ),
    _inputFile( ptree.get_child( "InputFile" ), model ),
    _executor(ptree.get<std::string>("Executable"), "mg5_aMC" ),
    _bannerFileName( ptree.get<std::string>("BannerFile") )
{

  _executor.AddArgument( _inputFile.GetName() );

  AddOutput( "IntegratedWeight", _weight  );
  AddOutput( "NumberOfEvents", _nevents );

  for ( const auto& node : ptree ) {

    if ( node.first != "Particle" ) continue;

    std::string name = node.second.get<std::string>( "Name" );
    int id           = node.second.get<int>( "PDGID" );

    AddOutput("Width_" + name );
    _pdgIds[name] = id;

  }

}

Fittino::MadGraphCalculator::~MadGraphCalculator() {
  
}

void Fittino::MadGraphCalculator::CalculatePredictions() {

  _inputFile.Write();

  _executor.Execute();

  boost::property_tree::ptree bannerFile;
  boost::property_tree::read_xml( _bannerFileName, bannerFile );

  std::string info = bannerFile.get<std::string>( "LesHouchesEvents.header.MGGenerationInfo" );
  std::vector<std::string> parts;
  boost::split( parts, info, boost::is_any_of( "\n,:" ) );

  if ( parts.size() != 6 || parts[0] != "" ||  parts[1] != "#  Number of Events        " || parts[3] != "#  Integrated weight (pb)  " || parts[5] != "" ){

    throw CalculatorException( _name, "BannerFile" );

  }

  _weight = stod( parts[4] );
  _nevents = stod( parts[2] );

  std::string slha = bannerFile.get<std::string>("LesHouchesEvents.header.slha");
  _slhaOutputDataStorage->Clear();
  _slhaOutputDataStorage->ReadString( slha );

  for( const auto& id : _pdgIds ) {

    double width = _slhaOutputDataStorage->GetEntry( std::to_string( id.second ) , 2, "DECAY", "", "", "");
    SetOutput( "Width_" + id.first, width  );

  }

  //std::string zipfile = "./testprocess/Events/run_01/tag_1_pythia_events.hep.gz";
  //Executor unzip("/bin/gunzip", "gunzip");
  //unzip.AddArgument(zipfile);
  //unzip.Execute();

}

void Fittino::MadGraphCalculator::SetupMeasuredValues() {

}

void Fittino::MadGraphCalculator::Initialize() {
  
}
