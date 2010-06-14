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
#include "ConfigurationException.h"
#include "InputException.h"
#include "InputFileInterpreterBase.h"
#include "InputFileInterpreterFactory.h"
#include "ModelBase.h"
#include "ModelFactory.h"
#include "OptimizerBase.h"
#include "OptimizerFactory.h"

Fittino::Controller* Fittino::Controller::GetInstance() {

    if ( !_instance ) {

        _instance = new Controller();

    }

    return _instance;

}

void Fittino::Controller::InitializeFittino( int argc, char** argv ) {

    // If Fittino is called without options or arguments print a help text with
    // further instructions and exit.

    if ( argc == 1 ) {

        Fittino::Controller::PrintHelp();
        exit( EXIT_SUCCESS );

    }

    // Otherwise use getopt() to handle given options. For more informations on
    // getopt() see manpage of getopt(3)

    static struct option options[] = {

        {"input-file", required_argument, 0, 'i'},
        {"help",       no_argument,       0, 'h'},
        {"seed",       required_argument, 0, 's'},
        {0,            0,                 0, 0  }

    };

    int optionIndex = 0;
    int optionCode = -1;
    opterr = 0;

    try {

        while ( true ) {

            optionCode = getopt_long( argc, argv, ":i:hs:", options, &optionIndex );

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

                case ':':
                    throw InputException( "Missing option parameter." );

                default:
                    throw InputException( "Unknown option(s)" );

            }

        }

        if ( optind < argc && argc == 2 ) {

            _inputFileName = std::string( argv[optind] );

        }

        std::cout << "--------------------------------------------------------------------------------" << std::endl;
        std::cout << "                                                                                " << std::endl;
        std::cout << "  Welcome to Fittino"                                                             << std::endl;
        std::cout << "                                                                                " << std::endl;

        InputFileInterpreterFactory inputFileInterpreterFactory;
        InputFileInterpreterBase* inputFileInterpreter = inputFileInterpreterFactory.CreateInputFileInterpreter( Controller::GetInputFileFormat() );
        inputFileInterpreter->Parse( _inputFileName );
        delete inputFileInterpreter;

    }
    catch ( InputException& inputException ) {

        std::cout << "\n" << inputException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}

void Fittino::Controller::ExecuteFittino() {

    try {

        ModelFactory modelFactory;
        ModelBase* model = modelFactory.CreateModel( Configuration::GetInstance()->GetModelType() );

        if ( Configuration::GetInstance()->GetExecutionMode() == ExecutionMode::OPTIMIZATION ) {

            OptimizerFactory optimizerFactory;
            OptimizerBase* optimizer = optimizerFactory.CreateOptimizer( Configuration::GetInstance()->GetOptimizerType(), model );
            optimizer->Execute();
            delete optimizer;

        }
        else if ( Configuration::GetInstance()->GetExecutionMode() == ExecutionMode::SCAN ) {

            throw ConfigurationException( "Execution mode SCAN not supported yet." );

        }
        else {

            throw ConfigurationException( "Configured execution mode unknown." );

        }

        delete model; 

    }
    catch ( ConfigurationException& configurationException ) {

        std::cout << "\n" << configurationException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}

void Fittino::Controller::TerminateFittino() {

}

Fittino::Controller* Fittino::Controller::_instance = 0;

Fittino::Controller::Controller()
        : _randomSeed( 0 ),
          _inputFileName( "" ), 
          _messenger( new Messenger() ) { 

}

Fittino::Controller::~Controller() {

    delete _messenger;

}

void Fittino::Controller::PrintHelp() {

    std::cout << std::endl;
    std::cout << "Usage: fittino [OPTION(S)] [FILE]" << std::endl;
    std::cout << std::endl;
    std::cout << "  If only a single parameter is given (different from \"-h\" or \"--help\")," << std::endl;
    std::cout << "  Fittino reads in input file FILE." << std::endl;
    std::cout << "  Input file suffix must be .ftn (Fittino format) or .xml (XML format)." << std::endl;
    std::cout << std::endl;
    std::cout << "Supported options are:" << std::endl;
    std::cout << std::endl;
    std::cout << "  -h, --help" << std::endl;
    std::cout << "      Fittino prints this message." << std::endl;
    std::cout << std::endl;
    std::cout << "  -i, --input-file=FILE " << std::endl;
    std::cout << "      Fittino uses input file FILE." << std::endl;
    std::cout << "      Input file suffix must be .ftn (Fittino format) or .xml (XML format)." << std::endl;
    std::cout << std::endl;
    std::cout << "  -s, --seed=SEED" << std::endl;
    std::cout << "      Fittino uses the given random number generator seed." << std::endl;
    std::cout << std::endl;

}

Fittino::InputFileInterpreterBase::InputFileFormat Fittino::Controller::GetInputFileFormat() {

    try {

        if ( _inputFileName.length() < 5 ) {

            throw InputException( "Invalid input file name." );

        }

        if ( !_inputFileName.compare( _inputFileName.length() - 4, 4, ".ftn" ) ) {

            return Fittino::InputFileInterpreterBase::FITTINOINPUTFILE;

        }
        else if ( !_inputFileName.compare( _inputFileName.length() - 4, 4, ".xml" ) ) {

            return Fittino::InputFileInterpreterBase::XMLINPUTFILE;

        }
        else {

            throw InputException( "Input file suffix must be .ftn (Fittino format) or .xml (XML format)." );

        }

    }
    catch ( InputException& inputException ) {

        std::cout << "\n" << inputException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}
