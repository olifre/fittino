
/* $Id: HosakiModel.cpp 1947 2014-03-02 19:54:40Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HosakiModel.cpp                                              *
*                                                                              *
* Description Implementation of a n-dimensional HosakiModel function                           *
*                                                                              *
* Authors     Pia     Kullik      <pkullik@uni-bonn.de>                        *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include "ModelParameter.h"
#include "HosakiModel.h"

Fittino::HosakiModel::HosakiModel( const boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "HosakiModel";

    TestModelBase::Initialize();

}

Fittino::HosakiModel::~HosakiModel() {

}

Fittino::HosakiModel* Fittino::HosakiModel::Clone() const {

    return new HosakiModel( *this );

}

double Fittino::HosakiModel::ToRadians(double x){
    return (x * M_PI) / 180;
}

double Fittino::HosakiModel::TestModelFunction() {

    double HosakiModel = 0;
    double x1 = GetCollectionOfParameters().At(0)->GetValue(), x2 = GetCollectionOfParameters().At(1)->GetValue();
    HosakiModel = (1 - (8*x1) + (7 * pow(x1, 2)) - ((7/3) * pow(x1, 3)) + (0.25 * pow(x1, 4))) * pow(x2, 2) * exp(-x1);
    return HosakiModel;

}
