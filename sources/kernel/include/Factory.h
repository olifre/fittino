/* $Id: Factory.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Factory.h                                                        *
*                                                                              *
* Description Factory class for creating input file interpreters, models and   *
*             optimizers                                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FACTORY_H
#define FITTINO_FACTORY_H

#include "InputFileInterpreterBase.h"
#include "ModelBase.h"
#include "OptimizerBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Factory class for creating input file interpreters. models and optimizers.
   */
  class Factory {

    public:
      /*!
       *  Constructor
       */
                                            Factory();
      /*!
       *  Destructor
       */
                                            ~Factory();
      const InputFileInterpreterBase* const CreateInputFileInterpreter( const InputFileInterpreterBase::InputFileFormat& inputFileFormat ) const;
      ModelBase* const                      CreateModel( const ModelBase::ModelType& modelType ) const;
      OptimizerBase* const                  CreateOptimizer( const OptimizerBase::OptimizerType& optimizerType, ModelBase* model ) const;

  };

}

#endif // FITTINO_FACTORY_H
