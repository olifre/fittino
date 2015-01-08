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
#include "Executor.h"
#include <iostream>
#include <fstream>



Fittino::MadGraphCalculator::MadGraphCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model ),
    // Initialize input quantities.                                                                                                                                                      
    _fH ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "fH.Name","fH" ) )->GetValue() ),
    _cHW ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "cHW.Name", "cHW" ) )->GetValue() ),
    _cHB ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "cHB.Name", "cHB" ) )->GetValue() ),
    _cBB ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "cBB.Name", "cBB" ) )->GetValue() ) {
  
  
  
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

  std::cout<<"USING _cHW = "<<_cHW<<std::endl;
  
  std::string originalinputfile = "/afs/atlass01.physik.uni-bonn.de/user/thakur/programs/Madgraph_v2_1_1/runmadgraph.txt";
  std::string inputfile = "fittino_madgraph_in.txt"; 

  std::ifstream infile( originalinputfile.c_str(), std::ios::binary );
  std::ofstream outfile( inputfile.c_str(),    std::ios::binary );
  outfile << infile.rdbuf();
  infile.close();
  outfile.close();

  std::ofstream myfile;
  myfile.open ( inputfile.c_str(), std::ios::app ) ;
  myfile << "set cHW "<<_cHW<<std::endl;
  myfile.close();
  
  
  Executor executor("/afs/atlass01.physik.uni-bonn.de/user/thakur/programs/Madgraph_v2_1_1/bin/mg5_aMC", "mg5");
  executor.AddArgument(inputfile);
  executor.Execute();
  
}

void Fittino::MadGraphCalculator::SetupMeasuredValues() {
  
  
}

void Fittino::MadGraphCalculator::Initialize() {
  
}
