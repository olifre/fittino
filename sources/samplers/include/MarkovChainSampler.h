/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MarkovChainSampler.h                                             *
*                                                                              *
* Description Class for Markov chain parameter sampler                         *
*                                                                              *
* Authors     Matthias  Hamer     <mhamer@gwdg.de>                             *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
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
      bool                   _pointAccepted;
      bool                   _strictBounds;
      double                 _previousChi2;
      double                 _firstPointScalefactor;
      /*!
       *  Stores the configured maximal number of iteration steps.
       */
      unsigned int           _numberOfIterations;
      unsigned int           _numberOfFirstIteration;
      std::vector<double>    _previousParameterValues;
      unsigned int           _weight;
      unsigned int           _numberOfRejectedPoints;

      /*!
       *  Used to count how often a point is accepted.
       */
      TBranch*               _branchPointAccepted;

    private:
      void                   Execute();
      void                   PrintSteeringParameters() const;
      void                   UpdateModel();
      virtual void           UpdateParameterPoint( double scalefactor );
      void                   FillBranchPointAccepted();
      bool                   IsAccepted();
      virtual void           UpdateMemory();
      void                   ResetParameters();
      void                   CompareChi2();
      virtual void           UpdatePropertyTree();

      /*! \endcond UML */

  };

}

#endif // FITTINO_MARKOVCHAINSAMPLER_H
