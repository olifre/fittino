/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Controller.cpp                                                   *
*                                                                              *
* Description Singleton class for controlling the execution flow of Fittino    *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <getopt.h>

#include <cstdlib>
#include <iostream>

#include "Configuration.h"
#include "Controller.h"
#include "FittinoInputFileInterpreter.h"
#include "InputFileException.h"
#include "OptimizerBase.h"
#include "XMLInputFileInterpreter.h"

Fittino::Controller* Fittino::Controller::GetInstance() {

    if ( !_instance ) {

        _instance = new Controller();

    }

    return _instance;

}

void Fittino::Controller::InitializeFittino( int argc, char** argv ) {

    while ( true ) {

        static struct option options[] = {

            {"input-file", required_argument, 0, 'i'},
            {"help",       no_argument,       0, 'h'},
            {"seed",       required_argument, 0, 's'}

        };

        int optionIndex = 0;
        int optionCode = getopt_long( argc, argv, "i:hs:", options, &optionIndex );

        if ( optionCode == -1 ) break; 

        switch ( optionCode ) {

            case 'i':
                _inputFileName = std::string( optarg );
                continue;

            case 'h':
                Fittino::Controller::PrintHelp();
                exit( EXIT_SUCCESS );

            case 's':
                _randomSeed = atoi( optarg );
                continue;

        }

    }

    if ( Fittino::Controller::GetInputFileFormat() == InputFileInterpreterBase::FITTINOINPUTFILE ) {

        Fittino::FittinoInputFileInterpreter* inputFileInterpreter = new Fittino::FittinoInputFileInterpreter();
        inputFileInterpreter->Parse( _inputFileName );
        delete inputFileInterpreter;

    }
    else if ( Fittino::Controller::GetInputFileFormat() == InputFileInterpreterBase::XMLINPUTFILE ) {

        Fittino::XMLInputFileInterpreter* inputFileInterpreter = new Fittino::XMLInputFileInterpreter();
        inputFileInterpreter->Parse( _inputFileName );
        delete inputFileInterpreter;

    }

}

void Fittino::Controller::ExecuteFittino() {

    try {

        //switch ( Configuration::GetInstance()->GetSteeringParameter( "ExecutionMode", (int)ExecutionMode::OPTIMIZATION ) ) {

            //case ExecutionMode::OPTIMIZATION:
                OptimizerBase* optimizer = Configuration::GetInstance()->GetOptimizer();
                optimizer->Execute();
                //std::cout << "Parameter optimization not supported yet\n" << std::endl; 
                exit( EXIT_SUCCESS );
                //throw InputFileException( "Parameter optimization not supported yet" );

            //case ExecutionMode::SCAN:
            //    std::cout << "Parameter scan not supported yet\n" << std::endl; 
            //    exit( EXIT_SUCCESS );
            //    //throw InputFileException( "Parameter scan not supported yet" );

        //}

    }
    catch ( InputFileException& inputFileException ) {

        std::cout << "\n" << inputFileException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}

void Fittino::Controller::TerminateFittino() {

}

Fittino::Controller* Fittino::Controller::_instance = 0;

Fittino::Controller::Controller() {

}

Fittino::Controller::~Controller() {

}

void Fittino::Controller::PrintHelp() {

    std::cout << std::endl;
    std::cout << "Usage: fittino [<parameters>]" << std::endl;
    std::cout << std::endl;
    std::cout << "Supported parameters are:" << std::endl;
    std::cout << std::endl;
    std::cout << "  <inputfile>" << std::endl;
    std::cout << "      If only a single parameter is given (different from \"-h\" or \"--help\")," << std::endl;
    std::cout << "      Fittino reads in input file <inputfile>." << std::endl;
    std::cout << "      Input file suffix must be .ftn (Fittino format) or .xml (XML format)." << std::endl;
    std::cout << std::endl;
    std::cout << "  -h, --help" << std::endl;
    std::cout << "      Fittino prints this message." << std::endl;
    std::cout << std::endl;
    std::cout << "  -i <inputfile>" << std::endl;
    std::cout << "      Fittino uses input file <inputfile>." << std::endl;
    std::cout << "      Input file suffix must be .ftn (Fittino format) or .xml (XML format)." << std::endl;
    std::cout << std::endl;
    std::cout << "  -s <seed>" << std::endl;
    std::cout << "      Fittino uses the given random number generator seed." << std::endl;
    std::cout << std::endl;

}

Fittino::InputFileInterpreterBase::InputFileFormat Fittino::Controller::GetInputFileFormat() {

    try {

        if ( _inputFileName.length() < 5 ) {

            throw InputFileException( "Invalid input file name" );

        }

        if ( !_inputFileName.compare( _inputFileName.length() - 4, 4, ".ftn" ) ) {

            return Fittino::InputFileInterpreterBase::FITTINOINPUTFILE;

        }
        else if ( !_inputFileName.compare( _inputFileName.length() - 4, 4, ".xml" ) ) {

            return Fittino::InputFileInterpreterBase::XMLINPUTFILE;

        }
        else {

            throw InputFileException( "Input file suffix must be .ftn (Fittino format) or .xml (XML format)." );

        }

    }
    catch ( InputFileException& inputFileException ) {

        std::cout << "\n" << inputFileException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}
