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
    double chi2Value = 0.;
    //std::vector<int> bins;
    //for( int i = 0; i < _relevantParametersMap.at((*itr).first).size(); ++i ) {
    //  bins.push_back( (*itr).second->GetAxis( i )->FindFixBin( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(i))->GetValue() ) );
    //}
    //_simpleOutputDataStorage->GetMap()->at( (*itr).first ) = (*itr).second -> GetBinContent( &bins.at(0) );
    
    /* have to do the interpolation by hand? Find out how to do this better... */
    // first step: Find 2^n closesst points.
    std::vector<double> parameterValues;
    for( unsigned int i = 0; i < _relevantParametersMap.at( (*itr).first).size(); ++i ) {
      parameterValues.push_back( _model->GetCollectionOfParameters().At( _relevantParametersMap.at((*itr).first).at(i))->GetValue() );
    }

    std::vector<double> closestHigherValues;
    std::vector<double> closestLowerValues;
    for( unsigned int i = 0; i < parameterValues.size(); ++i ) {

      bool overFlow = false;
      double maxValue = (*itr).second->GetAxis( i )->GetBinCenter( (*itr).second->GetAxis( i )->GetNbins() );
      double minValue = (*itr).second->GetAxis( i )->GetBinCenter( 1 );
      if( parameterValues.at(i) > maxValue ) { parameterValues.at(i) = maxValue; overFlow = true; }
      if( parameterValues.at(i) < minValue ) { parameterValues.at(i) = minValue; }

      int binIndex = (*itr).second->GetAxis( i )->FindFixBin( parameterValues.at(i) );
      double binCenter = (*itr).second->GetAxis( i )->GetBinCenter( binIndex );
      
      if( binCenter >= parameterValues.at(i) && !overFlow ) {
        closestHigherValues.push_back((*itr).second->GetAxis( i )->GetBinCenter(binIndex));
        closestLowerValues.push_back((*itr).second->GetAxis( i )->GetBinCenter(binIndex-1));
      }
      else {
        closestHigherValues.push_back((*itr).second->GetAxis( i )->GetBinCenter(binIndex+1));
        closestLowerValues.push_back((*itr).second->GetAxis( i )->GetBinCenter(binIndex));
      }
        
    }
    
    // now have the parameter value; now store the chi2 values:
    
    std::vector<double> chi2Values;
    std::vector<double> chi2ValuesTemp;
    std::vector<std::vector<double> > binaryLowerHigher;
    binaryLowerHigher.push_back( closestLowerValues );
    binaryLowerHigher.push_back( closestHigherValues );
    std::vector<int> position( closestHigherValues.size(), 1 );
    std::vector<int> coordinates( closestHigherValues.size(), 1);
    
    for( unsigned int i = 0; i < pow(2, closestHigherValues.size()); ++i ) {
      for( unsigned int j = 0; j < closestHigherValues.size(); ++j ) {
        int period = pow(2, j );
        if( i%period == 0 ) {
            position.at(j) = (position.at(j)+1)%2;
        }
        coordinates.at(j) = (*itr).second->GetAxis(j)->FindFixBin( binaryLowerHigher.at(position.at(j)).at(j));
      }
      chi2Values.push_back( (*itr).second->GetBinContent( &coordinates.at(0) ));
    }
    int interpolateCoordinate = 0;
    while( interpolateCoordinate < closestHigherValues.size() ) {
      chi2ValuesTemp.clear();
      for( unsigned int i = 0; i < chi2Values.size(); ++i ) {
        double chi2_inter = chi2Values.at(i)+ (chi2Values.at(i)-chi2Values.at(++i))/(closestLowerValues.at(interpolateCoordinate)-closestHigherValues.at(interpolateCoordinate))*(parameterValues.at(interpolateCoordinate)-closestLowerValues.at(interpolateCoordinate));
        chi2ValuesTemp.push_back(chi2_inter);
      }
      chi2Values.clear();
      for( unsigned int i = 0; i < chi2ValuesTemp.size(); ++i ) {
        chi2Values.push_back( chi2ValuesTemp.at(i) );
      }
      interpolateCoordinate += 1;
    }
    chi2Value = chi2Values.at(0);
    _simpleOutputDataStorage->GetMap()->at( (*itr).first ) = chi2Value; 
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
