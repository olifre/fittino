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
   *  \brief Fittino exception base class
   */
  class ExceptionBase : public std::exception {

    public:
      /*!
       *  Takes as input a message string which is printed on the screen as soon
       *  as the exception is caught and the what() method is called. The message
       *  is supposed to provide the user with further information about the
       *  occurred exception.
       */
                        ExceptionBase( const std::string& message );
      /*!
       *  Destructor
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
