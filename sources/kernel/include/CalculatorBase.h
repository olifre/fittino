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

  class PhysicsModel;
  class PredictionBase;

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
      std::string                        GetName() const;
      const Collection<PredictionBase*>& GetCollectionOfQuantities() const;

    public:
      virtual                            ~CalculatorBase();
      virtual void                       CalculatePredictions() = 0;
      virtual void                       Initialize();
      /*!
       *  \todo Remove when no longer used by derived classes (Matthias).
       */
      virtual void                       SetupMeasuredValues();

    protected:
      std::string                        _name;
      std::string                        _tag;
      const PhysicsModel*                _model;

    protected:
      void                               AddQuantity( PredictionBase* prediction );

      /*! \cond UML */
    private:
      Collection<PredictionBase*>        _collectionOfQuantities;

      /*! \endcond UML */

  };

}

#endif // FITTINO_CALCULATORBASE_H
