
/* $Id: ModifiedRosenbrockModel.cpp 1947 2014-03-02 19:54:40Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModifiedRosenbrockModel.cpp                                              *
*                                                                              *
* Description Implementation of a n-dimensional ModifiedRosenbrockModel function                           *
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
#include "ModifiedRosenbrockModel.h"

Fittino::ModifiedRosenbrockModel::ModifiedRosenbrockModel( const boost::property_tree::ptree& ptree )
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
    double x1 = GetCollectionOfParameters().At(0)->GetValue(), x2 = GetCollectionOfParameters().At(1)->GetValue();
    ModifiedRosenbrockModel = 74 + (100*pow((x2 - pow(x1, 2)), 2)) + pow((1, x1), 2) - (400 * exp(-10 * (pow((x1 + 1), 2) + pow((x2 + 1), 2))));

    return ModifiedRosenbrockModel;

}
