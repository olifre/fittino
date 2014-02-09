/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CalculatorBase.h                                                 *
*                                                                              *
* Description Base class for calculators                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CALCULATORBASE_H
#define FITTINO_CALCULATORBASE_H

#include "Collection.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PredictionBase;
  class PhysicsModel;
  class SimpleDataStorage;
  class Chi2ContributionBase;

  /*!
   *  \ingroup kernel
   *  \brief Base class for calculators.
   */
  class CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      CalculatorBase( const PhysicsModel* model );
      /*!
       *  Standard destructor.
       */
      ~CalculatorBase();
      std::string                              GetName() const;

    public:
      /*!
       *  \todo Remove.
       */
      const Collection<Chi2ContributionBase*>& GetCollectionOfChi2Contributions() const;
      const Collection<PredictionBase*>&       GetCollectionOfQuantities() const;
      /*!
       *  \todo Remove.
       */
      const SimpleDataStorage*                 GetSimpleOutputDataStorage() const;

    public:
      virtual void                             CalculatePredictions() = 0;
      virtual void                             Initialize() const;
      virtual void                             SetupMeasuredValues();

    protected:
      std::string                              _name;
      const PhysicsModel*                      _model;
      /*!
       *  \todo Remove.
       */
      SimpleDataStorage*                       _simpleOutputDataStorage;
      /*!
       *  \todo Remove.
       */
      Collection<Chi2ContributionBase*>        _collectionOfChi2Contributions;
      Collection<PredictionBase*>              _collectionOfQuantities;

    protected:
      /*!
       *  \todo Remove.
       */
      void                                     AddChi2Contribution( Chi2ContributionBase* chi2Contribution );
      void                                     AddQuantity( PredictionBase* prediction );

  };

}

#endif // FITTINO_CALCULATORBASE_H
