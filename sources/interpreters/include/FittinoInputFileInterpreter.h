/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FittinoInputFileInterpreter.h                                    *
*                                                                              *
* Description Class for reading and interpreting Fittino input files           *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FITTINOINPUTFILEINTERPRETER_H
#define FITTINO_FITTINOINPUTFILEINTERPRETER_H

#include "InputFileInterpreterBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Class for reading and interpreting Fittino input files
   */
  class FittinoInputFileInterpreter : public InputFileInterpreterBase {
  
    public:
           /*!
            *  Constructor
            */
           FittinoInputFileInterpreter();

           /*!
            *  Destructor
            */
           ~FittinoInputFileInterpreter();

      void Parse();
  
  };

}

#endif // FITTINO_FITTINOINPUTFILEINTERPRETER_H
