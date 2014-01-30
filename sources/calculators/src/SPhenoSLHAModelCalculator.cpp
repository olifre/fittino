/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SPhenoSLHAModelCalculator.cpp                                    *
*                                                                              *
* Description Wrapper class for SPheno                                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>
#include <sstream>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/wait.h>

#include "boost/property_tree/ptree.hpp"
#include <boost/foreach.hpp>

#include "PhysicsModelBase.h"
#include "SLHADataStorageBase.h"
#include "SPhenoSLHAModelCalculator.h"
#include "SLHALine.h"

Fittino::SPhenoSLHAModelCalculator::SPhenoSLHAModelCalculator( const boost::property_tree::ptree& ptree, const PhysicsModelBase* model )
        :SLHAModelCalculatorBase( model ) {

    _callMethod         = EXECUTABLE;
    _executableName     = "../SPheno";
    _name               = "SPheno";
    _slhaInputFileName  = "LesHouches.in";
    _slhaOutputFileName = "SPheno.spc";
    
    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "SLHALine" ) {
	  
	  _lines.push_back( new SLHALine( node.second, model ) );

	}

    }

}

Fittino::SPhenoSLHAModelCalculator::~SPhenoSLHAModelCalculator() {

  for ( unsigned int i=0; i<_lines.size(); i++ ) {

    delete _lines[i];

  }

}

void Fittino::SPhenoSLHAModelCalculator::Initialize() const {

}

void Fittino::SPhenoSLHAModelCalculator::ConfigureInput() {

    // Write block "MODSEL".

    _slhaInputDataStorage->AddBlock( "MODSEL:BLOCK MODSEL:# Model selection" );
    _slhaInputDataStorage->AddLine( "MODSEL:1:1:# " + _model->GetName() );
    _slhaInputDataStorage->AddLine( "MODSEL:12:1000:# Q_EWSB (fixed)" );

    // Write block "SMINPUTS".

    _slhaInputDataStorage->AddBlock( "SMINPUTS:BLOCK SMINPUTS:# Standard model inputs" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:1:1.279250e+02:# 1/alpha_em (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:2:1.166370e-05:# G_F (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:3:1.176000e-01:# alpha_s (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:4:9.118750e+01:# mZ (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:5:4.200000e+00:# mb(mb) (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:6:1.724000e+02:# mtop (fixed)" );
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
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:63:1.270000e+00:# m_c(Q) (fixed)" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:80:1:# SPheno exits with non-zero value for sure" );

    // Add parameter point dependent lines to block "MINPAR".

    for ( unsigned int i = 0; i < _lines.size(); i++ ) {

        _slhaInputDataStorage->AddLine( *_lines.at(i) );

      }

}

void Fittino::SPhenoSLHAModelCalculator::CallExecutable() {

    int returnValue = 0;

    int pid = -2;
    int status = 0;
    int child_pid = 0;

     // Get a child process.

    if ( ( pid = fork() ) < 0 ) {

        // NOTE: perror() produces a short error message on the standard error describing the
        // last error encountered during a call to a system or library function.

        perror( "fork" );
        exit( 1 );

    }

    if ( pid == 0 ) {

      // The child executes the code inside this if.

      child_pid = getpid();
      //char* argv[2];
      //argv[0] = "";
      //argv[1] = 0;

      //char* const argv[] = { "", NULL };
      char* argv[1] = { NULL };
      
      returnValue = execve( _executableName.c_str(), argv, environ );
      _exit( 255 );
      //returnValue = system( _executableName.c_str() );

    }
    else {

        // The parent executes this.

        int counter = 0;

        while ( true ) {

            counter++;

            if ( waitpid ( pid, &status, WNOHANG ) == pid ) {

                break;

            }
            //if ( yyMaxCalculatorTime < ( float )counter / 10. ) {

            //    std::cout << "Killing child process " << pid << " due to too much time" << std::endl;
            //    kill ( pid, 9 );
            //    waitpid ( -1, &status, 0 );
            //    return( 1 );

            //}
            usleep ( 100000 );
        }
    }

    //returnValue = WEXITSTATUS( status );

    //if ( returnValue > 0 ) {

    //    return returnValue;

    //}

    //return 0;

}

void Fittino::SPhenoSLHAModelCalculator::CallFunction() {

}
