/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Factory.h                                                        *
*                                                                              *
* Description Factory class for creating calculators, models, optimizers,      *
*             plotters and samplers                                            *
*                                                                              *
* Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FACTORY_H
#define FITTINO_FACTORY_H

#include <boost/property_tree/ptree_fwd.hpp>

#include "Collection.h"

class TH1;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class CalculatorBase;
    class CutBase;
    class Measurement;
    class ModelBase;
    class Observable;
    class PhysicsModel;
    class PlotterBase;
    class PredictionBase;
    class SLHADataStorageBase;
    class Tool;
    class UncertaintyBase;
    class Quantity;

  /*!
   *  \ingroup kernel
   *  \brief Factory class for creating calculators, models, optimizers, plotters and samplers.
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
      /*!
       *  Returns a concrete calculator.\n
       *  Supported calculators are
       *  <ul>
       *    <li>AstroCalculator\n
       *    <li>AstroFitCalculator\n
       *    <li>CheckVacuumCalculator\n
       *    <li>FeynHiggsCalculator\n
       *    <li>FormulaCalculator\n
       *    <li>HDim6Calculator\n
       *    <li>HECCalculator\n
       *    <li>HiggsBoundsCalculator\n
       *    <li>HiggsSignalsSLHACalculator\n
       *    <li>LHCLimitCalculator\n
       *    <li>MicromegasCalculator\n
       *    <li>RegressionCalculator\n
       *    <li>SPhenoSLHACalculator\n
       *    <li>SuperIsoCalculator\n
       *    <li>TreeCalculator\n
       *  </ul>
       */
      CalculatorBase* const      CreateCalculator(const std::string &type, const ModelBase *model, boost::property_tree::ptree &ptree) const;
      /*!
       *  Returns a cut object. So far the only supported type is a SplineCut.
       */
      CutBase* const             CreateCut( const std::string& type, ModelBase* model, const boost::property_tree::ptree& ptree ) const;
      /*!
       *  Returns a concrete model.\n
       *  Supported models are
       *  <ul>
       *    <li> PhysicsModel\n
       *    <li> RosenbrockModel\n
       *  </ul>
       */
      ModelBase* const           CreateModel( const std::string& type, boost::property_tree::ptree& ptree ) const;
      /*!
       *  Returns an Observable with a prediction according to the type specified in the ptree.
       *  \todo Remove when no longer used by derived classes (Matthias).
       */
      Observable* const          CreateObservable( const boost::property_tree::ptree& ptree, const Fittino::Collection<Fittino::CalculatorBase*>& calculators ) const;
      /*!
       *  \todo Remove when no longer used by derived classes (Matthias).
       */
      Observable* const          CreateObservable( const boost::property_tree::ptree& ptree, const Fittino::Collection<Fittino::Quantity*>& predictions, const Fittino::Collection<Fittino::CalculatorBase*>& calculators ) const;
      /*!
       *  Returns a concrete plotter.\n
       *  Supported plotters are
       *  <ul>
       *    <li> ContourPlotter\n
       *    <li> ProfilePlotter\n
       *    <li> SimplePlotter\n
       *    <li> SummaryPlotter\n
       *  </ul>
       */
      PlotterBase* const         CreatePlotter( const std::string& type, std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree ) const;
      UncertaintyBase *CreateUncertainty(const std::string &type, const ModelBase *model, const Measurement *measurement, const boost::property_tree::ptree &ptree) const;
      SLHADataStorageBase* const CreateSLHAeaSLHADataStorage() const;
      /*!
       *  Returns a concrete tool.\n
       *  Supported tools are
       *  <ul>
       *    <li> GeneticAlgorithmOptimizer\n
       *    <li> MarkovChainSampler\n
       *    <li> MinuitOptimizer\n
       *    <li> ParticleSwarmOptimizer\n
       *    <li> SimpleOptimizer\n
       *    <li> SimpleSampler\n
       *    <li> SimulatedAnnealingOptimizer\n
       *    <li> TreeSampler
       *  </ul>
       */
      Tool* const                CreateTool( const std::string& type, ModelBase* model, const boost::property_tree::ptree& ptree ) const;

  };

}

#endif // FITTINO_FACTORY_H
