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

#include "Configuration.h"
#include "ParticleSwarmOptimizer.h"

Fittino::ParticleSwarmOptimizer::ParticleSwarmOptimizer( Fittino::ModelBase* model )
        : OptimizerBase( model ) {

    Configuration* configuration = Configuration::GetInstance();

    _c1 = configuration->GetSteeringParameter( "C1", 0.01 );
    _c2 = configuration->GetSteeringParameter( "C2", 0.01 );
    _name =  "particle swarm optimization algorithm";
    _numberOfParticles = configuration->GetSteeringParameter( "NumberOfParticles", 20 );

    TRandom _randomGenerator;

    for ( unsigned int n = 0; n < _numberOfParticles; n++ ) {

        int seed = _randomGenerator.Uniform( 0, 10000 );

        Particle* particle = new Particle( _c1, _c2, _model, seed );
        _particleSwarm.push_back( particle );

    }

    ParticleSwarmOptimizer::PrintConfiguration();


}

Fittino::ParticleSwarmOptimizer::~ParticleSwarmOptimizer() {

    ParticleSwarmOptimizer::PrintResult();
    //delete _particleSwarm;

}

void Fittino::ParticleSwarmOptimizer::Execute() {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Running " << _name                                                              << std::endl;
    std::cout << "                                                                                " << std::endl;

    while (  _globalBestChi2 > _abortCriterium && _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;

        for ( unsigned int i = 0; i < _particleSwarm.size(); i++ ) {

            _particleSwarm[i]->UpdateModel();

        }

        _globalBestChi2 = Fittino::Particle::_globalBestChi2;
        _model = Fittino::Particle::_globalBestModel;

        //PrintStatus();

    }

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Optimization converged after " << _iterationCounter << " iterations           " << std::endl;
    std::cout << "                                                                                " << std::endl;

}

void Fittino::ParticleSwarmOptimizer::PrintConfiguration() const {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Initializing " << _name                                                         << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Configuration                                                                " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    Maximum number of iterations    " << _numberOfIterations                      << std::endl;
    std::cout << "    Number of particles             " << _numberOfParticles                       << std::endl;
    std::cout << "    Global scaling factor c1        " << _c1                                      << std::endl;
    std::cout << "    Local scaling factor c2         " << _c2                                      << std::endl;
    std::cout << "                                                                                " << std::endl;

}
