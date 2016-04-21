/* $Id: GCECalculator.h 2462 2015-02-06 11:59:42Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GCECalculator.h                                         *
*                                                                              *
* Description Calculator for Galactic Center Excess
*                                                                              *
* Authors     Matthias Hamer <matthias.hamer@cern.ch>                          *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_GCETCALCULATOR_H
#define FITTINO_GCETCALCULATOR_H

#include "CalculatorBase.h"
#include "Executor.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Calculator for Galactic Center Excess
   */
  class GCECalculator : public CalculatorBase {

    public:
      GCECalculator( const ModelBase* model, const boost::property_tree::ptree& ptree  );
      ~GCECalculator();

    private:
      Executor _executor;

    private:
      void     CalculatePredictions();
    
    private:
      double _ll_gce;
      double _chi2_gce;
      double _ll_R3;
      double _chi2_R3;
      double _ll_R16;
      double _chi2_R16;
      double _ll_j;
      double _chi2_j;
      double _ll_dSph;
      double _chi2_dSph;
      double _jfactor;
      double _jres;
      double _GCEERROR;

  };

}

#endif // FITTINO_GCETCALCULATOR_H
