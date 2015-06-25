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

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class ModelBase;
    class Quantity;
    class UncertaintyBase;

/*!
 *  \ingroup calculators
 *  \brief .
 */

    class Measurement : public CalculatorBase {

    public:
        Measurement(std::string type, unsigned int index, const ModelBase *model, const boost::property_tree::ptree &ptree);
        ~Measurement();

        bool IsWithinBounds() const;
        void CalculatePredictions();
        void SetMeasuredValue( double value );

        const double& GetDeviation() const;
        const double& GetTotalUncertainty() const;
        const double& GetPredictedValue() const;
        const double& GetMeasuredValue() const;
        const double& GetChi2() const;
        const std::map<std::string, const Quantity*>& GetNamedUncertainties() const;

    private:

        unsigned int _index;

        double _measuredValue;
        double _lowerBound;
        double _upperBound;

        bool _isLowerLimit;
        bool _isUpperLimit;

        double _deviation;
        double _totalUncertainty;
        double _pull;
        double _chi2;

        std::vector<Quantity*> _uncertainties;
        std::map<std::string, const Quantity*> _namedUncertainties;

    };

}
#endif
