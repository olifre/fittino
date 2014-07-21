/* $Id$ */

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

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <sstream>

#include "TMath.h"
#include "TMatrixD.h"
#include "TMatrixDSym.h"
#include "TMatrixDSymEigen.h"

#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameter.h"
#include "NewCorrelatedSampler.h"
#include "RandomGenerator.h"

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
          _scalingFactor( ptree.get<double>("ScalingFactor", 10.)),
          _acceptedPoints( TMatrixD(_numberOfIterations, _model->GetNumberOfParameters() )),
          _memory( std::queue<std::vector<double> >()),
          _communicationsString(ptree.get<std::string>("CommunicationsFile", "")),
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

          { //Constructor

    _name = "Correlated parameter sampler";
    _numberOfAcceptedPoints = 0;
    _poppedFirst = false;
    _statusParameterVector.push_back( new Quantity( "PointAccepted", "PointAccepted", 0. , 0., 1.) );
    _communicationsPath = _communicationsString.c_str();
    _useCovariance = false;

    //PDF in direction Xi
    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {
        std::ostringstream name1;
        name1 << "StepX" << k+1;
        _statusParameterVector.push_back( new Quantity(name1.str(), name1.str(), 0., 0., 1.) );
    }

    //variances and covariance
    _statusParameterVector.push_back(new Quantity("Sigma1", "Sigma1", 0., 0., 1.));
    _statusParameterVector.push_back(new Quantity("Sigma2", "Sigma2", 0., 0., 1.));
    _statusParameterVector.push_back(new Quantity("Rho", "Rho", 0., 0., 1.));
    _statusParameterVector.push_back(new Quantity("ScalingFactor", "ScalingFactor", _scalingFactor, _scalingFactor, _scalingFactor));
    _statusParameterVector.push_back(new Quantity("MemorySize", "MemorySize", _memorySize, _memorySize, _memorySize));
    _statusParameterVector.push_back(new Quantity("PoppedFirst", "PoppedFirst", 0., 0., 1000.));

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
    ReadCommunicationsFile();
    PrintMatrices();

    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        //std::cout<<"useCovariance = "<<_useCovariance<<" in iteration "<<_iterationCounter<<"\n";
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );

        _chi2 = _model->GetChi2();
        GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );

        //AnalysisTool::PrintStatus();


        this->UpdateModel();
        PrintCommunicationsFile();

    }
    PrintMatrices();
    }

void Fittino::NewCorrelatedSampler::UpdateModel() {


        //UpdateStatusParameters();


        this->FillTree();

        //PrintMatrices();


        this->DoSampling();
        this->FillTree();
        UpdateStatusParameters();


        double chi2 = _model->GetChi2();


        double likelihood = TMath::Exp( -1. * chi2 / 2. );


        bool pointAccepted = false;
        GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );


        double rho = 0.;

        //decide whether point shall be accepted
        if ( _previousLikelihood > 0. ) {

            rho = likelihood / _previousLikelihood;

        }

        if ( rho > 1. ) {

            pointAccepted = true;
            GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

        }
        else {

            double randomThreshold = _randomGenerator->Uniform(0., 1.);
            if ( rho > randomThreshold) {

                pointAccepted = true;
                GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

            }

        }


        if ( pointAccepted ) {

            _previousRho        = rho;
            _previousChi2       = chi2;
            _previousLikelihood = likelihood;

            //store newly accepted point
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _previousParameterValues.at(k) = _model->GetCollectionOfParameters().At( k )->GetValue();


                _acceptedPoints(_numberOfAcceptedPoints, k) = _model->GetCollectionOfParameters().At( k )->GetValue();

            }
            _numberOfAcceptedPoints++;

            //push to queue
            PushNewPoint();
            //std::cout<<_memory.size()<<" points in queue\n";

            //if queue full, pop oldest point
            if(_memory.size() > _memorySize){
                PopOldestPoint();
                _useCovariance = true;
            }

            //some maintenance
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

            //keep last point
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _model->GetCollectionOfParameters().At( k )->SetValue( _previousParameterValues.at(k) );

            }

        }
        //more maintenance
        if(chi2 < 1) _totalPointslt1++;
        else if (chi2 >= 10) _totalPointsge10++;
        else if (chi2 >= 6) _totalPointsge6lt10++;
        else _totalPointsge1lt6++;




    }

void Fittino::NewCorrelatedSampler::PushNewPoint(){

    _memory.push(_previousParameterValues);

    //update covariance matrix
    if(_useCovariance == true){

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

                    _currentExpectationValues[i] = (((_memory.size() - 1) * _currentExpectationValues[i]) + _memory.back()[i]) / _memory.size();
                    for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){
                       _expectationMatrix[i][k] = (((_memory.size() - 1)*_expectationMatrix[i][k]) + (_memory.back()[i] * _memory.back()[k])) / _memory.size();
                       _expectationMatrix[k][i] = _expectationMatrix[i][k];
                    }
                }
                break;


    }
}

void Fittino::NewCorrelatedSampler::PopOldestPoint(){
    //update expectation values
    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

                    _currentExpectationValues[i] = ((_memory.size() * _currentExpectationValues[i]) - _memory.front()[i]) / (_memory.size() - 1);
                    //_currentExpectationValues[i] = ((_memory.size() * _currentExpectationValues[i]) - _previousParameterValues[i]) / (_memory.size() - 1);

                    for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){
                        _expectationMatrix[i][k] = ((_memory.size() * _expectationMatrix[i][k]) - (_memory.front()[i] * _memory.front()[k])) / (_memory.size() - 1);
                        //_expectationMatrix[i][k] = ((_memory.size() * _expectationMatrix[i][k]) - (_previousParameterValues[i] * _previousParameterValues[k])) / (_memory.size() - 1);

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
    if (GetStatusParameterVector()->at(GetStatusParameterVector()->size() - 1)->GetValue() <= 0) GetStatusParameterVector()->at(GetStatusParameterVector()->size() - 1)->SetValue(_iterationCounter);
    _memory.pop();

}

void Fittino::NewCorrelatedSampler::DoSampling(){


    TVectorD y( _model->GetNumberOfParameters() );

    //double scalingFactor = 0.5;


    TMatrixDSym mat(_model->GetNumberOfParameters());

    mat = _covarianceMatrix;

    /*for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
        mat[i][i] = 1;
        for(unsigned int k = i+1; k < _model->GetNumberOfParameters(); k++){
            mat[i][k] = 0;
            mat[k][i] = mat[i][k];
        }
    }*/


    TMatrixDSymEigen covariantEigen = TMatrixDSymEigen((const TMatrixDSym) mat);

    //maintenance
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


    //generate a uniform random step n-dimensional space spanned be EVs of the covariance matrix
   for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++) {

        double newstep = _randomGenerator->Gaus(0., TMath::Sqrt(covariantEigen.GetEigenValues()[i] ) );
        //double newstep = gRandom->Gaus(0., 1.);
        y[i] = newstep * _scalingFactor;
        //_statusParameterVector[i+3]->SetValue(newstep);

   }

    //transform step to R^n
   y = covariantEigen.GetEigenVectors() * y;

    //add to current point
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
        std::cout<<_currentExpectationValues.at(i)<<"\n";
        std::cout<<_currentExpectationValues[i]<<"\n";
    }
    std::cout<<"\n";

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

    PrintItem( "NumberOfIterations",      _numberOfIterations );
    PrintItem( "UpdtateCovariancesAfter", _updateAfter        );
    PrintItem( "MemorySize",              _memorySize         );
    PrintItem( "ScalingFactor",              _scalingFactor         );

}

void Fittino::NewCorrelatedSampler::UpdateStatusParameters(){

    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

        _statusParameterVector[3 + i]->SetValue( _model->GetCollectionOfParameters().At(i)->GetValue() - _previousParameterValues[i] ); //StepXi
        //std::cout<<"1\n";
         _statusParameterVector[3 + _model->GetNumberOfParameters() + i]->SetValue(std::sqrt(_covarianceMatrix[i][i])); //variance sigma_i
        //std::cout<<"2\n";

        }
        //std::cout<<"size of status parameter vector in"<<_iterationCounter<<"th iteration: "<<_statusParameterVector.size()<<"\n";
        _statusParameterVector[3 + 2*_model->GetNumberOfParameters()]->SetValue(_covarianceMatrix[0][1] / (std::sqrt(_covarianceMatrix[0][0]) * std::sqrt(_covarianceMatrix[1][1])));
        //std::cout<<"3\n";

}

void Fittino::NewCorrelatedSampler::PrintCommunicationsFile(){
    std::string s;
    std::vector<std::vector<double> > data;
    std::vector<double> row;
    _communicationsFile.open("testtalk.txt");

    //write current point and covariance matrix into one 2D data vector
    for(int i = 0; i < _model->GetNumberOfParameters(); i++){ //current point first
        row.push_back(_model->GetCollectionOfParameters().At(i)->GetValue());
    }
    data.push_back(row);
    row.clear();
    for(int i = 0; i < _model->GetNumberOfParameters(); i++){ //then covariances
        for(int j = 0; j < _model->GetNumberOfParameters(); j++){
            row.push_back(_covarianceMatrix[i][j]);
        }
        data.push_back(row);
        row.clear();
    }
    for(int i = 0; i < _model->GetNumberOfParameters(); i++){
        for(int j = 0; j < _model->GetNumberOfParameters(); j++){
            row.push_back(_expectationMatrix[i][j]);
        }
        data.push_back(row);
        row.clear();
    }

    //write data to file
    for(int i = 0; i < data.size(); i++){
        for(int j = 0; j < data[i].size(); j++){
            //_communicationsFile<<data[i][j]<<" ";
            std::cout<<data[i][j]<<" ";
        }
        //_communicationsFile<<"\n";
        std::cout<<"\n";
    }

    _communicationsFile.close();

}

void Fittino::NewCorrelatedSampler::ReadCommunicationsFile(){

    _communicationsFile.open("testtalk.txt"); //file "testtalk.txt" must exist in current directory
    std::cout<<"opened file\n";
    std::vector<std::vector<double> > data;
    std::cout<<"made data vector\n";
    std::string line;
    double value;
    int row = 0, col = 0;
    std::cout<<"made more variables\n";
    std::vector<double> newrow;
    //std::getline(_communicationsFile, line);
    //std::cout<<line<<" 1st line\n";

    //read data from file
        while(std::getline(_communicationsFile, line)) {
            std::cout<<line<<" is current line\n";
            std::stringstream ssline(line);
            if(line=="") {std::cout<<"break\n"; break;}
            newrow.clear();
            while(ssline >> value){
                newrow.push_back(value);
            }
            data.push_back(newrow);
            std::cout<<"pushing row: \n";
            for(int i = 0; i < newrow.size(); i++){std::cout<<newrow[i]<<" ";}
            std::cout<<"\n";
            row++;
        }


    //transfer data to parameter vector and matrices
    if(data.size() > 0){
        _useCovariance = true;
        for(int j = 0; j < _model->GetNumberOfParameters(); j++){ //last point from old job
            _model->GetCollectionOfParameters().At(j)->SetValue(data[0][j]);
        }
        std::cout<<"got old point\n";
        for(int i = 0; i < _model->GetNumberOfParameters(); i++){
            for(int j = 0; j < _model->GetNumberOfParameters(); j++){
                _covarianceMatrix[i][j] = data[i+1][j];
                _expectationMatrix[i][j] = data[i+_model->GetNumberOfParameters()][j];
            }
            _currentExpectationValues[i] = _model->GetCollectionOfParameters().At(i)->GetValue();
        }
        std::cout<<"got matrices\n";
    }

    _communicationsFile.close();
    std::cout<<"closed file\n";

}



