/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsFermionicChannel.cpp                                    *
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
#include "FeynHiggsFermionicChannel.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsFermionicChannel::FeynHiggsFermionicChannel( FHRealType* gammas, FHRealType* gammasms, FHComplexType* couplings, FHComplexType* couplingsms, std::string higgsName, std::string channelName, int channelNumber, bool SM )
: FeynHiggsChannel( gammas, gammasms, couplings, couplingsms, higgsName, channelName, channelNumber, SM ) {

    AddQuantity( new SimplePrediction( "gs_Abs_" + higgsName + "_" + channelName, "", _model_gs_Abs ) );
    AddQuantity( new SimplePrediction( "gs_Arg_" + higgsName + "_" + channelName, "", _model_gs_Arg ) );

    AddQuantity( new SimplePrediction( "gp_Abs_" + higgsName + "_" + channelName, "", _model_gp_Abs ) );
    AddQuantity( new SimplePrediction( "gp_Arg_" + higgsName + "_" + channelName, "", _model_gp_Arg ) );

    if ( _doSM ) {

        AddQuantity( new SimplePrediction( "SM_gs_Abs_" + higgsName + "_" + channelName, "", _sm_gs_Abs ) );
        AddQuantity( new SimplePrediction( "SM_gs_Arg_" + higgsName + "_" + channelName, "", _sm_gs_Arg ) );

        AddQuantity( new SimplePrediction( "SM_gp_Abs_" + higgsName + "_" + channelName, "", _sm_gp_Abs ) );
        AddQuantity( new SimplePrediction( "SM_gp_Arg_" + higgsName + "_" + channelName, "", _sm_gp_Arg ) );

        AddQuantity( new SimplePrediction( "NormSM_gs_Abs_" + higgsName + "_" + channelName, "", _normSM_gs_Abs ) );

        AddQuantity( new SimplePrediction( "NormSM_gp_Abs_" + higgsName + "_" + channelName, "", _normSM_gp_Abs ) );

        AddQuantity( new SimplePrediction( "NormSM_g_Abs" + higgsName + "_" + channelName, "", _normSM_g_Abs ) );
        AddQuantity( new SimplePrediction( "NormSM_g_Abs2" + higgsName + "_" + channelName, "", _normSM_g_Abs2 ) );

    }

}

Fittino::FeynHiggsFermionicChannel::~FeynHiggsFermionicChannel() {

}

void Fittino::FeynHiggsFermionicChannel::CalculatePredictions() {

    FeynHiggsChannel::CalculatePredictions();

    FHComplexType coup;

    coup = RCoupling( _channel ) + LCoupling( _channel );
    coup = coup / FHComplexType( 2, 0 );

    _model_gs_Abs = std::abs( coup );
    _model_gs_Arg = std::arg( coup );

    coup = RCoupling( _channel) - LCoupling( _channel );
    coup = coup / FHComplexType( 0, 2 );

    _model_gp_Abs = std::abs( coup );
    _model_gp_Arg = std::arg( coup );

    if ( _doSM ) {
        
        coup  = RCouplingSM( _channel ) + LCouplingSM( _channel );
        coup  = coup / FHComplexType( 2, 0 );

        _sm_gs_Abs = std::abs( coup );
        _sm_gs_Arg = std::arg( coup );

        coup = RCouplingSM( _channel) - LCouplingSM( _channel );
        coup = coup / FHComplexType( 0, 2 );

        _sm_gp_Abs = std::abs( coup );
        _sm_gp_Arg = std::arg( coup );

        coup = RCoupling( _channel) / RCouplingSM( _channel ) + LCoupling( _channel ) / LCouplingSM( _channel );
        _normSM_gs_Abs   = std::abs( coup ) / 2.;

        coup = RCoupling( _channel) / RCouplingSM( _channel ) - LCoupling( _channel ) / LCouplingSM( _channel );
        _normSM_gp_Abs   = std::abs( coup ) / 2.;

        _normSM_g_Abs2 = TMath::Power( _normSM_gs_Abs, 2 ) + TMath::Power( _normSM_gp_Abs, 2 );

        _normSM_g_Abs   = TMath::Sqrt( _normSM_g_Abs2 );

    }

}

