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

#include <boost/property_tree/ptree_fwd.hpp>

#include "Collection.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class ModelBase;
    class PhysicsModel;
    class Quantity;
    class FormulaQuantity;

  /*!
   *  \ingroup kernel
   *  \brief Base class for calculators.
   */
  class CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      CalculatorBase( const ModelBase* model, boost::property_tree::ptree* ptree = 0 );

      /*!
       *  Standard destructor.
       */
      std::string                                   GetName() const;
      const Collection<Quantity*>&                  GetCollectionOfQuantities() const;

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
      boost::property_tree::ptree*                  _ptree;

    protected:
      const double&                                 GetInput( std::string name ) const;
      void                                          AddInput( std::string name, std::string defaultValue = "" );
      void                                          AddQuantity( Quantity* prediction );
      void                                          UpdateInput();
      void                                          PrintInput() const;

      /*! \cond UML */
    private:
      std::map< std::string, FormulaQuantity* >     _input;
      Collection<Quantity*>                         _collectionOfQuantities;

      /*! \endcond UML */

  };

}

#endif // FITTINO_CALCULATORBASE_H
