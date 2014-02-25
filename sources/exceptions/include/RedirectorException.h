/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RedirectorException.h                                            *
*                                                                              *
* Description Indicates a problem with redirection                             *
*                                                                              *
* Authors     Bjoern Sarrazin <sarrazin@physik.uni-bonn.de>                    *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_REDIRECTOREXCEPTION_H
#define FITTINO_REDIRECTOREXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup exceptions
   *  \brief Fittino model calculator exception class.
   */
  class RedirectorException : public ExceptionBase {

    public:
      RedirectorException( const std::string& message );

  };

}

#endif // FITTINO_REDIRECTOREXCEPTION_H
