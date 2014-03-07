/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCLimitCalculator.cpp                                           *
*                                                                              *
* Description Base class for LHC Calculator                                    *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <stdlib.h>

#include <iostream>
#include <map>
#include <vector>
#include <string>

#include <boost/property_tree/ptree.hpp>
#include <boost/foreach.hpp>

#include "TFile.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TH3D.h"
#include "THnSparse.h"
#include "TDirectory.h"

#include "Factory.h"
#include "PhysicsModel.h"
#include "ModelParameter.h"
#include "LHCLimitCalculator.h"
#include "SimpleDataStorage.h"
#include "ConfigurationException.h"
#include "MathTools.h"
#include "Chi2ContributionBase.h"
#include "LHCChi2Contribution.h"
#include "Observable.h"

Fittino::LHCLimitCalculator::LHCLimitCalculator( const PhysicsModel* model )
    : CalculatorBase( model ) {

    _name = "LHCLimitCalculator";

}

Fittino::LHCLimitCalculator::LHCLimitCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ) {

    _name = "LHCLimitCalculator";
    CreateChi2Contributions( ptree );

}

Fittino::LHCLimitCalculator::~LHCLimitCalculator() {

}

void Fittino::LHCLimitCalculator::AddAnalysis( std::string name, std::string fileName, std::string histName, std::vector<std::string> relevantParameters ) {

    if( relevantParameters.size() == 0 ) return;



    _relevantParametersMap.insert( std::pair<std::string, std::vector<std::string> >( name, relevantParameters ) );
    _simpleOutputDataStorage->AddEntry( name, 0. );
    
    // save the old gDirectory:
    TDirectory *tempDir = gDirectory;

    TFile *f = new TFile( fileName.c_str(), "OPEN" );
    
    if( relevantParameters.size() == 1 ) {
      
      _chi2Histograms1D.insert( std::pair<std::string, TH1D*>( name, ((TH1D*)(f->Get(histName.c_str()))->Clone("")) ) );
      
    }
    else if( relevantParameters.size() == 2 ) {
      
      _chi2Histograms2D.insert( std::pair<std::string, TH2D*>( name, ((TH2D*)(f->Get(histName.c_str()))->Clone("") ) ));
      
    }
    else if( relevantParameters.size() == 3 ) {
      
      _chi2Histograms3D.insert( std::pair<std::string, TH3D*>( name, ((TH3D*)(f->Get(histName.c_str()))->Clone("")) ) );
      
    }
    else if( relevantParameters.size() > 3 ) {
      
      _chi2HistogramsnD.insert( std::pair<std::string, THnSparseD*>( name, ((THnSparseD*)(f->Get(histName.c_str()))->Clone("")) ) );
      
    }
    f->Close();

    // and restore the original gDirectory:
    gDirectory = tempDir;

}

void Fittino::LHCLimitCalculator::CalculatePredictions() {

  std::map<std::string, std::vector<double> > parameterValueMap;
  
  // loop over the analyses
  for ( std::map<std::string, std::vector<std::string> >::const_iterator itr = _relevantParametersMap.begin(); itr != _relevantParametersMap.end(); ++itr ) {
    
    std::vector<double> parameterValues;
    bool isInListOfParameters = false;
    bool isInListOfObservables = false;
    // now loop over the parameters:
    // try to find model parameter values in the list of parameters from the model and fill a vector with the values;
    
    for( int j = 0; j < (*itr).second.size(); ++j ) { 

        for( int i = 0; i < _model->GetCollectionOfParameters().GetNumberOfElements(); ++i ) {
            if( (*itr).second.at(j) == _model->GetCollectionOfParameters().At(i)->GetName() ) {
                parameterValues.push_back( _model->GetCollectionOfParameters().At(i)->GetValue() );
                isInListOfParameters = true;
                break;
            }
        }

    // if not found in the list of parameters, try to find it in the list of observables...for now
        if( !isInListOfParameters ) {

            for( int i = 0; i < _model->GetCollectionOfPredictions().GetNumberOfElements(); ++i ) {
                if( (*itr).second.at(j) == _model->GetCollectionOfPredictions().At(i)->GetName() ) {
                    parameterValues.push_back( _model->GetCollectionOfPredictions().At(i)->GetValue() );
                    isInListOfObservables = true;
                    break;
                }
            }

        }

        if( !isInListOfParameters && !isInListOfObservables ) {

            throw ConfigurationException( "In LHCChi2Calculator: Won't be able to set values for relevant parameter in LHC Chi2 Contribution" );

        }
    
    }

    // loops complete. all parameters should have been filled.
    if( parameterValues.size() != (*itr).second.size() ) {
        
        throw ConfigurationException(  "In LHCChi2Calculator: Number of assigned parameters does not match number of relevant parameters! Something is wrong!" );

    }
    // if found, add it:
    parameterValueMap.insert( std::pair<std::string, std::vector<double> >( (*itr).first, parameterValues ) );
    

  }


  for( std::map<std::string, TH1D*>::const_iterator itr = _chi2Histograms1D.begin(); itr != _chi2Histograms1D.end(); ++itr ) {
    //int binx = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( binx );
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> Interpolate( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> Interpolate( parameterValueMap.at((*itr).first).at(0) );
  }
  
  for( std::map<std::string, TH2D*>::const_iterator itr = _chi2Histograms2D.begin(); itr != _chi2Histograms2D.end(); ++itr ) {
    //int binx = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    //int biny = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue() );
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( binx, biny );
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> Interpolate( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue(), _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue() );
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> Interpolate( parameterValueMap.at((*itr).first).at(0), parameterValueMap.at((*itr).first).at(1) );
 }
  
  for( std::map<std::string, TH3D*>::const_iterator itr = _chi2Histograms3D.begin(); itr != _chi2Histograms3D.end(); ++itr ) {
    //int binx = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    //int biny = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue() );
    //int binz = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(2))->GetValue() );
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( binx, biny, binz );
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> Interpolate( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue(), _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue(), _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(2))->GetValue() );
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> Interpolate( parameterValueMap.at((*itr).first).at(0), parameterValueMap.at((*itr).first).at(1), parameterValueMap.at((*itr).first).at(2) );
  }

  for( std::map<std::string, THnSparseD*>::const_iterator itr = _chi2HistogramsnD.begin(); itr != _chi2HistogramsnD.end(); ++itr ) {
    /*
    std::vector<double> parameterValues;
    for( unsigned int i = 0; i < _relevantParametersMap.at( (*itr).first).size(); ++i ) {
      parameterValues.push_back( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(i))->GetValue() );
    }
    */
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = Fittino::MathTools::InterpolateND( (*itr).second, parameterValueMap.at((*itr).first) ); 
  
  }

}

void Fittino::LHCLimitCalculator::UpdateAnalysisHistogram( std::string name, std::string fileName, std::string newHistogramName, std::vector<std::string> relevantParameters ) {

  // save the old TDirectory first:
  TDirectory *tempDir = gDirectory;

  TFile *f = new TFile( fileName.c_str(), "OPEN" );
  if( relevantParameters.size() == 1 ) {
    delete _chi2Histograms1D.at( name );
    _chi2Histograms1D.at(name) = (TH1D*)(f->Get( newHistogramName.c_str() )->Clone(""));
  }
  else if( relevantParameters.size() == 2 ) {
    delete _chi2Histograms2D.at( name );
    _chi2Histograms2D.at(name) = (TH2D*)(f->Get( newHistogramName.c_str() )->Clone(""));
  }
  else if( relevantParameters.size() == 3 ) {
    delete _chi2Histograms3D.at( name );
    _chi2Histograms3D.at(name) = (TH3D*)(f->Get( newHistogramName.c_str() )->Clone(""));
  }
  else if( relevantParameters.size() > 3 ) {
    delete _chi2HistogramsnD.at( name );
    _chi2HistogramsnD.at(name) = (THnSparseD*)(f->Get( newHistogramName.c_str() )->Clone(""));
  }
  f->Close();
  
  // reset the directory:
  gDirectory = tempDir;

}

void Fittino::LHCLimitCalculator::CreateChi2Contributions( const boost::property_tree::ptree& ptree ) {

    Factory factory;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree.get_child("Chi2Contributions") ) {
        
       AddChi2Contribution( factory.CreateChi2Contribution( node.second, this ) );

    }

}

void Fittino::LHCLimitCalculator::Initialize() const {

}

