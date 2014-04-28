/* $Id$ */

/******************************************************************************
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
*             Peter   Wienemann   <wienemann@physik.uni-bonn.de>              *
*                                                                             *
* Licence     This program is free software; you can redistribute it and/or   *
*             modify it under the terms of the GNU General Public License as  *
*             published by the Free Software Foundation; either version 3 of  *
*             the License, or (at your option) any later version.             *
*                                                                             *
******************************************************************************/

#include "ModelBase.h"
#include "ModelParameter.h"
#include "Particle.h"

double Fittino::Particle::_globalBestChi2 = 1.e99;

Fittino::ModelBase* Fittino::Particle::_globalBestModel;

Fittino::Particle::Particle( double c1, double c2, Fittino::ModelBase* model, int seed )
    : _c1( c1 ),
      _c2( c2 ),
      _personalBestChi2( 1.e99 ),
      _model( model ) {

    _randomGenerator = Fittino::RandomGenerator::GetInstance();
    if( _randomGenerator->GetSeed() == 0 ) {
    
        _randomGenerator->SetSeed( seed );
    
    }

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        _position.push_back( _randomGenerator->Uniform( _model->GetCollectionOfParameters().At( i )->GetLowerBound(), _model->GetCollectionOfParameters().At( i )->GetUpperBound() ) );
        _velocity.push_back( 0. );

    }

    _globalBestModel = model->Clone();
    _personalBestModel = model->Clone();

}

Fittino::Particle::~Particle() {

}

void Fittino::Particle::UpdateModel() {

    UpdateVelocity();
    UpdatePosition();

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        _model->GetCollectionOfParameters().At( i )->SetValue( _position.at( i ) );

    }

    double actualChi2 = _model->GetChi2();

    if ( actualChi2 < _personalBestChi2 ) {

        _personalBestChi2 = actualChi2;
        _personalBestModel = _model->Clone();

    }
    if ( _personalBestChi2 < _globalBestChi2 ) {

        _globalBestChi2 = _personalBestChi2;
        _globalBestModel = _personalBestModel->Clone();

    }

}

void Fittino::Particle::UpdatePosition() {

    for ( unsigned int i = 0; i < _position.size(); i++ ) {

        _position.at( i ) = _position.at( i ) + _velocity.at( i );

    }

}

void Fittino::Particle::UpdateVelocity() {

    double randomNumber1 = _randomGenerator->Uniform( 0., 1. );
    double randomNumber2 = _randomGenerator->Uniform( 0., 1. );

    for ( unsigned int i = 0; i < _velocity.size(); i++ ) {

        _velocity.at( i ) =  _velocity.at( i )
                             + _c1 * randomNumber1 * ( _personalBestModel->GetCollectionOfParameters().At( i )->GetValue() - _position.at( i ) )
                             + _c2 * randomNumber2 * ( _globalBestModel->GetCollectionOfParameters().At( i )->GetValue() - _position.at( i ) );

    }

}
