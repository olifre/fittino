/* $Id$ */

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

#include <iomanip>
#include <iostream>

#include "Configuration.h"
#include "ConfigurationException.h"
#include "Messenger.h"

const std::string& Fittino::Messenger::_dashedLine = std::string( 85, '-' );

Fittino::Messenger& Fittino::Messenger::Endl( Messenger& messenger ) {

    messenger.Send();
    return messenger;

}

Fittino::Messenger& Fittino::Messenger::GetInstance() {

    static Messenger instance;
    return instance;

}

Fittino::Messenger::Messenger()
        : _actualVerbosityLevel( Messenger::ALWAYS ),
          _verbosityLevel( Messenger::ALWAYS ) {

}

Fittino::Messenger::~Messenger() {

}

void Fittino::Messenger::Send() {

    if ( _actualVerbosityLevel >= _verbosityLevel ) {

        std::cout << std::setiosflags( std::ios::fixed )
                  << this->str()
		  << std::endl;

    }

    this->str( "" );

}

void Fittino::Messenger::SetVerbosityLevel( const std::string& verbosityLevel ) {

    if ( verbosityLevel == "INFO" ) {

        SetVerbosityLevel(INFO);

    }
    else if ( verbosityLevel == "ALWAYS" ) {

        SetVerbosityLevel(ALWAYS);

    }
    else {

        throw ConfigurationException( "Verbosity level unknown." );

    }

}

void Fittino::Messenger::SetVerbosityLevel( const VerbosityLevel& verbosityLevel ) {

    _verbosityLevel = verbosityLevel;

}

Fittino::Messenger& Fittino::Messenger::operator<<( std::ios& ( *_f )( std::ios& ) ) {

    ( _f )( *this );
    return *this;

}

Fittino::Messenger& Fittino::Messenger::operator<<( std::ostream& ( *_f )( std::ostream& ) ) {

    ( _f )( *this );
    return *this;

}

Fittino::Messenger& Fittino::Messenger::operator<<( Fittino::Messenger& ( *_f )( Fittino::Messenger& ) ) {

    return ( _f )( *this );

}

Fittino::Messenger& Fittino::Messenger::operator<<( Fittino::Messenger::VerbosityLevel verbosityLevel ) {

    _actualVerbosityLevel = verbosityLevel;
    return *this;

}
