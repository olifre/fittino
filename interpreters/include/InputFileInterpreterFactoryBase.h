/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        InputFileInterpreterFactoryBase.h                                *
*                                                                              *
* Description Base class for input file interpreter factories                  *
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

#ifndef FITTINO_INPUTFILEINTERPRETERFACTORYBASE_H
#define FITTINO_INPUTFILEINTERPRETERFACTORYBASE_H

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Base class for input file interpreter factories 
   */
  class InputFileInterpreterFactoryBase {

    public:
                                       /*!
                                        *  Constructor
                                        */
                                       InputFileInterpreterFactoryBase();

                                       /*!
                                        *  Destructor
                                        */
                                       ~InputFileInterpreterFactoryBase();

      virtual InputFileInterpreterBase* CreateInterpreter() = 0;

  };

}

#endif // FITTINO_INPUTFILEINTERPRETERFACTORYBASE_H
