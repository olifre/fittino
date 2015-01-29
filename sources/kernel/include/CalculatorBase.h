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
#include "PtreeForwardDeclaration.h"
#include <boost/property_tree/ptree_fwd.hpp>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;
  class PhysicsModel;
    class Quantity;
    class FormulaQuantity;

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
      CalculatorBase(const ModelBase *model, boost::property_tree::ptree &ptree);

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
      boost::property_tree::ptree*                  _ptree;

    protected:
      void                                          AddQuantity( Quantity* prediction );
      void                                          AddQuantity( std::string key, Quantity* prediction );
      void                                          AddStringVariable( VariableBase<std::string>* variable );
      void                                          AddInput( std::string name, std::string path, std::string defaultValue );
      void                                          AddInput( std::string name, std::string path );
      void                                          UpdateInput();
      const double&                                 GetInput( std::string name );

      /*! \cond UML */
    private:
      Collection<Quantity*>                         _collectionOfQuantities;
      Collection<VariableBase<std::string>*>        _collectionOfStringVariables;
      std::map< std::string, FormulaQuantity* >     _input;


      /*! \endcond UML */

  };

}

#endif // FITTINO_CALCULATORBASE_H
