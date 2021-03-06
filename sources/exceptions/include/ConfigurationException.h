/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ConfigurationException.h                                         *
*                                                                              *
* Description Thrown in case of problems with the configuration of Fittino     *
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
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup exceptions
   */
  /*!
   *  \ingroup exceptions
   *  \brief Thrown in case of problems with the configuration of Fittino.
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
