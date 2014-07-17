
/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CheckMATECalculator.cpp                                          *
*                                                                              *
* Description      Wrapper around CheckMATE                                    *
* Authors: Uddhipan Thakur                                                                      *
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

Fittino::CheckMATECalculator::CheckMATECalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model ), 
    // Initialize input quantities.                                                                                                                                                      
     _a  ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "a.Name", "a" ) )->GetValue() ),
     _b  ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "b.Name", "b" ) )->GetValue() ),
     _c  ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "c.Name", "c" ) )->GetValue() ),
     _d  ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "d.Name", "d" ) )->GetValue() ) 

{
    

    std::cout<<"Hello World!"<<std::endl;
   
    _name = "CheckMATE";


   Messenger& messenger = Messenger::GetInstance();

   messenger << Messenger::ALWAYS << Messenger::Endl;
   messenger << Messenger::ALWAYS << "Test line 1" << Messenger::Endl;
   messenger << Messenger::ALWAYS << Messenger::Endl;
   messenger << Messenger::ALWAYS << "test line 2" << Messenger::Endl;
   messenger << Messenger::ALWAYS << Messenger::Endl;
   std::string configurationOption1 = ptree.get<std::string>( "MyFirstConfigurationOption" );
}

Fittino::CheckMATECalculator::~CheckMATECalculator() {


}

void Fittino::CheckMATECalculator::CalculatePredictions() {
  Executor executor("/afs/atlass01.physik.uni-bonn.de/user/thakur/programs/Madgraph_v2_1_1/bin/mg5", "mg5");
  executor.AddArgument("/afs/atlass01.physik.uni-bonn.de/user/thakur/programs/Madgraph_v2_1_1/a.txt");
  executor.Execute();
}

void Fittino::CheckMATECalculator::SetupMeasuredValues() {
    

}


void Fittino::CheckMATECalculator::Initialize() {

}
