/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCModelCalculator.cpp                                               *
*                                                                              *
* Description Base class for SLHA compatible model calculators                 *
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
    int binx = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( binx );
  }
  
  for( std::map<std::string, TH2D*>::const_iterator itr = _chi2Histograms2D.begin(); itr != _chi2Histograms2D.end(); ++itr ) {
    int binx = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    int biny = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue() );
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( binx, biny );
  }
  
  for( std::map<std::string, TH3D*>::const_iterator itr = _chi2Histograms3D.begin(); itr != _chi2Histograms3D.end(); ++itr ) {
    int binx = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(0))->GetValue() );
    int biny = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(1))->GetValue() );
    int binz = (*itr).second->GetXaxis()->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(2))->GetValue() );
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( binx, biny, binz );
  }

  for( std::map<std::string, THnSparseD*>::const_iterator itr = _chi2HistogramsnD.begin(); itr != _chi2HistogramsnD.end(); ++itr ) {
    
    std::vector<int> bins;
    for( int i = 0; i < _relevantParametersMap.at((*itr).first).size(); ++i ) {
      bins.push_back( (*itr).second->GetAxis( i )->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(i))->GetValue() ) );
    }
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( &bins.at(0) );
  }

}

void Fittino::LHCModelCalculator::Initialize() const {

}

void Fittino::LHCModelCalculator::CallExecutable() {

}

void Fittino::LHCModelCalculator::CallFunction() {

}

void Fittino::LHCModelCalculator::ConfigureInput() {

}
