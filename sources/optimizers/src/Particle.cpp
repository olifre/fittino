/* $Id: Particle.cpp,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

/*******************************************************************************
 *                                                                             *
 * Project     Fittino - A SUSY Parameter Fitting Package                      *
 *                                                                             *
 * File        Particle.cpp                                                    *
 *                                                                             *
 * Description Class for Particle                                              *
 *                                                                             *
 * Authors     Philip  Bechtle     <philip.bechtle@desy.de>                    *
 *             Klaus   Desch       <desch@physik.uni-bonn.de>                  *
 *             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>             *
 *             Peter   Wienemann   <wiene@physik.uni-bonn.de>                  *
 *                                                                             *
 * Licence     This program is free software; you can redistribute it and/or   *
 *             modify it under the terms of the GNU General Public License as  *
 *             published by the Free Software Foundation; either version 3 of  *
 *             the License, or (at your option) any later version.             *
 *                                                                             *
 *******************************************************************************/

#include <cstdlib>
#include <ctime>
#include <iostream>

#include "Particle.h"

double Fittino::Particle::_globalBestChi2 = 1e99;

Fittino::Particle::Particle( double c1, double c2, Fittino::ModelBase* model, int seed )
        : _c1( c1 ),
          _c2( c2 ),
          _personalBestChi2( 1e99 ),
          _randomGenerator( new TRandom() ),
          _model( model ) {

    _randomGenerator->SetSeed( seed );

    for ( unsigned int n = 0; n < _model->GetNumberOfParameters(); n++ ) {

        _position.push_back( _randomGenerator->Uniform( -3., 3. ) );
        _velocity.push_back( 0. );

    }


    _globalBestModel = model->Clone();
    _personalBestModel = model->Clone();

}

Fittino::Particle::~Particle() {

}

void Fittino::Particle::UpdateVelocity() {

    double randomNumber1 = _randomGenerator->Uniform( 0, 1 );
    double randomNumber2 = _randomGenerator->Uniform( 0, 1 );

    for ( unsigned int i = 0; i < _velocity.size(); i++ ) {

        _velocity[i] =   _velocity[i]
                       + _c1 * randomNumber1 * ( ( *( _personalBestModel->GetParameterVector() ) )[i] - _position[i] )
                       + _c2 * randomNumber2 * ( ( *( _globalBestModel->GetParameterVector() ) )[i] - _position[i] );

    }

}

void Fittino::Particle::UpdatePosition() {

    for ( unsigned int i = 0; i < _position.size(); i++ ) {

        _position[i] = _position[i] + _velocity[i];

    }

}

void Fittino::Particle::UpdateModel() {

    UpdateVelocity();
    UpdatePosition();

    for ( unsigned int i = 0; i < _model->GetParameterVector()->size(); i++ ) {

        ( *( _model->GetParameterVector() ) )[i] = _position[i];

    }

    double actualChi2 = _model->Evaluate();

    if ( actualChi2 < _personalBestChi2 ) {

        _personalBestChi2 = actualChi2;
        _personalBestModel = _model->Clone();

    }
    if ( _personalBestChi2 < _globalBestChi2 ) {

        _globalBestChi2 = _personalBestChi2;
        _globalBestModel = _personalBestModel->Clone();

    }

}

Fittino::ModelBase* Fittino::Particle::_globalBestModel;
