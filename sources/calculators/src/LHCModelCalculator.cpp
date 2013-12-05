/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCModelCalculator.cpp                                           *
*                                                                              *
* Description Base class for LHC Calculator                                    *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of       *
*	      the License, or (at your option) any later version.                  *
*                                                                              *
*******************************************************************************/

#include <stdlib.h>

#include <iostream>
#include <map>
#include <vector>
#include <string>

#include "TFile.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TH3D.h"
#include "THnSparse.h"

#include "PhysicsModelBase.h"
#include "ModelParameterBase.h"
#include "LHCModelCalculator.h"
#include "SimpleDataStorage.h"
#include "ConfigurationException.h"
#include "MathTools.h"

Fittino::LHCModelCalculator::LHCModelCalculator( const PhysicsModelBase* model )
    : ModelCalculatorBase( model ) {

    _name = "LHCModelCalculator";

}

Fittino::LHCModelCalculator::~LHCModelCalculator() {

}

void Fittino::LHCModelCalculator::AddAnalysis( std::string name, std::string fileName, std::string histName, std::vector<std::string> relevantParameters ) {

    if( relevantParameters.size() == 0 ) return;



    _relevantParametersMap.insert( std::pair<std::string, std::vector<std::string> >( name, relevantParameters ) );
    _simpleOutputDataStorage->AddEntry( name, 0. );
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

}

void Fittino::LHCModelCalculator::CalculatePredictions() {

  for( std::map<std::string, TH1D*>::const_iterator itr = _chi2Histograms1D.begin(); itr != _chi2Histograms1D.end(); ++itr ) {
    //int binx = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( binx );
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> Interpolate( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
  }
  
  for( std::map<std::string, TH2D*>::const_iterator itr = _chi2Histograms2D.begin(); itr != _chi2Histograms2D.end(); ++itr ) {
    //int binx = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    //int biny = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue() );
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( binx, biny );
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> Interpolate( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue(), _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue() );
 }
  
  for( std::map<std::string, TH3D*>::const_iterator itr = _chi2Histograms3D.begin(); itr != _chi2Histograms3D.end(); ++itr ) {
    //int binx = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    //int biny = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue() );
    //int binz = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(2))->GetValue() );
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( binx, biny, binz );
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> Interpolate( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue(), _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue(), _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(2))->GetValue() );
  }

  for( std::map<std::string, THnSparseD*>::const_iterator itr = _chi2HistogramsnD.begin(); itr != _chi2HistogramsnD.end(); ++itr ) {
    std::vector<double> parameterValues;
    for( unsigned int i = 0; i < _relevantParametersMap.at( (*itr).first).size(); ++i ) {
      parameterValues.push_back( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(i))->GetValue() );
    }
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = Fittino::MathTools::InterpolateND( (*itr).second, parameterValues ); 
  }

}

void Fittino::LHCModelCalculator::UpdateAnalysisHistogram( std::string name, std::string fileName, std::string newHistogramName, std::vector<std::string> relevantParameters ) {

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
}

void Fittino::LHCModelCalculator::Initialize() const {

}

void Fittino::LHCModelCalculator::CallExecutable() {

}

void Fittino::LHCModelCalculator::CallFunction() {

}

void Fittino::LHCModelCalculator::ConfigureInput() {

}
