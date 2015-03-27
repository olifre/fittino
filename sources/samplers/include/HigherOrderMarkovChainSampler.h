/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HigherOrderMarkovChainSampler.h                                  *
*                                                                              *
* Description Extends plain Markov Chain sampling by additionally exploiting   *
*             parameter correlations                                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGHERORDERMARKOVCHAINSAMPLER_H
#define FITTINO_HIGHERORDERMARKOVCHAINSAMPLER_H

#include <queue>

#include "TMatrixDSym.h"

#include "MarkovChainSampler.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup samplers
   */
  /*!
   *  \ingroup samplers
   *  \brief Extends plain Markov Chain sampling by additionally exploiting parameter correlations.
   */
  class HigherOrderMarkovChainSampler : public MarkovChainSampler {

    public:
      HigherOrderMarkovChainSampler( ModelBase* model, const boost::property_tree::ptree& ptree );
      ~HigherOrderMarkovChainSampler();

      /*! \cond UML */
    private:
      double                            _memorySize;
      double                            _scalingFactor;
      int                               _maximalMemorySize;
      int                               _minimalMemorySize;
      std::queue< std::vector<double> > _memory;
      std::vector<double>               _expectationValues;
      TMatrixDSym                       _covarianceMatrix;
      TMatrixDSym                       _expectationMatrix;

    private:
      void                              DepopulateQueue();
      void                              FinalizeStatus();
      void                              InitializeMemory();
      void                              PopOldestPoint();
      void                              PopulateQueue();
      void                              PrintSteeringParameters() const;
      void                              PushNewPoint( std::vector<double> point );
      void                              UpdateCovarianceMatrix();
      void                              UpdateMemory();
      void                              UpdateParameterValues( double scalefactor );
      void                              UpdateParameterValuesUsingCovariance( double scalefactor );
      void                              UpdateQueue( std::vector<double> point );
      void                              UpdateQueue( const boost::property_tree::ptree& entry );

      /*! \endcond UML */

  };

}

#endif // FITTINO_HIGHERORDERMARKOVCHAINSAMPLER_H
