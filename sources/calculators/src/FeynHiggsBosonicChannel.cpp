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

#include <iostream>
#include <fstream>

#include <boost/foreach.hpp>
#include "boost/format.hpp"
#include <boost/filesystem.hpp>
#include <boost/property_tree/ptree.hpp>

#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "CalculatorException.h"
#include "FeynHiggsBosonicChannel.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsBosonicChannel::FeynHiggsBosonicChannel( FHRealType* gammas, FHRealType* gammasms, FHComplexType* couplings, FHComplexType* couplingsms, std::string higgsName, std::string channelName, int channelNumber, bool SM )
: FeynHiggsChannel( gammas, gammasms, couplings, couplingsms, higgsName, channelName, channelNumber, SM ) {

    AddQuantity( new SimplePrediction( "g2_" + higgsName + "_" + channelName, "", _model_g2 ) );
    AddQuantity( new SimplePrediction( "gPhi_" + higgsName + "_" + channelName, "", _model_gPhi ) );

    if ( _doSM ) {

        AddQuantity( new SimplePrediction( "SM_g2_" + higgsName + "_" + channelName, "", _sm_g2 ) );
        AddQuantity( new SimplePrediction( "SM_gPhi_" + higgsName + "_" + channelName, "", _sm_gPhi ) );

        AddQuantity( new SimplePrediction( "NormSM_g2_" + higgsName + "_" + channelName, "", _normSM_g2 ) );
        AddQuantity( new SimplePrediction( "NormSM_gPhi_" + higgsName + "_" + channelName, "", _normSM_gPhi ) );

    }

}

Fittino::FeynHiggsBosonicChannel::~FeynHiggsBosonicChannel() {

}

void Fittino::FeynHiggsBosonicChannel::CalculatePredictions() {

    FeynHiggsChannel::CalculatePredictions();

    FHComplexType coup;

    coup = Coupling( _channel );
    _model_g2 = std::norm( coup );
    _model_gPhi = std::arg( coup );

    if ( _doSM ) {

        coup = CouplingSM( _channel );
        _model_g2 = std::norm( coup );
        _model_gPhi = std::arg( coup );

        _normSM_g2 = _model_g2 / _sm_g2; 
        _normSM_gPhi = _model_gPhi / _sm_gPhi;

    }

}
