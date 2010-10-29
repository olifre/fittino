/* $Id: SimulatedAnnealingOptimizer.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimulatedAnnealingOptimizer.h                                    *
*                                                                              *
* Description Class for simulated annealing parameter optimizer                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMULATEDANNEALINGOPTIMIZER_H
#define FITTINO_SIMULATEDANNEALINGOPTIMIZER_H

#include "OptimizerBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Class for simulated annealing parameter optimizer.
   */
  class SimulatedAnnealingOptimizer : public OptimizerBase {

    public:
      /*!
       *  Standard constructor.
       */
                   SimulatedAnnealingOptimizer( ModelBase* model );
      /*!
       *  Standard destructor.
       */
                   ~SimulatedAnnealingOptimizer();

      /*! \cond UML */
    private:
      double       _initialTemperature;
      double       _temperatureReductionFactor;
      double       _temperature;

    private:
      virtual void PrintSteeringParameters() const;
      /*!
       *  This method updates the model according to the simulated annealing algorithm.
       */
      virtual void UpdateModel();
      /*! \endcond UML */

  };

}

#endif // FITTINO_SIMULATEDANNEALINGOPTIMIZER_H
