/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        InputException.h                                                 *
*                                                                              *
* Description Fittino input exception class. It is thrown in case of erroneous *
*             input.                                                           *
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

#ifndef FITTINO_INPUTEXCEPTION_H
#define FITTINO_INPUTEXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup exceptions
   *  \brief Fittino input exception class.
   *
   *  Input exceptions are thrown if Fittino is called with formally invalid input of any kind e.g\n
   *  with unknown options, an invalid combination of options or if there are missing option\n
   *  parameters. They are also thrown if the format of the input file cannot be detected or if\n
   *  parsing errors have occurred.
   */
  class InputException : public ExceptionBase {

    public:
      /*!
       *  Takes as input a message string which is printed on the screen as soon as the exception\n
       *  is caught and the what() method is called. The message is supposed to provide the user\n
       *  with further information about the occurred exception.
       */
      InputException( const std::string& message );

  };

}

#endif // FITTINO_INPUTEXCEPTION_H
