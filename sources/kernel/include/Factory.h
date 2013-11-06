/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Factory.h                                                        *
*                                                                              *
* Description Factory class for creating file handlers, models, optimizers     *
*             and samplers                                                     *
*                                                                              *
* Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FACTORY_H
#define FITTINO_FACTORY_H

#include "Configuration.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class AnalysisTool;
  class Configuration;
  class DataStorageBase;
  class ModelBase;
  class ModelCalculatorBase;
  class OptimizerBase;
  class PhysicsModelBase;
  class PlotterBase;
  class SamplerBase;

  /*!
   *  \ingroup kernel
   *  \brief Factory class for creating file handlers, models, optimizers and samplers.
   */
  class Factory {

    public:
      /*!
       *  Standard constructor.
       */
                                 Factory();
      /*!
       *  Standard destructor.
       */
                                 ~Factory();

    public:

      ModelCalculatorBase*  CreateCalculator( const std::string& type, const PhysicsModelBase* model, const boost::property_tree::ptree& ptree ) const; 
      /*!
       *  Returns a concrete analysis tool.
       */
      AnalysisTool* const        CreateAnalysisTool( const std::string& type, ModelBase* model, const boost::property_tree::ptree& ptree ) const;
      /*!
       *  Returns a concrete data storage according to the file format passed as an argument.\n
       *  Supported file formats are
       *  <ul>
       *    <li> SLHA\n
       *    <li> XML\n
       *  </ul>
       */
      DataStorageBase* const     CreateDataStorage( const Configuration::FileFormat& fileFormat ) const;
      /*!
       *  Returns a concrete model according to the model type passed as an argument. Supported\n
       *  model types are
       *  <ul>
       *    <li> CMSSM\n
       *    <li> HEC\n
       *    <li> ROSENBROCK\n
       *  </ul>
       */
      ModelBase* const           CreateModel( const Configuration::ModelType& modelType ) const;
      /*!
       *  Returns a concrete model.
       */
      ModelBase* const           CreateModel( const std::string& type, const boost::property_tree::ptree& ptree ) const;
      /*!
       *  Returns a concrete calculator according to the calculator type passed as an argument. Supported\n
       *  calculator types are
       *  <ul>
       *    <li> HDIM6\n
       *  </ul>
       */
      ModelCalculatorBase* const CreateCalculator( const Configuration::CalculatorType& calculatorType, const PhysicsModelBase* model ) const;
      /*!
       *  Returns a concrete parameter optimizer according to the optimizer type passed as an\n
       *  argument. Supported optimizer types are
       *  <ul>
       *    <li> GENETICALGORITHM\n
       *    <li> MINUIT\n
       *    <li> PARTICLESWARM\n
       *    <li> SIMULATEDANNEALING\n
       *  </ul>
       */
      OptimizerBase* const       CreateOptimizer( const Configuration::OptimizerType& optimizerType, ModelBase* model, int randomSeed ) const;
      /*!
       *  Returns a concrete plotter according to the plotter type passed as an argument. Supported\n
       *  plotter types are
       *  <ul>
       *    <li> CONTOUR\n
       *    <li> SCATTER\n
       *    <li> SUMMARY\n
       *  </ul>
       */
      PlotterBase* const         CreatePlotter( const Configuration::PlotterType& plotterType, ModelBase* model, std::string dataFileName, int randomSeed ) const;
      /*!
       *  Returns a concrete parameter sampler according to the sampler type passed as an\n
       *  argument.  Supported sampler types are
       *  <ul>
       *    <li> MARKOVCHAIN\n
       *    <li> SIMPLE\n
       *  </ul>
       */
      SamplerBase* const         CreateSampler( const Configuration::SamplerType& samplerType, ModelBase* model, int randomSeed ) const;

  };

}

#endif // FITTINO_FACTORY_H
