/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HigherOrderMarkovChainSampler.h                                  *
*                                                                              *
* Description Class for correlated covariant parameter sampler                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGHERORDERMARKOVCHAINSAMPLER_H
#define FITTINO_HIGHERORDERMARKOVCHAINSAMPLER_H

#include <queue>
#include <vector>

#include "TMatrixDSym.h"

#include "MarkovChainSampler.h"

namespace Fittino {

  /*!
   *  \ingroup samplers
   */
  class HigherOrderMarkovChainSampler : public MarkovChainSampler {

    public:

                             HigherOrderMarkovChainSampler( ModelBase* model, const boost::property_tree::ptree& ptree );
                             ~HigherOrderMarkovChainSampler();

    private:
      double              _scalingFactor;
      int                 _minimalMemorySize;
      int                 _maximalMemorySize;
      std::queue< std::vector<double> >   _memory;
      std::vector<double> _expectationValues;
      TMatrixDSym         _covarianceMatrix;
      TMatrixDSym         _expectationMatrix;

    private:
      void           PrintSteeringParameters() const;
      void           UpdateMemory();
      void           UpdateParameterValuesUsingCovariance( double scalefactor );
      void           UpdateQueue( std::vector<double> point );
      void           PushNewPoint( std::vector<double> point);
      void           PopOldestPoint();
      void           UpdateCovarianceMatrix();
      void           UpdateParameterValues( double scalefactor );
      void           FinalizeStatus();
      void           InitializeMemory();
      void           FillQueue();
      void           EmptyQueue();
      void           UpdateQueue( const boost::property_tree::ptree& entry );

  };

}


#endif 
