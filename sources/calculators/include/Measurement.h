/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Measurement.h                                                    *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MEASUREMENT_H
#define FITTINO_MEASUREMENT_H

#include <map>
#include <string>
#include <vector>

#include <boost/property_tree/ptree_fwd.hpp>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class FormulaQuantity;
    class ModelBase;
    class Quantity;
    class UncertaintyBase;

/*!
 *  \ingroup calculators
 *  \brief A helper class of Chi2Calculator.
 *
 *  Its main components are a measurement, a corresponding prediction and uncertainties.
 *  Uncertainties may be uncertainties on the measurement or on the prediction - both are treated on an equal footing.
 *  The class also stores the bounds of the measurement in order to avoid unphysical values when smearing the measurement in toy experiments.
 *  The class provides the total uncertainty, deviation, pull and chi2 of the represented observable.
 *  The value of the latter three depends on whether the observable is configured as an lower/upper limit.
 *  \todo Rename to Observable.
 */
    class Measurement {

    public:
        /*!
         * \param[in] model The model whose quantities are used by the prediction and the uncertainties to calculate their own values.
         * \param[in] ptree Configuration of the observable consisting of the following nodes:
         * - _string_ __Name__ Used to identify the observable. Restricted to non-empty values.
         * - _double_ <b>%Measurement</b> The measured value of the observable.
         * - _formula_ __Prediction__ The predicted value of the observable.
         * - _tree_ __Uncertainty__ [0..] The configuration of an uncertainty as described in AddUncertainty().
         * - _boolean_ __IsLowerLimit__ (false) Whether the measurement is a lower limit.
         * - _boolean_ __IsUpperLimit__ (false) Whether the measurement is an upper limit.
         *
         * - _double_ __LowerBound__ (-inf)
         * \copydoc _lowerBound
         *
         * - _double_ __UpperBound__ (+inf) \copydoc _upperBound
         */
        Measurement( const ModelBase *model, const boost::property_tree::ptree &ptree );
        /*!
         */
        ~Measurement();

    public:
        /*!
         * \return
         * True if the measurement is within the closed interval [lower limit, upper limit].
         * Otherwise false.
         */
        bool IsWithinBounds() const;
        /*!
         * \return
         * \copydoc _deviation
         */
        const double& GetDeviation() const;
        /*!
         * \return
         * \copydoc _totalUncertainty
         */
        const double& GetTotalUncertainty() const;
        /*!
         * \return
         * \copydoc _prediction
         */
        const double& GetPrediction() const;
        /*!
         * \return
         * \copydoc _measurement
         */
        const double& GetMeasurement() const;
        /*!
         * \return
         * \copydoc _chi2
         */
        const double& GetChi2() const;
        /*!
         * \return
         * \copydoc _pull
         */
        const double& GetPull() const;
        /*!
         * \param[in] name The name of the uncertainty.
         * \return
         * The value of the uncertainty.
         */
        const double& GetUncertainty( std::string name ) const;
        /*!
         * \return
         * \copydoc _name
         */
        const std::string& GetName() const;
        /*!
         *  Updates the total uncertainty, deviation, pull and chi2 according to the current values of the prediction, the measurement and the individual uncertainties.
         */
        void Update();
        /*!
         * Sets the measurement to the given value.
         * \param[in] value The value to which the measurement is set.
         */
        void SetMeasurement( double value );

    private:
        /*!
         * Whether the measurement is a lower limit.
         */
        bool                                   _isLowerLimit;
        /*!
         * Whether the measurement is an upper limit.
         */
        bool                                   _isUpperLimit;
        /*!
         * The lower bound below which the measurement should not be set in toy experiments.
         */
        double                                 _lowerBound;
        /*!
         * The upper bound above which the measurement should not be set in toy experiments.
         */
        double                                 _upperBound;
        /*! The deviation of the prediction from the measurement.
         * If the observable is a lower (upper) limit and the prediction is larger (smaller) than the measurement the deviation is equal to 0.
         * Otherwise it is the difference ( prediction - measurement ).
         */
        double                                 _deviation;
        /*!
         * The total uncertainty, i.e. the square root of the sum of the squares of the individual uncertainties.
         */
        double                                 _totalUncertainty;
        /*!
         * The pull, i.e the deviation divided by the total uncertainty.
         */
        double                                 _pull;
        /*!
         * The chi2, i.e. the square of the pull.
         */
        double                                 _chi2;
        /*!
         * The name of the observable.
         */
        std::string                            _name;
        /*!
         * Container of uncertainties with names.
         */
        std::map<std::string, const Quantity*> _namedUncertainties;
        /*!
         * Container of all uncertainties.
         */
        std::vector<Quantity*>                 _uncertainties;
        /*!
         * The predicted value.
         */
        FormulaQuantity*                       _prediction;
        /*!
         * The measured value.
         */
        Quantity*                              _measurement;

    private:
        /*!
         * Adds a new uncertainty to the observable.
         * \param[in] model The model which quantities can be used to calculate the value of the uncertainty.
         * \param[in] ptree The configuration of the uncertainty, consisting of the following nodes:
         * - _string_ __Name__ [0..1] Used to identify the uncertainty. Restricted to non-empty values.
         * - _formula_ __Value__ A formula returning the value of the uncertainty. The formula might contain the special words "Measurement" and "Prediction" which are interpreted as the measured and predicted values of the observable.
         */
        void AddUncertainty( const ModelBase* model, const boost::property_tree::ptree &ptree );

    };

}
#endif
