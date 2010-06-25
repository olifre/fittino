/* $Id: InputFileInterpreterFactory.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        InputFileInterpreterFactory.h                                    *
*                                                                              *
* Description Factory class for input file interpreters                        *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_INPUTFILEINTERPRETERFACTORY_H
#define FITTINO_INPUTFILEINTERPRETERFACTORY_H

#include "InputFileInterpreterBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Factory class for input file interpreters
   */
  class InputFileInterpreterFactory {

    public:
      /*!
       *  Constructor
       */
                                            InputFileInterpreterFactory();
      /*!
       *  Destructor
       */
                                            ~InputFileInterpreterFactory();
      const InputFileInterpreterBase* const CreateInputFileInterpreter( const InputFileInterpreterBase::InputFileFormat& inputFileFormat ) const;

  };

}

#endif // FITTINO_INPUTFILEINTERPRETERFACTORY_H
