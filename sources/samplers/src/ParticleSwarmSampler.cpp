
/* $Id: ParticleSwarmSampler.cpp 1715 2013-11-10 13:16:58Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParticleSwarmSampler.cpp                                           *
*                                                                              *
* Description Class for SamplingParticle Swarm Optimisation sampling                         *
*                                                                              *
* Authors     Pia Kullik <pkullik@uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include <cmath>

#include "TTree.h"
#include "TBranch.h"

//#include "Configuration.h"
#include "ParticleSwarmSampler.h"
#include "Messenger.h"
#include "ModelBase.h"
//#include "ModelParameterBase.h"
//#include "ModelCalculatorException.h"
#include "SamplingParticle.h"

//Constructors:
Fittino::ParticleSwarmSampler::ParticleSwarmSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
  : SamplerBase( model, ptree.get<int>( "randomSeed" ) ),
    _numberOfIterations(ptree.get<int>("numberOfIterations")),
    _numberOfParticles(ptree.get<int>("numberOfParticles")),
    _inertia(1.e99),
    _c1(1.e99),
    _c2(1.e99),
    _bestChi2(1.e99),
    _currentChi2(1.e99),
    _bestParticle(model->GetNumberOfParameters()),
    _particles(std::vector<SamplingParticle>(ptree.get<int>("numberOfParticles"),model->GetNumberOfParameters())){

        _name = "Particle Swarm Optimization Sampler";
}

Fittino::ParticleSwarmSampler::ParticleSwarmSampler( Fittino::ModelBase* model, int randomSeed )
  : SamplerBase( model, randomSeed ),
    _numberOfIterations(Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", 10000 )),
    _numberOfParticles(Configuration::GetInstance()->GetSteeringParameter( "NumberOfParticles", 10000 )),
    _inertia(1.e99),
    _c1(1.e99),
    _c2(1.e99),
    _bestChi2(1.e99),
    _currentChi2(1.e99),
    _bestParticle(model->GetNumberOfParameters()),
    _particles(std::vector<SamplingParticle>(Configuration::GetInstance()->GetSteeringParameter( "NumberOfParticles", 10000 ),model->GetNumberOfParameters())){

        _name = "Particle Swarm Optimization Sampler";
        //add steering parameters...
}

//Destructor:
Fittino::ParticleSwarmSampler::~ParticleSwarmSampler() {

}

//Execute sampling
void Fittino::ParticleSwarmSampler::Execute() {

    PrintSteeringParameters();
    InitializeParticles();
    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );
        this->UpdateModel();
        GetStatusParameterVector()->at( 0 )->SetValue( _bestChi2 );
    }

}

//Print steering parameters:
void Fittino::ParticleSwarmSampler::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Number of particles         " << _numberOfParticles << Messenger::Endl;
    //print other parameters...

}


//Update SamplingParticle swarm
void Fittino::ParticleSwarmSampler::UpdateModel() {

    for(int i = 0; i < _numberOfParticles; i++){

        //enter parameters into model and evaluate chi2
        for(int j = 0; j < _model->GetNumberOfParameters(); j++){
            _model->GetCollectionOfParameters().At(j)->SetValue(_particles.at(i).getCurrentParameterVector().at(j));
        }
        _currentChi2 = _model->GetChi2(); //this part is expensive!
        GetStatusParameterVector()->at( 0 )->SetValue( _currentChi2 );

        //write to tree
        this->FillTree();
        std::cout<<"tree filled at iteration "<<_iterationCounter<<", particle "<<i<<"\n";

        //generate fitness value, update personal best
        _particles.at(i).setCurrentFitness(FitnessFunction(_currentChi2));
        if(_particles.at(i).getCurrentFitness() > _particles.at(i).getBestFitness()){
            _particles.at(i).setBestFitness(_particles.at(i).getCurrentFitness());

        }

        //remember best SamplingParticle
        if(_currentChi2 < _bestChi2){ //use fitness values instead?
            _bestChi2 = _currentChi2;
            _bestParticle = _particles.at(i);
        }

        //update location and speed of each SamplingParticle
        for(int j = 0; j < _model->GetNumberOfParameters(); j++){
            //to do: find clever way to determine c1, c2; maybe use covariance matrix of personal parameter vector history (c1) and history of best parameters (c2), respectively?
            //for now: see InitializeParticles
            _c1 = 0.01*(rand()%200) - 1;
            _c2 = 0.01*(rand()%200) - 1;
            _particles.at(i).setSpeedVector(j, (_inertia*_particles.at(i).getSpeedVector().at(j) + _c1*(_particles.at(i).getBestParameterVector().at(j) - _particles.at(i).getCurrentParameterVector().at(j)) + _c2*(_bestParticle.getBestParameterVector().at(j) - _particles.at(i).getCurrentParameterVector().at(j))));
            _particles.at(i).setCurrentParameterVector(j, (_particles.at(i).getCurrentParameterVector().at(j) + _particles.at(i).getSpeedVector().at(j)));
        }

    }

}

//Fitness function
double Fittino::ParticleSwarmSampler::FitnessFunction(double chi2){
    //to do: find clever fitness function, maybe factor in area where high point density is desired?
    //for now: want to maximise fitness where chi2 is small -->
    return -chi2;
}

//Initialise set of starting parameters:
void Fittino::ParticleSwarmSampler::InitializeParticles(){

    for(int i = 0; i < _numberOfParticles; i++){
        //to do: implement such that the user can choose a bounding box/centre+variance for init. distribution of SamplingParticles in parameter space
        //for now: normal distribution around 0
        for(int j = 0; j < _model->GetNumberOfParameters(); j++){
            _particles.at(i).setCurrentParameterVector(j, (0.01*(rand()%200) - 1));
            _particles.at(i).setBestParameterVector(j, _particles.at(i).getCurrentParameterVector().at(j));
            _particles.at(i).setSpeedVector(j, (0.01*(rand()%200) - 1));
        }
    }

}

