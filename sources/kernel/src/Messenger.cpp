/* $Id: Messenger.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Messenger.cpp                                                    *
*                                                                              *
* Description Class for printing messages of various priority                  *
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

#include "Messenger.h"

Fittino::Messenger* Fittino::Messenger::GetInstance() {

    if ( !_instance ) {

        _instance = new Messenger::Messenger();

    }

    return _instance;

}

Fittino::Messenger::Messenger()
//        : _outputLevel( Messenger::ALWAYS ) {
        : _outputLevel( Messenger::INFO ) {

}

Fittino::Messenger::~Messenger() {

}

void Fittino::Messenger::PrintALWAYSMessage( std::string alwaysMessage ) {

    if ( _outputLevel == Messenger::ALWAYS ||
	 _outputLevel == Messenger::DEBUG  ||
	 _outputLevel == Messenger::INFO   ||
	 _outputLevel == Messenger::VERBOSE ) {

        std::cout << alwaysMessage;
    }

}

void Fittino::Messenger::PrintDEBUGMessage( std::string debugMessage ) {
 
    if ( _outputLevel == Messenger::DEBUG ||
         _outputLevel == Messenger::VERBOSE ) {

        std::cout << debugMessage;
    }

}

void Fittino::Messenger::PrintINFOMessage( std::string infoMessage ) {

    if ( _outputLevel == Messenger::DEBUG ||
	 _outputLevel == Messenger::INFO  ||
	 _outputLevel == Messenger::VERBOSE ) {

        std::cout << infoMessage;
    }

}

void Fittino::Messenger::PrintVERBOSEMessage( std::string verboseMessage ) {

    if ( _outputLevel == Messenger::VERBOSE ) {

        std::cout << verboseMessage;
    }

}

Fittino::Messenger* Fittino::Messenger::_instance = 0;
