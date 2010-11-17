/* $Id: ConfigurationException.h 582 2010-04-15 23:00:32Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ConfigurationException.h                                         *
*                                                                              *
* Description Fittino configuration exception class. It is thrown in case of   *
*             problems with the user configuration.                            *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CONFIGURATIONEXCEPTION_H
#define FITTINO_CONFIGURATIONEXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Fittino configuration exception class.
   *
   *  Configuration exceptions are thrown if an inconsistent configuration is detected, e.g.\n
   *  steering parameters unknown to Fittino.
   */
  class ConfigurationException : public ExceptionBase {

    public:
      /*!
       *  Takes as input a message string which is printed on the screen as soon as the exception\n
       *  is caught and the what() method is called. The message is supposed to provide the user\n
       *  with further information about the occurred exception.
       */
      ConfigurationException( const std::string& message );

  };

}

#endif // FITTINO_CONFIGURATIONEXCEPTION_H
