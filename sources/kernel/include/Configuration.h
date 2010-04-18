/* $Id: Configuration.h,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Configuration.h                                                  *
*                                                                              *
* Description Singleton class for storing and providing access to user-defined *
*             configuration settings                                           *
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

#ifndef FITTINO_CONFIGURATION_H
#define FITTINO_CONFIGURATION_H

#include <map>
#include <string>

#include "ExecutionMode.h"
#include "SteeringParameterBase.h"
//#include "OptimizerBase.h"

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  typedef std::map<std::string, SteeringParameterBase*> SteeringParameterMap;

  /*!
   *  \brief Singleton class for storing and providing access to user-defined
   *  configuration settings 
   */
  class Configuration {
  
    public:
      static Configuration* GetInstance();
  
    public:
      SteeringParameterMap* GetSteeringParameterMap() const;
      //OptimizerBase*        GetOptimizer() const;
  
    protected:
                            Configuration();
                            ~Configuration();
  
    private:
      static Configuration* _instance;
  
    private:
      SteeringParameterMap* _steeringParameterMap;
      //OptimizerBase*        _optimizer;
  
  };

}

#endif // FITTINO_CONFIGURATION_H
