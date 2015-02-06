/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AstroFitCalculator.h                                             *
*                                                                              *
* Description Wrapper class for AstroFit                                       *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_ASTROFITCALCULATOR_H
#define FITTINO_ASTROFITCALCULATOR_H

#include "CalculatorBase.h"
#include "Executor.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for AstroFit.
   */
  class AstroFitCalculator : public CalculatorBase {

    public:
      AstroFitCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree  );
      ~AstroFitCalculator();

    private:
      double   _chi2_direct;
      double   _chi2_photon;
      double   _chi2_relic;
      double   _chi2_svind;
      double   _direct;
      double   _photon;
      double   _relic;
      double   _svind;
      Executor _executor;

    private:
      void     CalculatePredictions();

  };

}

#endif // FITTINO_ASTROFITCALCULATOR_H
