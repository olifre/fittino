/* $Id: ParticleSwarmOptimizer.h,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParticleSwarmOptimizer.h                                         *
*                                                                              *
* Description Class for particle swarm parameter optimizer                     *
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

#include "OptimizerBase.h"
#include "Particle.h"

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  /*!
   *  \brief Class for particle swarm parameter optimizer.
   *
   *  The algorithm works as follows:
   *  <br>
   *  \f[
   *    \vec{r} = \vec{r} + \vec{v} 
   *  \f] 
   *
   */
  class ParticleSwarmOptimizer : public OptimizerBase {
  
    public:
      /*!
       *  Standard constructor.
       */
	                    ParticleSwarmOptimizer( ModelBase* model );
      /*!
       *  Standard destructor.
       */
                            ~ParticleSwarmOptimizer();

      /*! \cond UML */
    private:
      double                _c1;
      double                _c2;
      unsigned int          _numberOfParticles;
      std::vector<Particle> _particleSwarm;

    private:
      virtual void          PrintSteeringParameters() const;
      virtual void          UpdateModel();
      /*! \endcond UML */
 
  };

}

#endif // FITTINO_PARTICLESWARMOPTIMIZER_H
