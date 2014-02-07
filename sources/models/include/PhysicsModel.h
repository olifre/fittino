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

#include "ModelBase.h"
#include "TMatrixDSym.h"

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare > class basic_ptree;
    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}

class TRandom3;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelCalculatorBase;
  class Chi2ContributionBase;
  class Observable;

  /*!
   *  \ingroup models
   *  \brief Base class for Fittino physics models.
   */
  class PhysicsModel : public ModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      PhysicsModel( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~PhysicsModel();
      /*!
       *  Adds an observable to the model.
       */
      void                                            AddObservable( Observable *observable );
      /*!
       *  Adds a calculator to the model.
       */
      void                                            AddCalculator( ModelCalculatorBase *calculator );

      void                                            AddChi2Contribution( const std::string& name );
      void                                            AddChi2Contribution( Chi2ContributionBase* contribution );
      /*!
       *  Returns the predictions of the model as a collection.
       */
      virtual const Collection<ModelCalculatorBase*>& GetCollectionOfCalculators() const;

    public:
      virtual void                                    PrintStatus() const;
      virtual void                                    SmearObservations( TRandom3* );
      /*!
       *  Virtual copy constructor.
       */
      virtual PhysicsModel*                           Clone() const;

    public:
      virtual const std::vector<Observable*>*         GetObservableVector() const;

    protected:
      virtual void                                    Initialize() const;

    protected:
      std::vector<Observable*>                        _observableVector;
      Collection<const Quantity*>                     _collectionOfChi2Quantities;
      //Collection<Chi2ContributionBase*>             _collectionOfChi2Contributions;
      TMatrixDSym*                                    _observableCovarianceMatrix;
      TMatrixDSym*                                    _fitObservableCovarianceMatrix;
      TMatrixDSym*                                    _invertedFitObservableCovarianceMatrix;
      Collection<TMatrixDSym*>                        _collectionOfCovarianceMatrices;
      std::map<std::string, int>                      _observableIndexInCovarianceMatrix;
      /*! \cond UML */
    private:
      /*!
       *  Calculate the resulting chi2.
       *  \todo Eventually generalize this function to allow for correlated
       *  observables.
       */
      double                                          CalculateChi2();

    private:
      virtual double                                  Evaluate();

      void                                            InitializeCalculators( const boost::property_tree::ptree& ptree );
      void                                            InitializeObservables( const boost::property_tree::ptree& ptree );
      void                                            InitializeCovarianceMatrix( const boost::property_tree::ptree& ptree );
      /*! \endcond UML */

    private:
      /*!
       *  Stores the calculators.
       */
      Collection<ModelCalculatorBase*>                _collectionOfCalculators;

  };

}

#endif // FITTINO_PHYSICSMODEL_H
