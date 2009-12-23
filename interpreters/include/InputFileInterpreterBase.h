/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        InputFileInterpreterBase.h                                       *
*                                                                              *
* Description Base class for reading and interpreting input files              *
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

#ifndef FITTINO_INPUTFILEINTERPRETERBASE_H
#define FITTINO_INPUTFILEINTERPRETERBASE_H

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Base class for reading and interpreting input files
   */
  class InputFileInterpreterBase {
  
    public:
      enum FileFormat { FITTINOINPUTFILE, XMLINPUTFILE };
  
    public:
                   /*!
                    *  Constructor
                    */
                   InputFileInterpreterBase();

                   /*!
                    *  Destructor
                    */
                   ~InputFileInterpreterBase();

      virtual void Parse() = 0;
  
  };

}

#endif // FITTINO_INPUTFILEINTERPRETERBASE_H
