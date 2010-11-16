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
#include "ConfigurationException.h"
#include "Controller.h"
#include "Factory.h"
#include "InputException.h"
#include "InputFileInterpreterBase.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "OptimizerBase.h"
#include "SamplerBase.h"

Fittino::Controller* Fittino::Controller::GetInstance() {

    if ( !_instance ) {

        _instance = new Controller::Controller();

    }

    return _instance;

}

void Fittino::Controller::InitializeFittino( int argc, char** argv ) {

    // If Fittino is called without options or arguments print a help text with further instructions
    // and exit.

    if ( argc == 1 ) {

        Controller::PrintHelp();
        exit( EXIT_SUCCESS );

    }

    // Otherwise use getopt() to handle given command line options. For more informations on
    // getopt() have a look at the manpage of getopt(3).

    static struct option options[] = {

        {"help",       no_argument,       0, 'h'},
        {"input-file", required_argument, 0, 'i'},
        {"seed",       required_argument, 0, 's'},
        {0,            0,                 0, 0  }

    };

    int optionIndex = 0;
    int optionCode = -1;
    opterr = 0;

    try {

        while ( true ) {

            optionCode = getopt_long( argc, argv, ":hi:s:", options, &optionIndex );

            if ( optionCode == -1 ) break;

            switch ( optionCode ) {

                case 'h':
                    Controller::PrintHelp();
                    exit( EXIT_SUCCESS );

                case 'i':
                    _inputFileName = std::string( optarg );
                    continue;

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

	// Print a welcome logo.

        Controller::PrintLogo();

	// Create an input file interpreter depending on the file format and parse the input file.

        const Factory factory;
        const InputFileInterpreterBase* const inputFileInterpreter = factory.CreateInputFileInterpreter( Controller::DetermineInputFileFormat() );
        inputFileInterpreter->Parse( _inputFileName );
        delete inputFileInterpreter;

    }
    catch ( const InputException& inputException ) {

        std::cout << "\n" << inputException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}

void Fittino::Controller::ExecuteFittino() const {

    try {

        const Factory factory;
        ModelBase* const model = factory.CreateModel( Configuration::GetInstance()->GetModelType() );

        if ( Configuration::GetInstance()->GetExecutionMode() == Configuration::OPTIMIZATION ) {

            OptimizerBase* const optimizer = factory.CreateOptimizer( Configuration::GetInstance()->GetOptimizerType(), model );
            optimizer->PerformAnalysis();
            delete optimizer;

        }
        else if ( Configuration::GetInstance()->GetExecutionMode() == Configuration::SAMPLING ) {

            SamplerBase* const sampler = factory.CreateSampler( Configuration::GetInstance()->GetSamplerType(), model );
            sampler->PerformAnalysis();
            delete sampler;

	}
        else if ( Configuration::GetInstance()->GetExecutionMode() == Configuration::SCAN ) {

            throw ConfigurationException( "Execution mode SCAN not supported yet." );

        }
        else {

            throw ConfigurationException( "Configured execution mode unknown." );

        }

        delete model;

    }
    catch ( const ConfigurationException& configurationException ) {

        std::cout << "\n" << configurationException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}

void Fittino::Controller::TerminateFittino() const {

}

Fittino::Controller* Fittino::Controller::_instance = 0;

Fittino::Controller::Controller()
        : _randomSeed( 0 ),
          _inputFileName( "" ) {

}

Fittino::Controller::~Controller() {

}

void Fittino::Controller::PrintHelp() const {

    Messenger* messenger = Messenger::GetInstance();

    messenger->PrintALWAYSMessage( "\n" );
    messenger->PrintALWAYSMessage( "Usage: fittino [OPTION(S)] FILE\n" );
    messenger->PrintALWAYSMessage( "\n" );
    messenger->PrintALWAYSMessage( "  A single given argument (different from \"-h\" or \"--help\") is\n" );
    messenger->PrintALWAYSMessage( "  interpreted as the name of an input file. The input file suffix\n" );
    messenger->PrintALWAYSMessage( "  must be .ftn (Fittino format) or .xml (XML format).\n" );
    messenger->PrintALWAYSMessage( "  Several example input files can be found at fittino2/input.\n" );
    messenger->PrintALWAYSMessage( "\n" );
    messenger->PrintALWAYSMessage( "Supported options are:\n" );
    messenger->PrintALWAYSMessage( "\n" );
    messenger->PrintALWAYSMessage( "  -h, --help\n" );
    messenger->PrintALWAYSMessage( "      Fittino prints this message.\n" );
    messenger->PrintALWAYSMessage( "  -i, --input-file=FILE\n" );
    messenger->PrintALWAYSMessage( "      Fittino uses the input file FILE. The input file suffix must\n" );
    messenger->PrintALWAYSMessage( "      be .ftn (Fittino format) or .xml (XML format).\n" );
    messenger->PrintALWAYSMessage( "      Several example input files can be found at fittino2/input.\n" );
    messenger->PrintALWAYSMessage( "  -s, --seed=SEED\n" );
    messenger->PrintALWAYSMessage( "      Fittino uses the given random number generator seed.\n" );
    messenger->PrintALWAYSMessage( "\n" );

}

void Fittino::Controller::PrintLogo() const {

    Messenger* messenger = Messenger::GetInstance();

    messenger->PrintALWAYSMessage( "--------------------------------------------------------------------------------\n" );
    messenger->PrintALWAYSMessage( "\n" );
    messenger->PrintALWAYSMessage( "  Welcome to Fittino\n" );
    messenger->PrintALWAYSMessage( "\n" );

}

const Fittino::Configuration::InputFileFormat Fittino::Controller::DetermineInputFileFormat() const {

    try {

        if ( _inputFileName.length() < 5 ) {

            throw InputException( "Invalid input file name." );

        }

        if ( !_inputFileName.compare( _inputFileName.length() - 4, 4, ".ftn" ) ) {

            return Configuration::FITTINOINPUTFILE;

        }
        else if ( !_inputFileName.compare( _inputFileName.length() - 4, 4, ".xml" ) ) {

            return Configuration::XMLINPUTFILE;

        }
        else {

            throw InputException( "Input file suffix must be .ftn (Fittino format) or .xml (XML format)." );

        }

    }
    catch ( const InputException& inputException ) {

        std::cout << "\n" << inputException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}
