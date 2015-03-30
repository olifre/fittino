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
#include "SimplePrediction.h"
#include "ConfigurationException.h"
#include "Observable.h"

Fittino::LHCLimitCalculator::LHCLimitCalculator( const ModelBase* model )
    : CalculatorBase( model ) {

    _name = "LHCLimitCalculator";

}

Fittino::LHCLimitCalculator::LHCLimitCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ) {

    _name = "LHCLimitCalculator";
    
    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree.get_child("Chi2Contributions") ) {
        std::string analysisName = node.second.get<std::string>( "Name" );
        _fileNames.insert( std::pair<std::string, std::string>( analysisName, node.second.get<std::string>( "FileName" ) ) );
        _histogramNames.insert( std::pair<std::string, std::string>( analysisName, node.second.get<std::string>( "HistogramName" ) ) );
        _nObs.insert( std::pair<std::string, int>( analysisName, node.second.get<int>( "NObs", 0 ) ) );
        
        
        
        std::vector<std::string> relevantParameters;
        BOOST_FOREACH( const boost::property_tree::ptree::value_type &subnode, node.second ) {
            if( subnode.first == "RelevantParameter" ) {
               relevantParameters.push_back( subnode.second.data() );
            }
        }
        
        std::stringstream nObs_ss;
        nObs_ss << _nObs.at( analysisName );
        std::string actualHistogramName = _histogramNames.at( analysisName ) + "_nObs_" + nObs_ss.str();
        
        AddAnalysis( analysisName, _fileNames.at( analysisName ), actualHistogramName, relevantParameters );
        

    }

}

Fittino::LHCLimitCalculator::~LHCLimitCalculator() {

}

void Fittino::LHCLimitCalculator::AddAnalysis( std::string name, std::string fileName, std::string histName, std::vector<std::string> relevantParameters ) {

    std::string predictionName = name + "_NObs";
    std::string plotName = "Number of observed events for " + name;
    AddQuantity( new SimplePrediction( predictionName, plotName, "", "", 0., 1.e6, _nObs.at(name) ) );
    
    _relevantParametersMap.insert( std::pair<std::string, std::vector<std::string> >( name, relevantParameters ) );
    _chi2Values.insert( std::pair<std::string,double>( name, 0. ) );
    AddQuantity( new SimplePrediction( name+"_chi2", "", _chi2Values.at(name) ) );
    
    if( relevantParameters.size() == 0 ) return;


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
    _chi2Values.at( (*itr).first ) = (*itr).second -> Interpolate( parameterValueMap.at((*itr).first).at(0) );
  }
  
  for( std::map<std::string, TH2D*>::const_iterator itr = _chi2Histograms2D.begin(); itr != _chi2Histograms2D.end(); ++itr ) {
    _chi2Values.at( (*itr).first ) = (*itr).second -> Interpolate( parameterValueMap.at((*itr).first).at(0), parameterValueMap.at((*itr).first).at(1) );
 }
  
  for( std::map<std::string, TH3D*>::const_iterator itr = _chi2Histograms3D.begin(); itr != _chi2Histograms3D.end(); ++itr ) {
    
    _chi2Values.at( (*itr).first ) = (*itr).second -> Interpolate( parameterValueMap.at((*itr).first).at(0), parameterValueMap.at((*itr).first).at(1), parameterValueMap.at((*itr).first).at(2) );
  }

  for( std::map<std::string, THnSparseD*>::const_iterator itr = _chi2HistogramsnD.begin(); itr != _chi2HistogramsnD.end(); ++itr ) {
    _chi2Values.at( (*itr).first ) = InterpolateND( (*itr).second, parameterValueMap.at((*itr).first) ); 
  
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

void Fittino::LHCLimitCalculator::Initialize() {

}

double Fittino::LHCLimitCalculator::InterpolateND( THnSparse *histogram, std::vector<double> parameterValues ) {

  // first step : find the 2^n nearest bins
  std::vector<double> closestHigherValues;
  std::vector<double> closestLowerValues;

  for( unsigned int i = 0; i < parameterValues.size(); ++i ) {

    bool underFlow = false;
    double maxValue = histogram->GetAxis( i )->GetBinCenter( histogram->GetAxis( i )->GetNbins() );
    double minValue = histogram->GetAxis( i )->GetBinCenter( 1 );
    if( parameterValues.at( i ) > maxValue ) {
      parameterValues.at( i ) = maxValue;
    }
    if( parameterValues.at( i ) <= minValue ) {
      parameterValues.at( i ) = minValue;
      underFlow = true;
    }

    int binIndex = histogram->GetAxis( i )->FindFixBin( parameterValues.at( i ) );
    double binCenter = histogram->GetAxis( i )->GetBinCenter( binIndex );

    if( binCenter >= parameterValues.at( i ) && !underFlow ) {
      closestHigherValues.push_back( histogram->GetAxis( i )->GetBinCenter( binIndex ) );
      closestLowerValues.push_back( histogram->GetAxis( i )->GetBinCenter( binIndex - 1 ) );
    }
    else {
      closestHigherValues.push_back( histogram->GetAxis( i )->GetBinCenter( binIndex + 1 ) );
      closestLowerValues.push_back( histogram->GetAxis( i )->GetBinCenter( binIndex ) );
    }

  }

  // got the reference points
  // now get and store the function values at the reference poitns;

  std::vector<double> referenceValues;
  std::vector<double> referenceValuesTemp;
  std::vector<std::vector<double> > binaryLowerHigher;
  binaryLowerHigher.push_back( closestLowerValues );
  binaryLowerHigher.push_back( closestHigherValues );
  std::vector<int> position( closestHigherValues.size(), 1 );
  std::vector<int> coordinates( closestHigherValues.size(), 1 );

  // loop over the 2^n points like this and fill the vector referenceValues like this:
  //
  // for each coordinate, have a 'boolean': 0 means the next lowest value, 1 means the next highest value
  // then store the referenceValues in the following order:
  // 0 0 0 0 . . .
  // 1 0 0 0 . . .
  // 0 1 0 0 . . .
  // 1 1 0 0 . . .
  // 0 0 1 0 . . .
  // 1 0 1 0 . . .
  // 0 1 1 0 . . .
  // 1 1 1 0 . . .
  // 0 0 0 1 . . .
  // so the boolean for the nth parameter switches value every 2^(n-1)th time

  for( unsigned int i = 0; i < pow( 2, closestHigherValues.size() ); ++i ) {
    for( unsigned int j = 0; j < closestHigherValues.size(); ++j ) {
      int period = pow( 2, j );
      if( i % period == 0 ) {
        position.at( j ) = ( position.at( j ) + 1 ) % 2;
      }
      coordinates.at( j ) = histogram->GetAxis( j )->FindFixBin( binaryLowerHigher.at( position.at( j ) ).at( j ) );
    }
    referenceValues.push_back( histogram->GetBinContent( &coordinates.at( 0 ) ) );
  }


  // reference values are stored. now interpolate iteratively all coordinates:
  // combine the ith and (i+1)th entry from the vector referenceValues to the interpolated value for the nth dimension, until
  // the n equals the number of dimensions from the input histogram and the new referenceValues has only 1 entry left.

  int interpolateCoordinate = 0;

  while( interpolateCoordinate < closestHigherValues.size() ) {
    referenceValuesTemp.clear();
    for( unsigned int i = 0; i < referenceValues.size(); ++i ) {
      double return_inter = referenceValues.at( i ) + ( referenceValues.at( i ) - referenceValues.at( ++i ) ) / ( closestLowerValues.at( interpolateCoordinate ) - closestHigherValues.at( interpolateCoordinate ) ) * ( parameterValues.at( interpolateCoordinate ) - closestLowerValues.at( interpolateCoordinate ) );
      referenceValuesTemp.push_back( return_inter );
    }

    // clear referenceValues and re-fill it with the interpolated values
    referenceValues.clear();
    for( unsigned int i = 0; i < referenceValuesTemp.size(); ++i ) {
      referenceValues.push_back( referenceValuesTemp.at( i ) );
    }
    interpolateCoordinate += 1;
  }

  // all done. return interplated value:
  return referenceValues.at( 0 );

}

void Fittino::LHCLimitCalculator::SetupMeasuredValues() {

    for( std::map<std::string, std::string>::const_iterator itr = _fileNames.begin(); itr != _fileNames.end(); ++itr ) { 
    
        std::string observableName = (*itr).first + "_NObs";
        int newNObs = 0;
        for( int i = 0; i < _model->GetObservableVector()->size(); ++i ) {
            if( observableName == _model->GetObservableVector()->at(i)->GetPrediction()->GetName() ) {
                newNObs = (int)_model->GetObservableVector()->at(i)->GetMeasuredValue();
                break;
            }
        }
        std::stringstream newNObs_ss;
        newNObs_ss << newNObs;
        std::string actualHistogramName = _histogramNames.at( (*itr).first ) + "_nObs_" + newNObs_ss.str();
        UpdateAnalysisHistogram( (*itr).first, (*itr).second, actualHistogramName, _relevantParametersMap.at((*itr).first) ); 

    }

}
