/* $Id: Individual.cpp,v 1.0  2010/11/03 22:00:00 sarrazin $ */

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

#include "Individual.h"

Fittino::Individual::Individual( Fittino::ModelBase* model, double mutationRate, int seed ):
    _model ( model ) ,
    _mutationRate ( mutationRate ),
    _randomGenerator( new TRandom() ),
    _chi2 ( 1e99 ) {
    _mutatedIndividual = false;
    _randomGenerator->SetSeed( seed );

    for ( unsigned int i = 0; i < model->GetNumberOfParameters(); i++ ) {

        _genes.push_back( _randomGenerator->Uniform( -3., 3. ) ); //to do: Get bounds from bounds of parameters of the pointed model or from input file

    }

    UpdateModel();
    SetChi2();
}

Fittino::Individual::~Individual() {

}

double Fittino::Individual::GetGene( int index ) {

    return _genes[index];

}

void Fittino::Individual::Mutation() {

    for ( unsigned int i = 0; i < _genes.size(); i++ ) {

        if ( _randomGenerator->Uniform( 0, 1 ) < _mutationRate ) {

            _genes[i] = _randomGenerator->Gaus( _genes[i], 0.02 );
            _mutatedIndividual = true; //to do: Get MutationStepSize from error of parameters of the pointed model

        }

    }

}

void Fittino::Individual::SetChi2() {

    _chi2 = _model->Evaluate();

}

void Fittino::Individual::SetGene( int index, double newValue ) {

    _genes[index] = newValue;

}

void Fittino::Individual::UpdateModel() {

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        ( *_model->GetParameterVector() )[i].SetValue( _genes[i] );

    }

}

bool Fittino::Individual::operator<( const Individual& individual ) const {

    return this->_chi2 < individual._chi2;

}


