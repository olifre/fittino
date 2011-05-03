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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PHYSICSMODELBASE_H
#define FITTINO_PHYSICSMODELBASE_H

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ObservableBase;

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
      virtual double               Evaluate();
      virtual void                 PrintStatus();

    protected:
      std::vector<ObservableBase*> _observableVector;

      /*! \cond UML */
    private:
      double                       CalculateChi2();
      /*!
       *  \todo Short-term: This function may either become obsolete or will have to be expanded,
       *  depending on how the actual interface to LHC rate prediction calculators will be realized.
       */
      void                         UpdateLHCRatePrediction();
      void                         UpdateObservablePredictions();
      void                         UpdateSLHAConfiguration();

      /*! \endcond UML */

  };

}

#endif // FITTINO_PHYSICSMODELBASE_H
