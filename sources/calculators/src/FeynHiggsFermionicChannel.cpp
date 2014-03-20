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

#include <iostream>
#include <fstream>

#include <boost/foreach.hpp>
#include "boost/format.hpp"
#include <boost/filesystem.hpp>
#include <boost/property_tree/ptree.hpp>

#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "CalculatorException.h"
#include "FeynHiggsFermionicChannel.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsFermionicChannel::FeynHiggsFermionicChannel( FHRealType* gammas, FHRealType* gammasms, FHComplexType* couplings, FHComplexType* couplingsms, std::string higgsName, std::string channelName, int channelNumber, bool SM )
: FeynHiggsChannel( gammas, gammasms, couplings, couplingsms, higgsName, channelName, channelNumber, SM ) {

}

Fittino::FeynHiggsFermionicChannel::~FeynHiggsFermionicChannel() {

}

void Fittino::FeynHiggsFermionicChannel::CalculatePredictions() {

    FeynHiggsChannel::CalculatePredictions();

    FHComplexType coup;

    coup = RCoupling( _channel ) + LCoupling( _channel );
    coup  = coup / 2.;
    _gs2 = std::norm( coup );
    _gsPhi = std::arg( coup );

    coup = RCoupling( _channel) - LCoupling( _channel );
    coup = coup / FHComplexType( 0, 2 );
    _gp2 = std::norm( coup );
    _gpPhi = std::arg( coup );

//     _g2 = std::norm( Coupling( _channel ) );
//      _gPhi = std::arg( Coupling( _channel ) );
        

    
}

