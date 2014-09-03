
/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CheckMATECalculator.cpp                                          *
*                                                                              *
* Description:  Wrapper around CheckMATE                                       *
* Authors:      Uddhipan Thakur                                                *
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
#include "CheckMATECalculator.h"
#include "ConfigurationException.h"
#include "PhysicsModel.h"
#include "ModelParameter.h"
#include "Factory.h"
#include "SimplePrediction.h"
#include "SimpleDataStorage.h"
#include "Executor.h"
#include <iostream>
#include <fstream>
#include <map>
Fittino::CheckMATECalculator::CheckMATECalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model ),
    
    _f_t  ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "f_t.Name", "f_t" ) )->GetValue() )
{
  
  std::cout<<"USING _f_B = "<<_f_B<<std::endl;
  std::string originalinputfile = "/lustre/user/thakur/programs/CheckMATE/lustreversion/runfittino.txt";
  std::string inputfile = "fittino_checkmate_in.txt";
  
  std::ifstream infile( originalinputfile.c_str(), std::ios::binary );
  std::ofstream outfile( inputfile.c_str(), std::ios::binary );
  outfile << infile.rdbuf();
  infile.close();
  outfile.close();
  
  std::ofstream myfile;
  myfile.open ( inputfile.c_str(), std::ios::app ) ;
  myfile.close();
  
  
  Executor executor("/lustre/user/thakur/programs/CheckMATE/lustreversion/bin/CheckMATE", "CheckMATE");
  executor.AddArgument(inputfile);
  
  std::cout<<"Start CheckMATE execution "<<std::endl;
  executor.Execute();
  std::cout<<"Finished CheckMATE execution "<<std::endl;
  
  
  std::cout<<"CheckMATE constructor."<<std::endl;
  std::ifstream file( "/lustre/user/thakur/programs/CheckMATE/lustreversion/results/atlas_conf_2013_079/analysis/000_atlas_conf_2013_079_signal.dat" );
  std::string line;
  
  TString character;
  
  while ( ! character.BeginsWith( "Cut " ) ) {
    
    std::getline( file, line );
    character = line.c_str();
    
  }
  
  std::vector<std::string> vector_name; 
  
  while ( file ) {
    
    std::string name;
    double weight1;
    double nevents;
    double weight2;
    double acc;
    file >> name >> weight1 >> weight2 >> acc >> nevents;
    
    character = name.c_str();
    if (name=="") break;
    
    vector_name.push_back(name);
    _acc_map[name]=0;
    
    std::cout<<"name: "<<name<<std::endl;
    
  }
  
  // loop over i 
  
  for(int i = 0; i < vector_name.size(); ++i) {
    
    AddQuantity( new SimplePrediction(vector_name[i] , "", _acc_map[vector_name[i]] ) );
    
  }
  
  _name = "CheckMATE";
  
  
  Messenger& messenger = Messenger::GetInstance();
  
  messenger << Messenger::ALWAYS << Messenger::Endl;
  messenger << Messenger::ALWAYS << "Test line 1" << Messenger::Endl;
  messenger << Messenger::ALWAYS << Messenger::Endl;
  messenger << Messenger::ALWAYS << "test line 2" << Messenger::Endl;
  messenger << Messenger::ALWAYS << Messenger::Endl;
  std::string configurationOption1 = ptree.get<std::string>( "MyFirstConfigurationOption" );

  std::cout<<"Finished CheckMATE constructor."<<std::endl;

}

Fittino::CheckMATECalculator::~CheckMATECalculator() {
   
}

void Fittino::CheckMATECalculator::CalculatePredictions() {
  std::cout<<"USING _f_B = "<<_f_B<<std::endl;
  std::string originalinputfile = "/lustre/user/thakur/programs/CheckMATE/lustreversion/runfittino.txt";
  std::string inputfile = "fittino_checkmate_in.txt";
  
  std::ifstream infile( originalinputfile.c_str(), std::ios::binary );
  std::ofstream outfile( inputfile.c_str(), std::ios::binary );
  outfile << infile.rdbuf();
  infile.close();
  outfile.close();

  std::ofstream myfile;
  myfile.open ( inputfile.c_str(), std::ios::app ) ;
  myfile.close();
  
  
  Executor executor("/lustre/user/thakur/programs/CheckMATE/lustreversion/bin/CheckMATE", "CheckMATE");
  executor.AddArgument(inputfile);

  std::cout<<"Start ChekMATE execution "<<std::endl;
  executor.Execute();
  std::cout<<"Finished ChekMATE execution "<<std::endl;
  
  //Storing the cutflow in doubles.

  std::ifstream file( "/lustre/user/thakur/programs/CheckMATE/lustreversion/results/atlas_conf_2013_079/analysis/000_atlas_conf_2013_079_signal.dat" );
  std::string line;

  TString character;
  
  while ( ! character.BeginsWith( "Cut " ) ) {
    
    std::getline( file, line );
    character = line.c_str();  
    
  }
  
  
  
  while ( file ) {
    
    
    std::string name;
    double Sum_W;
    double Sum_W2;
    double Acc;
    double N_Norm;
    file >> name >> Sum_W >> Sum_W2 >> Acc >> N_Norm;
    
    character = name.c_str();
    if (name=="") break;
    _acc_map[name]=Acc;
    std::cout<<"name: "<<name<<" acc: "<<Acc<<std::endl;
    
  }
  
}

void Fittino::CheckMATECalculator::SetupMeasuredValues() {
  
  
}


void Fittino::CheckMATECalculator::Initialize() {
  
}
