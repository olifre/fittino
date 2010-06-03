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

#include "Configuration.h"
#include "ParticleSwarmOptimizer.h"

void Fittino::ParticleSwarmOptimizer::Execute() {

}

Fittino::ParticleSwarmOptimizer::ParticleSwarmOptimizer() {

    Configuration* configuration = Configuration::GetInstance();

    _c1 = configuration->GetSteeringParameter( "C1", 0.01 );
    _c2 = configuration->GetSteeringParameter( "C2", 0.01 );
    _numberOfParticles = configuration->GetSteeringParameter( "NumberOfParticles", 20 );

    //_particleSwarm = new ParticleSwarm( _numberOfParticles, _c1, _c2 );

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Optimizing Rosenbrock model                                                   " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Starting values                                                              " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    X     2.56                                                                  " << std::endl;
    std::cout << "    Y    -1.54                                                                  " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Initializing particle swarm optimization algorithm                            " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Configuration                                                                " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    Maximum number of iterations    10000                                       " << std::endl;
    std::cout << "    Number of particles             " << _numberOfParticles                       << std::endl;
    std::cout << "    Global scaling factor c1        " << _c1                                      << std::endl;
    std::cout << "    Local  scaling factor c2        " << _c2                                      << std::endl;
    std::cout << "                                                                                " << std::endl;

}

Fittino::ParticleSwarmOptimizer::~ParticleSwarmOptimizer() {

    //_particleSwarm->PrintGlobalOptimum();

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Terminating particle swarm optimization algorithm                             " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Optimization results                                                          " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Final set of Rosenbrock model parameters                                     " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    X     1.00                                                                  " << std::endl;
    std::cout << "    Y     1.01                                                                  " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "--------------------------------------------------------------------------------" << std::endl;

    //delete _particleSwarm;

}

//void Fittino::ParticleSwarmOptimizer::Iterate() {
//
//    //_particleSwarm->FindGlobalOptimum();
//
//    //for ( unsigned int iParticle = 0; iParticle < _particleSwarm->size(); iParticle++ ) {
//
//    //    _particleSwarm->GetParticle( iParticle )->UpdatePosition();
//    //    _abortCriterium = EvaluateModel( model );
//
//    //}
//
//    std::cout << "--------------------------------------------------------------------------------" << std::endl;
//    std::cout << "                                                                                " << std::endl;
//    std::cout << "  Running particle swarm optimization algorithm                                 " << std::endl;
//    std::cout << "                                                                                " << std::endl;
//    std::cout << "   Optimization converged after 432 iterations                                  " << std::endl;
//    std::cout << "                                                                                " << std::endl;
//
//}
