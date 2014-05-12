/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SamplingParticle.cpp                                             *
*                                                                              *
* Description Class for SamplingParticle used in PSO sampler                    *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "SamplingParticle.h"
//#include "ModelParameterBase.h"
#include <cmath>
using namespace Fittino;

//SamplingParticle constructor
Fittino::SamplingParticle::SamplingParticle(int n)
{
    for(int i = 0; i < n; i++){
        _currentParameterVector.push_back(0);
        _bestParameterVector.push_back(0);
        _speedVector.push_back(0);
    }
    setCurrentFitness(-INFINITY);
    setBestFitness(-INFINITY);
}

Fittino::SamplingParticle::~SamplingParticle()
{
    //dtor
}

//SamplingParticle parameter getters
std::vector<double> Fittino::SamplingParticle::getCurrentParameterVector(){
    return _currentParameterVector;
}


std::vector<double> Fittino::SamplingParticle::getBestParameterVector(){
    return _bestParameterVector;
}

std::vector<double> Fittino::SamplingParticle::getSpeedVector(){
    return _speedVector;
}

//SamplingParticle parameter setters
void Fittino::SamplingParticle::setCurrentParameterVector(int i, double value){
    _currentParameterVector.at(i) = value;
}

void Fittino::SamplingParticle::setBestParameterVector(int i, double value){
    _bestParameterVector.at(i) = value;
}

void Fittino::SamplingParticle::setBestParameterVector(std::vector<double> other){
    this->_bestParameterVector = other;
}

void Fittino::SamplingParticle::setSpeedVector(int i, double value){
    _speedVector.at(i) = value;
}

//Fitness getters
double Fittino::SamplingParticle::getCurrentFitness(){
    return _currentFitness;
}

double Fittino::SamplingParticle::getBestFitness(){
    return _bestFitness;
}

//Fitness setters
void Fittino::SamplingParticle::setCurrentFitness(double value){
    this->_currentFitness = value;
}

void Fittino::SamplingParticle::setBestFitness(double value){
    this->_bestFitness = value;
}


