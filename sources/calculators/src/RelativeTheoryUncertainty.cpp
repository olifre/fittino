/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RelativeTheoryUncertainty.cpp                                    *
*                                                                              *
* Description                                                                  *
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

#include "RelativeTheoryUncertainty.h"
#include "Quantity.h"

Fittino::RelativeTheoryUncertainty::RelativeTheoryUncertainty(ModelBase const *model, const Measurement *observable, const boost::property_tree::ptree &ptree)
: UncertaintyBase(model, observable, ptree) {

    _relativeValue =  ptree.get<double>( "Value" );

    Update();
}

Fittino::RelativeTheoryUncertainty::~RelativeTheoryUncertainty() {


}

void Fittino::RelativeTheoryUncertainty::Update() {

    _value = _relativeValue * _observable->GetPrediction()->GetValue();

}
