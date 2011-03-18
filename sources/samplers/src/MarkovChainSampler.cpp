/* $Id: MarkovChainSampler.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MarkovChainSampler.cpp                                           *
*                                                                              *
* Description Class for Markov chain parameter sampler                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include "TMath.h"

#include "MarkovChainSampler.h"
#include "ModelBase.h"

Fittino::MarkovChainSampler::MarkovChainSampler( Fittino::ModelBase* model )
        : SamplerBase( model ),
          _previousChi2( 1.e99 ),
          _previousLikelihood( 0. ),
          _previousRho( 1. ) {

    _name = "Markov chain parameter sampler";

}

Fittino::MarkovChainSampler::~MarkovChainSampler() {

}

void Fittino::MarkovChainSampler::PrintSteeringParameters() const {

    std::cout << "    Markov chain sampler parameter" << std::endl;

}

void Fittino::MarkovChainSampler::UpdateModel() {

    // Calclate chi2.

    double chi2 = _model->Evaluate();

    // Calculate likelihood.

    double likelihood = TMath::Exp( -chi2 / 2. );

    // Decide whether point shall be accepted.

    bool pointAccepted = false;
    double rho = 0.;

    if ( _previousLikelihood > 0. ) {

        rho = likelihood / _previousLikelihood;

    }

    if ( rho > 1. ) {

        pointAccepted = true;

    }
    else {

        double randomThreshold = _randomGenerator.Uniform( 0., 1. );
        if ( rho > randomThreshold ) {

            pointAccepted = true;

        }

    }

    if ( pointAccepted ) {

        _previousRho        = rho;
        _previousChi2       = chi2;
        _previousLikelihood = likelihood;

    }

    // Update model.

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        ( *_model->SetParameterVector() )[k].SetValue( ( _model->GetParameterVector() )[k].GetValue() + _randomGenerator.Gaus( 0., 1. ) );

    }

}
