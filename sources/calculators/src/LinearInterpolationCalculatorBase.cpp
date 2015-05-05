/* $Id: LHCChi2Calculator.cpp 2481 2015-02-18 23:35:23Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LinearInterpolationCalculatorBase.cpp                            *
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

#include <boost/lexical_cast.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/foreach.hpp>

#include "TFile.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TH3D.h"
#include "TMath.h"

#include "ModelBase.h"
#include "LinearInterpolationCalculatorBase.h"
#include "SimplePrediction.h"

Fittino::LinearInterpolationCalculatorBase::LinearInterpolationCalculatorBase( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model, &ptree ) {

  _filePath      = GetConfiguration()->get<std::string>( "File"      );
  _histogramName = GetConfiguration()->get<std::string>( "Histogram" );

  _nDimensions = 0;

  BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree ) {

          if( node.first != "Variable" ) continue;

          std::string variableName = node.second.get_value<std::string>();

          AddInput( boost::lexical_cast<std::string>( _nDimensions ), variableName );

          ++_nDimensions;

        }

  _interpolationPoint.resize( _nDimensions );

  _file = TFile::Open( _filePath.c_str(), "READ" );

}

Fittino::LinearInterpolationCalculatorBase::~LinearInterpolationCalculatorBase() {

  if ( _nDimensions == 1 ) {

      delete _histogram1D;

  }
  else if ( _nDimensions == 2 ) {

      delete _histogram2D;

  }
  else if ( _nDimensions == 3 ) {

      delete _histogram3D;

  }
  else {

      delete _histogramnD;

  }

  _file->Close();
  delete _file;

}

void Fittino::LinearInterpolationCalculatorBase::GetHistogram() {

  TObject* object = _file->Get( _histogramName.c_str() );

  if ( ! object ) {

    throw ConfigurationException( "Histogram " + _histogramName + " does not exist."  );

  }

  if ( _nDimensions == 1 ) {

    _histogram1D = dynamic_cast< TH1D* >( object );

  }
    else if ( _nDimensions ==2 ) {

    _histogram2D = dynamic_cast< TH2D* >( object );

  }
  else if ( _nDimensions ==3 ) {

    _histogram3D = dynamic_cast< TH3D* >( object );

  }
  else {

    _histogramnD = dynamic_cast< THnSparseD* >( object );

  }

}

void Fittino::LinearInterpolationCalculatorBase::CalculatePredictions() {

  UpdateInput();

  for (unsigned int i = 0; i < _nDimensions; i++ ) {

    _interpolationPoint[i] = GetInput( boost::lexical_cast<std::string>( i ) );

  }

  if ( _nDimensions == 1 ) {

    _value = _histogram1D->Interpolate( _interpolationPoint[0] );

  }
  else if ( _nDimensions == 2 ) {

    _value = _histogram2D->Interpolate( _interpolationPoint[0], _interpolationPoint[1] );

  }
  else if ( _nDimensions == 3 ) {

    _value = _histogram3D->Interpolate( _interpolationPoint[0], _interpolationPoint[1], _interpolationPoint[2] );

  }
  else {

    InterpolateND();

  }

}

void Fittino::LinearInterpolationCalculatorBase::InterpolateND() {

  // first step : find the nearest bins

  std::vector<int> closestHigherBinIndices( _nDimensions );
  std::vector<int> closestLowerBinIndices( _nDimensions );

  for( unsigned int iDimension = 0; iDimension < _nDimensions; ++iDimension) {

    bool underFlow = false;
    double maxValue = _histogramnD->GetAxis( iDimension )->GetBinCenter( _histogramnD->GetAxis( iDimension )->GetNbins() );
    double minValue = _histogramnD->GetAxis( iDimension )->GetBinCenter( 1 );

    if( _interpolationPoint.at( iDimension ) > maxValue ) {

      _interpolationPoint.at( iDimension ) = maxValue;
      
    }
    if( _interpolationPoint.at( iDimension ) <= minValue ) {

      _interpolationPoint.at( iDimension ) = minValue;
      underFlow = true;

    }

    int binIndex = _histogramnD->GetAxis( iDimension )->FindFixBin( _interpolationPoint.at( iDimension ) );
    double binCenter = _histogramnD->GetAxis( iDimension )->GetBinCenter( binIndex );

    if( binCenter >= _interpolationPoint.at( iDimension ) && !underFlow ) {

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

  unsigned int nReferencePoints = TMath::Power( 2, static_cast<int>( _nDimensions ) );
  std::vector<double> referenceFunctionValues( nReferencePoints );

  for( unsigned int iReferencePoint = 0; iReferencePoint < nReferencePoints; ++iReferencePoint) {

    std::bitset<100> bits(iReferencePoint);
    std::vector<int> binIndices;

    for( unsigned int iDimension = 0; iDimension < _nDimensions; ++iDimension ) {

      int binIndex;

      if ( bits.test( iDimension ) ) {

        binIndex = closestHigherBinIndices.at( iDimension );

      }
      else {

        binIndex = closestLowerBinIndices.at( iDimension );

      }

      binIndices.push_back( binIndex );

    }

    referenceFunctionValues.at( iReferencePoint ) = _histogramnD->GetBinContent ( &binIndices.at(0) );

  }

  // reference values are stored. now interpolate iteratively all coordinates:
  // combine the ith and (i+1)th entry from the vector referenceValues to the interpolated value for the nth dimension, until
  // the n equals the number of dimensions from the input histogram and the new referenceValues has only 1 entry left.

  for ( unsigned int iDimension = 0; iDimension < _nDimensions; iDimension++ ) {

    std::vector<double> referenceValuesTemp;

    double x = _interpolationPoint.at( iDimension );
    double x0 = _histogramnD->GetAxis( iDimension )->GetBinCenter( closestLowerBinIndices.at( iDimension ) );
    double x1 = _histogramnD->GetAxis( iDimension )->GetBinCenter( closestHigherBinIndices.at( iDimension ) );

    for( unsigned int i = 0; i < referenceFunctionValues.size(); i += 2 ) {

      double y0 = referenceFunctionValues.at( i );
      double y1 = referenceFunctionValues.at( i + 1 );

      double y = y0 + ( y1 - y0 )  /  ( x1 - x0 ) * ( x - x0 );

      referenceValuesTemp.push_back( y );

    }

    referenceFunctionValues = referenceValuesTemp;

  }

  _value = referenceFunctionValues.at( 0 );

}
