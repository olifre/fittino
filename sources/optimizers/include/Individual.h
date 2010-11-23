/* $Id: Individual.h,v 1.0 2010/11/03 22:00:00 sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Individual.h                                                     *
*                                                                              *
* Description Class for Individual (needed by genetic algorithm optimizer)     *
*                                                                              *
* Authors     Bjoern Sarrazin  <bjoern.sarrazin@desy.de>                       *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_INDIVIDUAL_H
#define FITTINO_INDIVIDUAL_H

#include <iostream>
#include <vector>

#include "TRandom.h"

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Class for individual (needed by genetic algorithm optimizer)
   */
  struct Individual {

    public:
                          Individual( ModelBase* model, double mutationRate, int seed );
                          ~Individual();
      void                Mutation();
      void                SetChi2();
      void                UpdateModel();


      //  private:
      std::vector<double> _genes;
      TRandom*            _randomGenerator;
      ModelBase*          _model;
      bool                _mutatedIndividual;
      double              _chi2;
      double              _mutationRate;
      bool operator<( const Individual& individual ) const;

  };

  /*!
   *  \brief Structure for comparison of individuals
     */
  struct CompareIndividuals {

    bool operator ()( Individual *lhs, Individual *rhs ) {

      return ( *lhs < *rhs );

    }

  };

}

#endif // FITTINO_INDIVIDUAL_H
