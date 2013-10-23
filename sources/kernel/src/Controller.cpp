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

#include <boost/foreach.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>

#include "Configuration.h"
#include "ConfigurationException.h"
#include "Controller.h"
#include "DataStorageBase.h"
#include "Factory.h"
#include "InputException.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "OptimizerBase.h"
#include "PlotterBase.h"
#include "SamplerBase.h"

Fittino::Controller* Fittino::Controller::GetInstance() {

    if ( !_instance ) {

        _instance = new Controller;

    }

    return _instance;

}

void Fittino::Controller::InitializeFittino( int argc, char** argv ) {

    try {

	// If Fittino is called without options or arguments print a help text with further
	// instructions and exit.

        if ( argc == 1 ) {

            Controller::PrintHelp();
            exit( EXIT_SUCCESS );

        }

        // Otherwise handle given command line options.

        Controller::HandleOptions( argc, argv );

	// Print a welcome logo.

        Controller::PrintLogo();

	// Create a data storage depending on the input file format and parse the input file.

        const Factory factory;
        const DataStorageBase* const fittinoInputDataStorage = factory.CreateDataStorage( Controller::DetermineInputFileFormat() );
        fittinoInputDataStorage->ReadFile( _inputFileName );
        delete fittinoInputDataStorage;

        boost::property_tree::read_xml( _inputFileName, *_propertyTree );

        if ( _propertyTree->get_child("InputFile").count("Tool") != 0 ) {

            std::string verbosityLevel = _propertyTree->get<std::string>("InputFile.VerbosityLevel");

            Messenger::GetInstance().SetVerbosityLevel( verbosityLevel );

        }
        else {
              
            // Set the level of output verbosity.
            Messenger::GetInstance().SetVerbosityLevel( Configuration::GetInstance()->GetVerbosityLevel() );

        }

    }
    catch ( const InputException& inputException ) {

        std::cout << "\n" << inputException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}

void Fittino::Controller::ExecuteFittino() const {

    try {

        const Factory factory;

        if ( _propertyTree->get_child("InputFile").count("Tool") != 0 ) {

          const boost::property_tree::ptree::value_type& modelNode = *( _propertyTree->get_child("InputFile.Model").begin() );
          ModelBase* model = factory.CreateModel( modelNode.first, modelNode.second );

          const boost::property_tree::ptree::value_type& toolNode = *( _propertyTree->get_child("InputFile.Tool").begin() );
          AnalysisTool* tool = factory.CreateAnalysisTool( toolNode.first, model, toolNode.second );

          tool->PerformAnalysis();

          delete tool;
          delete model;

        }
        else {

            ModelBase* model = factory.CreateModel( Configuration::GetInstance()->GetModelType() );

            if ( Configuration::GetInstance()->GetExecutionMode() == Configuration::OPTIMIZATION ) {

                OptimizerBase* const optimizer = factory.CreateOptimizer( Configuration::GetInstance()->GetOptimizerType(), model, _randomSeed );
                optimizer->PerformAnalysis();
                delete optimizer;

            }
            else if ( Configuration::GetInstance()->GetExecutionMode() == Configuration::SAMPLING ) {

                SamplerBase* const sampler = factory.CreateSampler( Configuration::GetInstance()->GetSamplerType(), model, _randomSeed );
                sampler->PerformAnalysis();
                delete sampler;

            }
            else if ( Configuration::GetInstance()->GetExecutionMode() == Configuration::PLOTTING ) {

                PlotterBase* plotter = factory.CreatePlotter( Configuration::GetInstance()->GetPlotterType(), model, _dataFileName, _randomSeed );
                plotter->PerformAnalysis();
                delete plotter;

            }
            else {

                throw ConfigurationException( "Configured execution mode unknown." );

            }

            delete model;

        }
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
          _dataFileName( "" ),
          _inputFileName( "" ),
          _propertyTree( new boost::property_tree::ptree() ) {

}

Fittino::Controller::~Controller() {

  delete _propertyTree;

}

void Fittino::Controller::HandleOptions( int argc, char** argv ) {

    // Use getopt() to handle given command line options. For more informations on getopt() have a
    // look at the manpage of getopt(3).

    static struct option options[] = {

        {"help",       no_argument,       0, 'h'},
        {"input-file", required_argument, 0, 'i'},
        {"data-file",  required_argument, 0, 'd'},
        {"seed",       required_argument, 0, 's'},
        {0,            0,                 0,  0 }

    };

    int optionIndex = 0;
    int optionCode = -1;
    opterr = 0;

    while ( true ) {

        optionCode = getopt_long( argc, argv, ":hi:d:s:", options, &optionIndex );

        if ( optionCode == -1 ) break;

        switch ( optionCode ) {

            case 'h':
                Controller::PrintHelp();
                exit( EXIT_SUCCESS );

            case 'i':
                _inputFileName = std::string( optarg );
                continue;

            case 'd':
                _dataFileName = std::string( optarg );
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

}

void Fittino::Controller::PrintHelp() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "Usage: fittino [OPTION(S)]" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "Supported options are:" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  -h, --help" << Messenger::Endl;
    messenger << Messenger::ALWAYS << "      Fittino prints this message." << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  -i, --input-file=FILE" << Messenger::Endl;
    messenger << Messenger::ALWAYS << "      Fittino uses the input file FILE. The input file suffix must" << Messenger::Endl;
    messenger << Messenger::ALWAYS << "      be .xml (XML format)." << Messenger::Endl;
    messenger << Messenger::ALWAYS << "      Several example input files can be found at fittino2/input." << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  -d, --data-file=FILE" << Messenger::Endl;
    messenger << Messenger::ALWAYS << "      Fittino uses the data file FILE. The data file suffix must" << Messenger::Endl;
    messenger << Messenger::ALWAYS << "      be .root (ROOT format)." << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  -s, --seed=SEED" << Messenger::Endl;
    messenger << Messenger::ALWAYS << "      Fittino uses the given random number generator seed." << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

}

void Fittino::Controller::PrintLogo() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Welcome to Fittino" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

}

const Fittino::Configuration::FileFormat Fittino::Controller::DetermineInputFileFormat() const {

    try {

        if ( _inputFileName.length() < 5 ) {

            throw InputException( "Invalid input file name. The input file has to be specified with the option flag -i/--input-file and its suffix must be .xml (XML format)." );

        }
        else if ( !_inputFileName.compare( _inputFileName.length() - 4, 4, ".xml" ) ) {

            return Configuration::XML;

        }
        else {

            throw InputException( "Input file suffix must be .xml (XML format)." );

        }

    }
    catch ( const InputException& inputException ) {

        std::cout << "\n" << inputException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

}
