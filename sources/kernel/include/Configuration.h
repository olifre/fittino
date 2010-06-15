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
#include <sstream>
#include <string>

#include "ExecutionMode.h"
#include "ModelBase.h"
#include "OptimizerBase.h"

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  typedef std::map<std::string, std::string> SteeringParameterMap;

  /*!
   *  \brief Singleton class for storing and providing access to user-defined
   *  configuration settings 
   */
  class Configuration {
  
    public:
      static Configuration*                 GetInstance();
  
    public:
      void                                  AddSteeringParameter( std::string key, std::string value );
      ExecutionMode::Mode                   GetExecutionMode() const;
      ModelBase::ModelType                  GetModelType() const;
      OptimizerBase::OptimizerType          GetOptimizerType() const;

    public:
      template<class SteeringParameterType>
      SteeringParameterType                 GetSteeringParameter( const std::string& name, const SteeringParameterType& value ) const;
  
    private:
      static Configuration*                 _instance;
  
    private:
      ExecutionMode::Mode                   _executionMode;
      ModelBase::ModelType                  _modelType;
      OptimizerBase::OptimizerType          _optimizerType;
      SteeringParameterMap*                 _steeringParameterMap;

    private:
                                            Configuration();
                                            ~Configuration();
  
  };

  template<class SteeringParameterType>
  SteeringParameterType Configuration::GetSteeringParameter( const std::string& name, const SteeringParameterType& defaultValue ) const {

    /*!
     *  \todo Short-term: Think about a more sophisticated implementation of this function. 
     */
    if ( !_steeringParameterMap->empty() ) {

      for ( SteeringParameterMap::iterator iter = _steeringParameterMap->begin(); iter != _steeringParameterMap->end(); iter++ ) {

        if ( _steeringParameterMap->find( name )->first == name ) {

          std::stringstream stringstream;
          SteeringParameterType value;

          stringstream << (*_steeringParameterMap)[name];
          stringstream >> value;

          return value;

        }
        else {

          return defaultValue;

        }

      }

    }
    else {

      return defaultValue;

    }

  }

}

#endif // FITTINO_CONFIGURATION_H
