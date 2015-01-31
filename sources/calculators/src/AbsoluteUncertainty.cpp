/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AbsoluteUncertainty.cpp                                          *
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

#include "AbsoluteUncertainty.h"
#include "Quantity.h"

Fittino::AbsoluteUncertainty::AbsoluteUncertainty(ModelBase const *model, const Measurement *observable, const boost::property_tree::ptree &ptree)
: UncertaintyBase(model, observable, ptree) {

    double value =  ptree.get<double>( "Value", 0 );
    _valueMinus = ptree.get<double>( "ValueMinus", value );
    _valuePlus = ptree.get<double>( "ValuePlus", value );

    Update();
}

Fittino::AbsoluteUncertainty::~AbsoluteUncertainty() {


}

void Fittino::AbsoluteUncertainty::Update() {

    if ( _observable->GetPrediction()->GetValue() < _observable->GetCollectionOfQuantities().At("Measurement")->GetValue() ) {

        _value = _valueMinus;

    }
    else {

        _value = _valuePlus;

    }

}
