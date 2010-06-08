/* $Id: ModelFactory.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelFactory.h                                                   *
*                                                                              *
* Description Factory class for models                                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELFACTORY_H
#define FITTINO_MODELFACTORY_H

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Factory class for models 
   */
  class ModelFactory {

    public:
      /*!
       *  Constructor
       */
                 ModelFactory();
      ModelBase* GetModel( ModelBase::ModelType modelType ) const;

      /*!
       *  Destructor
       */
                 ~ModelFactory();

  };

}

#endif // FITTINO_MODELFACTORY_
