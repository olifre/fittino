/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsBosonicChannel.cpp                                      *
 *                                                                              *
 * Description Wrapper class for FeynHiggs                                      *
 *                                                                              *
 * Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#include "TMath.h"

#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "CalculatorException.h"
#include "FeynHiggsBosonicChannel.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsBosonicChannel::FeynHiggsBosonicChannel( FHRealType* gammas, FHRealType* gammasms, FHComplexType* couplings, FHComplexType* couplingsms, std::string higgsName, std::string channelName, int channelNumber, bool SM )
: FeynHiggsChannel( gammas, gammasms, couplings, couplingsms, higgsName, channelName, channelNumber, SM ) {

    AddQuantity( new SimplePrediction( "g_Abs_" + higgsName + "_" + channelName, "", _model_g_Abs ) );
    AddQuantity( new SimplePrediction( "g_Arg_" + higgsName + "_" + channelName, "", _model_g_Arg ) );

    if ( _doSM ) {

        AddQuantity( new SimplePrediction( "SM_g_Abs_" + higgsName + "_" + channelName, "", _sm_g_Abs ) );
        AddQuantity( new SimplePrediction( "SM_g_Arg_" + higgsName + "_" + channelName, "", _sm_g_Arg ) );

        AddQuantity( new SimplePrediction( "NormSM_g_Abs_" + higgsName + "_" + channelName, "", _normSM_g_Abs ) );
        AddQuantity( new SimplePrediction( "NormSM_g_Abs2_" + higgsName + "_" + channelName, "", _normSM_g_Abs2 ) );

    }

}

Fittino::FeynHiggsBosonicChannel::~FeynHiggsBosonicChannel() {

}

void Fittino::FeynHiggsBosonicChannel::CalculatePredictions() {

    FeynHiggsChannel::CalculatePredictions();

    FHComplexType coup;

    coup = Coupling( _channel );

    _model_g_Abs   = std::abs( coup );
    _model_g_Arg   = std::arg( coup );

    if ( _doSM ) {

        coup = CouplingSM( _channel );

        _sm_g_Abs   = std::abs( coup );
        _sm_g_Arg   = std::arg( coup );

        _normSM_g_Abs   =  _model_g_Abs / _sm_g_Abs;
        _normSM_g_Abs2  = TMath::Power( _normSM_g_Abs, 2 );

    }
    
}

