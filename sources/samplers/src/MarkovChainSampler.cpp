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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include <cmath>

#include "TTree.h"
#include "TBranch.h"

#include "MarkovChainSampler.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameter.h"
//#include "CalculatorException.h"

Fittino::MarkovChainSampler::MarkovChainSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
  : SamplerBase( model, ptree ), 

    _previousChi2( ptree.get<double>("Chi2", 1.e99) ),
    //_previousChi2( model->GetChi2() ),
    _previousParameterValues( std::vector<double>( model->GetNumberOfParameters(), 0. ) ),
    _acceptCounter( 1 ),
    _previousRho( 1. ),
    _numberOfFirstIteration( _iterationCounter+1 ),
    _numberOfIterations( _iterationCounter + ptree.get<int>( "NumberOfIterations" ) ) {

    _name = "Markov chain parameter sampler";

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _previousParameterValues.at( k ) = _model->GetCollectionOfParameters().At( k )->GetValue();

    }

    _statusParameterVector.push_back( new Quantity( "PointAccepted", "PointAccepted", 0. , 0., 1. ) );
  

}

Fittino::MarkovChainSampler::~MarkovChainSampler() {

}

void Fittino::MarkovChainSampler::Execute() {

    this -> FillMetaDataTree();  
    
    _branchPointAccepted = _tree->GetBranch( "PointAccepted" );
    _branchPointAccepted->SetStatus( 0 );

    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );

        //_chi2 = _model->GetChi2();
        //GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );

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
    if( _iterationCounter != 1 ) {
      for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _model->GetCollectionOfParameters().At( k )->SetValue( _model->GetCollectionOfParameters().At( k )->GetValue() + _randomGenerator.Gaus( 0., _model->GetCollectionOfParameters().At( k )->GetError() ) );

      }
    }

    // Calclate chi2.

    double chi2 = _model->GetChi2();
    _chi2 = chi2;
    GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );
    
    AnalysisTool::PrintStatus();


    // Calculate DeltaChi2 and likelihood;
    double DeltaChi2 = _chi2 - _previousChi2;

    // Decide whether point shall be accepted.

    bool pointAccepted = false;
    //GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

    double rho = exp(-DeltaChi2/2.);
    
    if ( rho > 1. ) {

        pointAccepted = true;
        //GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

    }
    else {

        double randomThreshold = _randomGenerator.Uniform( 0., 1. );
        if ( rho > randomThreshold ) {

            pointAccepted = true;
            //GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );

        }

    }
    // Further check if any parameter value is out of bounds.

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        if (    _model->GetCollectionOfParameters().At( k )->GetValue() < _model->GetCollectionOfParameters().At( k )->GetLowerBound()
                || _model->GetCollectionOfParameters().At( k )->GetValue() > _model->GetCollectionOfParameters().At( k )->GetUpperBound() ) {

            pointAccepted = false;
            //GetStatusParameterVector()->at( 2 )->SetValue( pointAccepted );
            break;

        }

    }

    if ( pointAccepted || _iterationCounter == _numberOfIterations ) {
       
        if ( pointAccepted ) {
            _previousRho        = rho;
            _previousChi2       = chi2;
        
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _previousParameterValues.at( k ) = _model->GetCollectionOfParameters().At( k )->GetValue();

            }
        
        }
        this->FillTree();

        if( _iterationCounter == _numberOfFirstIteration ) return;
        if( !pointAccepted ) {
            
            chi2 = _previousChi2;
            rho = _previousRho;
            _chi2 = chi2;
            GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );
            
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _model->GetCollectionOfParameters().At( k )->SetValue( _previousParameterValues.at( k ) );

            }

            _acceptCounter++;

        }

        _branchPointAccepted->SetStatus( 1 );
        GetStatusParameterVector()->at( 2 )->SetValue( _acceptCounter );
        _branchPointAccepted->Fill();

        GetStatusParameterVector()->at( 2 )->SetValue( 0. );
        for( unsigned int j = 0; j < _acceptCounter - 1; j++ ) {
            _branchPointAccepted->Fill();
        }

        if( pointAccepted && _iterationCounter == _numberOfIterations ) {
            GetStatusParameterVector()->at( 2 )->SetValue( 1. );
            _branchPointAccepted->Fill();
        }

        _acceptCounter = 1;
        _branchPointAccepted->SetStatus( 0 );

    }
    else {
        
        // if an interface file was used, and the first point in the new run was not accepted, fill that point into the ntuple first!
        if( _iterationCounter == _numberOfFirstIteration ) {
            double firstNewChi2 = _chi2;
        
            std::vector<double> firstNewPointParameterValues;
            for( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {
                firstNewPointParameterValues.push_back( _model->GetCollectionOfParameters().At( k )->GetValue() );
            }
        
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _model->GetCollectionOfParameters().At( k )->SetValue( _previousParameterValues.at( k ) );

            }
            _chi2 = _previousChi2;
            GetStatusParameterVector()->at( 0 ) -> SetValue( _chi2 );
            this->FillTree();
        
            _iterationCounter++;
            GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );
 
            // now reset everything to the first new point           
            _chi2 = firstNewChi2;
            GetStatusParameterVector()->at( 0 ) -> SetValue( _chi2 );
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _model->GetCollectionOfParameters().At( k )->SetValue( firstNewPointParameterValues.at( k ) );
            
            }
            
        }
        // save point and increment counter for last accepted point.
        this->FillTree();
        _acceptCounter++;

        // Reset the parameter values.

        for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

            _model->GetCollectionOfParameters().At( k )->SetValue( _previousParameterValues.at( k ) );

        }

    }

    //}
    //catch ( const CalculatorException& modelCalculatorException ) {

    //    std::cout << "\n" << modelCalculatorException.what() << "\n" << std::endl;
    //
    //    // Reset the parameter values.

    //    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

    //        _model->GetCollectionOfParameters().At( k )->SetValue( _previousParameterValues.at( k ) );

    //    }
    //
    //}

}
