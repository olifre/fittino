/*******************************************************************************  
 *                                                                              *                      
 * Project     Fittino - A SUSY Parameter Fitting Package                       *             
 *                                                                              *         
 * File        CheckMATE2Calculator.cpp                                         *          
 * Description: Wrapper around CheckMATE                                        * 
 * Authors:     Nanette Range                                                   *           
 *                                                                              *               
 * Licence     This program is free software; you can redistribute it and/or    *            
 *             modify it under the terms of the GNU General Public License as   *  
 *             published by the Free Software Foundation; either version 3 of   *                             
 *             the License, or (at your option) any later version.              *
 *                                                                              *           
 *******************************************************************************/

#include <iostream>
#include <boost/property_tree/ptree.hpp>
#include <fstream>
#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>

#include "ModelBase.h"
#include "Executor.h"
#include "SimplePrediction.h"
#include "CheckMATE2Calculator.h"

Fittino::CheckMATE2Calculator::CheckMATE2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  :CalculatorBase( model, &ptree ) {

  for ( const auto& node : *GetConfiguration() ) {

    if ( node.first != "Process" ) continue; 

    AddProcess( node.second );

  }

  AddQuantity(new SimplePrediction( "r", "", _r));
  AddQuantity(new SimplePrediction("cl", "", _cl));
  AddQuantity(new SimplePrediction( "r_cl", "", _r_cl));
  
}

Fittino::CheckMATE2Calculator::~CheckMATE2Calculator() {

} 

void Fittino::CheckMATE2Calculator::AddProcess( const boost::property_tree::ptree& ptree ) {

   std::string name = ptree.get<std::string>( "Name" );

   if( std::count( _processes.begin(), _processes.end(), name ) ) {

       throw ConfigurationException( "CheckMATE2Calculator: Process " + name + " is configured multiple times." );

   }

   _processes.push_back( name );

   // todo: get crosssection and crosssection errors

   for ( const auto& node : ptree ) {
    
      if ( node.first != "Events" ) continue;

      _events[name].push_back( node.second.get_value<std::string>() );

  }

}

void Fittino::CheckMATE2Calculator::CalculatePredictions() {

  double xsec = _model->GetCollectionOfQuantities().At("Herwigpp_Total_Xsec")->GetValue();
  std::string Xsec = boost::lexical_cast<std::string>(xsec);
  std::string Xsec_unit = Xsec + "*NB";
  //double xsec_error = _model->GetCollectionOfQuantities().At("Herwigpp_Total_Xsec_error")->GetValue();
  //std::string Xsec_error = boost::lexical_cast<std::string>(xsec_error);
  //std::string Xsec_error_unit = Xsec_error + "*NB";

  std::string inputfile = "/lustre/user/range/fittino/bin/LHC-MSSM.hepmc";
   
  Executor executor( "/lustre/fittino/group/external/SL6/CheckMATE/CheckMATE-1.2.0/bin/CheckMATE","CheckMATE");
  executor.AddArgument( "-n" );
  executor.AddArgument( "/lustre/user/range/fittino/bin/Last_Run" );
  executor.AddArgument( "-a" );
  executor.AddArgument( "atlas" );
  executor.AddArgument( "-cl" );
  executor.AddArgument( "-q" );
  executor.AddArgument( "-t" );
  executor.AddArgument( "-oe" );
  executor.AddArgument( "overwrite" );
  executor.AddArgument( "-p" );
  executor.AddArgument( "gluinogluino" );
  executor.AddArgument( "-xs" );
  executor.AddArgument( Xsec_unit );
  executor.AddArgument( "-xse" );
  executor.AddArgument( "0*NB" );
  executor.AddArgument( inputfile );

  executor.Execute();

  std::ifstream file1;
  std::string line1;

  file1.open("/lustre/user/range/fittino/bin/Last_Run/result.txt");
  
  while(getline(file1, line1)) {

    typedef std::vector< std::string> split_vector_type;
   
    split_vector_type SplitVec;
    split( SplitVec, line1, boost::is_any_of(" "), boost::token_compress_on);
  
    if(SplitVec.size() > 4) {
      
      if (SplitVec[3] == "cls_min") {

	std::string CL = SplitVec[5];
	_cl = boost::lexical_cast <double>(CL);
      }
    }

    if(SplitVec.size() > 4) {
      if(SplitVec[3] == "r_max") {

	std::string R = SplitVec[5];
	_r_cl = boost::lexical_cast <double>(R);

      }
    }  

  }
      
  file1.close();  

  Executor executorR( "/lustre/fittino/group/external/SL6/CheckMATE/CheckMATE-1.2.0/bin/CheckMATE","CheckMATE");
  executorR.AddArgument( "-n" );
  executorR.AddArgument( "/lustre/user/range/fittino/bin/Last_Run" );
  executorR.AddArgument( "-a" );
  executorR.AddArgument( "atlas" ); 
  executorR.AddArgument( "-cl" );
  executorR.AddArgument( "-q" );
  executorR.AddArgument( "-t" );
  executorR.AddArgument( "-oe" );
  executorR.AddArgument( "overwrite" );
  executorR.AddArgument( "-p" );
  executorR.AddArgument( "total" );
  executorR.AddArgument( "-xs" );
  executorR.AddArgument( Xsec_unit );
  executorR.AddArgument( "-xse" );
  executorR.AddArgument( "0*NB" );
  executorR.AddArgument( inputfile );
  executorR.Execute();


  std::ifstream file2;
  std::string line2;
 
  file2.open("/lustre/user/range/fittino/bin/Last_Run/result.txt");

  while(getline(file2, line2)) {

    typedef std::vector< std::string> split_vector_type;

    split_vector_type SplitVec;
    split( SplitVec, line2, boost::is_any_of(" "), boost::token_compress_on);

    if(SplitVec.size() > 4) {
      if(SplitVec[3] == "r_max") {
	
	std::string R = SplitVec[5]; 
	_r = boost::lexical_cast <double>(R);
	
       }

      else continue;
      
     }
  }
 
  file2.close();


}

void Fittino::CheckMATE2Calculator::SetupMeasuredValues() {

}

void Fittino::CheckMATE2Calculator::Initialize() {

}
