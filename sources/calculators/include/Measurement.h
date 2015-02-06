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

        void CalculatePredictions();
        const Quantity* GetPrediction() const;
        double GetTotalUncertainty() const;
        void SetMeasuredValue(double value);
        bool IsWithinBounds();
        const std::map<std::string, const UncertaintyBase*>& GetNamedUncertainties() const;

    private:

        bool _lowerLimit;
        bool _upperLimit;

        unsigned int _index;

        const  Quantity* _prediction;

        double _measuredValue;
        double _lowerBound;
        double _upperBound;

        double  _deviation;
        double  _chi2;
        double  _pull;
        double _totalUncertainty;

        std::vector<UncertaintyBase*> _uncertainties;
        std::map<std::string, const UncertaintyBase*> _namedUncertainties;

    };

}
#endif
