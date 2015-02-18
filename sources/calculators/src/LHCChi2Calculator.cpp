/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCChi2Calculator.cpp                                           *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <string>
#include <bitset>

#include <boost/property_tree/ptree.hpp>
#include <boost/foreach.hpp>

#include "TFile.h"
#include "TH1D.h"
#include "TMath.h"

#include "ModelBase.h"
#include "LHCChi2Calculator.h"
#include "RandomGenerator.h"
#include "SimplePrediction.h"
#include "ConfigurationException.h"

Fittino::LHCChi2Calculator::LHCChi2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ) {

  _name = ptree.get<std::string>( "Name", "LHCChi2Calculator" );
  _tag = ptree.get<std::string>( "Tag", _name );


  AddQuantity( new SimplePrediction(  "Chi2" , "", "", "", 0., 1.e6, _chi2 ) );

  BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree ) {

          if( node.first == "Variable" ) {

            std::string variableName = node.second.get_value<std::string>();
            const Quantity* variable = model->GetCollectionOfQuantities().At( variableName );
            _variables.push_back( variable );

          }

        }

  int numberOfObservedEvents = ptree.get<int>( "NumberOfObservedEvents", 0 );
  std::string filePath = ptree.get<std::string>( "File" );
  std::string histogramBaseName = ptree.get<std::string>( "HistogramBaseName" );

  bool toyrun = ptree.get<bool>( "ToyRun", false );

  if ( toyrun ) {

    double nBackgroundOrig  = ptree.get<double>( "NumberOfBackgroundEvents" );
    double backgroundUncertainty  = ptree.get<double>( "RelativeBackgroundUncertainty" );
    double nBackground = nBackgroundOrig * RandomGenerator::GetInstance()->Gaus( 1., backgroundUncertainty );

    // todo: Determine this number from Best Fit parameters!
    double nSignalOrig  = ptree.get<double>( "NumberOfSignalEventsAtBestFitPoint" );
    double signalUncertainty = ptree.get<double>( "RelativeSignalUncertainty" );
    double nSignal = nSignalOrig * RandomGenerator::GetInstance()->Gaus( 1., signalUncertainty );

    numberOfObservedEvents = RandomGenerator::GetInstance()->Poisson( nBackground + nSignal );

  }

  std::stringstream ss;
  ss << numberOfObservedEvents;
  std::string histogramName = histogramBaseName + "_nObs_" + ss.str();

  TFile* file = TFile::Open( filePath.c_str(), "READ" );
  TObject* object =  file->Get( histogramName.c_str() );

  if ( ! object ) {

      throw ConfigurationException( "Histogram " + histogramName + " does not exist."  );

  }

  if ( _variables.size() <= 3 ) {

    _chi2Histogram = dynamic_cast< TH1D* >( object->Clone( "" ) );

  }
  else {

    _chi2HistogramnD = dynamic_cast< THnSparseD* >( object->Clone( "" ) );

  }

  delete object;
  file->Close();

  CalculatePredictions();

}

Fittino::LHCChi2Calculator::~LHCChi2Calculator() {

}

void Fittino::LHCChi2Calculator::CalculatePredictions() {

  std::vector<double> interpolationPoint( _variables.size() );

  for (unsigned int i = 0; i < _variables.size(); i++ ) {

    interpolationPoint[i] = _variables[i]->GetValue();

  }

  if ( _variables.size() == 1 ) {

    _chi2 = _chi2Histogram->Interpolate( interpolationPoint[0] );

  }
  else if ( _variables.size() == 2 ) {

    _chi2 = _chi2Histogram->Interpolate( interpolationPoint[0], interpolationPoint[1] );

  }
  else if ( _variables.size() == 3 ) {

    _chi2 = _chi2Histogram->Interpolate( interpolationPoint[0], interpolationPoint[1], interpolationPoint[2] );

  }
  else {

    _chi2 = InterpolateND( _chi2HistogramnD, interpolationPoint );

  }

}

double Fittino::LHCChi2Calculator::InterpolateND( THnSparse *histogram, std::vector<double> interpolationPoint) {

  unsigned int nDimensions = interpolationPoint.size();

  // first step : find the nearest bins

  std::vector<int> closestHigherBinIndices( nDimensions );
  std::vector<int> closestLowerBinIndices( nDimensions );

  for( unsigned int iDimension = 0; iDimension < nDimensions; ++iDimension) {

    bool underFlow = false;
    double maxValue = histogram->GetAxis( iDimension )->GetBinCenter( histogram->GetAxis( iDimension )->GetNbins() );
    double minValue = histogram->GetAxis( iDimension )->GetBinCenter( 1 );

    if( interpolationPoint.at( iDimension ) > maxValue ) {

      interpolationPoint.at( iDimension ) = maxValue;
      
    }
    if( interpolationPoint.at( iDimension ) <= minValue ) {

      interpolationPoint.at( iDimension ) = minValue;
      underFlow = true;

    }

    int binIndex = histogram->GetAxis( iDimension )->FindFixBin( interpolationPoint.at( iDimension ) );
    double binCenter = histogram->GetAxis( iDimension )->GetBinCenter( binIndex );

    if( binCenter >= interpolationPoint.at( iDimension ) && !underFlow ) {

      closestHigherBinIndices.at( iDimension ) = binIndex;
      closestLowerBinIndices.at( iDimension ) =  binIndex - 1;

    }
    else {

      closestHigherBinIndices.at( iDimension ) = binIndex + 1 ;
      closestLowerBinIndices.at( iDimension ) = binIndex;

    }

  }

  // now get and store the function values at the reference points;
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

  unsigned int nReferencePoints = TMath::Power( 2, static_cast<int>( nDimensions ) );
  std::vector<double> referenceFunctionValues( nReferencePoints );

  for( unsigned int iReferencePoint = 0; iReferencePoint < nReferencePoints; ++iReferencePoint) {

    std::bitset<100> bits(iReferencePoint);
    std::vector<int> binIndices;

    for( unsigned int iDimension = 0; iDimension < nDimensions; ++iDimension ) {

      int binIndex;

      if ( bits.test( iDimension ) ) {

        binIndex = closestHigherBinIndices.at( iDimension );

      }
      else {

        binIndex = closestLowerBinIndices.at( iDimension );

      }

      binIndices.push_back( binIndex );

    }

    referenceFunctionValues.at( iReferencePoint ) = histogram->GetBinContent ( &binIndices.at(0) );

  }

  // reference values are stored. now interpolate iteratively all coordinates:
  // combine the ith and (i+1)th entry from the vector referenceValues to the interpolated value for the nth dimension, until
  // the n equals the number of dimensions from the input histogram and the new referenceValues has only 1 entry left.

  for ( unsigned int iDimension = 0; iDimension < nDimensions; iDimension++ ) {

    std::vector<double> referenceValuesTemp;

    double x = interpolationPoint.at( iDimension );
    double x0 = histogram->GetAxis( iDimension )->GetBinCenter( closestLowerBinIndices.at( iDimension ) );
    double x1 = histogram->GetAxis( iDimension )->GetBinCenter( closestHigherBinIndices.at( iDimension ) );

    for( unsigned int i = 0; i < referenceFunctionValues.size(); i += 2 ) {

      double y0 = referenceFunctionValues.at( i );
      double y1 = referenceFunctionValues.at( i + 1 );

      double y = y0 + ( y1 - y0 )  /  ( x1 - x0 ) * ( x - x0 );

      referenceValuesTemp.push_back( y );

    }

    referenceFunctionValues = referenceValuesTemp;

  }

  // all done. return interpolated value:
  return referenceFunctionValues.at( 0 );

}
