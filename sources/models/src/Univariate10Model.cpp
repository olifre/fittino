/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Univariate10Model.cpp                                            *
*                                                                              *
* Description Implementation of a n-dimensional Univariate10Model function     *
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
#include "Univariate10Model.h"

Fittino::Univariate10Model::Univariate10Model( const boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "Univariate10Model";

    TestModelBase::Initialize();

}

Fittino::Univariate10Model::~Univariate10Model() {

}

Fittino::Univariate10Model* Fittino::Univariate10Model::Clone() const {

    return new Univariate10Model( *this );

}

double Fittino::Univariate10Model::ToRadians(double x){
    return (x * M_PI) / 180;
}

double Fittino::Univariate10Model::TestModelFunction() {

    double x = GetCollectionOfParameters().At(0)->GetValue();
    return ( -x * sin(ToRadians(x)));

}
