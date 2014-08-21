
// NEW VERSION:


/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        NewCorrelatedSampler.h                                             *
*                                                                              *
* Description Class for correlated covariant parameter sampler                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>
              Pia Kullik          <kullik@informatik.uni-bonn.de>             *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/


#ifndef FITTINO_NewCorrelatedSampler_H
#define FITTINO_NewCorrelatedSampler_H

#include "SamplerBase.h"
#include <vector>
#include <queue>
#include "TMatrixD.h"
#include "TMatrixDSym.h"
#include "TMatrixDSymEigen.h"

#include <fstream>



namespace Fittino {

  /*!
   *  \ingroup samplers
   */
  class NewCorrelatedSampler : public SamplerBase {

    public:

                             NewCorrelatedSampler( ModelBase* model, const boost::property_tree::ptree& ptree );
                             ~NewCorrelatedSampler();

    private:
      double                 _previousChi2;
      double                 _previousLikelihood;
      double                 _previousRho;
      double                 _maxEigenValue;
      double                 _avgEigenValue;
      double                 _minEigenValue;
      double                 _minX1;
      double                 _minX2;
      double                 _maxX2;
      double                 _maxX1;
      double                 _scalingFactor;

      int                    _iterationCounter;
      int                    _numberOfAcceptedPoints;
      int                    _updateAfter;
      int                    _memorySize;
      int                    _accPointslt1;
      int                    _accPointsge10;
      int                    _accPointsge6lt10;
      int                    _accPointsge1lt6;
      int                    _totalPointslt1;
      int                    _totalPointsge10;
      int                    _totalPointsge6lt10;
      int                    _totalPointsge1lt6;

      bool                   _poppedFirst;
      bool                   _useCovariance;

      std::queue< std::vector<double> >           _memory;

      unsigned int           _numberOfIterations;
      std::vector<double>    _previousParameterValues;
      std::vector<double>    _currentExpectationValues;
      std::vector<double>    _standardDeviations;
      TVectorD   _eigenValues;
      TMatrixDSym   _covarianceMatrix;
      TMatrixDSym   _expectationMatrix;
      TMatrixD   _acceptedPoints;
      TMatrixD   _eigenVectors;
      //TFile     _communicationsFile;


    private:
      virtual void           Execute();
      virtual void           PrintSteeringParameters() const;
      virtual void           PrintMatrices();
      virtual void           UpdateModel();
      virtual void           DoSampling();
      virtual void           CalculateStandardDeviations();
      virtual void           FillStatusParameterVector();
      virtual void           PushNewPoint();
      virtual void           PopOldestPoint();
      virtual void           PrintCommunicationsFile();
      virtual void           ReadCommunicationsFile();



  };

}


#endif // FITTINO_NewCorrelatedSampler_H




