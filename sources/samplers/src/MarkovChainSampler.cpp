/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MarkovChainSampler.cpp                                           *
*                                                                              *
* Description Class for Markov chain parameter sampler                         *
*                                                                              *
* Authors     Matthias  Hamer     <mhamer@gwdg.de>                             *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include <boost/lexical_cast.hpp>

#include "TTree.h"
#include "TBranch.h"

#include "MarkovChainSampler.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameter.h"
#include "RandomGenerator.h"

Fittino::MarkovChainSampler::MarkovChainSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
  : SamplerBase( model, ptree ), 
    _previousChi2( ptree.get<double>("Chi2", std::numeric_limits<double>::max() ) ),
    _previousParameterValues( std::vector<double>( model->GetNumberOfParameters(), 0. ) ),
    _acceptCounter( 1 ),
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

        this->UpdateModel();

    }

    _branchPointAccepted->SetStatus( 1 );

}

void Fittino::MarkovChainSampler::PrintSteeringParameters() const {

    AnalysisTool::PrintSteeringParameters();

    PrintItem( "NumberOfIterations", _numberOfIterations );

}

void Fittino::MarkovChainSampler::UpdateParameterPoint() {

  if( _iterationCounter == 1 ) return;

  for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

    _model->GetCollectionOfParameters().At( k )->SetValue( _model->GetCollectionOfParameters().At( k )->GetValue() + _randomGenerator->Gaus( 0., _model->GetCollectionOfParameters().At( k )->GetError() ) );

  }

}

void Fittino::MarkovChainSampler::UpdateModel() {

    UpdateParameterPoint();

    _chi2 = _model->GetChi2();
    GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );

    _pointAccepted = IsAccepted();

    AnalysisTool::PrintStatus();
    
    if ( _pointAccepted ) {

        _previousChi2       = _chi2;
        
        for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

            _previousParameterValues.at( k ) = _model->GetCollectionOfParameters().At( k )->GetValue();

        }

    }

    if ( _pointAccepted || _iterationCounter == _numberOfIterations ) {
    
        this->FillTree();

        if( _iterationCounter == _numberOfFirstIteration ) return;
        if( !_pointAccepted ) {

            _chi2 = _previousChi2;
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

        if( _pointAccepted && _iterationCounter == _numberOfIterations ) {
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
	    
	    _chi2 = _model->GetChi2();

	    if ( TMath::Abs( _chi2 - _previousChi2 ) > 0.01 ) {

	      Messenger::GetInstance()<<Messenger::ALWAYS<< "In iteration step "<< _iterationCounter<<Messenger::Endl;
	      Messenger::GetInstance()<<Messenger::ALWAYS<< "Chi2 from interface file does not fit to provided parameter: Delta Chi2 =  "<< _chi2 - _previousChi2<<Messenger::Endl;

		for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

		  Messenger::GetInstance()<<_model->GetCollectionOfParameters().At( k )->GetName()<<" = "<<_model->GetCollectionOfParameters().At( k )->GetValue()<<Messenger::Endl;

		}

		Messenger::GetInstance()<<Messenger::ALWAYS<< "_chi2="<<_chi2<<Messenger::Endl;
		Messenger::GetInstance()<<Messenger::ALWAYS<< "_previousChi2="<<_previousChi2<<Messenger::Endl;


		throw ConfigurationException("Chi2 from interface file does not match. " );

	    }

            GetStatusParameterVector()->at( 0 ) -> SetValue( _chi2 );

            this->FillTree();
        
            _iterationCounter++;
            GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );
 

	    // now reset everything to the first new point           
            
            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                _model->GetCollectionOfParameters().At( k )->SetValue( firstNewPointParameterValues.at( k ) );
            
            }
	    
	    _chi2 = _model->GetChi2();


	    if ( TMath::Abs( _chi2 - firstNewChi2 ) > 0.01 ) {

		std::string message = "Inconsistency in chi2: Delta chi2 = " + boost::lexical_cast<std::string>( _chi2 - firstNewChi2 ) ;

		Messenger::GetInstance()<<Messenger::ALWAYS<< message<<Messenger::Endl;

		for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

		  Messenger::GetInstance()<<Messenger::ALWAYS<<_model->GetCollectionOfParameters().At( k )->GetName()<<" = "<<_model->GetCollectionOfParameters().At( k )->GetValue()<<Messenger::Endl;

		}

		Messenger::GetInstance()<<Messenger::ALWAYS<< "_chi2="<<_chi2<<Messenger::Endl;
		Messenger::GetInstance()<<Messenger::ALWAYS<< "firstNewChi2="<<firstNewChi2<<Messenger::Endl;

		throw ConfigurationException( "Inconsistency in chi2." );

	    }

	    GetStatusParameterVector()->at( 0 ) -> SetValue( _chi2 );
            
        }

        // save point and increment counter for last accepted point.

        this->FillTree();
        _acceptCounter++;

        // Reset the parameter values.

        for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

            _model->GetCollectionOfParameters().At( k )->SetValue( _previousParameterValues.at( k ) );

        }

    }

}


bool Fittino::MarkovChainSampler::IsAccepted() {

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        if (    _model->GetCollectionOfParameters().At( k )->GetValue() < _model->GetCollectionOfParameters().At( k )->GetLowerBound()
                || _model->GetCollectionOfParameters().At( k )->GetValue() > _model->GetCollectionOfParameters().At( k )->GetUpperBound() ) {

          return false;

        }

    }

    double DeltaChi2 = _chi2 - _previousChi2;
    double rho = exp(-DeltaChi2/2.);
    double randomThreshold = _randomGenerator->Uniform( 1. );
    if ( rho < randomThreshold ) return false; 

    return true;

}

