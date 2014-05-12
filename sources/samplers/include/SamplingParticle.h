/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SamplingParticle.h                                               *
*                                                                              *
* Description Class for sampling particles used in PS sampler                  *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>                                *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SamplingParticle_H
#define FITTINO_SamplingParticle_H

#include <vector>

//#include "ModelParameterBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup samplers
   *  \brief Class for sampling particles used in PS sampler.
   */
  class SamplingParticle {

    public:
        SamplingParticle(int n);
        virtual ~SamplingParticle();

        std::vector<double> getCurrentParameterVector();
        std::vector<double> getBestParameterVector();
        std::vector<double> getSpeedVector();
        void setCurrentParameterVector(int i,  double value);
        void setBestParameterVector(int i, double value);
        void setBestParameterVector(std::vector<double> other);
        void setSpeedVector(int i, double value);

        double getCurrentFitness();
        double getBestFitness();
        void setCurrentFitness(double fitness);
        void setBestFitness(double fitness);

    private:
        std::vector<double> _currentParameterVector;
        std::vector<double> _bestParameterVector;
        std::vector<double> _speedVector;

        double _currentFitness;
        double _bestFitness;

  };

}

#endif // SamplingParticle_H
