/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RosenbrockCalculator.h                                           *
*                                                                              *
* Description Calculates the Rosenbrock function                               *
*                                                                              *
* Authors     Pia     Kullik      <pkullik@uni-bonn.de>                        *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_ROSENBROCKCALCULATOR_H
#define FITTINO_ROSENBROCKCALCULATOR_H

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Calculates the Rosenbrock function.
   */
  class RosenbrockCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      RosenbrockCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~RosenbrockCalculator();

    public:
      virtual void CalculatePredictions();

    private:
      Quantity*    _returnValue;

  };

}

#endif // FITTINO_ROSENBROCKCALCULATOR_H
