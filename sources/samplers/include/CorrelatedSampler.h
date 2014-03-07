
/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CorrelatedSampler.h                                             *
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

#ifndef FITTINO_CorrelatedSampler_H
#define FITTINO_CorrelatedSampler_H

#include "SamplerBase.h"
#include <vector>
#include "TMatrixD.h"
#include "TMatrixDSym.h"
#include "TMatrixDSymEigen.h"

#include <fstream>


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup samplers
   */
  /*!
   *  \ingroup samplers
   *  \brief Class for covariant parameter sampler.
   */
  class CorrelatedSampler : public SamplerBase {

    public:
      /*!
       *  Standard constructor.
       */
      CorrelatedSampler( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                             ~CorrelatedSampler();

      /*! \cond UML */
    private:
      double                 _previousChi2;
      double                 _previousLikelihood;
      double                 _previousRho;
      int                    _iterationCounter;
      int                    _numberOfAcceptedPoints;
      int                    _updateAfter;

      /*!
       *  Stores the configured maximal number of iteration steps.
       */
      unsigned int           _numberOfIterations;
      std::vector<double>    _previousParameterValues;
      std::vector<double>    _currentExpectationValues;
      std::vector<double>    _standardDeviations;
      TVectorD   _eigenValues;
      TMatrixDSym   _covarianceMatrix;
      TMatrixDSym   _expectationMatrix;
      TMatrixD   _acceptedPoints;
      TMatrixD   _eigenVectors;


    private:
      virtual void           Execute();
      virtual void           PrintSteeringParameters() const;
      virtual void           PrintMatrices();
      virtual void           UpdateModel();
      virtual void           UpdateExpectations();
      virtual void           UpdateCovarianceMatrix();
      virtual void           DoSampling();
      virtual void           CalculateStandardDeviations();
      virtual void           CalculateStepWidth();



      /*! \endcond UML */

  };

}

#endif // FITTINO_CorrelatedSampler_H
