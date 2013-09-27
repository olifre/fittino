/* $Id: CovariantSampler.h 1280 2013-03-28 11:23:49Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CovariantSampler.h                                             *
*                                                                              *
* Description Class for covariant parameter sampler                         *
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

#ifndef FITTINO_CovariantSampler_H
#define FITTINO_CovariantSampler_H

#include "SamplerBase.h"
#include <vector>
#include "TMatrixD.h"
#include "TMatrixD.h"

#include <fstream>


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup samplers
   *  \brief Class for covariant parameter sampler.
   */
  class CovariantSampler : public SamplerBase {

    public:
      /*!
       *  Standard constructor.
       */
      CovariantSampler( ModelBase* model, int randomSeed );
      /*!
       *  Standard destructor.
       */
                             ~CovariantSampler();

      /*! \cond UML */
    private:
      double                 _previousChi2;
      double                 _previousLikelihood;
      double                 _previousRho;
      int                    _numberOfAcceptedPoints;
      int                    _updateAfter;

      /*!
       *  Stores the configured maximal number of iteration steps.
       */
      unsigned int           _numberOfIterations;
      std::vector<double>    _previousParameterValues;
      std::vector<double>    _currentExpectationValues;
      std::vector<double>    _standardDeviations;
      TMatrixD   _covarianceMatrix;
      TMatrixD   _expectationMatrix;
      TMatrixD   _acceptedPoints;



    private:
      virtual void           Execute();
      virtual void           PrintSteeringParameters() const;
      virtual void           UpdateModel();
      virtual void           UpdateExpectations();
      virtual void           UpdateCovarianceMatrix();
      virtual void           UpdateParameters();
      virtual void           CalculateStandardDeviations();
      virtual void           CalculateStepWidth();



      /*! \endcond UML */

  };

}

#endif // FITTINO_CovariantSampler_H
