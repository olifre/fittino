/* $Id: NewCorrelatedSampler.cpp 1319 2013-04-18 16:58:41Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        NewCorrelatedSampler.cpp                                            *
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
#include "NewCorrelatedSampler.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include <cstdlib>
#include <fstream>
#include <sstream>

Fittino::NewCorrelatedSampler::NewCorrelatedSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
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
          _memorySize( ptree.get<int>( "MemorySize", 10000 ) ),
          _acceptedPoints( TMatrixD(_numberOfIterations, _model->GetNumberOfParameters() )),
          _memory( std::queue<std::vector<double> >()),
          _maxEigenValue(0),
          _minEigenValue(1),
          _avgEigenValue(0),
          _accPointslt1(0),
          _accPointsge10(0),
          _accPointsge6lt10(0),
          _accPointsge1lt6(0),
          _totalPointslt1(0),
          _totalPointsge10(0),
          _totalPointsge6lt10(0),
          _totalPointsge1lt6(0)

          {

    _name = "Correlated parameter sampler";
    _numberOfAcceptedPoints = 0;
    _poppedFirst = false;
    _statusParameterVector.push_back( new Quantity( "PointAccepted", "PointAccepted", 0. , 0., 1.) );

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {
        std::ostringstream name;
        name << "StepX" << k+1;
        _statusParameterVector.push_back( new Quantity(name.str(), name.str(), 0., 0., 1.) );
    }


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

Fittino::NewCorrelatedSampler::~NewCorrelatedSampler() {

}




void Fittino::NewCorrelatedSampler::Execute() {

    this->FillMetaDataTree();

    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );

        _chi2 = _model->GetChi2();
        GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );

        AnalysisTool::PrintStatus();


        this->UpdateModel();
        if(_poppedFirst){
            std::cout<<_iterationCounter;
            _poppedFirst = false;
        }


        }

    std::cout<<_totalPointslt1<<"\n";
    std::cout<<_totalPointsge1lt6<<"\n";
    std::cout<<_totalPointsge6lt10<<"\n";
    std::cout<<_totalPointsge10<<"\n\n";

    std::cout<<_accPointslt1<<"\n";
    std::cout<<_accPointsge1lt6<<"\n";
    std::cout<<_accPointsge6lt10<<"\n";
    std::cout<<_accPointsge10<<"\n\n";

    std::cout<<_minX1<<"\n";
    std::cout<<_maxX1<<"\n";
    std::cout<<_minX2<<"\n";
    std::cout<<_maxX2<<"\n\n";








    }

void Fittino::NewCorrelatedSampler::UpdateModel() {


        this->FillTree();


        this->DoSampling();


        double chi2 = _model->GetChi2();


        double likelihood = TMath::Exp( -1. * chi2 / 2. );


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

            double randomThreshold = _randomGenerator.Uniform(0., 1.);
            if ( rho > randomThreshold) {

                pointAccepted = true;
                GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

            }

        }

        if ( pointAccepted ) {

            _previousRho        = rho;
            _previousChi2       = chi2;
            _previousLikelihood = likelihood;
            CalculateStepWidths();
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _previousParameterValues.at(k) = _model->GetCollectionOfParameters().At( k )->GetValue();


                _acceptedPoints(_numberOfAcceptedPoints, k) = _model->GetCollectionOfParameters().At( k )->GetValue();

            }
            _numberOfAcceptedPoints++;
            PushNewPoint();

            if(_memory.size() > _memorySize) PopOldestPoint();

            if(chi2 < 1) _accPointslt1++;
            else if (chi2 >= 10) _accPointsge10++;
            else if (chi2 >= 6) _accPointsge6lt10++;
            else _accPointsge1lt6++;

            if(_model->GetCollectionOfParameters().At( 0)->GetValue() < _minX1) _minX1 = _model->GetCollectionOfParameters().At( 0)->GetValue();
            if(_model->GetCollectionOfParameters().At( 1)->GetValue() < _minX2) _minX2 = _model->GetCollectionOfParameters().At( 1)->GetValue();
            if(_model->GetCollectionOfParameters().At( 0)->GetValue() > _maxX1) _maxX1 = _model->GetCollectionOfParameters().At( 0)->GetValue();
            if(_model->GetCollectionOfParameters().At( 1)->GetValue() > _maxX2) _maxX2 = _model->GetCollectionOfParameters().At( 1)->GetValue();




        }
        else {


            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _model->GetCollectionOfParameters().At( k )->SetValue( _previousParameterValues.at(k) );

            }

        }
        if(chi2 < 1) _totalPointslt1++;
        else if (chi2 >= 10) _totalPointsge10++;
        else if (chi2 >= 6) _totalPointsge6lt10++;
        else _totalPointsge1lt6++;




    }

void Fittino::NewCorrelatedSampler::PushNewPoint(){

    _memory.push(_previousParameterValues);

    //update covariance matrix
    if(_numberOfAcceptedPoints >= _updateAfter){

        for(unsigned int i=0; i<_model->GetNumberOfParameters(); i++){

            for(unsigned int k=0; k<=i; k++){

            _covarianceMatrix[i][k] = _expectationMatrix[i][k] - (_currentExpectationValues.at(i) * _currentExpectationValues.at(k));
            _covarianceMatrix[k][i] = _covarianceMatrix[i][k];

            }

            _standardDeviations[i] = pow(_covarianceMatrix[i][i], 0.5);

        }
    }
        //update expectation values
    switch (_memory.size()){
        case 0: break;
        case 1: for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

                    _currentExpectationValues[i] = _model->GetCollectionOfParameters().At( i)->GetValue();
                    for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){
                       _expectationMatrix[i][k] = (_model->GetCollectionOfParameters().At( i)->GetValue() * _model->GetCollectionOfParameters().At( k )->GetValue());
                       _expectationMatrix[k][i] = _expectationMatrix[i][k];
                    }
                }
                break;
        default: for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

                    _currentExpectationValues[i] = (((_memory.size() - 1) * _currentExpectationValues[i]) + _model->GetCollectionOfParameters().At( i)->GetValue()) / _memory.size();
                    for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){
                       _expectationMatrix[i][k] = (((_memory.size() - 1)*_expectationMatrix[i][k]) + (_model->GetCollectionOfParameters().At( i)->GetValue() * _model->GetCollectionOfParameters().At( k )->GetValue())) / _memory.size();
                       _expectationMatrix[k][i] = _expectationMatrix[i][k];
                    }
                }
                break;


    }
}

void Fittino::NewCorrelatedSampler::PopOldestPoint(){
    //update expectation values
    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

                    //_currentExpectationValues[i] = ((_memory.size() * _currentExpectationValues[i]) - _model->GetCollectionOfParameters().At( i)->GetValue()) / (_memory.size() - 1);
                    _currentExpectationValues[i] = ((_memory.size() * _currentExpectationValues[i]) - _previousParameterValues[i]) / (_memory.size() - 1);

                    for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){
                        //_expectationMatrix[i][k] = ((_memory.size() * _expectationMatrix[i][k]) - (_model->GetCollectionOfParameters().At( i)->GetValue() * _model->GetCollectionOfParameters().At( k )->GetValue())) / (_memory.size() - 1);
                        _expectationMatrix[i][k] = ((_memory.size() * _expectationMatrix[i][k]) - (_previousParameterValues[i] * _previousParameterValues[k])) / (_memory.size() - 1);

                        _expectationMatrix[k][i] = _expectationMatrix[i][k];
                    }
                }
    //update covariance matrix
    for(unsigned int i=0; i<_model->GetNumberOfParameters(); i++){

            for(unsigned int k=0; k<=i; k++){

            _covarianceMatrix[i][k] = _expectationMatrix[i][k] - (_currentExpectationValues.at(i) * _currentExpectationValues.at(k));
            _covarianceMatrix[k][i] = _covarianceMatrix[i][k];

            }

            _standardDeviations[i] = pow(_covarianceMatrix[i][i], 0.5);

        }

    _memory.pop();

}

void Fittino::NewCorrelatedSampler::DoSampling(){


    TVectorD y( _model->GetNumberOfParameters() );

    double scalingFactor = 1.;


    TMatrixDSym mat(_model->GetNumberOfParameters());

    mat = _covarianceMatrix * scalingFactor;

    /*for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
        mat[i][i] = 1;
        for(unsigned int k = i+1; k < _model->GetNumberOfParameters(); k++){
            mat[i][k] = 0;
            mat[k][i] = mat[i][k];
        }
    }*/


    TMatrixDSymEigen covariantEigen = TMatrixDSymEigen((const TMatrixDSym) mat);
    double max = 0, min = 1.;
    _avgEigenValue = 0.;
    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
        if (abs(covariantEigen.GetEigenValues()[i]) > max) max = abs(covariantEigen.GetEigenValues()[i]);
        if (abs(covariantEigen.GetEigenValues()[i]) < min) min = abs(covariantEigen.GetEigenValues()[i]);
        _avgEigenValue += covariantEigen.GetEigenValues()[i];

    }
    if(_maxEigenValue < max) _maxEigenValue = max;
    if(_minEigenValue < min) _maxEigenValue = min;
    _avgEigenValue /= _model->GetNumberOfParameters();



   for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++) {

        double newstep = gRandom->Gaus(0., TMath::Sqrt(covariantEigen.GetEigenValues()[i] ) );
        //double newstep = gRandom->Gaus(0., 1.);
        y[i] = newstep;
        //_statusParameterVector[i+3]->SetValue(newstep);

   }


   y = covariantEigen.GetEigenVectors() * y;


   for (unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
       //y[i] += _currentExpectationValues.at(i);
       y[i] += _model->GetCollectionOfParameters().At( i)->GetValue();
       _model->GetCollectionOfParameters().At(i)->SetValue(y[i]);
   }

    if (_iterationCounter==_updateAfter-1){
        for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
            for(unsigned int k = 0; k < _model->GetNumberOfParameters(); k++){
                //std::cout<<"  "<<covariantEigen.GetEigenVectors()[i][k];
            }
            //std::cout<<"   //   "<<covariantEigen.GetEigenValues()[i]<<"\n";
        }
    }
}




void Fittino::NewCorrelatedSampler::PrintMatrices(){

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

void Fittino::NewCorrelatedSampler::CalculateStandardDeviations(){

    std::cout<<"Standard deviations:\n";

    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
        _standardDeviations[i] = pow(_covarianceMatrix(i,i), 0.5);
        std::cout<<_model->GetCollectionOfParameters().At(i)->GetName()<<" : "<<_standardDeviations[i]<<"\n";
    }
}

void Fittino::NewCorrelatedSampler::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Number of iterations     : " << _numberOfIterations << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Update covariances after : " << _updateAfter << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Memory size              : " << _memorySize << Messenger::Endl;



}

void Fittino::NewCorrelatedSampler::CalculateStepWidths(){

    for(unsigned int i = 3; i < _statusParameterVector.size(); i++){
        _statusParameterVector[i]->SetValue( _model->GetCollectionOfParameters().At(i-3)->GetValue() - _previousParameterValues[i-3] );
    }

}




