/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        MicromegasCalculator.cpp                                         *
 *                                                                              *
 * Description Wrapper class for Micromegas                                     *
 *                                                                              *
 * Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#include <boost/property_tree/ptree.hpp>

#include "MicromegasCalculator.h"

Fittino::MicromegasCalculator::MicromegasCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
:MicromegasWrapper( model ) {



}

Fittino::MicromegasCalculator::~MicromegasCalculator() {

}

