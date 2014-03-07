/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Redirector.cpp                                                   *
*                                                                              *
* Description Redirects stdout and stderr to a file                            *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazink@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <iostream>

#include "Redirector.h"
#include "RedirectorException.h"

extern "C" {

    void fortranflush_();

}

Fittino::Redirector::Redirector( std::string fileName )
    : _fileName ( fileName ),
      _redirecting( false ) {

}

Fittino::Redirector::~Redirector() {

    if ( _redirecting ) Stop();

}

void Fittino::Redirector::Start() {

    if ( _redirecting ) {

        throw RedirectorException( "Stdout already redirected." );

    }

    _redirecting = true;

    _fd_file = open( _fileName.c_str(), O_RDWR | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR );

    if ( _fd_file < 0 ) {

        perror( "open" );
        throw RedirectorException( "open" );

    }

#ifdef FEYNHIGGS

    fortranflush_();

#endif

    StartRedirection( stdout, _fd_stdout );
    StartRedirection( stderr, _fd_stderr );

    if ( close( _fd_file ) ) {

        perror( "close" );
        throw RedirectorException( "close" );

    }

}

void Fittino::Redirector::Stop() {

    if ( ! _redirecting ) {

        throw RedirectorException( "" );

    }

    _redirecting = false;

#ifdef FEYNHIGGS

    fortranflush_();

#endif

    StopRedirection( stdout, _fd_stdout );
    StopRedirection( stderr, _fd_stderr );

}

void Fittino::Redirector::StartRedirection( FILE *stream, int& backup ) {

    int fd = fileno( stream );

    if ( fd < 0 ) {

        perror( "fileno" );
        throw RedirectorException( "fileno" );

    }

    backup = dup( fd ) ;

    if ( backup < 0 ) {

        perror( "dup" );
        throw RedirectorException( "dup" );

    }

    if ( fflush( stream ) ) {

        perror( "fflush" );
        throw RedirectorException( "fflush" );

    }

    if ( dup2( _fd_file, fd ) < 0 ) {

        perror( "dup2" );
        throw RedirectorException( "dup2" );

    }

}

void Fittino::Redirector::StopRedirection( FILE* stream, int& backup ) {

    int fd = fileno( stream );

    if ( fd < 0 ) {

        perror( "fileno" );
        throw RedirectorException( "fileno" );

    }

    if ( fflush( stream ) ) {

        perror( "fflush" );
        throw RedirectorException( "fflush" );

    }

    if (  dup2( backup, fd ) < 0 ) {

        perror( "dup2" );
        throw RedirectorException( "dup2" );

    }

    if ( close( backup ) ) {

        perror( "close" );
        throw RedirectorException( "close" );

    }

}
