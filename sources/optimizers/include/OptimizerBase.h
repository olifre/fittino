/* $Id: OptimizerBase.h,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

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
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wiene@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_OPTIMIZERBASE_H
#define FITTINO_OPTIMIZERBASE_H

#include <string>

#include "TRandom.h"

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \brief Base class for Fittino parameter optimizers
   *
   *  The purpose of this class is to provide the template method
   *  OptimizerBase::Execute().
   *  <br>
   *  Supported parameter optimizers are
   *  <ul>
   *    <li> genetic algorithm optimizer 
   *    <li> Minuit optimizer
   *    <li> particle swarm optimizer
   *    <li> simulated annealing optimizer
   *  </ul>
   */
  class OptimizerBase {

    public:
      enum         OptimizerType { MINUIT, PARTICLESWARM, SIMULATEDANNEALING };

    public:
                   OptimizerBase( ModelBase* model );
      virtual      ~OptimizerBase();
      /*!
       *  The Execute() method. It checks the value of a generic abort
       *  criterium. In the case it is not met the model is updated and
       *  evaluated.
       */
      void         PerformOptimization();

    protected:
      std::string  _name;
      TRandom      _randomGenerator;
      ModelBase*   _model;

    protected:
      virtual void PrintSteeringParameters() const = 0;
      virtual void UpdateModel() = 0;

      /*! \cond UML */
    private:
      double       _abortCriterium;
      double       _chi2;
      unsigned int _iterationCounter;
      unsigned int _numberOfIterations;

    private:
      void         ExecuteOptimizer();
      void         InitializeOptimizer();
      void         PrintConfiguration() const;
      void         PrintResult() const;
      void         PrintStatus() const;
      void         TerminateOptimizer() const;
      /*! \endcond UML */

  };

}

#endif // FITTINO_OPTIMIZERBASE_H
