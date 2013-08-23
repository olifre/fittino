/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParticleSwarmOptimizer.cpp                                       *
*                                                                              *
* Description Class for particle swarm parameter optimization                  *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>
#include <sstream>

#include "Configuration.h"
#include "Messenger.h"
#include "ParticleSwarmOptimizer.h"

Fittino::ParticleSwarmOptimizer::ParticleSwarmOptimizer( Fittino::ModelBase* model )
        : OptimizerBase( model ) {

    _name = "particle swarm optimization algorithm";

    _c1 = Configuration::GetInstance()->GetSteeringParameter( "C1", 0.01 );
    _c2 = Configuration::GetInstance()->GetSteeringParameter( "C2", 0.01 );
    _numberOfParticles = Configuration::GetInstance()->GetSteeringParameter( "NumberOfParticles", 20 );

    for ( unsigned int n = 0; n < _numberOfParticles; n++ ) {

        int seed = static_cast<int>( _randomGenerator.Uniform( 0, 10000 ) );

        Particle particle( _c1, _c2, _model, seed );
        _particleSwarm.push_back( particle );

    }

}

Fittino::ParticleSwarmOptimizer::~ParticleSwarmOptimizer() {

    //delete _particleSwarm;

}

void Fittino::ParticleSwarmOptimizer::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Abort criterium              " << _abortCriterium     << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Number of particles          " << _numberOfParticles  << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Global scaling factor c1     " << _c1                 << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Local scaling factor c2      " << _c2                 << Messenger::Endl;

}

void Fittino::ParticleSwarmOptimizer::UpdateModel() {

    for ( unsigned int i = 0; i < _particleSwarm.size(); i++ ) {

        _particleSwarm[i].UpdateModel();

    }

    _model = Fittino::Particle::_globalBestModel;

}
