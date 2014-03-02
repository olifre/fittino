/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GeneticAlgorithmOptimizer.h                                      *
*                                                                              *
* Description Class for genetic algorithm optimizer                            *
*                                                                              *
* Authors     Bjoern Sarrazin  <bjoern.sarrazin@desy.de>                       *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_GENETICALGORITHMOPTIMIZER_H
#define FITTINO_GENETICALGORITHMOPTIMIZER_H

#include "Individual.h"
#include "OptimizerBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup optimizers
   */
  /*!
   *  \ingroup optimizers
   *  \brief Class for genetic algorithm parameter optimizer.
   */
  class GeneticAlgorithmOptimizer : public OptimizerBase {

    public:
      /*!
       *  Creates a random a sorted random population
       */
      GeneticAlgorithmOptimizer( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor
       */
      ~GeneticAlgorithmOptimizer();

      /*! \cond UML */

    private:
      double                  _mutationRate;
      unsigned int            _numberOfFamilies;
      unsigned int            _numberOfGenes;
      unsigned int            _numberOfSurvivors;
      unsigned int            _sizeOfPopulation;
      std::vector<double>     _cumulativeMatingProbabilities;
      std::vector<double>     _matingProbabilities;
      std::vector<Individual> _fathers;
      std::vector<Individual> _firstChildren;
      std::vector<Individual> _mothers;
      std::vector<Individual> _population;
      std::vector<Individual> _secondChildren;

    private:
      void                    CalculateMatingProbabilities();
      void                    CrossOver();
      void                    MutatePopulation();
      void                    Pair();
      void                    Replace();
      void                    SortPopulation();

    private:
      virtual void            PrintSteeringParameters() const;
      /*!
       *  By simulating evolution the created population in changed. The fittest individual of the new population determines how the model is updated.
       */
      virtual void            UpdateModel();

      /*! \endcond UML */

  };

}

#endif // FITTINO_GENETICALGORITHMOPTIMIZER_H
