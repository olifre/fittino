/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsModelBase.cpp                                             *
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
#include "Chi2ContributionBase.h"
#include "Messenger.h"
#include "ModelCalculatorBase.h"
#include "ModelParameterBase.h"
#include "Observable.h"
#include "PhysicsModelBase.h"
#include "PhysicsParameter.h"
#include "PredictionBase.h"
#include "SimplePrediction.h"
#include "SLHAPrediction.h"
#include "Collection.h"
#include "Configuration.h"
#include "TreeCalculator.h"
#include "FeynHiggsModelCalculator.h"
#include "FeynHiggsSLHAModelCalculator.h"
#include "HDim6ModelCalculator.h"
#include "HiggsSignalsHadXSModelCalculator.h"
#include "HiggsSignalsSLHAModelCalculator.h"
#include "SPhenoSLHAModelCalculator.h"
#include "TMatrixDSym.h"
#include "TMatrixDSymEigen.h"
#include "TVectorD.h"

Fittino::PhysicsModelBase::PhysicsModelBase( const boost::property_tree::ptree& ptree )
        : ModelBase( ptree ) {

  _name = ptree.get<std::string>( "Name" );

  Factory factory;
  
  InitializeCalculators( ptree );
  InitializeObservables( ptree );
  InitializeCovarianceMatrix( ptree );
  BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

    if ( node.first == "Chi2Contribution" ) AddChi2Contribution( node.second.get_value<std::string>() );

  }

  Initialize();

}

Fittino::PhysicsModelBase::PhysicsModelBase() {

    InitializeCalculators();
    InitializeObservables();

}

Fittino::PhysicsModelBase::~PhysicsModelBase() {

}


void Fittino::PhysicsModelBase::AddChi2Contribution( const std::string& name ) {

  _collectionOfChi2Quantities.AddElement( GetCollectionOfQuantities().At( name ) );

}

void Fittino::PhysicsModelBase::AddChi2Contribution( Fittino::Chi2ContributionBase* contribution ) {

  _collectionOfChi2Contributions.AddElement( contribution );

}

double Fittino::PhysicsModelBase::Evaluate() {

    // Let the calculators calculate the model predictions.

    for ( unsigned int i = 0; i < _collectionOfCalculators.GetNumberOfElements(); ++i ) {

        _collectionOfCalculators.At( i )->CalculatePredictions();

    }

    // Instruct the observables to update their predicted values.

    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        _observableVector[i]->UpdatePrediction();

    }

    for ( unsigned int i = 0; i < _collectionOfChi2Contributions.GetNumberOfElements(); ++i ) {

        _collectionOfChi2Contributions.At(i)->UpdateValue();

    }

    // Calculate and return the resulting chi2.

    return PhysicsModelBase::CalculateChi2();

}

void Fittino::PhysicsModelBase::PrintStatus() const {

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

    if ( _collectionOfChi2Quantities.GetNumberOfElements() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of chi2 terms:"  << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _collectionOfChi2Quantities.GetNumberOfElements(); ++i ) {

          _collectionOfChi2Quantities.At( i )->PrintStatus();

        }

    }

}

void Fittino::PhysicsModelBase::Initialize() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "   Initializing the list of model parameters" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        GetCollectionOfParameters().At( i )->PrintStatus();

    }

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::ALWAYS << "   Initializing the list of model calculators" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;


    for ( unsigned int i = 0; i < _collectionOfCalculators.GetNumberOfElements(); i++ ) {

        messenger << Messenger::ALWAYS << "    Initializing " << _collectionOfCalculators.At( i )->GetName() << Messenger::Endl;

        _collectionOfCalculators.At( i )->Initialize();

    }

    messenger << Messenger::ALWAYS << Messenger::Endl;

}

double Fittino::PhysicsModelBase::CalculateChi2() {

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
        tDeviationVector2 *= *(_invertedFitObservableCovarianceMatrix);
        chi2 += tDeviationVector2*tDeviationVector;
    }
  
    // Add additional chi2 terms.

    for ( unsigned int i = 0; i < _collectionOfChi2Quantities.GetNumberOfElements(); i++ ) {

      chi2 += _collectionOfChi2Quantities.At(i)->GetValue();
    
    }

    for ( unsigned int i = 0; i < _collectionOfChi2Contributions.GetNumberOfElements(); ++i ) {
    
      chi2 += _collectionOfChi2Contributions.At(i)->GetValue();

    }


    return chi2;

}

void Fittino::PhysicsModelBase::SmearObservations( TRandom3* randomGenerator ) {
    /*
    for( int i = 0; i < _observableVector.size(); ++i ) {
        
        _observableVector[i]->SmearMeasuredValue( randomGenerator );
    
    }
    */

    // Smear all observbles according to the covariance matrix:
    // First, determine the eigenvectors and eigenvalues of that matrix:
    //std::cout << "the covariance matrix is " << std::endl;
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
        
        tObservableVector[i] = _observableVector.at(i)->GetBestFitPrediction();

    }
    TVectorD tTransformedObservableVector( _observableVector.size() );
    tTransformedObservableVector = eigenVectorsInverse*tObservableVector;
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
        
        smearedVector[i] = randomGenerator->Gaus( tTransformedObservableVector[i], sqrt(eigenValues[i]) );

    }
    //std::cout << "the smeared, transformed observable vector is " << std::endl;
    //smearedVector.Print();
    //std::cout << "-------------------------------------------------------" << std::endl;
    // now transform back
    //std::cout << "will now multiply " << std::endl;
    //eigenVectors.Print();
    //std::cout << " and " << std::endl;
    //smearedVector.Print();
    
    tObservableVector = eigenVectors*smearedVector;
    for( int i = 0; i < _observableVector.size(); ++i ) {

        _observableVector[i]->SetMeasuredValue( tObservableVector[i] );

        std::cout << "using smeared value for observable " << _observableVector[i]->GetPrediction()->GetName() << " \t: " << _observableVector[i]->GetMeasuredValue() << " \t: " << (_observableVector[i]->GetMeasuredValue() - _observableVector[i]->GetBestFitPrediction())/_observableVector[i]->GetMeasuredError() << std::endl;
    }
    

    // now smear the observations for the chi2 contributions:
    for ( int i = 0; i < _collectionOfChi2Contributions.GetNumberOfElements(); ++i ) {
    
        _collectionOfChi2Contributions.At(i)->SmearObservation( randomGenerator );

    }

}

Fittino::PhysicsModelBase* Fittino::PhysicsModelBase::Clone() const{

  return new PhysicsModelBase( *this );

}

void Fittino::PhysicsModelBase::AddObservable( Observable* observable ) {

    _observableVector.push_back( observable );
    bool predictionIsKnown = false;
    for( unsigned int i = 0; i < GetCollectionOfPredictions().GetNumberOfElements(); ++i ) {
        if( observable->GetPrediction()->GetName() == GetCollectionOfPredictions().At(i)->GetName() ) {
            predictionIsKnown = true;
        }
    }


    if( !predictionIsKnown ) {
        AddPrediction( observable->GetPrediction() );
    }
}

void Fittino::PhysicsModelBase::AddCalculator( ModelCalculatorBase* calculator ) {
    
    _collectionOfCalculators.AddElement( calculator->GetName(), calculator );

    const Collection<PredictionBase*>& col = calculator->GetCollectionOfQuantities(); 

    for (unsigned int i = 0; i< col.GetNumberOfElements(); i++ ) {

      AddPrediction( col.At(i) );

    }

    const Collection<Chi2ContributionBase*>& col2 = calculator->GetCollectionOfChi2Contributions();

    for ( unsigned int i = 0; i < col2.GetNumberOfElements(); ++i ) {
    
        AddChi2Contribution( col2.At(i) );

    }

}

const Fittino::Collection<Fittino::ModelCalculatorBase*>& Fittino::PhysicsModelBase::GetCollectionOfCalculators() const {
    
    return _collectionOfCalculators;

}

std::vector<Fittino::Observable*>* Fittino::PhysicsModelBase::GetObservableVector() {

    return &_observableVector;

}

void Fittino::PhysicsModelBase::InitializeCalculators() {

    const Factory factory;

    Configuration *configuration = Configuration::GetInstance();
    const boost::property_tree::ptree* propertyTree = configuration->GetPropertyTree();

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & v, propertyTree->get_child( "InputFile" ) ) {
        if ( v.first == "Calculator" ) {
            std::string calculatorType = v.second.get<std::string>( "<xmlattr>.Type" );
            if ( calculatorType == "Tree" ) {

                AddCalculator( factory.CreateCalculator( Configuration::TREECALCULATOR, this ) );

                /* \todo The following should be done in the constructor avoiding static_cast and allowing to remove function GetCollectionOfCalculators  */
                TreeCalculator* treecalc = static_cast<TreeCalculator*>(GetCollectionOfCalculators().At( "TreeCalculator" ));
                treecalc->SetInputFileName( propertyTree->get<std::string>("InputFile.Sampler.<xmlattr>.InputFileName", "Fittino.old.root" ) );
                treecalc->SetInputTreeName( propertyTree->get<std::string>("InputFile.Sampler.<xmlattr>.InputTreeName", "Tree" ) );
                treecalc->OpenInputTree();
            
            }

            else if ( calculatorType == "FeynHiggs" ) {

                AddCalculator( factory.CreateCalculator( Configuration::FEYNHIGGSCALCULATOR, this ) );

            }

            else if ( calculatorType == "FeynHiggsSLHA" ) {

                AddCalculator( factory.CreateCalculator( Configuration::FEYNHIGGSSLHACALCULATOR, this ) );

            }

            else if ( calculatorType == "HDim6" ) {

                AddCalculator( factory.CreateCalculator( Configuration::HDIM6CALCULATOR, this ) );

            }

            else if ( calculatorType == "HiggsSignalsHadXS" ) {

                AddCalculator( factory.CreateCalculator( Configuration::HIGGSSIGNALSHADXSCALCULATOR, this ) );

            }

            else if ( calculatorType == "HiggsSignalsSLHA" ) {

                AddCalculator( factory.CreateCalculator( Configuration::HIGGSSIGNALSSLHACALCULATOR, this ) );

            }

            else if ( calculatorType == "SPhenoSLHA" ) {

                AddCalculator( factory.CreateCalculator( Configuration::SPHENOSLHACALCULATOR, this ) );

            }

            else if ( calculatorType == "LHC" ) {

                AddCalculator( factory.CreateCalculator( Configuration::LHCCALCULATOR, this ) );

            }

        }

    }

}

void Fittino::PhysicsModelBase::InitializeCalculators( const boost::property_tree::ptree& ptree ) {

  Factory factory;

  BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree.get_child("Calculators") ) {
  
    AddCalculator( factory.CreateCalculator( node.first, this, node.second ) );

  }

}

void Fittino::PhysicsModelBase::InitializeObservables() {

    Configuration *configuration = Configuration::GetInstance();
    const boost::property_tree::ptree* propertyTree = configuration->GetPropertyTree();

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & v, propertyTree->get_child( "InputFile" ) ) {
        if ( v.first == "Observable" ) {

            std::string name = v.second.get<std::string>( "<xmlattr>.Name" );
            std::string type = v.second.get<std::string>( "<xmlattr>.PredictionType" );
            double measuredValue = v.second.get<double>( "<xmlattr>.MeasuredValue" );
            double measuredError =  v.second.get<double>( "<xmlattr>.Error1" );
            double bestFitPrediction = v.second.get<double>( "<xmlattr>.BestFitPrediction", 0. );

            std::string plotName = v.second.get<std::string>( "<xmlattr>.PlotName", name );
            std::string unit = v.second.get<std::string>( "<xmlattr>.Unit", "" );
            std::string plotUnit = v.second.get<std::string>( "<xmlattr>.PlotUnit", unit );
            std::string id = v.second.get<std::string>( "<xmlattr>.ID", "" );
            std::string firstId = v.second.get<std::string>( "<xmlattr>.FirstID", "" );
            std::string secondId = v.second.get<std::string>( "<xmlattr>.SecondID", "" );
            std::string blockName = v.second.get<std::string>( "<xmlattr>.BlockName", "" );
            int columnIndex = v.second.get<int> ( "<xmlattr>.ColumnIndex", 0 );
            double plotLowerBound = v.second.get<double>( "<xmlattr>.PlotLowerBound", measuredValue - 10.*measuredError );
            double plotUpperBound = v.second.get<double>( "<xmlattr>.PlotUpperBound", measuredValue + 10.*measuredError );

            if( type == "Simple" ) {

                AddObservable( new Observable( new SimplePrediction( name, name, unit, plotUnit, plotLowerBound , plotUpperBound, _collectionOfCalculators.At( v.second.get<std::string>( "<xmlattr>.CalculatorName" ) ) ), measuredValue, measuredError, bestFitPrediction ) );

            }

            else if ( type == "SLHA" ) {

                if( firstId == "" || secondId == "" ) {

                    AddObservable( new Observable( new SLHAPrediction( name, name, unit, plotUnit, plotLowerBound, plotUpperBound, static_cast<SLHAModelCalculatorBase*>( _collectionOfCalculators.At( v.second.get<std::string>( "<xmlattr>.CalculatorName" ) ) ), blockName, id, columnIndex ), measuredValue, measuredError, bestFitPrediction ) );

                }

                else {

                    AddObservable( new Observable( new SLHAPrediction( name, name, unit, plotUnit, plotLowerBound, plotUpperBound, static_cast<SLHAModelCalculatorBase*>( _collectionOfCalculators.At( v.second.get<std::string>( "<xmlattr>.CalculatorName" ) ) ), blockName, firstId, secondId, columnIndex ), measuredValue, measuredError, bestFitPrediction ) );

                }

            }

        }
    }

}

void Fittino::PhysicsModelBase::InitializeObservables( const boost::property_tree::ptree& ptree ) {
  
  Factory factory;

  BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree.get_child("Observables") ) {

    AddObservable( factory.CreateObservable( node.second, GetCollectionOfPredictions(), GetCollectionOfCalculators() ) );

  }  

}

void Fittino::PhysicsModelBase::InitializeCovarianceMatrix( const boost::property_tree::ptree& ptree ) {

    // first step: read the covariance matrices as defind in the input file. 
    BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree.get_child("CovarianceMatrices" ) ) {

        int nRows = 0;
        // find out the number of dimensions of the matrix
        BOOST_FOREACH( const boost::property_tree::ptree::value_type &node2, node.second  ) {
            
            if( node2.first == "Row" ) {
            
                nRows += 1;
            
            }
            
        }
        
        // create matrix and fill matrix with the numbers from the input file. also, fill the _observableIndeCovarianceMatrix-map with the names of the observables for later re-ordering of the map.
        TMatrixDSym *mat = new TMatrixDSym( nRows );
        int row = 0;
        int col = 0;
        BOOST_FOREACH( const boost::property_tree::ptree::value_type &node2, node.second ) {
            if( node2.first == "Row" ) {
                col = 0;
                BOOST_FOREACH( const boost::property_tree::ptree::value_type &node3, node2.second) {
                    // assign one dimension to one observable:
                    if( node3.first == "ObservableName" ) {
                        _observableIndexInCovarianceMatrix.insert(std::pair<std::string, int>( node3.second.data(), _observableIndexInCovarianceMatrix.size() ));
                    }
                    // fill the matrix:
                    if( node3.first == "Col" ) {
                        (*mat)[row][col] = atof(node3.second.data().c_str() );
                        col++;
                    }
                }
                row++;
            }
        }

        // set matrix name and fill the collection of covariance matrices:
        
        char matname[20];
        sprintf(matname, "covMat_%i", _collectionOfCovarianceMatrices.GetNumberOfElements() );
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
                
                    (*unorderedCovarianceMatrix)[x][y] = 0.;
            
                }
    // fill the elements in the full matrix with the entries from the current active matrix when appropriate:
                else {
                
                    (*unorderedCovarianceMatrix)[x][y] = (*activeMatrix)[x-nDimOffset][y-nDimOffset];
            
                }
        
            }
        }
    
    }

    // now fill the remaining diagonal elements
    int uncorrelatedIndex = nDimActiveMatrices;
    for( unsigned int i = 0; i < _observableVector.size(); ++i ) {
        
        std::string observableName = _observableVector[i]->GetPrediction()->GetName();
        bool isCorrelatedObservable = false;
        for( std::map<std::string,int>::const_iterator itr = _observableIndexInCovarianceMatrix.begin(); itr != _observableIndexInCovarianceMatrix.end(); ++itr ) {
            if( (*itr).first == observableName ) {
                isCorrelatedObservable = true;
                break;
            }
            
        }
        if( isCorrelatedObservable ) continue;

        _observableIndexInCovarianceMatrix.insert(std::pair<std::string,int>( observableName, _observableIndexInCovarianceMatrix.size() ) );
        (*unorderedCovarianceMatrix)[uncorrelatedIndex][uncorrelatedIndex] = _observableVector[i]->GetMeasuredError()*_observableVector[i]->GetMeasuredError();
        uncorrelatedIndex += 1;
    }
    
   
    // now sort the matrix in the same order as the _observableVector is ordered.
    _observableCovarianceMatrix = new TMatrixDSym( unorderedCovarianceMatrix->GetNrows() );
    for( int i = 0; i < _observableVector.size(); ++i ) {

        for( int j = 0; j < _observableVector.size(); ++j ) {

            int oldIndex_x = _observableIndexInCovarianceMatrix.at( _observableVector[i]->GetPrediction()->GetName() );
            int oldIndex_y = _observableIndexInCovarianceMatrix.at( _observableVector[j]->GetPrediction()->GetName() );
            (*_observableCovarianceMatrix)[i][j] = (*unorderedCovarianceMatrix)[oldIndex_x][oldIndex_y];
    
        }

    }

    // now create a matrix for the observables actually used in the fit:
    
    // find out how many observables there are:
    int nFitObservables = 0;
    for( int i = 0; i < _observableVector.size(); ++i ) {
        if(_observableVector[i]->IsNoFitObservable() ) continue;
        nFitObservables += 1;
    }
    _fitObservableCovarianceMatrix = new TMatrixDSym( nFitObservables );
    

    // fill the matrix:
    int fitObs_x = 0;
    int fitObs_y = 0;
    for( int i = 0; i < _observableVector.size(); ++i ) {
        fitObs_y = 0;
        
        if(_observableVector[i]->IsNoFitObservable() ) continue;
        
        for( int j = 0; j < _observableVector.size(); ++j ) {
            
            if(_observableVector[j]->IsNoFitObservable() ) continue;
            
            (*_fitObservableCovarianceMatrix)[fitObs_x][fitObs_y] = (*_observableCovarianceMatrix)[i][j];
            fitObs_y++;
        
        }
        fitObs_x++;
    }

    // create the inverted matrix for the calculation of the chi2:
    _invertedFitObservableCovarianceMatrix = new TMatrixDSym(_fitObservableCovarianceMatrix->Invert());    
}
