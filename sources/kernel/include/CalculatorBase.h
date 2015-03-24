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

  class FormulaQuantity;
  class ModelBase;
  class PhysicsModel;
  class Quantity;

  /*!
   *  \ingroup kernel
   *  \brief Base class for calculators.
   */
  class CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      CalculatorBase( const ModelBase* model, const boost::property_tree::ptree* ptree = 0 );
      /*!
       *  Standard destructor.
       */
      const std::string&                      GetName() const;
      const Collection<Quantity*>&            GetCollectionOfQuantities() const;

    public:
      virtual                                 ~CalculatorBase();
      virtual void                            CalculatePredictions() = 0;
      virtual void                            Initialize();
      /*!
       *  \todo Remove when no longer used by derived classes (Matthias).
       */
      virtual void                            SetupMeasuredValues();

    protected:
      std::string                             _name;
      std::string                             _tag;
      const ModelBase*                        _model;

    protected:
      const double&                           GetInput( std::string name ) const;
      void                                    AddInput( std::string name, std::string defaultValue = "" );
      void                                    AddQuantity( Quantity* prediction );
      void                                    PrintInput() const;
      void                                    UpdateInput();
      const boost::property_tree::ptree*      GetConfiguration() const;

      /*! \cond UML */
    private:
      std::map<std::string, FormulaQuantity*> _input;
      const boost::property_tree::ptree*      _ptree;
      Collection<Quantity*>                   _collectionOfQuantities;

      /*! \endcond UML */

  };

}

#endif // FITTINO_CALCULATORBASE_H
