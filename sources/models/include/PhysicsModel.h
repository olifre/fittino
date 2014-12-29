/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsModel.h                                                   *
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

#ifndef FITTINO_PHYSICSMODEL_H
#define FITTINO_PHYSICSMODEL_H

#include "TMatrixDSym.h"

#include "ModelBase.h"
#include "PtreeForwardDeclaration.h"


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class CalculatorBase;
  class Observable;

  /*!
   *  \defgroup models
   */
  /*!
   *  \ingroup models
   *  \brief Base class for Fittino physics models.
   */
  class PhysicsModel : public ModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      PhysicsModel( boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~PhysicsModel();
      /*!
       *  Adds an observable to the model.
       */
      void                                       AddObservable( Observable *observable );

      void                                       AddChi2Contribution( const std::string& name );
      /*!
       *  Returns the predictions of the model as a collection.
       */
      virtual const Collection<CalculatorBase*>& GetCollectionOfCalculators() const;

    public:
      virtual void                               PrintStatus() const;
      virtual void                               SetupForToyRun( );
      /*!
       *  Virtual copy constructor.
       */
      virtual PhysicsModel*                      Clone() const;

    public:

    protected:
      virtual void                               Initialize();

    protected:
      Collection<const Quantity*>                _collectionOfChi2Quantities;
      TMatrixDSym*                               _observableCovarianceMatrix;
      TMatrixDSym*                               _observableCorrelationMatrix;
      TMatrixDSym*                               _fitObservableCovarianceMatrix;
      TMatrixDSym*                               _invertedFitObservableCovarianceMatrix;
      Collection<TMatrixDSym*>                   _collectionOfCovarianceMatrices;
      std::map<std::string, int>                 _observableIndexInCovarianceMatrix;
      /*! \cond UML */
    private:
      /*!
       *  Calculate the resulting chi2.
       *  \todo Eventually generalize this function to allow for correlated
       *  observables.
       */
      double                                     CalculateChi2();
      std::string                                _calculator;
      std::string                                _error;
      bool                                       _performToyRun;

    private:
      virtual double                             Evaluate();

      void                                       InitializeCalculators( const boost::property_tree::ptree& ptree );
      void                                       InitializeObservables( const boost::property_tree::ptree& ptree );
      void                                       InitializeCovarianceMatrix( const boost::property_tree::ptree& ptree );
      void                                       UpdateCovarianceMatrix();
      /*! \endcond UML */

    private:

  };

}

#endif // FITTINO_PHYSICSMODEL_H
