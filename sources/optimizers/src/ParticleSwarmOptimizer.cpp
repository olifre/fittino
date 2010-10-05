/* $Id: ParticleSwarmOptimizer.cpp,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

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
*	      Peter   Wienemann   <wiene@physik.uni-bonn.de>                   *
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

        int seed = _randomGenerator.Uniform( 0, 10000 );

        Particle* particle = new Particle( _c1, _c2, _model, seed );
        _particleSwarm.push_back( particle );

    }

}

Fittino::ParticleSwarmOptimizer::~ParticleSwarmOptimizer() {

    //delete _particleSwarm;

}

void Fittino::ParticleSwarmOptimizer::PrintSteeringParameters() const {

    Messenger* messenger = Messenger::GetInstance();

    std::ostringstream numberOfParticles;
    numberOfParticles << _numberOfParticles;
    std::ostringstream c1;
    c1 << _c1;
    std::ostringstream c2;
    c2 << _c2;

    messenger->PrintALWAYSMessage( "    Number of particles          " + numberOfParticles.str() + "\n" );
    messenger->PrintALWAYSMessage( "    Global scaling factor c1     " + c1.str()                + "\n" );
    messenger->PrintALWAYSMessage( "    Local scaling factor c2      " + c2.str()                + "\n" );

}

void Fittino::ParticleSwarmOptimizer::UpdateModel() {

    for ( unsigned int i = 0; i < _particleSwarm.size(); i++ ) {

        _particleSwarm[i]->UpdateModel();

    }

    _model = Fittino::Particle::_globalBestModel;

}
