/* $Id: MarkovChainSampler.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MarkovChainSampler.h                                             *
*                                                                              *
* Description Class for Markov chain parameter sampler                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MARKOVCHAINSAMPLER_H
#define FITTINO_MARKOVCHAINSAMPLER_H

#include "SamplerBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Class for Markov chain parameter sampler.
   */
  class MarkovChainSampler : public SamplerBase {

    public:
      /*!
       *  Standard constructor.
       */
      MarkovChainSampler( ModelBase* model);
      /*!
       *  Standard destructor.
       */
      ~MarkovChainSampler();

      /*! \cond UML */
    private:
      double                 _previousChi2;
      double                 _previousLikelihood;
      double                 _previousRho;

    private:
      virtual void           PrintSteeringParameters() const;
      virtual void           UpdateModel();

      /*! \endcond UML */

  };

}

#endif // FITTINO_MARKOVCHAINSAMPLER_H
