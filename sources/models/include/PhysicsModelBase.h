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
#include "SLHAParameter.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Chi2ContributionBase;
  class ObservableBase;
  class ModelCalculatorBase;

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
      virtual void                       PrintStatus();

    protected:
      std::vector<Chi2ContributionBase*> _chi2ContributionVector;
      std::vector<ModelCalculatorBase*>  _modelCalculatorVector;
      std::vector<ObservableBase*>       _observableVector;

      /*! \cond UML */
    private:
      /*!
       *  Calculate the resulting chi2.
       *  \todo Eventually generalize this function to allow for correlated
       *  observables.
       */
      double                             CalculateChi2();

      /*! \endcond UML */

    private:   
      virtual double                     Evaluate();

  };

}

#endif // FITTINO_PHYSICSMODELBASE_H
