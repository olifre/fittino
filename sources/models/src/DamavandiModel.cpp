/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        DamavandiModel.cpp                                               *
*                                                                              *
* Description Implementation of a n-dimensional DamavandiModel function        *
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
#include "DamavandiModel.h"

Fittino::DamavandiModel::DamavandiModel( const boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "DamavandiModel";

    TestModelBase::Initialize();

}

Fittino::DamavandiModel::~DamavandiModel() {

}

Fittino::DamavandiModel* Fittino::DamavandiModel::Clone() const {

    return new DamavandiModel( *this );

}

double Fittino::DamavandiModel::ToRadians(double x){
    return (x * M_PI) / 180;
}

double Fittino::DamavandiModel::TestModelFunction() {

    double DamavandiModel = 0;
    double x1 = GetCollectionOfParameters().At(0)->GetValue(), x2 = GetCollectionOfParameters().At(1)->GetValue();
    DamavandiModel = (1 - pow((abs((sin(ToRadians(M_PI * (x1 - 2))) * sin(ToRadians(M_PI * (x2 - 2)))) / (M_PI * M_PI * (x1 - 2) * (x2 - 2)))), 5)) * (2 + pow((x1 - 7), 2) + pow((x2 - 7), 2));

    return DamavandiModel;

}
