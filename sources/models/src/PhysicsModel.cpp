/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsModel.cpp                                                 *
*                                                                              *
* Description Base class for Fittino physics models                            *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*             Matthias Hamer        <mhamer@gwdg.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>

#include <cmath>

#include "Factory.h"
#include "Messenger.h"
#include "CalculatorBase.h"
#include "CalculatorException.h"
#include "Observable.h"
#include "PhysicsModel.h"
#include "ModelParameter.h"
#include "ReferenceVariable.h"
#include "PredictionBase.h"
#include "SimplePrediction.h"
#include "Collection.h"
#include "TreeCalculator.h"
#include "AstroCalculator.h"
#include "TMatrixDSym.h"
#include "TMatrixDSymEigen.h"
#include "TVectorD.h"
#include "RandomGenerator.h"
#include "RandomGenerator.h"


Fittino::PhysicsModel::PhysicsModel( const boost::property_tree::ptree& ptree )
    : ModelBase( ptree ) {

    _name       = ptree.get<std::string>( "Name" );
    _randomSeed = ptree.get<bool>       ( "RandomSeed", 0 );


    _collectionOfStringVariables.AddElement( "Calculator", new ReferenceVariable<std::string>( "Calculator", _calculator ) );
    _collectionOfStringVariables.AddElement( "Error"     , new ReferenceVariable<std::string>( "Error", _error ) );

    Factory factory;

    InitializeCalculators( ptree );
    InitializeObservables( ptree );

    for ( unsigned int i = 0; i < GetObservableVector()->size(); ++i ) {

        std::string measuredValueBranchName = "measuredValue_" + GetObservableVector()->at( i )->GetPrediction()->GetName();
        std::string uncertaintyBranchName = "uncertainty_" + GetObservableVector()->at( i )->GetPrediction()->GetName();
        
        _collectionOfMetaDataDoubleVariables.AddElement( measuredValueBranchName,
                                                         new ReferenceVariable<double>( measuredValueBranchName,
                                                                                        GetObservableVector()->at( i )->GetMeasuredValue() ) );
        
        _collectionOfMetaDataDoubleVariables.AddElement( uncertaintyBranchName,
                                                         new ReferenceVariable<double>( uncertaintyBranchName,
                                                                                        GetObservableVector()->at( i )->GetMeasuredError() ) );

    }

    InitializeCovarianceMatrix( ptree );
    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "Chi2Contribution" ) AddChi2Contribution( node.second.get_value<std::string>() );

    }

    Initialize();

}

Fittino::PhysicsModel::~PhysicsModel() {

}


void Fittino::PhysicsModel::AddChi2Contribution( const std::string& name ) {

    _collectionOfChi2Quantities.AddElement( GetCollectionOfQuantities().At( name ) );

}


double Fittino::PhysicsModel::Evaluate() {

    _calculator = "";
    _error      = "";

    // Let the calculators calculate the model predictions.

    try {

        for ( unsigned int i = 0; i < _collectionOfCalculators.GetNumberOfElements(); ++i ) {

            _collectionOfCalculators.At( i )->CalculatePredictions();

        }

    }
    catch( const CalculatorException& exception ) {

        _calculator = exception.GetCalculator();
        _error       = exception.GetError();

        return std::numeric_limits<double>::max();

    }

    // Instruct the observables to update their predicted values.

    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        if( !(_observableVector[i]->IsNoUpdateObservable()) ) {

            _observableVector[i]->UpdatePrediction();
       
        }

    }


    // Calculate and return the resulting chi2.

    return PhysicsModel::CalculateChi2();

}

void Fittino::PhysicsModel::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "   Set of the " << this->GetName() << " parameters:" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); ++i ) {

        GetCollectionOfParameters().At( i )->PrintStatus();

    }

    if ( _observableVector.size() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of the " << this->GetName() << " observables:"  << Messenger::Endl;
        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "    Observable          Predicted value                 Measured value    Deviation" << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

            _observableVector[i]->PrintStatus();

        }

    }

    if ( _collectionOfPredictions.GetNumberOfElements() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of the " << this->GetName() << " predictions:"  << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _collectionOfPredictions.GetNumberOfElements(); ++i ) {

            _collectionOfPredictions.At( i )->PrintStatus();

        }

    }

    if ( _collectionOfStringVariables.GetNumberOfElements() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of string variables:"  << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _collectionOfStringVariables.GetNumberOfElements(); ++i ) {

            _collectionOfStringVariables.At( i )->PrintStatus();

        }

    }

    if ( _collectionOfChi2Quantities.GetNumberOfElements() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of chi2 terms:"  << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _collectionOfChi2Quantities.GetNumberOfElements(); ++i ) {

            _collectionOfChi2Quantities.At( i )->PrintStatus();

        }

    }

}

void Fittino::PhysicsModel::Initialize() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "   Initializing the list of model parameters" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        GetCollectionOfParameters().At( i )->Initialize();

    }

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::ALWAYS << "   Initializing the list of model calculators" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;


    for ( unsigned int i = 0; i < _collectionOfCalculators.GetNumberOfElements(); i++ ) {

        messenger << Messenger::ALWAYS << "    Initializing " << _collectionOfCalculators.At( i )->GetName() << Messenger::Endl;

        _collectionOfCalculators.At( i )->Initialize();
        _collectionOfCalculators.At( i )->SetupMeasuredValues();

    }

    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;

}

double Fittino::PhysicsModel::CalculateChi2() {

    double chi2 = 0.;

    // Calculate the chi2 contributions of all observables. Eventually replace
    // this formula to allow for correlated observables.

    std::vector<double> deviationVector;
    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        if( _observableVector[i]->IsNoFitObservable() ) continue;
        deviationVector.push_back( _observableVector[i]->GetPrediction()->GetValue() - _observableVector[i]->GetMeasuredValue() );
        //chi2 += pow( ( _observableVector[i]->GetPrediction()->GetValue() - _observableVector[i]->GetMeasuredValue() ) / _observableVector[i]->GetMeasuredError(), 2 );

    }
    if( deviationVector.size() > 0 ) {
        TVectorD tDeviationVector( deviationVector.size(), &deviationVector[0] );
        TVectorD tDeviationVector2 = tDeviationVector;
        tDeviationVector2 *= *( _invertedFitObservableCovarianceMatrix );
        chi2 += tDeviationVector2 * tDeviationVector;
    }

    // Add additional chi2 terms.

    for ( unsigned int i = 0; i < _collectionOfChi2Quantities.GetNumberOfElements(); i++ ) {

        chi2 += _collectionOfChi2Quantities.At( i )->GetValue();

    }

    return chi2;

}

void Fittino::PhysicsModel::SetupForToyRun( ) {
    
    RandomGenerator *randomGenerator = Fittino::RandomGenerator::GetInstance();
    if( randomGenerator->GetSeed() == 0 ) {
        
        randomGenerator->SetSeed( _randomSeed );
    
    }
    /*
    for( int i = 0; i < _observableVector.size(); ++i ) {

        _observableVector[i]->SmearMeasuredValue( randomGenerator );

    }
    */

    // Smear all observbles according to the covariance matrix:
    // First, determine the eigenvectors and eigenvalues of that matrix:
    //std::cout << "the covariance matrix is " << std::endl;
    
    // For the moment, also Poisson-type observables are included in this smearing procedure.
    // Their measured values are smeared again correclty after all Gaussian variables have been smeared!


    //_observableCovarianceMatrix->Print();
    //std::cout << "-------------------------------------------------------" << std::endl;
    TMatrixDSymEigen eigenMatrix( *_observableCovarianceMatrix );
    TVectorD eigenValues = eigenMatrix.GetEigenValues();
    TMatrixD eigenVectorsInverse = eigenMatrix.GetEigenVectors();
    TMatrixD eigenVectors = eigenMatrix.GetEigenVectors();

    eigenVectorsInverse.Invert();

    //std::cout << "the eigenvalues are " << std::endl;
    //eigenValues.Print();
    //std::cout << "-------------------------------------------------------" << std::endl;
    //std::cout << "the eigenvector matrix is " << std::endl;
    //eigenVectors.Print();
    //std::cout << "-------------------------------------------------------" << std::endl;

    // now transform the observable vector:
    TVectorD tObservableVector( _observableVector.size() );
    for( int i = 0; i < _observableVector.size(); ++i ) {

        tObservableVector[i] = _observableVector.at( i )->GetBestFitPrediction();

    }
    TVectorD tTransformedObservableVector( _observableVector.size() );
    tTransformedObservableVector = eigenVectorsInverse * tObservableVector;
    //std::cout << " and now the ev matrix is " << std::endl;
    //eigenVectors.Print();

    //std::cout << "the observable vector is " << std::endl;
    //tObservableVector.Print();
    //std::cout << "-------------------------------------------------------" << std::endl;
    //std::cout << "the transformed observable vector is " << std::endl;
    //tTransformedObservableVector.Print();
    //std::cout << "-------------------------------------------------------" << std::endl;

    // now smear
    TVectorD smearedVector( _observableVector.size() );
    for( int i = 0; i < _observableVector.size(); ++i ) {

        smearedVector[i] = randomGenerator->Gaus( tTransformedObservableVector[i], sqrt( eigenValues[i] ) );

    }
    //std::cout << "the smeared, transformed observable vector is " << std::endl;
    //smearedVector.Print();
    //std::cout << "-------------------------------------------------------" << std::endl;
    // now transform back
    //std::cout << "will now multiply " << std::endl;
    //eigenVectors.Print();
    //std::cout << " and " << std::endl;
    //smearedVector.Print();

    tObservableVector = eigenVectors * smearedVector;
    for( int i = 0; i < _observableVector.size(); ++i ) {
        
        // if observable was defined as noSmearObservable, set the measured value to the best fit prediction
        if( _observableVector[i]->IsNoSmearObservable() ) {
            
            _observableVector[i]->SetMeasuredValue( _observableVector[i]->GetBestFitPrediction() );

        }


        // if smearing type is different from Gaus( at the moment, the only other type is Poisson),
        // smear the observed value correctly. This will only yield correct 
        // results, if this observable is not correlated with any of the other observables
        
        else if( _observableVector[i]->GetSmearingType() != "Gaus" ) {
        
            _observableVector[i]->SmearMeasuredValue( _randomSeed );
        
        }
        
        // finally, for all Gaussian variable, set the smeared value to the one obtained from 
        // smearing the eigentvectors of the covariance matrix
        
        else {
            
            _observableVector[i]->SetMeasuredValue( tObservableVector[i] );

        }

        std::cout << "using smeared value for observable " << _observableVector[i]->GetPrediction()->GetName() << " \t: " << _observableVector[i]->GetMeasuredValue() << " \t: " << ( _observableVector[i]->GetMeasuredValue() - _observableVector[i]->GetBestFitPrediction() ) / _observableVector[i]->GetMeasuredError() << std::endl;
    
    }


    // now re-setup the observables for all the calculators.
    for ( unsigned int i = 0; i < _collectionOfCalculators.GetNumberOfElements(); i++ ) {
        
        _collectionOfCalculators.At( i )->SetupMeasuredValues();

    }

}

Fittino::PhysicsModel* Fittino::PhysicsModel::Clone() const {

    return new PhysicsModel( *this );

}

void Fittino::PhysicsModel::AddObservable( Observable* observable ) {

    _observableVector.push_back( observable );
    bool predictionIsKnown = false;
    for( unsigned int i = 0; i < GetCollectionOfPredictions().GetNumberOfElements(); ++i ) {
        if( observable->GetPrediction()->GetName() == GetCollectionOfPredictions().At( i )->GetName() ) {
            predictionIsKnown = true;
        }
    }


    if( !predictionIsKnown ) {
        AddPrediction( observable->GetPrediction() );
    }
}

void Fittino::PhysicsModel::AddCalculator( CalculatorBase* calculator ) {

    _collectionOfCalculators.AddElement( calculator->GetName(), calculator );

    const Collection<PredictionBase*>& col = calculator->GetCollectionOfQuantities();

    for ( unsigned int i = 0; i < col.GetNumberOfElements(); i++ ) {

        AddPrediction( col.At( i ) );

    }

}

const Fittino::Collection<Fittino::CalculatorBase*>& Fittino::PhysicsModel::GetCollectionOfCalculators() const {

    return _collectionOfCalculators;

}

const std::vector<Fittino::Observable*>* Fittino::PhysicsModel::GetObservableVector() const {

    return &_observableVector;

}

void Fittino::PhysicsModel::InitializeCalculators( const boost::property_tree::ptree& ptree ) {

    Factory factory;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree.get_child( "Calculators" ) ) {

        AddCalculator( factory.CreateCalculator( node.first, this, node.second ) );

    }

}

void Fittino::PhysicsModel::InitializeObservables( const boost::property_tree::ptree& ptree ) {

    Factory factory;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree.get_child( "Observables" ) ) {

        AddObservable( factory.CreateObservable( node.second, GetCollectionOfPredictions(), GetCollectionOfCalculators() ) );

    }

}

void Fittino::PhysicsModel::InitializeCovarianceMatrix( const boost::property_tree::ptree& ptree ) {

    // first step: read the covariance matrices as defind in the input file.
    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree.get_child( "CovarianceMatrices" ) ) {

        int nRows = 0;
        // find out the number of dimensions of the matrix
        BOOST_FOREACH( const boost::property_tree::ptree::value_type & node2, node.second  ) {

            if( node2.first == "Row" ) {

                nRows += 1;

            }

        }

        // create matrix and fill matrix with the numbers from the input file. also, fill the _observableIndeCovarianceMatrix-map with the names of the observables for later re-ordering of the map.
        TMatrixDSym *mat = new TMatrixDSym( nRows );
        int row = 0;
        int col = 0;
        BOOST_FOREACH( const boost::property_tree::ptree::value_type & node2, node.second ) {
            if( node2.first == "Row" ) {
                col = 0;
                BOOST_FOREACH( const boost::property_tree::ptree::value_type & node3, node2.second ) {
                    // assign one dimension to one observable:
                    if( node3.first == "ObservableName" ) {
                        _observableIndexInCovarianceMatrix.insert( std::pair<std::string, int>( node3.second.data(), _observableIndexInCovarianceMatrix.size() ) );
                    }
                    // fill the matrix:
                    if( node3.first == "Col" ) {
                        ( *mat )[row][col] = atof( node3.second.data().c_str() );
                        col++;
                    }
                }
                row++;
            }
        }

        // set matrix name and fill the collection of covariance matrices:

        char matname[20];
        sprintf( matname, "covMat_%i", _collectionOfCovarianceMatrices.GetNumberOfElements() );
        _collectionOfCovarianceMatrices.AddElement( matname, mat );

    }


    // now generate the full covariance matrix.
    // number of dimensions corresponds to number of observables:
    int nRowsTotal = _observableVector.size();

    // first create the unordered matrix:
    TMatrixDSym *unorderedCovarianceMatrix = new TMatrixDSym( nRowsTotal );


    // the number of observables, for which a covariance matrix was specified in the input file
    int nDimActiveMatrices = 0;

    // if any covariance matrix has been defined in the input file, use these to fill the full matrix first:
    if( _collectionOfCovarianceMatrices.GetNumberOfElements() > 0 ) {

        int idxActiveMatrix = 0;
        TMatrixDSym *activeMatrix = _collectionOfCovarianceMatrices.At( idxActiveMatrix ) ;
        int nDimActiveMatrix = activeMatrix->GetNrows();
        int nDimOffset = 0;

        // find out for how many observables a covariance matrix was defined:
        for( int i = 0; i < _collectionOfCovarianceMatrices.GetNumberOfElements(); ++i ) {
            nDimActiveMatrices += _collectionOfCovarianceMatrices.At( i ) -> GetNrows();
        }

        // now fill the full matrix
        for( int x = 0; x < nRowsTotal; ++x ) {

            // go to the next matrix, if all rows/columns from the current matrix have been transferred to the full matrix
            if( x - nDimOffset >= activeMatrix->GetNrows() ) {
                nDimOffset += activeMatrix->GetNrows();
                idxActiveMatrix += 1;

                if( idxActiveMatrix < _collectionOfCovarianceMatrices.GetNumberOfElements() ) {
                    activeMatrix = _collectionOfCovarianceMatrices.At( idxActiveMatrix );
                    nDimActiveMatrix = activeMatrix->GetNrows();
                }

            }
            // fill all columns not included in the current active matrix with a 0. the diagonal elements will be replaced by the actual uncertainty squared later
            for( int y = 0; y < nRowsTotal; ++y ) {
                if( x >= nDimActiveMatrices || y >= nDimActiveMatrices || y < nDimOffset || y >= nDimOffset + nDimActiveMatrix ) {

                    ( *unorderedCovarianceMatrix )[x][y] = 0.;

                }
                // fill the elements in the full matrix with the entries from the current active matrix when appropriate:
                else {

                    ( *unorderedCovarianceMatrix )[x][y] = ( *activeMatrix )[x - nDimOffset][y - nDimOffset];

                }

            }
        }

    }

    // now fill the remaining diagonal elements
    int uncorrelatedIndex = nDimActiveMatrices;
    for( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        std::string observableName = _observableVector[i]->GetPrediction()->GetName();
        bool isCorrelatedObservable = false;
        for( std::map<std::string, int>::const_iterator itr = _observableIndexInCovarianceMatrix.begin(); itr != _observableIndexInCovarianceMatrix.end(); ++itr ) {
            if( ( *itr ).first == observableName ) {
                isCorrelatedObservable = true;
                break;
            }

        }
        if( isCorrelatedObservable ) continue;

        _observableIndexInCovarianceMatrix.insert( std::pair<std::string, int>( observableName, _observableIndexInCovarianceMatrix.size() ) );
        ( *unorderedCovarianceMatrix )[uncorrelatedIndex][uncorrelatedIndex] = _observableVector[i]->GetMeasuredError() * _observableVector[i]->GetMeasuredError();
        uncorrelatedIndex += 1;
    }


    // now sort the matrix in the same order as the _observableVector is ordered.
    _observableCovarianceMatrix = new TMatrixDSym( unorderedCovarianceMatrix->GetNrows() );
    for( int i = 0; i < _observableVector.size(); ++i ) {

        for( int j = 0; j < _observableVector.size(); ++j ) {

            int oldIndex_x = _observableIndexInCovarianceMatrix.at( _observableVector[i]->GetPrediction()->GetName() );
            int oldIndex_y = _observableIndexInCovarianceMatrix.at( _observableVector[j]->GetPrediction()->GetName() );
            ( *_observableCovarianceMatrix )[i][j] = ( *unorderedCovarianceMatrix )[oldIndex_x][oldIndex_y];

        }

    }

    // now create a matrix for the observables actually used in the fit:

    // find out how many observables there are:
    int nFitObservables = 0;
    for( int i = 0; i < _observableVector.size(); ++i ) {
        if( _observableVector[i]->IsNoFitObservable() ) continue;
        nFitObservables += 1;
    }
    _fitObservableCovarianceMatrix = new TMatrixDSym( nFitObservables );


    // fill the matrix:
    int fitObs_x = 0;
    int fitObs_y = 0;
    for( int i = 0; i < _observableVector.size(); ++i ) {
        fitObs_y = 0;

        if( _observableVector[i]->IsNoFitObservable() ) continue;

        for( int j = 0; j < _observableVector.size(); ++j ) {

            if( _observableVector[j]->IsNoFitObservable() ) continue;

            ( *_fitObservableCovarianceMatrix )[fitObs_x][fitObs_y] = ( *_observableCovarianceMatrix )[i][j];
            fitObs_y++;

        }
        fitObs_x++;
    }

    // now set the toleracne of the matrix:
    _fitObservableCovarianceMatrix->SetTol( 1.e-40 );
    // create the inverted matrix for the calculation of the chi2:
    _invertedFitObservableCovarianceMatrix = new TMatrixDSym( _fitObservableCovarianceMatrix->Invert() );
}
