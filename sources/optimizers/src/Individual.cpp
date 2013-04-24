/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Individual.cpp                                                   *
*                                                                              *
* Description Class for Individual                                             *
*                                                                              *
* Authors     Bjoern Sarrazin  <bjoern.sarrazin@desy.de>                       *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TRandom.h"

#include "Individual.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"

Fittino::Individual::Individual( Fittino::ModelBase* model, double mutationRate, int seed ):
    _model ( model ) ,
    _mutationRate ( mutationRate ),
    _randomGenerator( new TRandom() ),
    _chi2 ( 1e99 ) {
    _updatedChi2 = false;
    _randomGenerator->SetSeed( seed );

    for ( unsigned int i = 0; i < model->GetNumberOfParameters(); i++ ) {

        _genes.push_back( _randomGenerator->Uniform( -3., 3. ) ); //to do: Get bounds from bounds of parameters of the pointed model or from input file

    }

    UpdateChi2();
}

Fittino::Individual::~Individual() {

}

bool Fittino::Individual::UpdatedChi2(){

  return _updatedChi2;

}

double Fittino::Individual::GetGene( int index ) {

    return _genes[index];

}

void Fittino::Individual::Mutation() {

    for ( unsigned int i = 0; i < _genes.size(); i++ ) {

        if ( _randomGenerator->Uniform( 0, 1 ) < _mutationRate ) {

            _genes[i] = _randomGenerator->Gaus( _genes[i], 0.02 );
            _updatedChi2 = false; //to do: Get MutationStepSize from error of parameters of the pointed model

        }

    }

}

void Fittino::Individual::UpdateChi2() {

  UpdateModel();
    _chi2 = _model->GetChi2();
    _updatedChi2=true;

}

void Fittino::Individual::SetGene( int index, double newValue ) {

    _genes[index] = newValue;
    _updatedChi2=false;

}

void Fittino::Individual::UpdateModel() {

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        ( *_model->SetParameterVector() )[i]->SetValue( _genes[i] );

    }

}

bool Fittino::Individual::operator<( const Individual& individual ) const {

    return this->_chi2 < individual._chi2;

}


