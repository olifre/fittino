/* $Id$ */

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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MARKOVCHAINSAMPLER_H
#define FITTINO_MARKOVCHAINSAMPLER_H

#include "SamplerBase.h"

class TBranch;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup samplers
   *  \brief Class for Markov chain parameter sampler.
   */
  class MarkovChainSampler : public SamplerBase {

    public:
      /*!
       *  Standard constructor.
       */
      MarkovChainSampler( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~MarkovChainSampler();

      /*! \cond UML */
    private:
      double                 _previousChi2;
      double                 _previousRho;
      /*!
       *  Stores the configured maximal number of iteration steps.
       */
      unsigned int           _numberOfIterations;
      unsigned int           _numberOfFirstIteration;
      std::vector<double>    _previousParameterValues;
      unsigned int           _acceptCounter;

      /*!
       *  Used to count how often a point is accepted.
       */
      TBranch*               _branchPointAccepted;

    private:
      virtual void           Execute();
      virtual void           PrintSteeringParameters() const;
      virtual void           UpdateModel();

      /*! \endcond UML */

  };

}

#endif // FITTINO_MARKOVCHAINSAMPLER_H
