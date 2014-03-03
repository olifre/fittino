/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Particle.h                                                       *
*                                                                              *
* Description Class for Particle (needed by particle swarm optimizer)          *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*             Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PARTICLE_H
#define FITTINO_PARTICLE_H

#include <vector>

class TRandom3;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;

  /**
   *  \ingroup optimizers
   *  \brief Class for particle (needed by particle swarm optimizer).
   */
  class Particle {

    public:
      static double       _globalBestChi2;
      static ModelBase*   _globalBestModel;

    public:
      Particle( double c1, double c2, ModelBase* model, int seed );
      ~Particle();
      void                UpdateModel();

    private:
      float               _c1;
      float               _c2;
      double              _personalBestChi2;
      std::vector<double> _position;
      std::vector<double> _velocity;
      TRandom3*           _randomGenerator;
      ModelBase*          _model;
      ModelBase*          _personalBestModel;

    private:
      void                UpdatePosition();
      void                UpdateVelocity();

  };

}

#endif // FITTINO_PARTICLE_H
