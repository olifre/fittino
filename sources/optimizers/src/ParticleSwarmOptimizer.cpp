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
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*             Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Messenger.h"
#include "ParticleSwarmOptimizer.h"

Fittino::ParticleSwarmOptimizer::ParticleSwarmOptimizer( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : _c1               ( ptree.get<double>( "C1"               , 0.01 ) ),
      _c2               ( ptree.get<double>( "C2"               , 0.01 ) ),
      _numberOfParticles( ptree.get<int>   ( "NumberOfParticles", 20   ) ),
      OptimizerBase( model, ptree ) {

    _name = ptree.get<std::string>( "Name", "particle swarm optimization algorithm" );

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
