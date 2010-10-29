/* $Id: Factory.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Factory.h                                                        *
*                                                                              *
* Description Factory class for creating input file interpreters, models,      *
*             optimizers and samplers                                          *
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
#include "SamplerBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Factory class for creating input file interpreters, models, optimizers and samplers.
   */
  class Factory {

    public:
      /*!
       *  Standard constructor.
       */
                                            Factory();
      /*!
       *  Standard destructor. 
       */
                                            ~Factory();
      /*!
       *  Returns a concrete input file interpreter according to the input file format passed as\n
       *  an argument. Supported input file formats are
       *  <ul>
       *    <li> FITTINOINPUTFILE\n
       *    <li> XMLINPUTFILE\n
       *  </ul>
       */
      const InputFileInterpreterBase* const CreateInputFileInterpreter( const InputFileInterpreterBase::InputFileFormat& inputFileFormat ) const;
      /*!
       *  Returns a concrete model according to the model type passed as an argument. Supported\n
       *  model types are
       *  <ul>
       *    <li> MSUGRA\n
       *    <li> ROSENBROCK\n
       *  </ul>
       */
      ModelBase* const                      CreateModel( const ModelBase::ModelType& modelType ) const;
      /*!
       *  Returns a concrete parameter optimizer according to the optimizer type passed as an\n
       *  argument. Supported optimizer types are
       *  <ul>
       *    <li> MINUIT\n
       *    <li> PARTICLESWARM\n
       *    <li> SIMULATEDANNEALING\n
       *  </ul>
       */
      OptimizerBase* const                  CreateOptimizer( const OptimizerBase::OptimizerType& optimizerType, ModelBase* model ) const;
      /*!
       *  Returns a concrete parameter sampler according to the sampler type passed as an\n
       *  argument.  Supported sampler types are
       *  <ul>
       *    <li> MARKOVCHAIN\n
       *  </ul>
       */
      SamplerBase* const                    CreateSampler( const SamplerBase::SamplerType& samplerType, ModelBase* model ) const;

  };

}

#endif // FITTINO_FACTORY_H
