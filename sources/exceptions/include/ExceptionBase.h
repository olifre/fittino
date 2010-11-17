/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ExceptionBase.h                                                  *
*                                                                              *
* Description Fittino exception base class                                     *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*             Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_EXCEPTIONBASE_H
#define FITTINO_EXCEPTIONBASE_H

#include <exception>
#include <string>

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Fittino exception base class.
   *
   *  Exceptions make up the backbone of the error handling system in Fittino. This class provides\n
   *  basic functionality for the various Fittino exception classes. Their main purpose is to\n
   *  print out messages with further information about the occurred exception in a uniform way.\n
   *  Supported Fittino exceptions are
   *  <ul>
   *    <li> ConfigurationException\n
   *      Configuration exceptions are thrown if an inconsistent configuration is detected, e.g.\n
   *      steering parameters unknown to Fittino.
   *    <li> InputException\n
   *      Input exceptions are thrown if Fittino is called with formally invalid input of any kind\n
   *      e.g with unknown options, an invalid combination of options or if there are missing\n
   *      option parameters. They are also thrown if the format of the input file cannot be\n
   *      detected or if parsing errors have occurred.
   *    <li> SLHAFileException
   *    <li> ModelCalculatorException
   *    <li> OptimizerException
   *  </ul>
   */
  class ExceptionBase : public std::exception {

    public:
      /*!
       *  Takes as input a message string which is printed on the screen as soon as the exception\n
       *  is caught and the what() method is called. The message is supposed to provide the user\n
       *  with further information about the occurred exception.
       */
                        ExceptionBase( const std::string& message );
      /*!
       *  Standard destructor.
       */
      virtual           ~ExceptionBase() throw();
      /*!
       *  Prints message specified in the constructor.
       */
      const char*       what() const throw();

    protected:
      /*!
       *  Message to be printed.
       */
      const std::string _message;

  };

}

#endif // FITTINO_EXCEPTIONBASE_H
