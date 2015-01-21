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
#include "PtreeForwardDeclaration.h"

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
        Measurement( std::string type, const ModelBase* model, const boost::property_tree::ptree& ptree );
        ~Measurement();

        void CalculatePredictions();
        const Quantity* GetPrediction() const;
        const ModelBase* GetModel() const;
        double GetTotalUncertainty() const;
        void SetMeasuredValue(double value);
        bool IsWithinBounds();

    private:

        bool _lowerLimit;
        bool _upperLimit;

        const  Quantity* _prediction;

        double _measuredValue;
        double _lowerBound;
        double _upperBound;

        double  _deviation;
        double  _chi2;
        double  _pull;
        double _totalUncertainty;

        std::map<std::string, UncertaintyBase*> _uncertainties;

        const ModelBase* _model;


    private:
        void AddUncertainty( double& variable,  double uncertainty  );

    };

}
#endif