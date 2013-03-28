/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MinuitOptimizer.h                                                *
*                                                                              *
* Description Class for Minuit parameter optimizer                             *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MINUITOPTIMIZER_H
#define FITTINO_MINUITOPTIMIZER_H

#include "Minuit2/MnUserParameterState.h"

#include "OptimizerBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup optimizers
   *  \brief Class for Minuit parameter optimizer.
   */
  class MinuitOptimizer : public OptimizerBase {

    public:
      /*!
       *  Standard constructor.
       */
                                      MinuitOptimizer( ModelBase* model );
      /*!
       *  Standard destructor.
       */
                                      ~MinuitOptimizer();

      /*! \cond UML */
    private:
      ROOT::Minuit2::MnUserParameters _minuitUserParameters;

    private:
      virtual void                    PrintSteeringParameters() const;
      virtual void                    UpdateModel();

      /*! \endcond UML */

  };

}

#endif // FITTINO_MINUITOPTIMIZER_H
