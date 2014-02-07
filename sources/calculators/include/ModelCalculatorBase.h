/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelCalculatorBase.h                                            *
*                                                                              *
* Description Base class for model calculators                                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELCALCULATORBASE_H
#define FITTINO_MODELCALCULATORBASE_H

#include <string>
#include <map>

#include "Collection.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PredictionBase;
  class PhysicsModelBase;
  class SimpleDataStorage;
  class Chi2ContributionBase;

  /*!
   *  \defgroup calculators
   */
  /*!
   *  \ingroup calculators
   *  \brief Base class for model calculators.
   */
  class ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                                    ModelCalculatorBase( const PhysicsModelBase* model );
      /*!
       *  Standard destructor.
       */
                                    ~ModelCalculatorBase();
      std::string                   GetName() const;

    public:  
      const Collection<PredictionBase*>&        GetCollectionOfQuantities() const;
      const Collection<Chi2ContributionBase*>&  GetCollectionOfChi2Contributions() const;
      const SimpleDataStorage*                  GetSimpleOutputDataStorage() const;

    public:
      virtual void                  CalculatePredictions() = 0;
      virtual void                  Initialize() const;
      void                          SetupMeasuredValues();

    protected:
      void                          AddQuantity( PredictionBase* prediction );
      void                          AddChi2Contribution( Chi2ContributionBase* chi2Contribution );

    protected:
      std::string                   _name;
      const PhysicsModelBase*       _model;
      SimpleDataStorage*            _simpleOutputDataStorage;
      Collection<PredictionBase*>   _collectionOfQuantities;
      Collection<Chi2ContributionBase*> _collectionOfChi2Contributions;

  };

}

#endif // FITTINO_MODELCALCULATORBASE_H
