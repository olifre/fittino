/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MarkovChainSampler.h                                             *
*                                                                              *
* Description Class for Markov chain parameter sampler                         *
*                                                                              *
* Authors     Matthias Hamer       <mhamer@gwdg.de>                            *
*             Mathias  Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>             *
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

    protected:
      const std::vector<double>& GetParameterValuesOfLastAcceptedPoint() const;

    protected:
      virtual void               FinalizeStatus();
      virtual void               InitializeMemory();
      virtual void               PrintSteeringParameters() const;
      virtual void               UpdateMemory();
      virtual void               UpdateParameterValues( double scalefactor );

    protected:
      bool                       IsInBounds();
      bool                       _strictBounds;

      /*! \cond UML */
    private:
      bool                       _pointAccepted;
      double                     _chi2OfLastAcceptedPoint;
      double                     _firstPointScalefactor;
      /*!
       *  Stores the configured maximal number of iteration steps.
       */
      unsigned int               _numberOfIterations;
      unsigned int               _numberOfRejectedPoints;
      unsigned int               _weight;
      std::vector<double>        _parameterValuesOfLastAcceptedPoint;
      /*!
       *  Used to count how often a point is accepted.
       */
      TBranch*                   _branchPointAccepted;

    private:
      bool                       IsAccepted();
      void                       CompareChi2();
      void                       Execute();
      void                       FillBranchPointAccepted();
      void                       ResetParameters();
      void                       UpdateModel();
      void                       UpdateParameterValuesConsideringBounds( double scalefactor );

      /*! \endcond UML */

  };

}

#endif // FITTINO_MARKOVCHAINSAMPLER_H
