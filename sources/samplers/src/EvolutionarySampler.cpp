/* $Id: EvolutionarySampler.cpp 1715 2013-11-10 13:16:58Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        EvolutionarySampler.cpp                                           *
*                                                                              *
* Description Class for Evolutionary parameter sampler                 *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>              *
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
#include "EvolutionarySampler.h"
#include "Messenger.h"
#include "ModelBase.h"
//#include "ModelParameterBase.h"
//#include "ModelCalculatorException.h"
#include "Hypothesis.h"

//Constructors:
Fittino::EvolutionarySampler::EvolutionarySampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
  : SamplerBase( model, ptree.get<int>( "randomSeed" ) ),
    _numberOfIterations(ptree.get<int>("numberOfIterations")),
    _numberOfHypotheses(ptree.get<int>("numberOfHypotheses")),
    _chi2(1.e99),
    _hypotheses(std::vector<Hypothesis>(ptree.get<int>("numberOfHypotheses"),model->GetNumberOfParameters())){

        _name = "Evolutionary Optimization Sampler";
}



Fittino::EvolutionarySampler::EvolutionarySampler( Fittino::ModelBase* model, int randomSeed )
    : SamplerBase( model, randomSeed ),
    _numberOfIterations(Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", 10000 )),
    _numberOfHypotheses(Configuration::GetInstance()->GetSteeringParameter( "NumberOfHypotheses", 10000 )),
    _chi2(1.e99),
    _hypotheses(std::vector<Hypothesis>(Configuration::GetInstance()->GetSteeringParameter( "NumberOfHypotheses", 10000 ),model->GetNumberOfParameters())){

        _name = "Evolutionary Optimization Sampler";
        //add steering parameters...
}




//Destructors:
Fittino::EvolutionarySampler::~EvolutionarySampler() {

}

//Execute EA sampling
void Fittino::EvolutionarySampler::Execute() {

    InitialiseHypotheses();
    while(_iterationCounter <= _numberOfIterations){

        _iterationCounter++;
        UpdateModel();
        //maintenance...

    }

}

//Print steering parameters
void Fittino::EvolutionarySampler::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations << Messenger::Endl;
    //etc

}

//Update population
void Fittino::EvolutionarySampler::UpdateModel() {

    //select parents
    SelectParents();

    //reproduce
    Reproduce();

    for(int i = 0; i < _numberOfHypotheses; i++){
        Mutate(i);
    }

    //evaluate fitness and write to tree
    for(int i = 0; i < _numberOfHypotheses; i++){
        for(int j = 0; j < _model->GetNumberOfParameters(); j++){
           // _model->GetCollectionOfParameters().At(j).SetValue(_hypotheses.at(i).getParameterVector().at(j).GetValue());
        }
        _chi2 = _model->GetChi2();
        this->FillTree();

        _hypotheses.at(i).setFitness(FitnessFunction(_chi2));
    }

}

//Generate initial set of genomes
void Fittino::EvolutionarySampler::InitialiseHypotheses(){

    for(int i = 0; i < _numberOfHypotheses; i++){
        //to do: implement such that the user can choose a bounding box/centre+variance for init. distribution of particles in parameter space
        //for now: normal distribution around 0
        for(int j = 0; i < _model->GetNumberOfParameters(); j++){
            _hypotheses.at(i).setParameterVector(j, 2*rand() - 1);
        }
    }

}

//Select parents
void Fittino::EvolutionarySampler::SelectParents(){
    //Roulette wheel algorithm

}

//Create next generation
void Fittino::EvolutionarySampler::Reproduce(){
    //Crossover, I think... -->discuss with Goerke!

}

//Mutate i-th hypothesis
void Fittino::EvolutionarySampler::Mutate(int i){
    //idea: mutation rate of each parameter dependent on covariance matrix, see CorrelatedSampler

}

//Fitness function
double Fittino::EvolutionarySampler::FitnessFunction(double chi2){
    //to do: find clever fitness function, maybe factor in area where high point density is desired?
    //for now: want to maximise fitness where chi2 is small -->
    return -chi2;
}
