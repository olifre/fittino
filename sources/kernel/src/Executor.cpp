/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Executor.cpp                                                     *
*                                                                              *
* Description Executes an external program                                     *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazink@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/wait.h>

#include <iostream>

#include "Executor.h"
#include "Messenger.h"
#include "TimeoutExecutorException.h"

Fittino::Messenger& messenger = Fittino::Messenger::GetInstance();

Fittino::Executor::Executor( std::string path, std::string arg0 )
    : _path( path ) {

    _args.push_back( arg0 );
    _creationTimeout = NULL;
    _completionTimeout = 0;

}

Fittino::Executor::~Executor() {

    delete _creationTimeout;

}

int Fittino::Executor::Execute() {

    if ( pipe( _pipefds ) ) {

        perror( "pipe" );
        throw ExecutorException( "Failed to create pipe." );

    }

    _pid = fork();

    switch( _pid ) {

        case -1:

            perror( "fork" );
            throw ExecutorException( "Failed to fork child process." );

        case 0:

            Child();
            break;

        default:

            Parent();
            break;

    }

    return _rc;

}

void Fittino::Executor::AddArgument( std::string arg ) {

    _args.push_back( arg );

}

void Fittino::Executor::SetCompletionTimeout( double timeout ) {

    _completionTimeout = timeout;

}

void Fittino::Executor::SetCreationTimeout( double timeout ) {

    delete _creationTimeout;

    _creationTimeout = new timespec();
    _creationTimeout->tv_sec = timeout;
    _creationTimeout->tv_nsec = 0;

}

void Fittino::Executor::Child() {

    try {

        if ( close( _pipefds[0] ) ) {

            perror( "close" );
            throw ExecutorException( "Failed to close pipe." );

        }


        if ( fcntl( _pipefds[1], F_SETFD, fcntl( _pipefds[1], F_GETFD ) | FD_CLOEXEC ) ) {

            perror( "fcntl" );
            throw ExecutorException( "Failed to set pipe flags." );

        }

        char* argv[_args.size() + 1];

        for ( int i = 0;  i < _args.size();  ++i )   {

            argv [i] = const_cast<char*>( _args[i].c_str() );

        }

        argv[_args.size()] = NULL;

        execve( _path.c_str(), &argv[0], NULL );
        perror( "execve" );

    }
    catch ( const std::exception& exception  ) {

        messenger << Messenger::ALWAYS << " Exception in child process: " << Messenger::Endl;
        messenger << Messenger::ALWAYS << exception.what() << Messenger::Endl;

    }
    catch( ... ) {

        messenger << Messenger::ALWAYS << "Unknown exception in child process." << Messenger::Endl;

    }

    messenger << Messenger::ALWAYS << "A problem in child process occured. " << Messenger::Endl;

    int error = 1;

    if ( write( _pipefds[1], &error, sizeof( int ) ) == -1 ) {

        perror( "write" );

    }

    if ( close( _pipefds[1] ) ) {

        perror( "close" );

    }

    _exit( 0 );

}

void Fittino::Executor::Parent() {

    try {

        if ( close( _pipefds[1] ) ) {

            perror( "close" );
            throw ExecutorException( "Failed to close pipe." );

        }

        fd_set rfds;
        FD_ZERO( &rfds );
        FD_SET( _pipefds[0], &rfds );

        switch( pselect( _pipefds[0] + 1, &rfds, NULL, NULL, _creationTimeout, NULL ) ) {

            case -1:

                perror( "pselect" );
                throw ExecutorException( "pselect" );

            case 0:

                throw ExecutorException( "Timeout in creating process." );

            default:

                Read();
                break;

        }

    }
    catch ( ... ) {

        if( close( _pipefds[0] ) ) {

            perror( "close" );
            throw ExecutorException( "close" );

        }

        if ( kill( _pid, SIGKILL ) && errno != ESRCH ) {

            perror( "kill" );
            throw ExecutorException( "kill" );

        }

        if ( waitpid( -1, &_status, 0 ) == -1 ) {

            perror( "waitpid" );
            throw ExecutorException( "Waitpid after kill." );

        }

        throw;

    }

    if( close( _pipefds[0] ) ) {

        perror( "close" );
        throw ExecutorException( "close" );

    }

}

void Fittino::Executor::Read() {

    int error = 0;

    switch( read( _pipefds[0], &error, sizeof( int ) ) ) {

        case -1:

            perror( "read" );
            throw ExecutorException( "read" );

        case 0:

            Wait();
            break;

        default:

            throw ExecutorException( "Child reports problems." );

    }

}

void Fittino::Executor::Wait() {

    double counter = 0;

    while ( ( _completionTimeout <= 0 ) || ( counter / 10. < _completionTimeout ) ) {

        int wait = waitpid ( _pid, &_status, WNOHANG );

        if ( wait == -1 ) {

            perror( "waitpid" );
            throw ExecutorException( "waitpid" );

        }
        else if ( wait == 0 ) {

            if ( usleep ( 100000 ) && ( errno != EINTR ) ) {

                perror( "usleep" );
                throw ExecutorException( "usleep" );

            }

            counter++;

        }
        else if ( wait == _pid ) {

            if ( WIFEXITED( _status ) ) {

                _rc = WEXITSTATUS( _status );
                return;

            }
            else {

                throw ExecutorException( "Child didn't terminate normally." );

            }

        }
        else {

            throw ExecutorException( "Unexpected rc from wait." );

        }

    } // while

    throw TimeoutExecutorException( "Timeout in exec." );

}
