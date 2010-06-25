/* $Id: OptimizerFactory.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        OptimizerFactory.h                                               *
*                                                                              *
* Description Factory class for optimizers                                     *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_OPTIMIZERFACTORY_H
#define FITTINO_OPTIMIZERFACTORY_H

#include "ModelBase.h"
#include "OptimizerBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Factory class for optimizers
   */
  class OptimizerFactory {

    public:
      /*!
       *  Constructor
       */
                           OptimizerFactory();
      /*!
       *  Destructor
       */
                           ~OptimizerFactory();
      OptimizerBase* const CreateOptimizer( const OptimizerBase::OptimizerType& optimizerType, ModelBase* model ) const;

  };

}

#endif // FITTINO_OPTIMIZERFACTORY_H
