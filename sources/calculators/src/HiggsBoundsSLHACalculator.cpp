/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsBoundsSLHACalculator.cpp                                    *
*                                                                              *
* Description Wrapper class for HiggsBounds                                    *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include <boost/thread.hpp>

#include "CHiggsSignals.h"
#include "ConfigurationException.h"
#include "HiggsBoundsSLHACalculator.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "Observable.h"

Fittino::HiggsBoundsSLHACalculator::HiggsBoundsSLHACalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : HiggsBoundsCalculator( model, ptree ) {

}

Fittino::HiggsBoundsSLHACalculator::~HiggsBoundsSLHACalculator() {

}

void Fittino::HiggsBoundsSLHACalculator::setupHiggsBounds() {

    std::string filename = "SPheno.spc";
    int length = filename.length();
    char charfilename[256];
    sprintf( charfilename, "%s", filename.c_str() );
    higgsbounds_input_slha_( charfilename, &length );

}
