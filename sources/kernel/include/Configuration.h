/* $Id$ */

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
*	      Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
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

#include "Messenger.h"
#include "ModelBase.h"
#include "OptimizerBase.h"
#include "SamplerBase.h"

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare >
      class basic_ptree;

    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  typedef std::map<std::string, std::string> SteeringParameterMap;

  /*!
   *  \ingroup kernel
   *  \brief Singleton class for storing and providing access to user-defined configuration
   *  settings.
   *
   *  The instance of this class is created when the input file interpreter (see also\n
   *  InputFileInterpreterBase) is parsing the input file. The steering parameters found by the\n
   *  interpreter are added to a list via AddSteeringParameter() and can be accessed again later\n
   *  via the various getter functions.
   */
  class Configuration {

    public:
      /*!
       *  Returns a static pointer to the unique instance of this class.
       */
      static Configuration*                 GetInstance();

    public:
      enum                                  CalculatorType { HDIM6CALCULATOR };
      enum                                  ExecutionMode { OPTIMIZATION, PLOTTING, SAMPLING };
      enum                                  FileFormat { SLHA, XML };
      enum                                  ModelType { CMSSM, HDIM6, HEC, ROSENBROCK };
      enum                                  OptimizerType { GENETICALGORITHM, MINUIT, PARTICLESWARM, SIMULATEDANNEALING };
      enum                                  PlotterType { CONTOUR, SCATTER, SUMMARY };
      enum                                  SamplerType { MARKOVCHAIN, SIMPLE, COVARIANT, CORRELATED };

    public:
      /*!
       *  Adds a new steering parameter specified by a key-value pair to the _steeringParameterMap\n
       *  where the parameter is stored. It can be retrieved again by calling the apropriate\n
       *  getter function.
       */
      void                                  AddSteeringParameter( const std::string& key, const std::string& value );
      /*!
       *  Reads an xml file in the property tree.
       */
      void                                  ReadFile( std::string fileName );
      /*!
       *  Returns the configured execution mode.
       */
      ExecutionMode                         GetExecutionMode() const;
      /*!
       *  Returns the configured model type.
       */
      ModelType                             GetModelType() const;
      /*!
       *  Returns the configured optimizer type.
       */
      OptimizerType                         GetOptimizerType() const;
      /*!
       *  Returns the configured plotter type.
       */
      PlotterType                           GetPlotterType() const;
      /*!
       *  Returns the configured sampler type.
       */
      SamplerType                           GetSamplerType() const;
      /*!
       *  Returns the configured verbosity level.
       */
      Messenger::VerbosityLevel             GetVerbosityLevel() const;

    public:  
      /*!
       *  Returns the property tree.
       */
      const boost::property_tree::ptree*    GetPropertyTree() const;

    public:
      template<class SteeringParameterType>
      /*!
       *  Retrieves the value of a key-specified steering parameter from _steeringParameterMap if\n
       *  it has been added before via AddSteeringParameter(). Otherwise it returns the specified\n
       *  default value.
       */
      SteeringParameterType                 GetSteeringParameter( const std::string& key, const SteeringParameterType& defaultValue ) const;

    private:
      /*!
       *  Pointer to the unique instance of this class.
       */
      static Configuration*                 _instance;

    private:
      /*!
       *  Stores the configured steering parameters in a tree.
       */
      boost::property_tree::ptree*          _propertyTree;
      /*!
       *  Stores the configured steering parameters in an easy accessible key-value pair.
       */
      SteeringParameterMap*                 _steeringParameterMap;

    private:
      /*!
       *  Standard constructor.
       */
                                            Configuration();
      /*!
       *  Standard destructor.
       */
                                            ~Configuration();

  };

  template<class SteeringParameterType>
  SteeringParameterType Configuration::GetSteeringParameter( const std::string& key, const SteeringParameterType& defaultValue ) const {

    /*!
     *  \todo Short-term: Think about a more sophisticated implementation of this function.
     */
    if ( !_steeringParameterMap->empty() ) {

      for ( SteeringParameterMap::iterator iter = _steeringParameterMap->begin(); iter != _steeringParameterMap->end(); iter++ ) {

        if ( _steeringParameterMap->find( key )->first == key ) {

          std::stringstream stringstream;
          SteeringParameterType value;

          stringstream << ( *_steeringParameterMap )[key];
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