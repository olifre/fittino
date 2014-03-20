/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsChannel.cpp                     *
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
#include "FeynHiggsChannel.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsChannel::FeynHiggsChannel( FHRealType* gammas, FHRealType* gammasms, FHComplexType* couplings, FHComplexType* couplingsms, std::string higgsName, std::string channelName, int channelNumber, bool SM )
: CalculatorBase( 0 ) {

    _name = "FeynHiggsChannel";
    _channel = channelNumber;

    _doSM = SM;

    this->gammas = gammas;
    this->gammasms = gammasms;
    this->couplings = couplings;
    this->couplingsms = couplingsms;

    AddQuantity( new SimplePrediction( "Gamma_" + higgsName + "_to_" + channelName, "", _model_Gamma ) );
    AddQuantity( new SimplePrediction( "BR_" + higgsName + "_to_" + channelName, "", _model_BR ) );

    if ( _doSM ){

        AddQuantity( new SimplePrediction( "NormSM_Gamma_" + higgsName + "_to_" + channelName, "", _normSM_Gamma ) );
        AddQuantity( new SimplePrediction( "SM_Gamma_" + higgsName + "_to_" + channelName, "", _sm_Gamma ) );
        AddQuantity( new SimplePrediction( "SM_BR_" + higgsName + "_to_" + channelName, "", _sm_BR ) );
        AddQuantity( new SimplePrediction( "NormSM_BR_" + higgsName + "_to_" + channelName, "", _normSM_BR ) );
    }

}

Fittino::FeynHiggsChannel::~FeynHiggsChannel() {

}

void Fittino::FeynHiggsChannel::CalculatePredictions() {

    _model_Gamma = Gamma( _channel );
    _model_BR = BR( _channel );

    if ( _doSM ) {

        _sm_Gamma = GammaSM( _channel );
        _normSM_Gamma = _model_Gamma / _sm_Gamma;

        _sm_BR = BRSM( _channel );
        _normSM_BR = _model_BR / _sm_BR;

    }

}

