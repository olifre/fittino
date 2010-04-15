/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ExceptionBase.h                                                  *
*                                                                              *
* Description Fittino exception base class                                     *
*                                                                              *
* Authors     Peter Wienemann  <wienemann@physik.uni-bonn.de>                  *
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
       *  Constructor
       */
                          ExceptionBase();
                          ExceptionBase( const std::string& message );
      /*!
       *  Destructor
       */
      virtual             ~ExceptionBase() throw();
      /*!
       *  Method to print message
       */
      virtual const char* what() const throw();

    protected:
      std::string         _message; //! Message to be printed

  };

}

#endif // FITTINO_EXCEPTIONBASE_H
