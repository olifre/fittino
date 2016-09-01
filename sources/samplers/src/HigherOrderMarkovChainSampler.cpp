/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HigherOrderMarkovChainSampler.cpp                                *
*                                                                              *
* Description Extends plain Markov Chain sampling by additionally exploiting   *
*             parameter correlations                                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>

#include "TMath.h"
#include "TMatrixDSymEigen.h"

#include "HigherOrderMarkovChainSampler.h"
#include "ModelBase.h"
#include "ModelParameter.h"
#include "RandomGenerator.h"
#include "SimplePrediction.h"

Fittino::HigherOrderMarkovChainSampler::HigherOrderMarkovChainSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : MarkovChainSampler( model, ptree ),
      _expectationValues( _model->GetNumberOfParameters(), 0. ),
      _covarianceMatrix( _model->GetNumberOfParameters() ),
      _expectationMatrix( _model->GetNumberOfParameters() ),
      _minimalMemorySize( ptree.get<int>( "MinimalMemorySize", 10000 ) ),
      _maximalMemorySize( ptree.get<int>( "MaximalMemorySize", 10000 ) ),
      _scalingFactor( ptree.get<double>( "ScalingFactor", 1 ) ),
      _memorySize( 0 ),
      _memory(),
      _maxCorrelationFactor( ptree.get<double>( "MaxCorrelationFactor", 0.9 ) ) {

    _name = "Correlated parameter sampler";

    PopulateQueue();

    if ( _iterationCounter < _memory.size() ) {

        throw ConfigurationException( "Inconsistency between IterationCounter and size of queue." );

    }

    _statusParameterVector.push_back( new SimplePrediction( "MemorySize", "", _memorySize ) );

    // add the covariance matrix to the vector of status parameters:
    _covarianceMatrixFirstIndex = _statusParameterVector.size();
    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {
        std::string parameterName1 = _model->GetCollectionOfParameters().At( i )->GetName();
        for ( unsigned int k = 0; k <= i; ++k ) {
            std::string parameterName2 = _model->GetCollectionOfParameters().At( k )->GetName();
            _statusParameterVector.push_back( new SimplePrediction( "Cov_" + parameterName1 + "_" + parameterName2, "", _covarianceMatrix[i][k] ) );
        }
    }
    _covarianceMatrixLastIndex = _statusParameterVector.size() - 1;

}

Fittino::HigherOrderMarkovChainSampler::~HigherOrderMarkovChainSampler() {

}

void Fittino::HigherOrderMarkovChainSampler::DepopulateQueue() {

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

void Fittino::HigherOrderMarkovChainSampler::FinalizeStatus() {

    MarkovChainSampler::FinalizeStatus();

    DepopulateQueue();

}

void Fittino::HigherOrderMarkovChainSampler::InitializeMemory() {

    MarkovChainSampler::InitializeMemory();

    if ( _iterationCounter == 1 ) {

        UpdateQueue( GetParameterValuesOfLastAcceptedPoint() );

    }

}

void Fittino::HigherOrderMarkovChainSampler::PopOldestPoint() {

    int newMemorySize = _memory.size() - 1;

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        _expectationValues[i] = _memory.size() * _expectationValues[i] - _memory.front()[i];
        _expectationValues[i] /= newMemorySize;

        for ( unsigned int k = i; k < _model->GetNumberOfParameters(); k++ ) {

            _expectationMatrix[i][k] = _memory.size() * _expectationMatrix[i][k] - _memory.front()[i] * _memory.front()[k];
            _expectationMatrix[i][k] /= newMemorySize;

            _expectationMatrix[k][i] = _expectationMatrix[i][k];

        }

    }

    _memory.pop();

}

void Fittino::HigherOrderMarkovChainSampler::PopulateQueue() {

    if ( !_ptree.count( "Queue" ) ) return;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & entry, _ptree.get_child( "Queue" ) ) {

        if ( entry.first == "Entry" ) {

            UpdateQueue( entry.second );

        }

    }

}

void Fittino::HigherOrderMarkovChainSampler::PrintSteeringParameters() const {

    MarkovChainSampler::PrintSteeringParameters();

    PrintItem( "ScalingFactor",     _scalingFactor     );
    PrintItem( "MinimalMemorySize", _minimalMemorySize );
    PrintItem( "MaximalMemorySize", _maximalMemorySize );

}

void Fittino::HigherOrderMarkovChainSampler::PushNewPoint( std::vector<double> point ) {

    int oldMemorySize = _memory.size();

    _memory.push( point );

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        _expectationValues[i] = oldMemorySize * _expectationValues[i] + _memory.back()[i];
        _expectationValues[i] /= _memory.size();

        for ( unsigned int k = 0; k <= i ; k++ ) {

            _expectationMatrix[i][k] = oldMemorySize * _expectationMatrix[i][k] + _memory.back()[i] * _memory.back()[k];
            _expectationMatrix[i][k] /= _memory.size();

            _expectationMatrix[k][i] = _expectationMatrix[i][k];

        }

    }

}

void Fittino::HigherOrderMarkovChainSampler::UpdateCovarianceMatrix() {

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        for ( unsigned int k = 0; k <= i; k++ ) {

//            std::cout << "calculating new covariance matrix entry " << i << " " << k << " from " << _expectationMatrix[i][k] << " and " << _expectationValues[i] << " * " << _expectationValues[k] << std::endl;
            _covarianceMatrix[i][k] = _expectationMatrix[i][k] - ( _expectationValues[i] * _expectationValues[k] );
            if ( i == k && ( fabs( _covarianceMatrix[i][k] - 0. ) < std::numeric_limits<double>::min() || _covarianceMatrix[i][k] < 0. ) ) {
                int log = ( int )log10( _expectationMatrix[i][k] );
                _covarianceMatrix[i][k] = pow( 10., 1 + log - std::numeric_limits<double>::digits10 );
            }
            _covarianceMatrix[k][i] = _covarianceMatrix[i][k];

        }

    }
    /*
    _covarianceMatrix.Print();
    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {
        std::cout << std::setprecision( 15 ) << "error for parameter " << i << " is " << _covarianceMatrix[i][i] << " which gives " << 1. / sqrt( _covarianceMatrix[i][i] ) << std::endl;
    }
    */
    // first: check if a single uncertainty is smaller than the MinError for that Parameter. If yes, set the uncertainty for that Parameter to the minimum value. keep all correlations factors as is
    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {
        if ( sqrt( _covarianceMatrix[i][i] ) < _model->GetCollectionOfParameters().At( i )->GetMinError() ) {
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); ++k ) {
                if ( k == i ) continue;
                _covarianceMatrix[i][k] /= sqrt( _covarianceMatrix[i][i] );
                _covarianceMatrix[i][k] *= _model->GetCollectionOfParameters().At( i )->GetMinError();
                _covarianceMatrix[k][i] = _covarianceMatrix[i][k];
            }
            _covarianceMatrix[i][i] = _model->GetCollectionOfParameters().At( i )->GetMinError() * _model->GetCollectionOfParameters().At( i )->GetMinError();
        }
    }

    // now check if any correlation factor is > larger than the max allowed;
    int nAboveLimit = 0;
    int nIteration = 0;
    do {

        //std::cout << "in iteration " << nIteration << " for checking" << std::endl;
        nIteration += 1;
        nAboveLimit = 0;
        double maxDeviation = 0.;

        //std::cout << "correlation matrix is " << std::endl;
        //for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {
        //    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {
        //        std::cout << _covarianceMatrix[i][k] / sqrt( _covarianceMatrix[i][i] * _covarianceMatrix[k][k] ) << " ";
        //    }
        //    std::cout << std::endl;
        //}

        for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {
            for ( unsigned int k = 0; k < i; k++ ) {
                double thisRho = _covarianceMatrix[i][k] / sqrt( _covarianceMatrix[i][i] * _covarianceMatrix[k][k] );
                if ( fabs( thisRho ) > _maxCorrelationFactor ) {
                    nAboveLimit += 1;
                    if ( ( fabs( thisRho ) - _maxCorrelationFactor ) > maxDeviation ) maxDeviation = fabs( thisRho ) - _maxCorrelationFactor ;
                }
            }
        }

        if ( nAboveLimit == 0 ) break;
        if ( nAboveLimit == 1 && maxDeviation < 1.e-5 ) break;
        //std::cout << "need to fix the matrix because " << nAboveLimit << " are above the limit with maxDeviation " << maxDeviation  << std::endl;
        // assume the smallest eigenvalue is linear in the maximal correlation factor;
        // EV_min ~ 1 - rho_max
        // ==> change rho_max to rho_max - maxDeviation -> change EV_min to 1 - rho_max + maxDeviation = EV_min_old + maxDeviation;
        int nDim = _model->GetNumberOfParameters();
        TMatrixDSym oldCorrelationMatrix( nDim );
        for ( unsigned int i = 0; i < nDim; ++i ) {
            for ( unsigned int k = 0; k < nDim; ++k ) {
                oldCorrelationMatrix[i][k] = _covarianceMatrix[i][k] / sqrt( _covarianceMatrix[i][i] * _covarianceMatrix[k][k] );
            }
        }

        TMatrixDSymEigen eigenMatrix( oldCorrelationMatrix );
        TMatrixDSym eigenValMatrix( nDim );
        for ( unsigned int i = 0; i < nDim; ++i ) {
            for ( unsigned int k = 0; k < nDim; ++k ) {
                eigenValMatrix[i][k] = ( i == k ) ? eigenMatrix.GetEigenValues()[i] : 0.;
            }
        }

        // change the smallest eigenvalue
        eigenValMatrix[nDim - 1][nDim - 1] = eigenValMatrix[nDim - 1][nDim - 1] + maxDeviation;
        // keep the sum constant;
        for ( unsigned int i = 0; i < nDim - 1; ++i ) {
            eigenValMatrix[i][i] = eigenValMatrix[i][i] - maxDeviation / ( float )( nDim - 1 );
        }

        // now get the old eigenVectors
        TMatrixD eigenVectors = eigenMatrix.GetEigenVectors();
        TMatrixD eigenVectorsInverse = eigenMatrix.GetEigenVectors();
        eigenVectorsInverse.Invert();
        TMatrixD newCorrelationMatrix = eigenVectors * eigenValMatrix * eigenVectorsInverse;

        for ( unsigned int i = 0; i < nDim; ++i ) {
            for ( unsigned int k = i + 1; k < nDim; ++k ) {
                _covarianceMatrix[i][k] = newCorrelationMatrix[i][k] * sqrt( _covarianceMatrix[i][i] * _covarianceMatrix[k][k] );
                _covarianceMatrix[k][i] = _covarianceMatrix[i][k];
            }
        }

    }
    while ( nAboveLimit > 0 );


}

void Fittino::HigherOrderMarkovChainSampler::UpdateMemory() {

    MarkovChainSampler::UpdateMemory();

    UpdateQueue( GetParameterValuesOfLastAcceptedPoint() );

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

    bool isInBounds = false;
    _covarianceMatrix.Print();

    while ( !isInBounds ) {

        TMatrixDSymEigen covariantEigen( _covarianceMatrix );

        TVectorD y( _model->GetNumberOfParameters() );

        for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {
            //std::cout << std::setprecision( 15 ) << "for parameter " << i << " calculating width from " << scalefactor << " * " << covariantEigen.GetEigenValues()[i] << std::endl;
            double width = scalefactor * TMath::Sqrt( covariantEigen.GetEigenValues()[i] );
            y[i] = _randomGenerator->Gaus( 0., width );
            //std::cout << std::setprecision( 15 ) << "threw random number : " << y[i] << std::endl;
        }

        y = covariantEigen.GetEigenVectors() * y;

        for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

            y[i] += GetParameterValuesOfLastAcceptedPoint()[i];
            //std::cout << std::setprecision( 15 ) << "setting parameter " << i << " to value " << y[i] << std::endl;
            _model->GetCollectionOfParameters().At( i )->SetValue( y[i] );

        }

        _strictBounds ? isInBounds = IsInBounds() : isInBounds = true;

    }

}

void Fittino::HigherOrderMarkovChainSampler::UpdateQueue( std::vector<double> point ) {

    PushNewPoint( point );

    if ( _memory.size() > _maximalMemorySize ) PopOldestPoint();

    _memorySize = _memory.size();

}

void Fittino::HigherOrderMarkovChainSampler::UpdateQueue( const boost::property_tree::ptree& entry ) {

    std::vector<double> point;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & value, entry ) {

        if ( value.first == "Value" ) {

            point.push_back( value.second.get_value<double>() );

        }

    }

    if ( point.size() != _model->GetNumberOfParameters() ) {

        throw ConfigurationException( "Entry in queue has wrong number of values." );

    }

    UpdateQueue( point );

}
