/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RandomGenerator.cpp                                              *
*                                                                              *
* Description Singleton wrapper class for random number generator              *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@cbpf.br>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TRandom3.h"

#include "RandomGenerator.h"

Fittino::RandomGenerator* Fittino::RandomGenerator::GetInstance() {

    if ( !_instance ) {

        _instance = new RandomGenerator;

    }

    return _instance;

}

double Fittino::RandomGenerator::Gaus( double mean, double sigma ) {

    return _generator->Gaus( mean, sigma );

}

double Fittino::RandomGenerator::Poisson( double lambda ) {

    return _generator->Poisson( lambda );

}

unsigned int Fittino::RandomGenerator::GetSeed() {

    return _randomSeed;

}

void Fittino::RandomGenerator::SetSeed( unsigned int seed ) {

    _randomSeed = seed;
    _generator->SetSeed( _randomSeed );

}

TRandom3* Fittino::RandomGenerator::GetGenerator() {

    return _generator;

}

Fittino::RandomGenerator* Fittino::RandomGenerator::_instance = 0;

Fittino::RandomGenerator::RandomGenerator()
    : _randomSeed( 4357 ) {

    _generator = new TRandom3( _randomSeed );

}

Fittino::RandomGenerator::~RandomGenerator() {

    delete _generator;

}
