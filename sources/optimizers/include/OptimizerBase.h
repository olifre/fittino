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

#include <map>
#include <string>

#include "ModelBase.h"
#include "SteeringParameterBase.h"
#include "SteeringParameterTemplate.h"

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  //typedef std::map<std::string, SteeringParameterBase*> SteeringParameterMap;

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
      enum OptimizerType { PARTICLESWARMOPTIMIZER };

    public:
                                             OptimizerBase();
      virtual                                ~OptimizerBase();
      /*!
       *  The Execute() method. It checks the value of a generic abort
       *  criterium. In the case it is not met the model is updated and
       *  evaluated.  
       */
      virtual void                           Execute() = 0;

    protected:
      template<class SteeringParameterType>
      void                                   DeclareSteeringParameter( std::string name, SteeringParameterType value ); 

    private:
      double                                 _abortCriterium;
      ModelBase*                             _model;
      //SteeringParameterMap                   _steeringParameterMap;

    private:
      //void                                   PrintConfiguration();
      //void                                   PrintResult();
      //void                                   PrintStatus();
      //virtual ModelBase*                     UpdateModel() = 0;
      //virtual double                         EvaluateModel( ModelBase& model );

  };

  //template<class SteeringParameterType>
  //void OptimizerBase::DeclareSteeringParameter( std::string name, SteeringParameterType value ) {

  //  std::string key = name;
  //  _steeringParameterMap[ key ] = new SteeringParameterTemplate<SteeringParameterType>( name, value );

  //}

}

#endif // FITTINO_OPTIMIZERBASE_H
