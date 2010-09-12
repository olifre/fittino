/* $Id: ExecutionMode.h,v 1.0 2007/10/08 09:37:15 uhlenbrock$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ExecutionMode.h                                                  *
*                                                                              *
* Description Class for execution mode                                         *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wiene@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_EXECUTIONMODE_H
#define FITTINO_EXECUTIONMODE_H

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  /*!
   *  \brief Class for execution mode 
   */
  class ExecutionMode {
  
    public:
      enum Mode { OPTIMIZATION, SAMPLING, SCAN };
  
    public:
           ExecutionMode();
           ~ExecutionMode();
  
  };

}

#endif // FITTINO_EXECUTIONMODE_H
