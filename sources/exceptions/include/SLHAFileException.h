/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAFileException.h                                              *
*                                                                              *
* Description Fittino SLHA file exception class. It is thrown in case of       *
*             problems with the SLHA file (syntax errors, etc.)                *
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

#ifndef FITTINO_SLHAFILEEXCEPTION_H
#define FITTINO_SLHAFILEEXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup exceptions
   *  \brief Fittino SLHA file exception class.
   */
  class SLHAFileException : public ExceptionBase {

    public:
      /*!
       *  Takes as input a message string which is printed on the screen as soon as the exception\n
       *  is caught and the what() method is called. The message is supposed to provide the user\n
       *  with further information about the occurred exception.
       */
      SLHAFileException( const std::string& message );

  };

}

#endif // FITTINO_SLHAFILEEXCEPTION_H
