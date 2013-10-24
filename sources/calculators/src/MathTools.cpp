/*******************************************************************************
*                                        *
* Project   Fittino - A SUSY Parameter Fitting Package             *
*                                        *
* File    MathTools.cpp                         *
*                                        *
* Description Collection of useful functions
*                                        *
* Authors   Matthias Hamer  <mhamer@gwdg.de>                 *
*                                        *
* Licence   This program is free software; you can redistribute it and/or  *
*       modify it under the terms of the GNU General Public License as   *
*	    published by the Free Software Foundation; either version 3 of     *
*	    the License, or (at your option) any later version.          *
*                                        *
*******************************************************************************/

#include <stdlib.h>
#include <vector>

#include "THnSparse.h"
#include "TAxis.h"

#include "MathTools.h"

double Fittino::MathTools::InterpolateND( THnSparse *histogram, std::vector<double> parameterValues ) {

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
