/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LinearInterpolationCalculator                                    *
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
#include "LinearInterpolationCalculator.h"
#include "RandomGenerator.h"
#include "SimplePrediction.h"
#include "ConfigurationException.h"

Fittino::LinearInterpolationCalculator::LinearInterpolationCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : LinearInterpolationCalculatorBase( model, ptree ) {

  _name = ptree.get<std::string>( "Name", "LinearInterpolationCalculator" );
  _tag = ptree.get<std::string>( "Tag", _name );

  AddQuantity( new SimplePrediction(  "" , "", "", "", 0., 1.e6, _chi2 ) );

  std::string histogramName = ptree.get<std::string>( "HistogramName" );

  GetHistogram( histogramName );

  CalculatePredictions();

}

Fittino::LinearInterpolationCalculator::~LinearInterpolationCalculator() {

}
