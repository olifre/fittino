/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        NLLFastCalculator.cpp                                            *
 *
 * Description: Wrapper around NLL-Fast                                         *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              * 
 *                                                                              *
 *******************************************************************************/

#include <iostream>
#include <string>
#include <boost/lexical_cast.hpp>
#include <fstream>
#include <boost/algorithm/string.hpp>
#include <boost/algorithm/string/trim.hpp>
#include "boost/filesystem.hpp"
#include <math.h>

#include "ModelBase.h"
#include "NLLFastCalculator.h"
#include "Executor.h"
#include "LogicException.h"

Fittino::NLLFastCalculator::NLLFastCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

  _griddir = GetConfiguration()->get<std::string>( "Directory" );
  _executable = GetConfiguration()->get<std::string>( "Executable" );

  AddInput("Mass_squark");
  AddInput("Mass_gluino");
  AddInput("Mass_sbottom1");
  AddInput("Mass_sbottom2");
  AddInput("Mass_stop1");
  AddInput("Mass_stop2");

  _pdfs.push_back( "cteq" );

  AddOutput( "OutOfBounds", _outOfBounds );

  std::vector<std::string> processes = { "sb", "ss", "gg", "sg", "tb1", "tb2", "bb1", "bb2" };
  
 for( const auto& process :processes  ) {

     for( const auto& pdf : _pdfs ) {

  AddOutput( "xs_LO_" + pdf + "_" + process );
  AddOutput( "xs_NLO_" + pdf + "_" + process );
  AddOutput( "xs_NLL_" + pdf + "_" + process );
  AddOutput( "Error_mu_plus_" + pdf + "_" + process );
  AddOutput( "Error_mu_minus_" + pdf + "_" + process );
  AddOutput( "Error_pdf_plus_" + pdf + "_" + process );
  AddOutput( "Error_pdf_minus_" + pdf + "_" + process );
  AddOutput( "Error_alphas_plus_" + pdf + "_" + process );
  AddOutput( "Error_alphas_minus_" + pdf + "_" + process );
  AddOutput( "k_NLO_" + pdf + "_" + process );
  AddOutput( "k_NLL_" + pdf + "_" + process );
 
     } 
 }

}

Fittino::NLLFastCalculator::~NLLFastCalculator() {

}

void Fittino::NLLFastCalculator::SetToZero( std::string process ) {

    double zero = 0; 

 for ( const auto& pdf : _pdfs ) {

  SetOutput( "xs_LO_" + pdf + "_" + process, zero );
  SetOutput( "xs_NLO_" + pdf + "_" + process, zero );
  SetOutput( "xs_NLL_" + pdf + "_" + process, zero );
  SetOutput( "Error_mu_plus_" + pdf + "_" + process, 0 );
  SetOutput( "Error_mu_minus_" + pdf + "_" + process, 0 );
  SetOutput( "Error_pdf_plus_" + pdf + "_" + process, 0 );
  SetOutput( "Error_pdf_minus_" + pdf + "_" + process, 0 );
  SetOutput( "Error_alphas_plus_" + pdf + "_" + process, 0 );
  SetOutput( "Error_alphas_minus_" + pdf + "_" + process, 0 );
  SetOutput( "k_NLO_" + pdf + "_" + process, 1 );
  SetOutput( "k_NLL_" + pdf + "_" + process, 1 );

 } 

}

void Fittino::NLLFastCalculator::CallSquarkGluino( std::string process, std::string pdf ) {

  Executor executor( _executable, "nllfast");
  executor.AddArgument( process );
  executor.AddArgument( pdf  );
  executor.AddArgument( _mass_s );
  executor.AddArgument( _mass_g );
  executor.Execute();

  ReadFile( process + ".out", process, pdf, 2 ); 

}

void Fittino::NLLFastCalculator::ReadFile( std::string file, std::string process, std::string pdf, unsigned int offset ) {

  std::ifstream stream( file );
  std::string line;

  for ( unsigned int i = 0; i < 6; ++i ) getline( stream, line );

  boost::algorithm::trim_left( line );

  std::vector<std::string> words;
  split( words, line, boost::is_any_of(" "), boost::token_compress_on );

  if ( words.size() != offset + 11 ) throw LogicException("NLL-fast:Error in reading file " + file + " in line " + line ); 

  std::vector<std::string> outputs = { "xs_LO", "xs_NLO", "xs_NLL", "Error_mu_plus", "Error_mu_minus", "Error_pdf_plus", "Error_pdf_minus", "Error_alphas_plus", "Error_alphas_minus", "k_NLO", "k_NLL" };

  for( const auto& output : outputs ) {

  SetOutput( output +  "_" + pdf + "_" + process, std::stod( words[offset] ) );
  ++offset;
  }


}


void Fittino::NLLFastCalculator::CallStopAndDecoupling( std::string process, std::string outputProcess, std::string pdf, double mass, double massBound ) {

    if ( mass > massBound ) {

        SetToZero( outputProcess );
        return;

    }

  Executor executor( _executable, "nllfast" );
  executor.AddArgument( process );
  executor.AddArgument( pdf );
  executor.AddArgument(  std::to_string( mass ) );
  executor.Execute();

  ReadFile( process + ".out", outputProcess, pdf, 1 ); 

}


void Fittino::NLLFastCalculator::CalculatePredictions() {

    UpdateInput();

    double mass_s   =  GetInput( "Mass_squark" );
    double mass_g   =  GetInput( "Mass_gluino" );
    double mass_t1  =  GetInput( "Mass_stop1" );
    double mass_t2  =  GetInput( "Mass_stop2" );
    double mass_b1  =  GetInput( "Mass_sbottom1" );
    double mass_b2  =  GetInput( "Mass_sbottom2" );

  _outOfBounds = 0;
  if ( mass_g < 200 || mass_s < 200 || mass_t1 < 100 || mass_t2 < 100 ) _outOfBounds = 1;
  if ( mass_g > 2500 || mass_s > 2500 || mass_t1 > 2000 || mass_t2 > 2000  ) _outOfBounds = 1;

  if ( mass_g < 200 ) mass_g = 200;
  if ( mass_s < 200 ) mass_s = 200;
  if ( mass_t1 < 100 ) mass_t1 = 100;
  if ( mass_t2 < 100 ) mass_t2 = 100;
  if ( mass_b1 < 100 ) mass_b1 = 100;
  if ( mass_b2 < 100 ) mass_b2 = 100;

    _mass_s = std::to_string( mass_s );
    _mass_g = std::to_string( mass_g );

  boost::filesystem::path cwd( boost::filesystem::current_path() );

try {

  boost::filesystem::current_path( _griddir );

  if ( mass_g <= 2500 && mass_s <= 4500 ) CallSquarkGluino( "gg", "cteq" );
  else CallStopAndDecoupling("gdcpl", "gg", "cteq", mass_g, 2500. );

  if ( mass_g <= 2500 && mass_s <= 2500 ) CallSquarkGluino( "sb", "cteq" );
  else CallStopAndDecoupling( "sdcpl", "sb", "cteq", mass_s, 2500. ); 

  if ( mass_g <= 2500 && mass_s <= 4500 ) CallSquarkGluino( "sg", "cteq" );
  else SetToZero( "sg" );
  
  if ( mass_g <= 2500 && mass_s <= 2500 ) CallSquarkGluino( "ss", "cteq" );
  else SetToZero( "ss" );

  CallStopAndDecoupling( "st" , "tb1", "cteq", mass_t1, 2000. );
  CallStopAndDecoupling( "st" , "tb2", "cteq", mass_t2, 2000. );
  CallStopAndDecoupling( "st" , "bb1", "cteq", mass_b1, 2000 );
  CallStopAndDecoupling( "st" , "bb2", "cteq", mass_b2, 2000 );

  boost::filesystem::current_path( cwd );

}
catch(...) {

  boost::filesystem::current_path( cwd );
  throw;

}

}

