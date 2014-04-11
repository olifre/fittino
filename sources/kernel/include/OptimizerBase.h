/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        OptimizerBase.h                                                  *
*                                                                              *
* Description Base class for Fittino parameter optimizers                      *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*             Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_OPTIMIZERBASE_H
#define FITTINO_OPTIMIZERBASE_H

#include "AnalysisTool.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Base class for Fittino parameter optimizers.
   *
   *  Supported parameter optimizers are
   *  <ul>
   *    <li> genetic algorithm optimizer
   *    <li> Minuit optimizer
   *    <li> particle swarm optimizer
   *    <li> simple optimizer
   *    <li> simulated annealing optimizer
   *  </ul>
   */
  class OptimizerBase : public AnalysisTool {

    public:
      /*!
       *  Takes as input a pointer to the model to be analysed. Via this pointer an association\n
       *  between a model and the concrete optimizer is established.
       */
      OptimizerBase( ModelBase* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~OptimizerBase();

    protected:
      /*!
       *  Optimizer aborts if the measure of the goodness of fit (usually the chi2 of the model)\n
       *  is lower than this value. If the value is 0. the optimizer performs the maximal number\n
       *  of iterations.
       */
      double       _abortCriterion;
      /*!
       *  Stores the configured maximal number of iteration steps.
       */
      unsigned int _numberOfIterations;

    protected:
      /*!
       *  Prints the steering parameters common to all optimizers.
       */
      void         PrintSteeringParameters() const;

      /*! \cond UML */
    private:
      void         Execute();
      void         PrintResult() const;
      void         Terminate();

      /*! \endcond UML */

  };

}

#endif // FITTINO_OPTIMIZERBASE_H
