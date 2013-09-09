/* $Id$ */

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

#include <cmath>

#include "Configuration.h"
#include "MarkovChainSampler.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "ModelCalculatorException.h"
#include "TTree.h"

Fittino::MarkovChainSampler::MarkovChainSampler( Fittino::ModelBase* model )
    : SamplerBase( model ),
      _previousChi2( 1.e99 ),
      //_previousChi2( model->GetChi2() ),
      _previousLikelihood( 1.e-99 ),
      //_previousLikelihood( exp( -1. * _previousChi2 / 2. ) ),
      _previousParameterValues( std::vector<double>( model->GetNumberOfParameters(), 0. ) ),
      _acceptCounter( 1 ),
      _previousRho( 1. ),
      _numberOfIterations( Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", 10000 ) ) {

    _name = "Markov chain parameter sampler";

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _previousParameterValues.at( k ) = _model->GetParameterVector()->at( k )->GetValue();

    }

    _statusParameterVector.push_back( new ParameterBase( "PointAccepted", "PointAccepted", 0. , 0., 1. ) );

}

Fittino::MarkovChainSampler::~MarkovChainSampler() {

}

void Fittino::MarkovChainSampler::Execute() {


    _branchPointAccepted = _tree->GetBranch( "PointAccepted" );
    _branchPointAccepted->SetStatus( 0 );

    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );

        _chi2 = _model->GetChi2();
        GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );

        AnalysisTool::PrintStatus();

        this->UpdateModel();

    }
    _branchPointAccepted->SetStatus( 1 );
}

void Fittino::MarkovChainSampler::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations << Messenger::Endl;

}

void Fittino::MarkovChainSampler::UpdateModel() {

    //try {

    //this->FillTree();

    // Update model.

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _model->GetParameterVector()->at( k )->SetValue( _model->GetParameterVector()->at( k )->GetValue() + _randomGenerator.Gaus( 0., _model->GetParameterVector()->at( k )->GetError() ) );

    }

    // Calclate chi2.

    double chi2 = _model->GetChi2();

    // Calculate likelihood.

    double likelihood = exp( -1. * chi2 / 2. );

    // Decide whether point shall be accepted.

    bool pointAccepted = false;
    //GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

    double rho = 0.;

    if ( _previousLikelihood > 0. ) {

        rho = likelihood / _previousLikelihood;

    }

    if ( rho > 1. ) {

        pointAccepted = true;
        //GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

    } else {

        double randomThreshold = _randomGenerator.Uniform( 0., 1. );
        if ( rho > randomThreshold ) {

            pointAccepted = true;
            //GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

        }

    }

    // Further check if any parameter value is out of bounds.

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        if (    _model->GetParameterVector()->at( k )->GetValue() < _model->GetParameterVector()->at( k )->GetLowerBound()
                || _model->GetParameterVector()->at( k )->GetValue() > _model->GetParameterVector()->at( k )->GetUpperBound() ) {

            pointAccepted = false;
            //GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );
            break;

        }

    }

    if ( pointAccepted || _iterationCounter == _numberOfIterations ) {

        _previousRho        = rho;
        _previousChi2       = chi2;
        _previousLikelihood = likelihood;
        for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

            _previousParameterValues.at( k ) = _model->GetParameterVector()->at( k )->GetValue();

        }
        this->FillTree();

        if( _iterationCounter == 1 ) return;
        if( !pointAccepted ) _acceptCounter++;

        _branchPointAccepted->SetStatus( 1 );
        GetStatusParameterVector()->at( 2 )->SetValue( _acceptCounter );
        _leafVector[2 + _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters() + _model->GetNumberOfPredictions()] = ( float )_acceptCounter;
        _branchPointAccepted->Fill();

        GetStatusParameterVector()->at( 2 )->SetValue( 0. );
        _leafVector[2 + _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters() + _model->GetNumberOfPredictions()] = 0.;
        for( unsigned int j = 0; j < _acceptCounter - 1; j++ ) {
            _branchPointAccepted->Fill();
        }

        if( pointAccepted && _iterationCounter == _numberOfIterations ) {
            GetStatusParameterVector()->at( 2 )->SetValue( 1. );
            _leafVector[2 + _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters() + _model->GetNumberOfPredictions()] = 1.;
            _branchPointAccepted->Fill();
        }

        _acceptCounter = 1;
        _branchPointAccepted->SetStatus( 0 );

    } else {

        // save point and increment counter for last accepted point.
        this->FillTree();
        _acceptCounter++;

        // Reset the parameter values.

        for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

            _model->GetParameterVector()->at( k )->SetValue( _previousParameterValues.at( k ) );

        }

    }

    //}
    //catch ( const ModelCalculatorException& modelCalculatorException ) {

    //    std::cout << "\n" << modelCalculatorException.what() << "\n" << std::endl;
    //
    //    // Reset the parameter values.

    //    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

    //        _model->GetParameterVector()->at( k )->SetValue( _previousParameterValues.at( k ) );

    //    }
    //
    //}

}
