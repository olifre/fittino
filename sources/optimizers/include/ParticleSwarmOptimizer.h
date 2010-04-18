/* $Id: ParticleSwarmOptimizer.h,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParticleSwarmOptimizer.h                                         *
*                                                                              *
* Description Class for particle swarm parameter optimization                  *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wiene@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PARTICLESWARMOPTIMIZATION_H
#define FITTINO_PARTICLESWARMOPTIMIZATION_H

#include <iostream>

#include "ModelBase.h"
#include "OptimizerBase.h"
//#include "ParticleSwarm.h"

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  /*!
   *  \brief Class for particle swarm parameter optimization
   *
   *  The algorithm works as follows:
   *  <br>
   *  \f[
   *    \vec{r} = \vec{r} + \vec{v} 
   *  \f] 
   *
   *  
   *
   */

  /*!
   *  \todo Mid-term: Rethink optimizer design
   *
   *  \todo Mid-term: Make optimizer fully configurable from instance of
   *        Configuration class
   */
  class ParticleSwarmOptimizer : public OptimizerBase {
  
    public:
      /*!
       *  The constructor of the particle swarm optimizer takes as input the
       *  maximal number of iteration steps , the number of particles in the
       *  swarm , the global scaling parameter c1 which determines and the
       *  local scaling parameter c2 witch determines respectively. It
       *  subsequently creates and initializes a particle swarm with the
       *  specified number of particles.
       */
	                 ParticleSwarmOptimizer();
      /*!
       *  The destructor of the particle swarm optimizer. It calls the
       *  destructor of the particle swarm. 
       */
                         ~ParticleSwarmOptimizer();

    private:
      virtual ModelBase* UpdateModel();
 
    private:
      unsigned int       _numberOfParticles;
      double             _c1;
      double             _c2;
      //ParticleSwarm* _particleSwarm;

    private:
      //void               DeclareSteeringParameter( std::string parameterName, SteeringParameterBase parameterValue );

  };

}

#endif // FITTINO_PARTICLESWARMOPTIMIZER_H
