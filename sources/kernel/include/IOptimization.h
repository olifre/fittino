/* $Id: IOptimization.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        IOptimization.h                                                  *
*                                                                              *
* Description Interface class for optimization algorithms                      *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_IOPTIMIZATION_H
#define FITTINO_IOPTIMIZATION_H

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Interface class for optimization algorithms
   */
  class IOptimization {

    public:
      /*!
       *  Constructor
       */
                         IOptimization();
      /*!
       *  Destructor
       */
                         ~IOptimization();
      double             EvaluateModel( ModelBase* model );
      virtual void       UpdateModel() = 0;

  };

}

#endif // FITTINO_IOPTIMIZATION_H
