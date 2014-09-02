/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HosakiModel.cpp                                                  *
*                                                                              *
* Description Implementation of a n-dimensional HosakiModel function           *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>                                *
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

Fittino::HosakiModel::HosakiModel( boost::property_tree::ptree& ptree )
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
    double x1 = 0.5*GetCollectionOfParameters().At(0)->GetValue(), x2 = 0.5*GetCollectionOfParameters().At(1)->GetValue();
    HosakiModel =  (1 + 7*x1*x1 - 8*x1 - 2.33333333333333*x1*x1*x1 + 0.25*x1*x1*x1*x1)*x2* x2*exp(-x2);
    if(GetCollectionOfParameters().At(0)->GetValue()>=GetCollectionOfParameters().At(0)->GetLowerBound() && GetCollectionOfParameters().At(0)->GetValue()<=GetCollectionOfParameters().At(0)->GetUpperBound() && GetCollectionOfParameters().At(1)->GetValue()>=GetCollectionOfParameters().At(1)->GetLowerBound() && GetCollectionOfParameters().At(1)->GetValue()<=GetCollectionOfParameters().At(1)->GetUpperBound()){
        return (20/1.5)*HosakiModel;
    } else return 100000;
}
