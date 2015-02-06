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

#include <vector>

#include "TVectorT.h"

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class Measurement;

    /*!
   *  \ingroup calculators
   *  \brief .
   */
  class Chi2Calculator : public CalculatorBase {

    public:

                           Chi2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
                           ~Chi2Calculator();
    
    public:
      virtual void        CalculatePredictions();

  private:
      Quantity*                   _chi2;
      std::vector<Measurement*>  _measurements;
      std::vector<double>         _initialUncertainties;
      TVectorD                    _initialPredictions;

  private:
      void SmearMeasurements();
      bool MeasurementsAreWithinBounds();

  };

}

#endif
