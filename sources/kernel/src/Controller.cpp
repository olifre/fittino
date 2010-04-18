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

    for ( int i = 1; i <= argc; i++ ) {

        if ( argc == 1 || ( argc == 2 && !strcmp( argv[1], "-h" ) ) || ( argc == 2 && !strcmp( argv[1], "--help" ) ) ) {

            Fittino::Controller::PrintHelp();
            exit( EXIT_SUCCESS );

        }
        else if ( argc == 2 ) {

            _inputFileName = std::string( argv[1] );

        }
        else {

            if ( !strcmp( argv[i], "-i" ) ) {

                i++;
                _inputFileName = std::string( argv[i] );
                continue;

            }
            if ( !strcmp( argv[i], "-s" ) ) {

                i++;
                _randomSeed = atoi( argv[i] );
                continue;

            }

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

    //switch ( Configuration::GetInstance()->GetExecutionMode() ) {

    //case ExecutionMode::OPTIMIZATION:
    //    OptimizerBase* optimizer = Configuration::GetInstance()->GetOptimizer();
    //    optimizer->Execute();

    //}

}

void Fittino::Controller::TerminateFittino() {

}

Fittino::Controller* Fittino::Controller::_instance = 0;

Fittino::Controller::Controller()
        : _inputFileFormat( Fittino::InputFileInterpreterBase::XMLINPUTFILE ) {

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
