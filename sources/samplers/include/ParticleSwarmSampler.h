/* $Id: ParticleSwarmSampler.h 1692 2013-11-06 11:26:02Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParticleSwarmSampler.h                                             *
*                                                                              *
* Description Class for Particle Swarm Optimisation sampling                      *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_ParticleSwarmSampler_H
#define FITTINO_ParticleSwarmSampler_H

#include "SamplerBase.h"
#include "SamplingParticle.h"
#include <vector>

class TBranch;


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup samplers
   *  \brief Class for Particle Swarm Optimisation sampling
   */
  class ParticleSwarmSampler : public SamplerBase {

    public:
      /*!
       *  Standard constructor.
       */
      ParticleSwarmSampler( ModelBase* model, int randomSeed );
      ParticleSwarmSampler( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                             ~ParticleSwarmSampler();

      /*! \cond UML */
    private:
        int _numberOfIterations;
        int _numberOfParticles;
        double _inertia;
        double _c1;
        double _c2;
        double _bestChi2;
        double _currentChi2;
        SamplingParticle _bestParticle;
        std::vector<SamplingParticle> _particles;


    private:
      virtual void           Execute();
      virtual void           PrintSteeringParameters() const;
      virtual void           UpdateModel();
      virtual void           InitializeParticles();
      virtual double         FitnessFunction(double chi2);


      /*! \endcond UML */

  };

}

#endif // FITTINO_ParticleSwarmSampler_H
