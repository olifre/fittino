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
    : LinearInterpolationCalculatorBase( model, ptree ) {

  SetName( "LHCChi2Calculator" );
  SetTag ( "LHCChi2" );

  AddQuantity( new SimplePrediction( "Value" , "", "", "", 0., 1.e6, _value ) );

  int numberOfObservedEvents = ptree.get<int>( "NumberOfObservedEvents", 0 );
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
  _histogramName = _histogramName + "_nObs_" + ss.str();
  GetHistogram();

  CalculatePredictions();

}

Fittino::LHCChi2Calculator::~LHCChi2Calculator() {

}

