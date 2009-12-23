/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ExceptionBase.h                                                  *
*                                                                              *
* Description Fittino exception base class                                     *
*                                                                              *
* Authors     Peter Wienemann <wienemann@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_EXCEPTIONBASE_H
#define FITTINO_EXCEPTIONBASE_H

#include <string>
#include <exception>

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
       *  Constructor
       */
      ExceptionBase( const std::string& text ) {

	  _message = "Fittino::ExceptionBase: " + text;
	
      }

      /*!
       *  Destructor
       */
      virtual ~ExceptionBase() throw() { ; }

      /*!
       *  Method to print message
       */
      virtual const char* what() const throw() {

	  return _message.c_str();

      }

    protected:
      std::string    _message; //! message to be printed
  };

}

#endif // FITTINO_EXCEPTIONBASE_H
