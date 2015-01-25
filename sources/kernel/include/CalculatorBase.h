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
#include <boost/property_tree/ptree_fwd.hpp>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;
  class PhysicsModel;
    class Quantity;

  template<class T> class VariableBase;

  /*!
   *  \ingroup kernel
   *  \brief Base class for calculators.
   */
  class CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      CalculatorBase( const ModelBase* model );
      CalculatorBase( const ModelBase* model, const boost::property_tree::ptree& ptree  );

      /*!
       *  Standard destructor.
       */
      std::string                                   GetName() const;
      const Collection<Quantity*>&                  GetCollectionOfQuantities() const;
      const Collection<VariableBase<std::string>*>& GetCollectionOfStringVariables() const;

    public:
      virtual                                       ~CalculatorBase();
      virtual void                                  CalculatePredictions() = 0;
      virtual void                                  Initialize();
      /*!
       *  \todo Remove when no longer used by derived classes (Matthias).
       */
      virtual void                                  SetupMeasuredValues();

    protected:
      std::string                                   _name;
      std::string                                   _tag;
      const ModelBase*                              _model;

    protected:
      void                                          AddQuantity( Quantity* prediction );
      void                                          AddStringVariable( VariableBase<std::string>* variable );

      /*! \cond UML */
    private:
      Collection<Quantity*>                         _collectionOfQuantities;
      Collection<VariableBase<std::string>*>        _collectionOfStringVariables;

      /*! \endcond UML */

  };

}

#endif // FITTINO_CALCULATORBASE_H
