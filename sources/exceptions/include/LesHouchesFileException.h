/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LesHouchesFileException.h                                        *
*                                                                              *
* Description Fittino Les Houches file exception class. It is thrown in case   *
*             of problems with Les Houches file (syntax errors, etc.) from     *
*             model calculators.                                               *
*                                                                              *
* Authors     Peter Wienemann <wienemann@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_LESHOUCHESFILEEXCEPTION_H
#define FITTINO_LESHOUCHESFILEEXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Fittino Les Houches file exception class
   */
  class LesHouchesFileException : public Fittino::ExceptionBase {

    public:
      /*!
       *  Constructor
       */
      LesHouchesFileException( const std::string& text ) {

	  _message = "Fittino::LesHouchesFileException: " + text;
	
      }

      /*!
       *  Destructor
       */
      virtual ~LesHouchesFileException() throw() { ; }

  };

}

#endif // FITTINO_LESHOUCHESFILEEXCEPTION_H
