/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModifiedRosenbrockModel.cpp                                      *
*                                                                              *
* Description Implementation of a n-dimensional ModifiedRosenbrockModel        *
*             function                                                         *
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
#include "ModifiedRosenbrockModel.h"

Fittino::ModifiedRosenbrockModel::ModifiedRosenbrockModel( boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "ModifiedRosenbrockModel";

    TestModelBase::Initialize();

}

Fittino::ModifiedRosenbrockModel::~ModifiedRosenbrockModel() {

}

Fittino::ModifiedRosenbrockModel* Fittino::ModifiedRosenbrockModel::Clone() const {

    return new ModifiedRosenbrockModel( *this );

}

double Fittino::ModifiedRosenbrockModel::ToRadians(double x){
    return (x * M_PI) / 180;
}

double Fittino::ModifiedRosenbrockModel::TestModelFunction() {

    double ModifiedRosenbrockModel = 0;
    ModifiedRosenbrockModel = 74 + (100*pow((GetCollectionOfParameters().At(1)->GetValue() - pow(GetCollectionOfParameters().At(0)->GetValue(), 2)), 2)) + pow((1, GetCollectionOfParameters().At(0)->GetValue()), 2) - (400 * exp(-10 * (pow((GetCollectionOfParameters().At(0)->GetValue() + 1), 2) + pow((GetCollectionOfParameters().At(1)->GetValue() + 1), 2))));

    //if(std::max(GetCollectionOfParameters().At(0)->GetValue(), GetCollectionOfParameters().At(1)->GetValue()) < 8 && std::min(GetCollectionOfParameters().At(0)->GetValue(), GetCollectionOfParameters().At(1)->GetValue()) > -2) return (20/65) * ModifiedRosenbrockModel;
    //else return 0; //negate to create unique minimum

    //if(std::max(GetCollectionOfParameters().At(0)->GetValue(), GetCollectionOfParameters().At(1)->GetValue()) > 5 || std::min(GetCollectionOfParameters().At(0)->GetValue(), GetCollectionOfParameters().At(1)->GetValue()) < -5) return 1000000;
    double stretch = 20./115.;
    std::cout<<stretch<<"\n";
    return stretch*ModifiedRosenbrockModel;
    //return GetCollectionOfParameters().At(0)->GetValue();

}
