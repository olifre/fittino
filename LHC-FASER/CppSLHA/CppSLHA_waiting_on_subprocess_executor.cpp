/*
 * CppSLHA_waiting_on_subprocess_executor.cpp
 *
 *  Created on: 20 Mar 2010
 *      Author: Ben O'Leary (benjamin.oleary@gmail.com)
 *      Copyright 2010 Ben O'Leary
 *
 *      This file is part of CppSLHA.
 *
 *      CppSLHA is free software: you can redistribute it and/or modify
 *      it under the terms of the GNU General Public License as published by
 *      the Free Software Foundation, either version 3 of the License, or
 *      (at your option) any later version.
 *
 *      CppSLHA is distributed in the hope that it will be useful,
 *      but WITHOUT ANY WARRANTY; without even the implied warranty of
 *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *      GNU General Public License for more details.
 *
 *      You should have received a copy of the GNU General Public License
 *      along with CppSLHA.  If not, see <http://www.gnu.org/licenses/>.
 *
 *      The GNU General Public License should be in GNU_public_license.txt
 *      the files of CppSLHA are:
 *      CppSLHA.hpp
 *      CppSLHA.cpp
 *      CppSLHA_BLOCK.hpp
 *      CppSLHA_BLOCK.cpp
 *      CppSLHA_EW_scale_spectrum.hpp
 *      CppSLHA_EW_scale_spectrum.cpp
 *      CppSLHA_file_reading_stuff.hpp
 *      CppSLHA_file_reading_stuff.cpp
 *      CppSLHA_global_stuff.hpp
 *      CppSLHA_global_stuff.cpp
 *      CppSLHA_PDG_codes_and_data.hpp
 *      CppSLHA_PDG_codes_and_data.cpp
 *      CppSLHA_particle_data.hpp
 *      CppSLHA_particle_data.cpp
 *      CppSLHA_waiting_on_subprocess_executor.hpp
 *      CppSLHA_waiting_on_subprocess_executor.cpp
 *      and ./README.CppSLHA.txt which describes the package.
 *
 */

#include "CppSLHA_waiting_on_subprocess_executor.hpp"

namespace CppSLHA
{

  waiting_on_subprocess_executor::waiting_on_subprocess_executor(
      std::string const given_executable_name,
      std::vector< std::string const* > const* const given_arguments,
      int const given_patience_ticks ) :
        process_id( 0 ),
        subprocess_executable_name( given_executable_name ),
        patience_ticks( given_patience_ticks )
  /* N.B.: the waiting_on_subprocess_executor object does NOT store the
   * arguments internally! it only stores pointers to the arrays of chars
   * which were given to the constructor. if these strings change before
   * fork_and_execv_and_wait(), BAD THINGS will probably happen.
   */
  {

    set_arguments( given_arguments );

  }

  waiting_on_subprocess_executor::~waiting_on_subprocess_executor()
  {

    delete [] argument_list;

  }


  // non-inline functions:

  void
  waiting_on_subprocess_executor::set_arguments(
               std::vector< std::string const* > const* const given_arguments )
  /* this assigns memory to make argument_list point to an array of pointers
   * to chars which are stored in *given_arguments, NOT INTERNALLY, & thus
   * can be passed to execv to properly execute the subprocess with its
   * arguments.
   */
  {

    argument_list = new char*[ ( given_arguments->size() + 2 ) ];
    // create a char* const array which has room for the executable name,
    // then all the arguments, then NULL.

    // debugging:
    /*std::cout
    << std::endl << "debugging: argument_list = " << argument_list
    << ", size = " << ( given_arguments->size() + 2 );
    std::cout << std::endl;
    */

    argument_list[ 0 ] = (char*)(subprocess_executable_name.c_str());
    // write the 1st element of the array as the executable name, since that
    // is what execv() wants.

    // debugging:
    /*std::cout
    << std::endl << "debugging: argument_list[ 0 ] = " << argument_list[ 0 ];
    std::cout << std::endl;
    */


    // note that we are going to starting filling the array after the 0th
    // element.

    if( !(given_arguments->empty()) )
      // if the list of arguments is not empty...
      {

        number_of_arguments = given_arguments->size();

        for( int argument_filling_counter = 1;
             number_of_arguments >= argument_filling_counter;
             ++argument_filling_counter )
          // go through the list of arguments.
          {

            argument_list[ argument_filling_counter ]
            = (char*)(given_arguments->at( ( argument_filling_counter - 1 )
                                           )->c_str());
            // write this argument as the (argument_filling_counter)th element.

            // debugging:
            /*std::cout
            << std::endl
            << "debugging: argument_list[ " << argument_filling_counter
            << " ] = " << argument_list[ argument_filling_counter ];
            std::cout << std::endl;
            */

          }

      }

    argument_list[ ( given_arguments->size() + 1 ) ] = NULL;
    // we fill the (argument_filling_counter + 1)th element with NULL, since
    // that is what execv() wants.

    // debugging:
    /*std::cout
    << std::endl << "debugging:"
    << " CppSLHA::waiting_subprocess_executor::set_arguments( "
    << given_arguments << " ) set argument_list to be " << argument_list
    << " which should make the argument list itself:";
    std::cout << std::endl;
    for( int argument_filling_counter = 0;
         number_of_arguments <= argument_filling_counter;
         ++argument_filling_counter )
      {
        std::cout
        << "\"" << argument_list[ argument_filling_counter ] << "\", ";
      }
    */

  }


  bool
  waiting_on_subprocess_executor::fork_and_execv_and_wait()
  /* this forks off a new process, then checks if this process is the parent
   * or the child subprocess. if it's the parent, it waits until the child
   * returns a value or until the "patience" time runs out, at which point it
   * kills the child subprocess if it has not returned a value. if it is the
   * child, it runs execv with its arguments & returns the return value from
   * the execv process.
   */
  {

    int process_status = 0;
    // this keeps track of the status of the process.

    int return_value = 0;
    // this keeps track of what processes return.

    bool subprocess_returned_flag = true;
    // assume that the subprocess won't have to be killed.

    // debugging:
    //std::cout << std::endl << "forking!" << std::endl;

    int fork_return;
    fork_return = fork();

    if( 0 > fork_return )
      // if fork failed to do what it should do...
      {

        std::cout
        << std::endl
        << "unable to create subprocess, there was an error and fork()"
        << " returned " << fork_return << std::endl;
        // print error message.

      }
    else if( 0 == fork_return )
      // otherwise if this is the subprocess
      // [since it got the 0 from fork()]...
      {

        process_id = getpid();

        std::cout
        << std::endl
        << "now executing \"" << argument_list[ 0 ];
        for( int argument_writing_counter = 1;
             number_of_arguments >= argument_writing_counter;
             ++argument_writing_counter )
          {

            std::cout << " " << argument_list[ argument_writing_counter ];

          }
        std::cout
        << "\", with process id " << getpid() << ", real user id " << getuid()
        << " & effective user id " << geteuid() << std::endl;

        char** const constant_argument_list = argument_list;
        // silly pseudo-casting.
        return_value = execv( constant_argument_list[ 0 ],
                              constant_argument_list );
        // run the executable with its arguments.

        // debugging:
        // std::cout << "subprocess returning with return value "
        // << return_value << std::endl;

        exit( return_value );

      }
    else if( 0 < fork_return )
      // otherwise this is the parent process, since it got given the process
      // id of the subprocess.
      {

        // debugging:
        /*std::ofstream* output_log = new std::ofstream();
        output_log->open( "parent.log" );
        if( output_log->is_open() )
          // if the file was successfully opened...
          {
            *output_log
            << std::endl << "this process is the parent."
            << " the subprocess has process id " << fork_return << std::endl;
          }
        */

        int ticks_still_to_wait = patience_ticks;

        bool subprocess_finished_flag = false;
        // the tracker of whether the subprocess has changed state or not.

        while( 0 < ticks_still_to_wait )
          {

            if( waitpid( fork_return,
                         &process_status,
                         WNOHANG ) == fork_return )
              /* if the waitpid() function waited for the subprocess (with
               * process id fork_return) and the subprocess changed state, so
               * that waitpid() returned the subprocess's process id...
               */
              {

                ticks_still_to_wait = 0;
                // note that we don't have to wait any more.

                subprocess_finished_flag = true;
                // note that the subprocess changed state.

              }
            else
              {

                usleep( 1000 );
                // wait 1000 microseconds = 1 millisecond.

                --ticks_still_to_wait;
                // note that we have waited for 1 of the remaining
                // milliseconds.

                // debugging:
                //*output_log << std::endl << "sleeping, ticks remaining:"
                //<< ticks_still_to_wait << std::endl;

              }

          }

        if( false == subprocess_finished_flag )
          // if we have waited over (patience_ticks/1000) seconds & the
          // subprocess has not changed state...
          {

#ifndef CppSLHA_MAC

            std::cout
            << std::endl
            << "killing forked process " << fork_return
            << " due to it taking over " << patience_ticks << " milliseconds"
            << std::endl;
            // print warning about hanging subprocess.
            kill( fork_return,
                  9 );
            // kill the hanging process.
            waitpid( -1,
                     &process_status,
                     0 );
            // wait for all this killing to finish?  i'm not entirely sure.

            subprocess_returned_flag = false;
            // note that the subprocess had to be killed because it did not
            // return a value.

#endif

          }

        // debugging:
        //output_log->close();
        //delete output_log;

        return_value = WEXITSTATUS( process_status );
        // debugging:
        // std::cout << "forked process returning with return value "
        // << return_value << std::endl;

      }  // end of fork() statement.

    return subprocess_returned_flag;

  }

}  // end of CppSLHA namespace
