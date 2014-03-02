/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ExecutorException.h                                              *
*                                                                              *
* Description Indicates a problem with the execution of an external program    *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_EXECUTOREXCEPTION_H
#define FITTINO_EXECUTOREXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup exceptions
   *  \brief Indicated a problem with the execution of an external program.
   */
  class ExecutorException : public ExceptionBase {

    public:
      ExecutorException( const std::string& message );

  };

}

#endif // FITTINO_EXECUTOREXCEPTION_H
