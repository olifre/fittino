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

#include <boost/filesystem.hpp>
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
    _cWW ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "cWW.Name","cWW" ) )->GetValue() ),
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
  
  // std::string configurationOption1 = ptree.get<std::string>( "MyFirstConfigurationOption" );

  BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {

    if( node.first == "Parameter" ) {

      std::string parameterName    = node.second.get<std::string>( "Name"     );
      std::string quantityName = node.second.get<std::string>( "Quantity" );

      const Quantity* quantity  = _model->GetCollectionOfQuantities().At( quantityName );

      _input[parameterName] = quantity;
            
    }
        
  }

}



Fittino::MadGraphCalculator::~MadGraphCalculator() {
  
}


void Fittino::MadGraphCalculator::CalculatePredictions() {
  
  std::string originalinputfile = "/lustre/user/thakur/programs/madgraph_aMC_v2_2_2/runmadgraph.txt";
  std::string inputfile = "fittino_madgraph_in.txt"; 

  std::ifstream infile( originalinputfile.c_str(), std::ios::binary );
  std::ofstream outfile( inputfile.c_str(),    std::ios::binary );
  outfile << infile.rdbuf();
  infile.close();
  outfile.close();

  std::ofstream myfile;
  myfile.open ( inputfile.c_str(), std::ios::app ) ;

  // loop over _input Collection and set all contained parameters

  for(std::map<std::string, const Quantity*>::iterator i = _input.begin(); i != _input.end(); ++i)
    {
      std::string name = i->first;
      const Quantity* quantity = i->second;
      double value = quantity->GetValue();
      myfile <<"set " + name + " " <<value<<std::endl;
    }
  
  myfile.close();
  
  
  Executor executor("./mg5_aMC", "mg5_aMC");
  executor.AddArgument(inputfile);
  executor.Execute();

  std::string zipfile = "./testprocess/Events/run_01/tag_1_pythia_events.hep.gz";
  Executor unzip("/bin/gunzip", "gunzip");
  unzip.AddArgument(zipfile);
  unzip.Execute();

}

              
                                                                                                                                                     
void Fittino::MadGraphCalculator::SetupMeasuredValues() {
  
  
}

void Fittino::MadGraphCalculator::Initialize() {
  
}
