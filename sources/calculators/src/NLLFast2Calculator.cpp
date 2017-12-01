/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 o* File        NLLFastCalculator.cpp                                            *
 *
 * Description: Wrapper around NLL-Fast                                         *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              * 
 *
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
#include "NLLFast2Calculator.h"
#include "Executor.h"
#include "LogicException.h"

Fittino::NLLFast2Calculator::NLLFast2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

  _griddir = GetConfiguration()->get<std::string>( "Directory" );
  _executable = GetConfiguration()->get<std::string>( "Executable" );

  AddInput("Mass_s");
  AddInput("Mass_g");
  AddInput("Mass_b1");
  AddInput("Mass_b2");
  AddInput("Mass_t1");
  AddInput("Mass_t2");

  _pdfs.push_back( "cteq" );

  _lowerBounds["gg"] = { 200, 200 };
  _upperBounds["gg"] = { 4500, 2500 };

  _lowerBounds["sg"] = { 200, 200 };
  _upperBounds["sg"] = { 4500, 2500 };

  _lowerBounds["ss"] = { 200, 200 };
  _upperBounds["ss"] = { 2500, 2500 };

  _lowerBounds["sb"] = { 200, 200 };
  _upperBounds["sb"] = { 2500, 2500 };

  _lowerBounds["st"] = { 100 };
  _upperBounds["st"] = { 2000 };
  

  std::vector<std::string> processes = { "sb", "ss", "gg", "sg", "tb1", "tb2", "bb1", "bb2" };
  
 for( const auto& process :processes  ) {

     for( const auto& pdf : _pdfs ) {

  AddOutput( "NFast_xs_LO_" + pdf + "_" + process );
  AddOutput( "NFast_xs_NLO_" + pdf + "_" + process );
  AddOutput( "NFast_xs_NLL_" + pdf + "_" + process );
  AddOutput( "NFast_Error_mu_plus_" + pdf + "_" + process );
  AddOutput( "NFast_Error_mu_minus_" + pdf + "_" + process );
  AddOutput( "NFast_Error_pdf_plus_" + pdf + "_" + process );
  AddOutput( "NFast_Error_pdf_minus_" + pdf + "_" + process );
  AddOutput( "NFast_Error_alphas_plus_" + pdf + "_" + process );
  AddOutput( "NFast_Error_alphas_minus_" + pdf + "_" + process );
  AddOutput( "NFast_k_NLO_" + pdf + "_" + process );
  AddOutput( "NFast_k_NLL_" + pdf + "_" + process );
 
     } 
 }

}

Fittino::NLLFast2Calculator::~NLLFast2Calculator() {

}

void Fittino::NLLFast2Calculator::SetToZero( std::string process ) {

    double zero = 0; 

 for ( const auto& pdf : _pdfs ) {

  SetOutput( "NFast_xs_LO_" + pdf + "_" + process, zero );
  SetOutput( "NFast_xs_NLO_" + pdf + "_" + process, zero );
  SetOutput( "NFast_xs_NLL_" + pdf + "_" + process, zero );
  SetOutput( "NFast_Error_mu_plus_" + pdf + "_" + process, 0 );
  SetOutput( "NFast_Error_mu_minus_" + pdf + "_" + process, 0 );
  SetOutput( "NFast_Error_pdf_plus_" + pdf + "_" + process, 0 );
  SetOutput( "NFast_Error_pdf_minus_" + pdf + "_" + process, 0 );
  SetOutput( "NFast_Error_alphas_plus_" + pdf + "_" + process, 0 );
  SetOutput( "NFast_Error_alphas_minus_" + pdf + "_" + process, 0 );
  SetOutput( "NFast_k_NLO_" + pdf + "_" + process, 1 );
  SetOutput( "NFast_k_NLL_" + pdf + "_" + process, 1 );

 } 

}

void Fittino::NLLFast2Calculator::Call( std::string process, std::string outputProcess, std::string pdf, std::vector<double> masses ) {

  Executor executor( _executable, "nllfast");
  executor.AddArgument( process );
  executor.AddArgument( pdf  );
  
    for (unsigned int i = 0; i < masses.size(); i++ ) {

        if( masses[i] < _lowerBounds[process][i] ||
                masses[i] > _upperBounds[process][i] ||
                process == "st" && masses[0] > GetInput("Mass_gluino") ) {

            SetToZero(outputProcess);
            return;

        }

  executor.AddArgument( std::to_string( masses[i] ) );
    }
  executor.Execute();

  ReadFile( process + ".out", outputProcess, pdf, masses.size() ); 

}

void Fittino::NLLFast2Calculator::ReadFile( std::string file, std::string process, std::string pdf, unsigned int offset ) {

  std::ifstream stream( file );
  std::string line;

  for ( unsigned int i = 0; i < 6; ++i ) getline( stream, line );

  boost::algorithm::trim_left( line );

  std::vector<std::string> words;
  split( words, line, boost::is_any_of(" "), boost::token_compress_on );

  if ( words.size() != offset + 11 ) throw LogicException("NLL-fast:Error in reading file " + file + " in line " + line ); 

  std::vector<std::string> outputs = { "NFast_xs_LO", "NFast_xs_NLO", "NFast_xs_NLL", "NFast_Error_mu_plus", "NFast_Error_mu_minus", "NFast_Error_pdf_plus", "NFast_Error_pdf_minus", "NFast_Error_alphas_plus", "NFast_Error_alphas_minus", "NFast_k_NLO", "NFast_k_NLL" };

  for( const auto& output : outputs ) {

  SetOutput( output +  "_" + pdf + "_" + process, std::stod( words[offset] ) );
  ++offset;
  }


}

void Fittino::NLLFast2Calculator::CalculatePredictions() {

    UpdateInput();

    double mass_s   =  GetInput( "Mass_s" );
    double mass_g   =  GetInput( "Mass_g" );
    double mass_t1  =  GetInput( "Mass_t1" );
    double mass_t2  =  GetInput( "Mass_t2" );
    double mass_b1  =  GetInput( "Mass_b1" );
    double mass_b2  =  GetInput( "Mass_b2" );




  boost::filesystem::path cwd( boost::filesystem::current_path() );

try {

  boost::filesystem::current_path( _griddir );

  Call( "gg", "gg", "cteq", { mass_s, mass_g } );
  Call( "sg", "sg", "cteq", { mass_s, mass_g } );
  Call( "ss", "ss", "cteq", { mass_s, mass_g } );
  Call( "sb", "sb", "cteq", { mass_s, mass_g } );
  Call( "st" , "tb1", "cteq", { mass_t1 } );
  Call( "st" , "tb2", "cteq", { mass_t2 } );
  Call( "st" , "bb1", "cteq", { mass_b1 } );
  Call( "st" , "bb2", "cteq", { mass_b2 } );

  boost::filesystem::current_path( cwd );

}
catch(...) {

  boost::filesystem::current_path( cwd );
  throw;

}

}

