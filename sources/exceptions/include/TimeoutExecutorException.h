/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TimeoutExecutorException.h                                       *
*                                                                              *
* Description Thrown if the execution of an external program is taking too     *
*             long                                                             *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_TIMEOUTEXECUTOREXCEPTION_H
#define FITTINO_TIMEOUTEXECUTOREXCEPTION_H

#include "ExecutorException.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup exceptions
   *  \brief Thrown if the execution of an external program is taking too long.
   */
  class TimeoutExecutorException : public ExecutorException {

    public:
      TimeoutExecutorException( const std::string& message );

  };

}

#endif // FITTINO_TIMEOUTEXECUTOREXCEPTION_H
