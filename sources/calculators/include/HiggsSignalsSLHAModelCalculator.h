/* $Id: HiggsSignalsSLHAModelCalculator.h 851 2011-01-10 18:01:22Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSLHAModelCalculator.h                                *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSSIGNALSMODELCALCULATOR_H
#define FITTINO_HIGGSSIGNALSMODELCALCULATOR_H

#include "SLHAModelCalculatorBase.h"

extern "C" { void initialize_higgssignals_latestresults_( int* nHzero, int* nHplus ); }

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsSignals.
   */
  class HiggsSignalsSLHAModelCalculator : public SLHAModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
           HiggsSignalsSLHAModelCalculator();
      /*!
       *  Standard destructor.
       */
           ~HiggsSignalsSLHAModelCalculator();

    protected:
      void ConfigureInput( PhysicsModelBase* model );

  };

}

#endif // FITTINO_HIGGSSIGNALSMODELCALCULATOR_H
