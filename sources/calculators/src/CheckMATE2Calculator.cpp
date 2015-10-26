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

  _inputFileName = GetConfiguration()->get<std::string>( "InputFile" );
  _run = GetConfiguration()->get<std::string>( "Run" );

  for ( const auto& node : *GetConfiguration() ) {

    if ( node.first == "Analysis" ) _analyses.push_back( node.second.get_value<std::string>() );
    else if ( node.first == "Process" ) AddProcess( node.second );

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

   AddInput( name + ".CrossSection",      ptree.get<std::string>( "CrossSection.Value"      ) );   
   AddInput( name + ".CrossSectionError", ptree.get<std::string>( "CrossSectionError.Value" ) );   

   _unitOfCrossSection[name] = ptree.get<std::string>( "CrossSection.Unit" );  
   _unitOfCrossSectionError[name] = ptree.get<std::string>( "CrossSectionError.Unit" );  

   for ( const auto& node : ptree ) {
    
      if ( node.first != "Events" ) continue;

      _events[name].push_back( node.second.get_value<std::string>() );

  }

}

void Fittino::CheckMATE2Calculator::WriteInputFile() {

  std::ofstream infile( _inputFileName );
  if ( !infile.is_open() ) throw ConfigurationException( "Can't create input file for CheckMATE." );

  infile << "[Mandatory Parameters]" << std::endl; 
  infile << "Name: " << _run << std::endl; 
  infile << "Analyses: ";

  for ( const auto& analysis : _analyses ) {

     infile << analysis;
     if( std::addressof( analysis ) != std::addressof( _analyses.back() ) ) infile << ", ";

  } 

  infile << std::endl << std::endl;

  infile << "[Optional Parameters]" << std::endl << std::endl;
  infile << std::endl;
 
  for ( const auto& process : _processes ) {
 
     infile << "[" << process << "]" << std::endl; 
     infile << "XSect: " << GetInput( process + ".CrossSection" ) << "*" << _unitOfCrossSection.at( process ) << std::endl;
     infile << "Events: ";
     
    for ( const auto& file : _events.at( process ) ) {

        infile << file;
        if( std::addressof(file) != std::addressof( _events.at( process ).back() ) ) infile << ", ";

    }

   infile << std::endl;

  }

}

void Fittino::CheckMATE2Calculator::ReadResults() {
  
  std::ifstream file;
  std::string line;

  file.open("/lustre/user/range/fittino/bin/Last_Run/result.txt");
  
  for ( unsigned int i = 0; i < 4 ) getline(file, line);

  std::string clsid = "Result for CLs: cls_min = "; 
  std::string rid = "Result for r: r_max = ";

  if ( _fullCLs ) {

    if ( !boost::starts_with( line, clsid ) ) throw LogicException( "CheckMATECalculator: Expected CLs in result.txt." );
     boost::algorithm::erase_first( line, clsid );
     _cl = std::stod( line );
     getline( file, line );

  }
   
    if ( !boost::starts_with( line, rid ) ) throw LogicException( "CheckMATECalculator: Expected r in result.txt." );
     boost::algorithm::erase_first( line, rid );
     _r_cl = std::stod( line );

  file.close();  

}

void Fittino::CheckMATE2Calculator::CalculatePredictions() {

  UpdateInput();
  WriteInputFile();
  
  Executor executor( "/lustre/fittino/group/external/SL6/CheckMATE/CheckMATE-1.2.0/bin/CheckMATE","CheckMATE");
  executor.AddArgument( _inputFileName );
  executor.Execute();

}
