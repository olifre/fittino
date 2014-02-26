/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SPhenoSLHACalculator.cpp                                         *
*                                                                              *
* Description Wrapper class for SPheno                                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>
#include <sstream>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

#include <sys/types.h>
#include <sys/wait.h>

#include <boost/filesystem.hpp>
#include <boost/foreach.hpp>
#include <boost/lexical_cast.hpp>
#include "boost/property_tree/ptree.hpp"


#include "PhysicsModel.h"
#include "SLHADataStorageBase.h"
#include "SPhenoSLHACalculator.h"
#include "SLHALine.h"
#include "ConfigurationException.h"
#include "CalculatorException.h"
#include "TimeoutExecutorException.h"

Fittino::SPhenoSLHACalculator::SPhenoSLHACalculator( const boost::property_tree::ptree& ptree, const PhysicsModel* model )
  : SLHACalculatorBase( model ),
    _executor( "./SPheno", "SPheno" ) {

    _executableName     = "./SPheno";
    _name               = "SPheno";
    _slhaInputFileName  = "LesHouches.in";
    _slhaOutputFileName = "SPheno.spc";

    _executor.SetCompletionTimeout(5);

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "SLHALine" ) {

            _lines.push_back( new SLHALine( node.second, model ) );

        }

    }

}

Fittino::SPhenoSLHACalculator::~SPhenoSLHACalculator() {

    for ( unsigned int i = 0; i < _lines.size(); i++ ) {

        delete _lines[i];

    }

}

void Fittino::SPhenoSLHACalculator::CalculatePredictions() {

    if ( boost::filesystem::exists( _slhaInputFileName ) ) {

        boost::filesystem::rename( _slhaInputFileName, _slhaInputFileName + ".last" );

    }

    if ( boost::filesystem::exists( _slhaOutputFileName ) ) {

        boost::filesystem::rename( _slhaOutputFileName, _slhaOutputFileName + ".last" );

    }

    ConfigureInput();

    _slhaInputDataStorage->WriteFile( _slhaInputFileName );

    try {

        _returnValue = _executor.Execute();

    }
    catch ( const TimeoutExecutorException& e ) {

        throw CalculatorException( _name, "timeout" );

    }

    if ( _returnValue !=0 ) {

      throw  CalculatorException( _name, "Return value " + boost::lexical_cast<std::string>( _returnValue ) );

    }
    
    _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );

}

void Fittino::SPhenoSLHACalculator::ConfigureInput() {

    // Write block "MODSEL".

    _slhaInputDataStorage->AddBlock( "MODSEL:BLOCK MODSEL:# Model selection" );
    _slhaInputDataStorage->AddLine( "MODSEL:1:1:# " + _model->GetName() );
    //_slhaInputDataStorage->AddLine( "MODSEL:12:1000:# Q_EWSB (fixed)" );

    // Write block "SMINPUTS".

    _slhaInputDataStorage->AddBlock( "SMINPUTS:BLOCK SMINPUTS:# Standard model inputs" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:1:1.279250e+02:# 1/alpha_em (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:2:1.166370e-05:# G_F (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:3:1.176000e-01:# alpha_s (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:4:9.118750e+01:# mZ (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:5:4.200000e+00:# mb(mb) (fixed)" );
    //    _slhaInputDataStorage->AddLine( "SMINPUTS:6:1.724000e+02:# mtop (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:7:1.776840e+00:# mtau (fixed)" );


    // Write block "MINPAR".

    _slhaInputDataStorage->AddBlock( "MINPAR:BLOCK MINPAR:# Input parameters" );


    // Write block "SPHENOINPUT".

    _slhaInputDataStorage->AddBlock( "SPHENOINPUT:BLOCK SPHENOINPUT:# SPheno specific input" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:1:0:# error level" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:2:0:# if 1, then SPA conventions are used" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:11:1:# calculate branching ratios" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:12:1.00000000E-04:# write only branching ratios larger than this value" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:21:0:# calculate cross section" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:22:1.000000e+03:# cms energy in GeV" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:23:0.000000e+00:# polarisation of incoming e- beam" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:24:0.000000e+00:# polarisation of incoming e+ beam" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:25:1:# ISR is calculated" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:26:1.00000000E-05:# write only cross sections larger than this value [fb]" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:31:-1.00000000E+00:# m_GUT, if < 0 than it determined via g_1=g_2" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:32:0:# require strict unification g_1=g_2=g_3 if '1' is set" );
    //    _slhaInputDataStorage->AddLine( "SPHENOINPUT:63:1.270000e+00:# m_c(Q) (fixed)" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:80:1:# SPheno exits with non-zero value for sure" );

    // Add parameter point dependent lines to block "MINPAR".

    for ( unsigned int i = 0; i < _lines.size(); i++ ) {

        _slhaInputDataStorage->AddLine( *_lines.at( i ) );

    }

}

