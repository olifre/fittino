/* $Id: FeynHiggsSLHAModelCalculator.h 851 2011-01-10 18:01:22Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsSLHAModelCalculator.h                                   *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FEYNHIGGSMODELCALCULATOR_H
#define FITTINO_FEYNHIGGSMODELCALCULATOR_H

#include "SLHAModelCalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsSLHAModelCalculator : public SLHAModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
           FeynHiggsSLHAModelCalculator();
      /*!
       *  Standard destructor.
       */
           ~FeynHiggsSLHAModelCalculator();

    protected:
      void ConfigureInput( PhysicsModelBase* model );

  };

}

#endif // FITTINO_FEYNHIGGSMODELCALCULATOR_H
