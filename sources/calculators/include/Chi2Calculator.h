/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Chi2Calculator.h                                                 *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	          published by the Free Software Foundation; either version 3 of   *
*    	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CHI2CALCULATOR_H
#define FITTINO_CHI2CALCULATOR_H

#include <set>
#include <vector>

#include "TMatrixDSym.h"
#include "TVectorT.h"

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class Correlation;
    class Measurement;

    /*!
     * \ingroup calculators
     * \brief Calculates the chi2 from observables and correlations between the observables.
     *
     * The observables and correlations are represented by the two helper classes Measurement and Correlation.
     *
     * The following output quantities are provided:
     * - **Chi2** \copydoc _chi2
     *
     * - **CorrelatedChi2** \copydoc _correlatedChi2
     *
     * - For each observable with name [Name] the following quantities:
     *   - **Measurement_[Name]** \copydoc Measurement::_measurement
     *
     *   - **Deviation_[Name]** \copydoc Measurement::_deviation
     *
     *   - **Pull_[Name]** \copydoc Measurement::_pull
     *
     *   - **Chi2_[Name]** \copydoc Measurement::_chi2
     */
    class Chi2Calculator : public CalculatorBase {

      public:
      /*!
       * \param[in] model The model whose quantities are used as input.
       * \param[in] ptree The configuration consisting of the following nodes:
       * - _tree_ __Observable__ [1..] Configuration of an observable as described in Measurement::Measurement().
       * - _tree_ __Correlation__ [0..] Configuration of a correlation as described in Correlation::Correlation().
       */
      Chi2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *
       */
      ~Chi2Calculator();

    public:
      /*!
       *
       */
      void CalculatePredictions();

    private:
      /*!
       * True if the current covariance matrix was successfully inverted. Otherwise false.
       */
      bool                                      _inverted;
      /*!
       * The total chi2 neglecting correlations between the observables.
       */
      double _chi2;
      /*!
       * The total chi2 taking correlations into account.
       */
      double                                    _correlatedChi2;
      /*!
       * Set of names of added observables. Used to check uniqueness.
       */
      std::set<std::string>                     _observableNames;
      /*!
       * Set of IDs of added correlations. Each ID is a pair consisting of the name and the indices of the correlation. This set is used to check the uniqueness of the added correlations.
       */
      std::set<std::pair<std::string, std::pair<unsigned int, unsigned int>>> _correlationIDs;
      /*!
       * The initial total uncertainties of the observables. Used to smear the measured values in toy experiments.
       */
      std::vector<double>                       _initialUncertainties;
      /*!
       * The non-trivial correlations between the observables.
       */
      std::vector<Correlation*>                 _correlations;
      /*!
       * While the chi2 calculator is allowed to modify the observables by smearing its measurements,
      * the correlations only have read access to the measurements.
      * Hence this container of const pointers is used for the construction of the correlations.
      */
      std::vector<const Measurement*>           _constObservables;
      /*!
       * The observables.
       */
      std::vector<Measurement*>                 _observables;
      /*!
       * The covariance matrix, build from the uncertainties of the observables and the correlations.
       */
      TMatrixDSym                               _cov;
      /*!
       * The inverted covariance matrix.
       */
      TMatrixDSym                               _invCov;
      /*!
       * The last covariance matrix. Stored to determine whether the covariance matrix has changed in order to avoid unessesary invertions.
       */
      TMatrixDSym                               _lastCov;
      /*!
       * The initial predicted values of the observables. Used to smear the measured values in toy experiments.
       */
      TVectorD                                  _initialPredictions;
      /*!
       * The deviations of the predictions from the measurements.
       */
      TVectorD                                  _deviations;
      /*!
       * A copy of the vector of deviations playing the role of the transposed vector in the calculation of _correlatedChi2.
      */
      TVectorD                                  _deviationsTransposed;

    private:
      /*!
       * \return True if all measurements are within their bounds, otherwise false.
       */
      bool MeasurementsAreWithinBounds();
      /*!
       * Sets the measurements to their initial predicted values and smears them according to the initial covariance matrix.
       */
      void SmearMeasurements();
      /*!
       * Adds an observable.
       * \param[in] ptree Configuration of the observable. Please see Measurement::Measurement().
       */
      void AddObservable( boost::property_tree::ptree ptree );
      /*!
       * Adds a correlation.
       * \param[in] ptree Configuration of the correlation. Please see Correlation::Correlation().
       */
      void AddCorrelation( boost::property_tree::ptree ptree );
      /*!
       * Inverts the covariance matrix using a Cholesky decomposition.
       */
      void InvertCovarianceMatrix();

  };

}

#endif
