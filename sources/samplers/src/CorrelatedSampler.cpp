/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CorrelatedSampler.cpp                                            *
*                                                                              *
* Description Class for covariant parameter sampler                            *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>
              Pia Kullik          <kullik@informatik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of       *
*	      the License, or (at your option) any later version.                  *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include "TMath.h"
#include "TMatrixD.h"
#include "TMatrixDSym.h"
#include "TMatrixDSymEigen.h"


#include "CorrelatedSampler.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameter.h"
#include <cstdlib>
#include <fstream>

Fittino::CorrelatedSampler::CorrelatedSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : SamplerBase( model, ptree ),
          _previousChi2( 1.e99 ),
          //_previousChi2( model->GetChi2() ),
          _previousLikelihood( 1.e-99 ),
          //_previousLikelihood( TMath::Exp( -1. * _previousChi2 / 2. ) )
          _iterationCounter(0),
          _previousParameterValues( std::vector<double>( _model->GetNumberOfParameters(), 0. ) ),
          _currentExpectationValues( std::vector<double>( _model->GetNumberOfParameters(), 0. ) ),
          _standardDeviations(std::vector<double>( _model->GetNumberOfParameters(), 1. )),
          _covarianceMatrix(TMatrixDSym( _model->GetNumberOfParameters())),
          _expectationMatrix(TMatrixDSym(_model->GetNumberOfParameters())),
          _previousRho( 1. ),
          _numberOfIterations( ptree.get<int>( "NumberOfIterations", 10000 ) ),
          _updateAfter( ptree.get<int>( "UpdateCovariancesAfter", 10000 ) ),
          _acceptedPoints(TMatrixD(_numberOfIterations, _model->GetNumberOfParameters() ))
          {

    _name = "Correlated parameter sampler";
    _numberOfAcceptedPoints = 0;

    _statusParameterVector.push_back( new Quantity( "PointAccepted", "PointAccepted", 0. , 0., 1.) );
    _statusParameterVector.push_back( new Quantity( "StepWidth", "StepWidth", 0. , 0., 1.) );



    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _previousParameterValues.at( k ) = _model->GetCollectionOfParameters().At( k )->GetValue();
        _currentExpectationValues.at( k ) = _model->GetCollectionOfParameters().At( k )->GetValue();
        _covarianceMatrix[k][k] = 1.;
        _expectationMatrix[k][k] = (_currentExpectationValues[k])*(_currentExpectationValues[k]);
        for (unsigned int i = k+1; i < _model->GetNumberOfParameters(); i++ ) {
            _covarianceMatrix[k][i] = 0.;
            _expectationMatrix[k][i] = 0.;
            _covarianceMatrix[i][k] = 0.;
            _expectationMatrix[i][k] = 0.;

        }
        for (unsigned int i = 0; i < _numberOfIterations; i++){
            _acceptedPoints[i][k] = std::numeric_limits<double>::infinity();

        }
    }



}


void Fittino::CorrelatedSampler::DoSampling(){

    /*
    Sample parameter space using a correlated Gaussian distribution.
    */


    TVectorD y( _model->GetNumberOfParameters() );

    //Type "1" to use correlation or "0" to ignore correlations and simulate the regular Markov Chain parameter sampler.

    int useCorrelation = 1;
    TMatrixDSym mat(_model->GetNumberOfParameters());

    switch(useCorrelation){
        case 1: { mat = _covarianceMatrix; break;}

        case 0: {   for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++) {
                        for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++) {
                            mat[i][k] = 0;
                        }
                        mat[i][i] = 1;
                    }
                    break;
                }
    }

    TMatrixDSymEigen covariantEigen = TMatrixDSymEigen((const TMatrixDSym) mat);
    TVectorD increments(_model->GetNumberOfParameters());

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++) {
        increments[k] = mat[k][k];
    }

    for(unsigned int j = 0; j < covariantEigen.GetEigenValues().GetNoElements(); j++){
        if (_iterationCounter <= 20 ) std::cout<<"Eigenvalue "<<j<<" : "<<covariantEigen.GetEigenValues()[j]<<"\n";
    }




/*
TO DO:

- figure out how to force positive eigenvalues while keeping the eigenvectors intact (see while loop below).
- find out why the negative eigenvalues only appear if updateAfter is < 3.

*/
    while(covariantEigen.GetEigenValues().Min() < 0){

        // ???
    }

   for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++) {


        y[i] = gRandom->Gaus(0., TMath::Sqrt( covariantEigen.GetEigenValues()[i] ) );
   }


   y = covariantEigen.GetEigenVectors() * y;


   for (unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
       y[i] += _currentExpectationValues.at(i);
       _model->GetCollectionOfParameters().At(i)->SetValue(y[i]);
   }

}

void Fittino::CorrelatedSampler::PrintMatrices(){

    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

        for(unsigned int j = 0; j < _model->GetNumberOfParameters(); j++){

            std::cout<<_covarianceMatrix[i][j]<<" ";

        }

        std::cout<<"    ||    ";

        for(unsigned int k = 0; k < _model->GetNumberOfParameters(); k++){

            std::cout<<_expectationMatrix[i][k]<<" ";

        }

        std::cout<<"\n";
    }
    std::cout<<"------------------------\n";

}

Fittino::CorrelatedSampler::~CorrelatedSampler() {

}

void Fittino::CorrelatedSampler::UpdateExpectations() {

    // Update expectation values and -matrix.


    switch (_numberOfAcceptedPoints){
        case 0: break;
        case 1: for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

                    _currentExpectationValues[i] = (_currentExpectationValues[i] + _model->GetCollectionOfParameters().At(i)->GetValue()) / 2;
                    for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){
                       _expectationMatrix[i][k] = (_expectationMatrix[i][k] + (_model->GetCollectionOfParameters().At(i)->GetValue() * _model->GetCollectionOfParameters().At(k)->GetValue())) / 2;
                       _expectationMatrix[k][i] = _expectationMatrix[i][k];
                    }
                }
                break;
        default: for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

                    _currentExpectationValues[i] = (((_numberOfAcceptedPoints - 1) * _currentExpectationValues[i]) + _model->GetCollectionOfParameters().At(i)->GetValue()) / _numberOfAcceptedPoints;
                    for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){
                       _expectationMatrix[i][k] = (((_numberOfAcceptedPoints - 1)*_expectationMatrix[i][k]) + (_model->GetCollectionOfParameters().At(i)->GetValue() * _model->GetCollectionOfParameters().At(k)->GetValue())) / _numberOfAcceptedPoints;
                       _expectationMatrix[k][i] = _expectationMatrix[i][k];
                    }
                }
                break;
    }
}

void Fittino::CorrelatedSampler::UpdateCovarianceMatrix() {

    //Update covariance matrix and standard deviations.

    if(_numberOfAcceptedPoints >= 2){

        for(unsigned int i=0; i<_model->GetNumberOfParameters(); i++){

            for(unsigned int k=0; k<=i; k++){

            _covarianceMatrix[i][k] = _expectationMatrix[i][k] - (_currentExpectationValues.at(i) * _currentExpectationValues.at(k));
            _covarianceMatrix[k][i] = _covarianceMatrix[i][k];

            }

            _standardDeviations[i] = pow(_covarianceMatrix[i][i], 0.5);

        }
    }

}

void Fittino::CorrelatedSampler::Execute() {

    //Execute the Correlated parameter sampler
    this -> FillMetaDataTree();

    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );

        _chi2 = _model->GetChi2();
        GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );

        AnalysisTool::PrintStatus();


        this->UpdateModel();
        this->UpdateCovarianceMatrix();
        this->UpdateExpectations();
        if(_iterationCounter <= 20) this->PrintMatrices();
        if(_iterationCounter == _numberOfIterations){
            CalculateStandardDeviations();
        }





    }




}

void Fittino::CorrelatedSampler::CalculateStandardDeviations(){


    //Use the covariance matrix to obtain standard deviations for each parameter:

    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
        _standardDeviations[i] = pow(_covarianceMatrix(i,i), 0.5);
        std::cout<<_model->GetCollectionOfParameters().At(i)->GetName()<<" : "<<_standardDeviations[i]<<"\n";
    }
}





void Fittino::CorrelatedSampler::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations << Messenger::Endl;

}


void Fittino::CorrelatedSampler::CalculateStepWidth(){

    //Calculate the distance between each accepted point and its predecessor.

    double step = 0;
    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
        step += pow((_previousParameterValues.at(i) - _model->GetCollectionOfParameters().At(i)->GetValue()), 2);
    }
    GetStatusParameterVector()->at(3)->SetValue(pow(step, 0.5));
}


void Fittino::CorrelatedSampler::UpdateModel() {

    //try {

        this->FillTree();

        // Update model.

        this->DoSampling();

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
            if ( rho > 0.1*randomThreshold ) {

                pointAccepted = true;
                GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

            }

        }

        if ( pointAccepted ) {

            _previousRho        = rho;
            _previousChi2       = chi2;
            _previousLikelihood = likelihood;
            CalculateStepWidth();
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _previousParameterValues.at( k ) = _model->GetCollectionOfParameters().At( k )->GetValue();

                // Write point into _acceptedPoints.

                _acceptedPoints(_numberOfAcceptedPoints, k) = _model->GetCollectionOfParameters().At( k )->GetValue();

            }
            _numberOfAcceptedPoints++;

        }
        else {

            // Reset the parameter values.

            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _model->GetCollectionOfParameters().At( k )->SetValue( _previousParameterValues.at( k ) );

            }

        }
    }
