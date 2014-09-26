/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HigherOrderMarkovChainSampler.cpp                                *
*                                                                              *
* Description Class for covariant parameter sampler                            *
*                                                                              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>

#include "TMath.h"
#include "TMatrixDSymEigen.h"

#include "HigherOrderMarkovChainSampler.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameter.h"
#include "RandomGenerator.h"

Fittino::HigherOrderMarkovChainSampler::HigherOrderMarkovChainSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
        : MarkovChainSampler( model, ptree ),
          _expectationValues( std::vector<double>( _model->GetNumberOfParameters(), 0. ) ),
          _covarianceMatrix( _model->GetNumberOfParameters() ),
          _expectationMatrix( _model->GetNumberOfParameters() ),
          _minimalMemorySize( ptree.get<int>( "MinimalMemorySize", 10000 ) ),
          _maximalMemorySize( ptree.get<int>( "MaximalMemorySize", 10000 ) ),
          _scalingFactor( ptree.get<double>( "ScalingFactor", 1) ),
          _memory( std::queue<std::vector<double> >() ) {

    _name = "Correlated parameter sampler";

    FillQueue();

    if ( _iterationCounter < _memory.size() ) {

      throw ConfigurationException( "Inconsistency between IterationCounter and size of queue." );
      
    }

}

Fittino::HigherOrderMarkovChainSampler::~HigherOrderMarkovChainSampler() {

}

void Fittino::HigherOrderMarkovChainSampler::UpdateQueue( const boost::property_tree::ptree& entry ){ 

    std::vector<double> point;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & value, entry ) {
      
      if ( value.first == "Value" ) {

        point.push_back( value.second.get_value<double>() );

      }        

    }

    if ( point.size() != _model->GetNumberOfParameters() ) {

      throw ConfigurationException("Entry in queue has wrong number of values.");

    }

    UpdateQueue( point );

} 

void Fittino::HigherOrderMarkovChainSampler::FillQueue() { 

  if ( !_ptree.count( "Queue" ) ) return;
    
  BOOST_FOREACH( const boost::property_tree::ptree::value_type & entry, _ptree.get_child( "Queue" ) ) {

    if ( entry.first == "Entry" ) {

      UpdateQueue( entry.second );

    }

  }

}

void Fittino::HigherOrderMarkovChainSampler::EmptyQueue() {
    
    boost::property_tree::ptree queue;

    while ( ! _memory.empty() ) {

        boost::property_tree::ptree entry;

        for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {
          
            double value = _memory.front()[i];

            entry.add( "Value", value );

        }

        queue.add_child( "Entry", entry );

        _memory.pop();

    }

    _ptree.put_child( "Queue", queue );

}

void Fittino::HigherOrderMarkovChainSampler::InitializeMemory(){

  MarkovChainSampler::InitializeMemory();

    if ( _iterationCounter == 1 ){
      
        UpdateQueue( GetParameterValuesOfLastAcceptedPoint() );

    }

}

void Fittino::HigherOrderMarkovChainSampler::UpdateQueue( std::vector<double> point ) {

    PushNewPoint( point );

    if( _memory.size() > _maximalMemorySize ) PopOldestPoint();

}

void Fittino::HigherOrderMarkovChainSampler::UpdateMemory() {

    MarkovChainSampler::UpdateMemory();

    UpdateQueue( GetParameterValuesOfLastAcceptedPoint() );

}

void Fittino::HigherOrderMarkovChainSampler::PushNewPoint( std::vector<double> point) {

    int oldMemorySize = _memory.size();

    _memory.push( point );

    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){
    
      _expectationValues[i] = oldMemorySize * _expectationValues[i] + _memory.back()[i];
      _expectationValues[i] /= _memory.size(); 
      
      for( unsigned int k = 0; k <= i ; k++ ) {

        _expectationMatrix[i][k] = oldMemorySize * _expectationMatrix[i][k] + _memory.back()[i] * _memory.back()[k];
        _expectationMatrix[i][k] /= _memory.size();
        
        _expectationMatrix[k][i] = _expectationMatrix[i][k];
        
      }
       
    }
    
}

void Fittino::HigherOrderMarkovChainSampler::PopOldestPoint() {

   int newMemorySize = _memory.size() - 1;

    for(unsigned int i = 0; i < _model->GetNumberOfParameters(); i++){

      _expectationValues[i] = _memory.size() * _expectationValues[i] - _memory.front()[i]; 
      _expectationValues[i] /= newMemorySize;

      for(unsigned int k = i; k < _model->GetNumberOfParameters(); k++){

        _expectationMatrix[i][k] = _memory.size() * _expectationMatrix[i][k] - _memory.front()[i] * _memory.front()[k];
        _expectationMatrix[i][k] /= newMemorySize;

        _expectationMatrix[k][i] = _expectationMatrix[i][k];

      }

    }

    _memory.pop();

}

void Fittino::HigherOrderMarkovChainSampler::UpdateCovarianceMatrix() {

    for( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

      for( unsigned int k = 0; k <= i; k++ ) {

        _covarianceMatrix[i][k] = _expectationMatrix[i][k] - ( _expectationValues[i] * _expectationValues[k] );
        _covarianceMatrix[k][i] = _covarianceMatrix[i][k];

      }

    }

}

void Fittino::HigherOrderMarkovChainSampler::UpdateParameterValues( double scalefactor ) {

    if ( _memory.size() < _minimalMemorySize ) {

        MarkovChainSampler::UpdateParameterValues( scalefactor );

  }
  else {

      UpdateCovarianceMatrix();
      UpdateParameterValuesUsingCovariance( scalefactor * _scalingFactor );

  }

}

void Fittino::HigherOrderMarkovChainSampler::UpdateParameterValuesUsingCovariance( double scalefactor ) {

    TMatrixDSym mat( _model->GetNumberOfParameters() );

    mat = _covarianceMatrix * TMath::Power( scalefactor, 2 );

    TMatrixDSymEigen covariantEigen = TMatrixDSymEigen( mat );

    TVectorD y( _model->GetNumberOfParameters() );

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++) {

      y[i] = _randomGenerator->Gaus(0., TMath::Sqrt(covariantEigen.GetEigenValues()[i] ) );

    }

    y = covariantEigen.GetEigenVectors() * y;

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ){
    
      y[i] += GetParameterValuesOfLastAcceptedPoint()[i];

      _model->GetCollectionOfParameters().At(i)->SetValue( y[i] );
      
    }

}

void Fittino::HigherOrderMarkovChainSampler::PrintSteeringParameters() const {

    MarkovChainSampler::PrintSteeringParameters();

    PrintItem( "ScalingFactor",           _scalingFactor            );
    PrintItem( "MinimalMemorySize",       _minimalMemorySize        );
    PrintItem( "MaximalMemorySize",       _maximalMemorySize        );

}

void Fittino::HigherOrderMarkovChainSampler::FinalizeStatus() {

    MarkovChainSampler::FinalizeStatus();

    EmptyQueue();

}
