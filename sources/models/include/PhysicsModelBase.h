/* $Id: PhysicsModelBase.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsModelBase.h                                               *
*                                                                              *
* Description Base class for Fittino physics models                            *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PHYSICSMODELBASE_H
#define FITTINO_PHYSICSMODELBASE_H

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Base class for Fittino physics models.
   */
  class PhysicsModelBase : public ModelBase {

    public:
                     /*!
                      *  Standard constructor.
                      */
                     PhysicsModelBase();

                     /*!
                      *  Standard destructor.
                      */
                     ~PhysicsModelBase();
      virtual double Evaluate();

    private:
      double         CalculateChi2();
      void           UpdateObservablePredictions();
      void           UpdateSLHAConfiguration();

  };

}

#endif // FITTINO_PHYSICSMODELBASE_H
