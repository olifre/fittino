/* $Id: XMLInputFileInterpreter.h 542 2009-12-23 14:59:43Z wiene $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        XMLInputFileInterpreter.h                                        *
*                                                                              *
* Description Class for reading and interpreting XML input files               *
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

#ifndef FITTINO_XMLINPUTFILEINTERPRETER_H
#define FITTINO_XMLINPUTFILEINTERPRETER_H

#include "InputFileInterpreterBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Class for reading and interpreting XML input files
   */
  class XMLInputFileInterpreter : public InputFileInterpreterBase {
  
    public:
           /*!
            *  Constructor
            */
           XMLInputFileInterpreter();

           /*!
            *  Destructor
            */
           ~XMLInputFileInterpreter();

      void Parse();
  
  };

}

#endif // FITTINO_XMLINPUTFILEINTERPRETER_H
