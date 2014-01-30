/* $Id$ */

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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_INDIVIDUAL_H
#define FITTINO_INDIVIDUAL_H

#include <vector>

class TRandom3;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \ingroup optimizers
   *  \brief Class for individual (needed by genetic algorithm optimizer).
   */
  class Individual {

    public:
      Individual( ModelBase* model, double mutationRate, int seed );
      ~Individual();
      bool                UpdatedChi2();
      double              GetGene( int index );
      void                Mutation();
      /*!
       *  Calls UpdateModel() and than sets the chi2 according to that model.
       */
      void                UpdateChi2();
      void                SetGene( int index, double newValue );
      /*!
       *  Sets the pointed model according to the genes.
       */
      void                UpdateModel();

    public:
      bool operator       <( const Individual& individual ) const;

    private:
      bool                _updatedChi2;
      double              _chi2;
      double              _mutationRate;
      std::vector<double> _genes;
      TRandom3*            _randomGenerator;
      ModelBase*          _model;

  };

}

#endif // FITTINO_INDIVIDUAL_H
