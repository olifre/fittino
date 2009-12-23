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
#include <string>

#include "Configuration.h"
#include "Controller.h"
#include "FittinoInputFileInterpreter.h"

Controller* Fittino::Controller::GetInstance() {

    if ( !_instance ) {

        _instance = new Controller();

    }

    return _instance;

}

void Fittino::Controller::InitializeFittino( int argc, char** argv ) {

    if ( argc == 1 || ( argc == 2 && !strcmp( argv[1], "--help" ) ) ) {

	std::cout << std::endl;
	std::cout << "Usage: fittino [<parameters>]" << std::endl;
	std::cout << std::endl;
	std::cout << "Supported parameters are:" << std::endl;
	std::cout << "  --help" << std::endl;
	std::cout << "      Fittino prints this message." << std::endl;
	std::cout << std::endl;
	std::cout << "  <inputfile>" << std::endl;
	std::cout << "      If only a single parameter is given (different from \"--help\"), Fittino reads in " << std::endl;
	std::cout << "      input file <inputfile>." << std::endl;
	std::cout << "      Input file suffix must be .ftn (Fittino format) or .xml (XML format)." << std::endl;
	std::cout << std::endl;
	std::cout << "  -i <inputfile>" << std::endl;
	std::cout << "      Fittino uses input file <inputfile>." << std::endl;
	std::cout << "      Input file suffix must be .ftn (Fittino format) or .xml (XML format)." << std::endl;
	std::cout << std::endl;
	std::cout << "  -s <seed>" << std::endl;
	std::cout << "      Fittino uses the given random number generator seed." << std::endl;
	std::cout << std::endl;

	return 0;

    }
    else if ( argc == 2 ) {

	_inputFileName = std::string( argv[1] );

    }
    else {

	for ( int i = 1; i < argc; i++ ) {

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

    switch ( GetInputFileFormat() ) {

	case InputFileInterpreterBase::FITTINOINPUTFILE:
	    fittinoInputFileInterpreterFactory = new FittinoInputFileInterpreterFactory(); 
	    FittinoInputFileInterpreter* inputFileInterpreter = fittinoInputFileInterpreterFactory.CreateInterpreter();
            inputFileInterpreter->Parse();

	    //default:

    }

}

void Fittino::Controller::ExecuteFittino() {

    switch ( Configuration::GetInstance()->GetExecutionMode() ) {

	case ExecutionMode::OPTIMIZATION:
	    OptimizerBase* optimizer = Configuration::GetInstance()->GetOptimizer();
	    optimizer->Execute();

	    //default:

    }

}

void Fittino::Controller::TerminateFittino() {

}

Fittino::Controller::Controller() {

    _inputFileFormat = InputFileInterpreterBase::FITTINOINPUTFILE;

}

Fittino::Controller::~Controller() {

}

Controller* Fittino::Controller::_instance = 0;

InputFileInterpreterBase::InputFileFormat Fittino::Controller::GetInputFileFormat() {

    if ( _inputFileName.length() < 5 ) {

	throw ;

    }

    std::string suffix;
    std::string::reverse_iterator iter = _inputFileName.rbegin();

    if ( ; iter < _inputFileName.rend(); iter++ ) {

	suffix.insert( 0, *iter );
 
    }

    if ( !suffix.compare( ".ftn" ) ) {

	return InputFileInterpreterBase::FITTINOINPUTFILE;

    }
    else if ( !suffix.compare( ".xml" ) ) {
	    
	return = InputFileInterpreterBase::XMLINPUTFILE;
    
    }
    else {

	throw ;

    }

}
