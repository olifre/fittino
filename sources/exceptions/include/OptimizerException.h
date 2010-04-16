/* $Id: OptimizerException.h 582 2010-04-15 23:00:32Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        OptimizerException.h                                             *
*                                                                              *
* Description Fittino optimizer exception class. It is thrown in case of       *
*             problems with optimizers.                                        *
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

#ifndef FITTINO_OPTIMIZEREXCEPTION_H
#define FITTINO_OPTIMIZEREXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Fittino optimizer exception class
   */
  class OptimizerException : public ExceptionBase {

    public:
      /*!
       *  Takes as input a message string which is printed on the screen as soon
       *  as the exception is caught and the what() method is called. The message
       *  is supposed to provide the user with further information about the
       *  occurred exception.
       */
                  OptimizerException( const std::string& message );
      /*!
       *  Prints message specified in the constructor
       */
      const char* what() const throw();

  };

}

#endif // FITTINO_OPTIMIZEREXCEPTION_H
