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


double Fittino::PhysicsModelBase::Evaluate() {

    // Let the calculators calculate the model predictions.

    for ( unsigned int i = 0; i < _collectionOfCalculators.GetNumberOfElements(); ++i ) {

        _collectionOfCalculators.At( i )->CalculatePredictions();

    }

    // Instruct the observables to update their predicted values.

    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        _observableVector[i]->UpdatePrediction();

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

    return chi2;

}

void Fittino::PhysicsModelBase::SmearObservables( TRandom3* randomGenerator ) {

    for( int i = 0; i < _observableVector.size(); ++i ) {
        
        _observableVector[i]->SmearMeasuredValue( randomGenerator );
    
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

    //std::cout << "now generating the independen matrices" << std::endl;
    BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree.get_child("CovarianceMatrices" ) ) {

        int nRows = 0;
        
        BOOST_FOREACH( const boost::property_tree::ptree::value_type &node2, node.second  ) {
            
            if( node2.first == "Row" ) {
            
                nRows += 1;
            
            }
            
        }
        
        TMatrixDSym *mat = new TMatrixDSym( nRows );
        int row = 0;
        int col = 0;
        BOOST_FOREACH( const boost::property_tree::ptree::value_type &node2, node.second ) {
            if( node2.first == "Row" ) {
                col = 0;
                BOOST_FOREACH( const boost::property_tree::ptree::value_type &node3, node2.second) {
                    if( node3.first == "ObservableName" ) {
                        _observableIndexInCovarianceMatrix.insert(std::pair<std::string, int>( node3.second.data(), _observableIndexInCovarianceMatrix.size() ));
                    }
                    if( node3.first == "Col" ) {
                        (*mat)[row][col] = atof(node3.second.data().c_str() );
                        col++;
                    }
                }
                row++;
            }
        }
        char matname[20];
        //std::cout << "got matrix " << std::endl;
        //mat->Print();
        sprintf(matname, "covMat_%i", _collectionOfCovarianceMatrices.GetNumberOfElements() );
        _collectionOfCovarianceMatrices.AddElement( matname, mat );
        
    }
    
    //std::cout << "done. now filling the full matrix" << std::endl;

    int nRowsTotal = _observableVector.size();
    //std::cout << "covariacne matrix with " << nRowsTotal << " will be created" << std::endl;
    TMatrixDSym *unorderedCovarianceMatrix = new TMatrixDSym( nRowsTotal );
    //unorderedCovarianceMatrix->Print();

    int nDimActiveMatrices = 0;
    if( _collectionOfCovarianceMatrices.GetNumberOfElements() > 0 ) {
        int idxActiveMatrix = 0;
        TMatrixDSym *activeMatrix = _collectionOfCovarianceMatrices.At( idxActiveMatrix ) ;
        int nDimActiveMatrix = activeMatrix->GetNrows();
        int nDimOffset = 0;
        
        for( int i = 0; i < _collectionOfCovarianceMatrices.GetNumberOfElements(); ++i ) {
            nDimActiveMatrices += _collectionOfCovarianceMatrices.At( i ) -> GetNrows();
        }
    
        //std::cout << "starting the actual fill process " << std::endl;
        for( int x = 0; x < nRowsTotal; ++x ) {
        
            if( x - nDimOffset >= activeMatrix->GetNrows() ) {
                nDimOffset += activeMatrix->GetNrows();
                idxActiveMatrix += 1;
            
                if( idxActiveMatrix < _collectionOfCovarianceMatrices.GetNumberOfElements() ) {
                    //std::cout << "trying to access matrix at position " << idxActiveMatrix << std::endl;
                    activeMatrix = _collectionOfCovarianceMatrices.At( idxActiveMatrix ); 
                    nDimActiveMatrix = activeMatrix->GetNrows();
                }
        
            }

            for( int y = 0; y < nRowsTotal; ++y ) {
                if( x >= nDimActiveMatrices || y >= nDimActiveMatrices || y < nDimOffset || y >= nDimOffset + nDimActiveMatrix ) {
                
                    (*unorderedCovarianceMatrix)[x][y] = 0.;
            
                }

                else {
                
                    (*unorderedCovarianceMatrix)[x][y] = (*activeMatrix)[x-nDimOffset][y-nDimOffset];
            
                }
        
            }
        }
    
    }
    //std::cout << "done. now filling the remaining rows" << std::endl;

    int uncorrelatedIndex = nDimActiveMatrices;
    //std::cout << "I have " << _observableVector.size() << " observables " << std::endl;
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
        //std::cout << "i is equal to " << i << " trying to fill matrix at index " << uncorrelatedIndex << std::endl;
        (*unorderedCovarianceMatrix)[uncorrelatedIndex][uncorrelatedIndex] = _observableVector[i]->GetMeasuredError()*_observableVector[i]->GetMeasuredError();
        uncorrelatedIndex += 1;
    }
    //std::cout << "done. no printing stuff" << std::endl;

    //unorderedCovarianceMatrix->Print();
    //std::cout << "rows corresponding to observables " << std::endl;
    //for( std::map<std::string,int>::const_iterator itr = _observableIndexInCovarianceMatrix.begin(); itr != _observableIndexInCovarianceMatrix.end(); ++itr ) {
    //    std::cout << (*itr).first << "\t\t==!==\t\t" << (*itr).second << std::endl;
    //}
    
    _observableCovarianceMatrix = new TMatrixDSym( unorderedCovarianceMatrix->GetNrows() );
    for( int i = 0; i < _observableVector.size(); ++i ) {

        for( int j = 0; j < _observableVector.size(); ++j ) {

            int oldIndex_x = _observableIndexInCovarianceMatrix.at( _observableVector[i]->GetPrediction()->GetName() );
            int oldIndex_y = _observableIndexInCovarianceMatrix.at( _observableVector[j]->GetPrediction()->GetName() );
            (*_observableCovarianceMatrix)[i][j] = (*unorderedCovarianceMatrix)[oldIndex_x][oldIndex_y];
    
        }

    }

    //std::cout << "------------------------" << std::endl;
    //_observableCovarianceMatrix->Print();
    int nFitObservables = 0;
    for( int i = 0; i < _observableVector.size(); ++i ) {
        if(_observableVector[i]->IsNoFitObservable() ) continue;
        nFitObservables += 1;
    }
    _fitObservableCovarianceMatrix = new TMatrixDSym( nFitObservables );
    
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
    _fitObservableCovarianceMatrix -> Print();
    //std::cout << "the inveretd matrix has " << _fitObservableCovarianceMatrix->Invert().GetNrows() << std::endl;
    _invertedFitObservableCovarianceMatrix = new TMatrixDSym(_fitObservableCovarianceMatrix->Invert());    
}
