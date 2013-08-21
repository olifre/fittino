/* $Id: CovariantSampler.cpp 1319 2013-04-18 16:58:41Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CovariantSampler.cpp                                           *
*                                                                              *
* Description Class for covariant parameter sampler                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>
              Pia Kullik          <kullik@informatik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include "TMath.h"
#include "TMatrixD.h"

#include "Configuration.h"
#include "CovariantSampler.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "ModelCalculatorException.h"
#include <cstdlib>
#include <fstream>

Fittino::CovariantSampler::CovariantSampler( Fittino::ModelBase* model )
        : SamplerBase( model ),
          _previousChi2( 1.e99 ),
          //_previousChi2( model->GetChi2() ),
          _previousLikelihood( 1.e-99 ),
          //_previousLikelihood( TMath::Exp( -1. * _previousChi2 / 2. ) )

          _previousParameterValues( std::vector<double>( _model->GetNumberOfParameters(), 0. ) ),
          _currentExpectationValues( std::vector<double>( _model->GetNumberOfParameters(), 0. ) ),
          _standardDeviations(std::vector<double>( _model->GetNumberOfParameters(), 0. )),
          _covarianceMatrix(TMatrixD(_model->GetNumberOfParameters(), _model->GetNumberOfParameters() )),
          _expectationMatrix(TMatrixD(_model->GetNumberOfParameters(), _model->GetNumberOfParameters() )),
          _previousRho( 1. ),
          _numberOfIterations( Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", 10000 ) ),
          _updateAfter( Configuration::GetInstance()->GetSteeringParameter( "UpdateCovariancesAfter", 10000 )),
          _acceptedPoints(TMatrixD(_numberOfIterations, _model->GetNumberOfParameters() ))
          {

    _name = "Covariant parameter sampler";
    _numberOfAcceptedPoints = 0;

    _statusParameterVector.push_back( new ParameterBase( "PointAccepted", "PointAccepted", 0. , 0., 1.) );
    _statusParameterVector.push_back( new ParameterBase( "StepWidth", "StepWidth", 0. , 0., 1.) );


    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _previousParameterValues.at( k ) = _model->GetParameterVector()->at( k )->GetValue();
        _currentExpectationValues.at( k ) = _model->GetParameterVector()->at(k)->GetValue();
        _covarianceMatrix[k][k] = 1.;
        _expectationMatrix[k][k] = (_currentExpectationValues[k])*(_currentExpectationValues[k]);
        for (unsigned int i = k+1; i < _model->GetNumberOfParameters(); i++ ) {
            _covarianceMatrix[k][i] = 0.;
            _expectationMatrix[k][i] = 0.;
            _covarianceMatrix[i][k] = 0.;
            _expectationMatrix[i][k] = 0.;

        }
        for (unsigned int i = 0; i < _numberOfIterations; i++){
            _acceptedPoints(i, k) = std::numeric_limits<double>::infinity();

        }
    }




}



Fittino::CovariantSampler::~CovariantSampler() {

}

void Fittino::CovariantSampler::UpdateExpectations() {

    // Update expectation values and -matrix.


    switch (_numberOfAcceptedPoints){
        case 0: break;
        case 1: for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

                    _currentExpectationValues[i] = (_currentExpectationValues[i] + _model->GetParameterVector()->at(i)->GetValue()) / 2;
                    for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){
                       _expectationMatrix[i][k] = (_expectationMatrix[i][k] + (_model->GetParameterVector()->at(i)->GetValue() * _model->GetParameterVector()->at(k)->GetValue())) / 2;
                       _expectationMatrix[k][i] = _expectationMatrix[i][k];
                    }
                }
                break;
        default: for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

                    _currentExpectationValues[i] = (((_numberOfAcceptedPoints - 1) * _currentExpectationValues[i]) + _model->GetParameterVector()->at(i)->GetValue()) / _numberOfAcceptedPoints;
                    for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){
                       _expectationMatrix[i][k] = (((_numberOfAcceptedPoints - 1)*_expectationMatrix[i][k]) + (_model->GetParameterVector()->at(i)->GetValue() * _model->GetParameterVector()->at(k)->GetValue())) / _numberOfAcceptedPoints;
                       _expectationMatrix[k][i] = _expectationMatrix[i][k];
                    }
                }
                break;
    }
}


void Fittino::CovariantSampler::UpdateCovarianceMatrix() {

    // Update covariances.

        if(_numberOfAcceptedPoints >= _updateAfter){

        for(unsigned int i=0; i<_model->GetNumberOfParameters(); i++){

            for(unsigned int k=i; k < _model->GetNumberOfParameters(); k++){

            _covarianceMatrix[i][k] = _expectationMatrix[i][k] - (_currentExpectationValues.at(i) * _currentExpectationValues.at(k));
            _covarianceMatrix[k][i] = _covarianceMatrix[i][k];

            }

        }
        }


}



void Fittino::CovariantSampler::UpdateParameters() {

    //Update one parameter at random and all others according to their covariance with it.

    int p = rand() % _model->GetNumberOfParameters();

    double randomStep = 0.1*_randomGenerator.Gaus( 0., _model->GetParameterVector()->at( p)->GetError());
    _model->GetParameterVector()->at(p)->SetValue(_model->GetParameterVector()->at( p )->GetValue() +  randomStep);

    for (unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

        double a = 0.1*_randomGenerator.Gaus( 0., _model->GetParameterVector()->at( i )->GetError());
        if (i != p) {
            _model->GetParameterVector()->at(i)->SetValue(_model->GetParameterVector()->at( i )->GetValue() +  (randomStep*_covarianceMatrix[i][p])*(a*(1-_covarianceMatrix[i][p])));
        }

    }

}

void Fittino::CovariantSampler::Execute() {

    //Execute the Covariant parameter sampler.

    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );

        _chi2 = _model->GetChi2();
        GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );

        AnalysisTool::PrintStatus();


        this->UpdateModel();
        this->UpdateExpectations();
        if (_iterationCounter > _updateAfter) this->UpdateCovarianceMatrix();
        if (_iterationCounter == _numberOfIterations){
            this->CalculateStandardDeviations();
        }
        }








    }





void Fittino::CovariantSampler::CalculateStandardDeviations(){


    //Use the covariance matrix to obtain standard deviations for each parameter:

    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
        _standardDeviations[i] = pow(_covarianceMatrix(i,i), 0.5);
        std::cout<<_model->GetParameterVector()->at(i)->GetName()<<" : "<<_standardDeviations[i]<<"\n";
    }
}


void Fittino::CovariantSampler::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations << Messenger::Endl;

}

void Fittino::CovariantSampler::CalculateStepWidth(){

    //Calculate the distance between each accepted point and its predecessor.

    double step = 0;

    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
        step += pow((_previousParameterValues.at(i) - _model->GetParameterVector()->at(i)->GetValue()), 2);
    }
    GetStatusParameterVector()->at(3)->SetValue(pow(step, 0.5));
}

void Fittino::CovariantSampler::UpdateModel() {

    //try {

        this->FillTree();

        // Update model.

        UpdateParameters();

        // Calculate chi2.

        double chi2 = _model->GetChi2();

        // Calculate likelihood.

        double likelihood = TMath::Exp( -1. * chi2 / 2. );

        // Decide whether point shall be accepted.

        bool pointAccepted = false;
        GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

        double rho = 0.;

        if ( _previousLikelihood > 0. ) {

            rho = likelihood / _previousLikelihood;

        }

        if ( rho > 1. ) {

            pointAccepted = true;
            GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

        }
        else {

            double randomThreshold = _randomGenerator.Uniform( 0., 1. );
            if ( rho > randomThreshold ) {

                pointAccepted = true;
                GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

            }

        }

        if ( pointAccepted ) {

            _previousRho        = rho;

            // Write point into _acceptedPoints.

            for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
                _acceptedPoints(_iterationCounter-1, i) = _model->GetParameterVector()->at(i)->GetValue();
            }

            CalculateStepWidth();

            _numberOfAcceptedPoints++;

        }
        else {

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

    //        _model->SetParameterVector()->at( k )->SetValue( _previousParameterValues.at( k ) );

    //    }
    //
    //}

}
