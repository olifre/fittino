/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        InputFileException.h                                             *
*                                                                              *
* Description Fittino input file exception class. It is thrown in case of      *
*             problems with input file (syntax error, unknown type, etc.).     *
*                                                                              *
* Authors     Peter Wienemann <wienemann@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_INPUTFILEEXCEPTION_H
#define FITTINO_INPUTFILEEXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Fittino input file exception class
   */
  class InputFileException : public Fittino::ExceptionBase {

    public:
      /*!
       *  Constructor
       */
      InputFileException( const std::string& text ) {

	  _message = "Fittino::InputFileException: " + text;
	
      }

      /*!
       *  Destructor
       */
      virtual ~InputFileException() throw() { ; }

  };

}

#endif // FITTINO_INPUTFILEEXCEPTION_H
