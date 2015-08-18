/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.h                                                      *
*                                                                              *
* Description Base class for Fittino models                                    *
*                                                                              *
* Authors     Matthias  Hamer       <mhamer@gwdg.de>                           *
*             Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELBASE_H
#define FITTINO_MODELBASE_H

#include <boost/property_tree/ptree.hpp>

#include "Collection.h"
#include "PredictionBase.h"
#include "VariableBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class CalculatorBase;
  class ModelParameter;
  class PredictionBase;
  class FormulaQuantity;

  /* Currently needed by some calculators, should be removed! */
  class Observable;

  /*!
   *  \ingroup kernel
   *  \brief Base class for Fittino models.
   */
  class ModelBase {

    public:
      /*!
       *  Constructor using a property tree.
       */
      ModelBase( boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ModelBase();

      double                                              GetChi2();
      /*!
       *  Returns the number of parameters of the model.
       */
      int                                                 GetNumberOfParameters() const;
      /*!
       *  Updates the property tree.
       */
      void                                                UpdatePropertyTree();
      /*!
       *  Returns the name of the model.
       */
      std::string                                         GetName() const;
      /*!
       *  Returns the property tree.
       */
      boost::property_tree::ptree                         GetPropertyTree();
      /*!
       *  Returns the parameters as a collection.
       */
      const Collection<ModelParameter*>&                  GetCollectionOfParameters() const;
      const Collection<Quantity*>&                        GetCollectionOfPredictions() const;
      const Collection<const Quantity*>&                  GetCollectionOfQuantities() const;
      const Collection<const VariableBase<double>*>&      GetCollectionOfMetaDataDoubleVariables() const;
      const Collection<const VariableBase<std::string>*>& GetCollectionOfStringVariables() const;

    public:
      virtual void                                        PrintStatus() const;
      void                                                Update();
      /*!
       *  Returns a pointer to a copy of the model.
       *  \todo Discuss what this function should actually do...
       */
      virtual ModelBase*                                  Clone();

    /* Currently needed by some calculators, should be removed! */
      virtual const std::vector<Observable*>*             GetObservableVector() const;

    protected:
      /*!
       *  Name of the model.
       */
      std::string                                         _name;
      boost::property_tree::ptree&                        _ptree;
      std::vector<CalculatorBase*>                        _calculators;
      /*!
       *  Stores the predictions.
       */
      Collection<Quantity*>                               _collectionOfPredictions;
      Collection<const VariableBase<double>*>             _collectionOfMetaDataDoubleVariables;
      Collection<const VariableBase<std::string>*>        _collectionOfStringVariables;

      /* Currently needed by some calculators, should be removed! */
      std::vector<Observable*>                            _observableVector;

      double                                              _chi2;

    protected:
      /*!
       *  Adds a prediction to the model.
       */
      void                                                AddPrediction( Quantity* prediction );

    protected:
      /*!
       *  This function is mainly used to provide a dedicated command to print the model\n
       *  configuration to the screen and is usually called at the end of the model constructor\n
       *  after the actual "initialization" of the model is already finished. Therefore, it should\n
       *  not be used to alter the state of the model. However, since third party code (like e.g.\n
       *  model calculators) sometimes does not differ between initialization and printing, this\n
       *  is also the place where third party code is initialized.
       *  \todo This function should not be needed. For the moment implement an empty version.
       */
      virtual void                                        Initialize() ;

      /*! \cond UML */
    private:
      double                                              _errorCode;
      /*!
       *  Stores the parameters.
       */
      Collection<ModelParameter*>                         _collectionOfParameters;
      Collection<const Quantity*>                         _collectionOfQuantities;
      std::vector<FormulaQuantity*>                       _chi2Contributions;

    private:
      /*!
       *  Returns the number of predictions of the model.
       */
      int                                                 GetNumberOfPredictions() const;
      /*!
       *  Adds a calculator to the model.
       */
      void                                                AddCalculator( CalculatorBase *calculator );
      /*!
       *  Adds a parameter to the model.
       */
      void                                                AddParameter( ModelParameter* parameter );
      void                                                InitializeCalculators( boost::property_tree::ptree &ptree );
      void                                                InitializeChi2Contributions();

      /*!
         *  Setup all parameters using a ptree.
         */
      void                                                InitializeParameters( boost::property_tree::ptree& ptree );

    private:
      virtual void Evaluate();

      /*! \endcond UML */

  };

}

#endif // FITTINO_MODELBASE_H
