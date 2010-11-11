/* $Id: GeneticAlgorithmOptimizer.h,v 1.0  2010-11-3 22:00:00Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GeneticAlgorithmOptimizer.h                                      *
*                                                                              *
* Description Class for genetic algorithm optimizer                            *
*                                                                              *
* Authors     Bjoern Sarrazin <bjoern.sarrazin@desy.de>                        *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_GENETICALGORITHMOPTIMIZER_H
#define FITTINO_GENETICALGORITHMOPTIMIZER_H

#include "Individual.h"
#include "OptimizerBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Class for genetic algorithm parameter optimizer.
   */
  class GeneticAlgorithmOptimizer : public OptimizerBase {

    public:
      /*!
       *  Add a brief description of the constructor of this opitmizer here.
       */
                   GeneticAlgorithmOptimizer( ModelBase* model );
      /*!
       *  Add a brief description of the destructor of this opitmizer here.
       */
                   ~GeneticAlgorithmOptimizer();





  private:
		   double _mutationRate;
		   unsigned int _sizeOfPopulation;
		   unsigned int _numberOfGenes;
		   unsigned int _numberOfFamilies;
		   unsigned int _numberOfSurvivors;
		   std::vector<double> MaitingProbabilities;
		   std::vector<double> CumMaitingProbabilities;
		   std::vector<Individual*> _population;
		   std::vector<Individual*> _fathers;
		   std::vector<Individual*> _mothers;
		   std::vector<Individual*> _firstChilds;
		   std::vector<Individual*> _secondChilds;
		   
		   

  private:
		   void Pairing();
		   void Mutation();
		   void Crossover();
		   void Replacement();
		   void SortPopulation();
		   void CalculateMaitingProbabilities();
		   virtual void PrintSteeringParameters() const;

      /*!
       *  Add a brief description on how this function is implemented in this optimizer here.
       */
		   virtual void UpdateModel();

  };

}

#endif // FITTINO_GENETICALGORITHMOPTIMIZER_H
