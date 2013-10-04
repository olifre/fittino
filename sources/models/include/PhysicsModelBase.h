/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsModelBase.h                                               *
*                                                                              *
* Description Base class for Fittino physics models                            *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*             Matthias Hamer        <mhamer@gwdg.de>                           *
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

class TRandom3;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelCalculatorBase;
  class Observable;

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
      /*!
       *  Adds an observable to the model.
       */
      void                                           AddObservable( Observable *observable );
      /*!
       *  Adds a calculator to the model.
       */
      void                                           AddCalculator( ModelCalculatorBase *calculator );
      /*!
       *  Returns the predictions of the model as a collection.
       */
      const Collection<ModelCalculatorBase*>&        GetCollectionOfCalculators() const;

    public:
      virtual void                                   PrintStatus() const;
      virtual void                                   SmearObservables( TRandom3* );

    public:
      virtual std::vector<ModelCalculatorBase*>*     GetModelCalculatorVector();
      std::vector<Observable*>*                      GetObservableVector(); 

    protected:
      virtual void                                   Initialize() const;

    protected:
      std::vector<ModelCalculatorBase*>              _modelCalculatorVector;
      std::vector<Observable*>                       _observableVector;

      /*! \cond UML */
    private:
      /*!
       *  Calculate the resulting chi2.
       *  \todo Eventually generalize this function to allow for correlated
       *  observables.
       */
      double                                         CalculateChi2();

    private:
      virtual double                                 Evaluate();

      void                                           InitializeCalculators();
      void                                           InitializeObservables();
      /*! \endcond UML */

    private:
      /*!
       *  Stores the calculators.
       */
      Collection<ModelCalculatorBase*>               _collectionOfCalculators;

  };

}

#endif // FITTINO_PHYSICSMODELBASE_H
