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
#include "LogicException.h"
#include "SimplePrediction.h"
#include "CheckMATE2Calculator.h"

Fittino::CheckMATE2Calculator::CheckMATE2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  :CalculatorBase( model, &ptree )
  ,_inputFile( ptree.get_child("InputFile"), model ) {

  _executable = ptree.get<std::string>( "Executable" );
  _fullCLs = false; // todo determine value
  _directory = ptree.get<std::string>( "Directory" ); 

  AddQuantity(new SimplePrediction( "r", "", _r));
  AddQuantity(new SimplePrediction("CLs", "", _cls));
  
}

Fittino::CheckMATE2Calculator::~CheckMATE2Calculator() {

} 


void Fittino::CheckMATE2Calculator::ReadResult() {
  
  std::ifstream file( _directory + "/result.txt" );
  if( !file.is_open() ) throw LogicException("Cannot open result.txt.");

  std::string line;

  for ( unsigned int i = 0; i < 5; ++i ) getline(file, line);

  std::string clsid = "Result for CLs: cls_min = "; 
  std::string rid = "Result for r: r_max = ";

  if ( _fullCLs ) {

    if ( !boost::starts_with( line, clsid ) ) throw LogicException( "CheckMATECalculator: Expected CLs in result.txt." );
     boost::algorithm::erase_first( line, clsid );
     _cls = std::stod( line );
     getline( file, line );

  }
   
    if ( !boost::starts_with( line, rid ) ) throw LogicException( "CheckMATECalculator: Expected r in result.txt, got " + line );
     boost::algorithm::erase_first( line, rid );
     _r = std::stod( line );

  file.close();  

}

void Fittino::CheckMATE2Calculator::CalculatePredictions() {

  _inputFile.Write();
  
  Executor executor( _executable, "CheckMATE" );
  executor.AddArgument( _inputFile.GetName() );
  executor.Execute();

  ReadResult();

}
