/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GiuntaModel.cpp                                                  *
*                                                                              *
* Description Implementation of a n-dimensional GiuntaModel function           *
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
#include "GiuntaModel.h"

Fittino::GiuntaModel::GiuntaModel( boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "GiuntaModel";

    TestModelBase::Initialize();

}

Fittino::GiuntaModel::~GiuntaModel() {

}

Fittino::GiuntaModel* Fittino::GiuntaModel::Clone() const {

    return new GiuntaModel( *this );

}

double Fittino::GiuntaModel::ToRadians(double x){
    return (x * M_PI) / 180;
}

double Fittino::GiuntaModel::TestModelFunction() {

    double GiuntaModel = 0;

    for(int i = 0; i < GetNumberOfParameters(); i++){

        GiuntaModel += pow(sin(1 - (16 * 0.2*GetCollectionOfParameters().At(i)->GetValue() / 15)), 2) - (sin(4 - ((64 * 0.2*GetCollectionOfParameters().At(i)->GetValue()) / 15)) / 50) - sin(1 - ((16 * 0.1*GetCollectionOfParameters().At(i)->GetValue()) / 15));

    }
    if(std::max(GetCollectionOfParameters().At(0)->GetValue(), GetCollectionOfParameters().At(1)->GetValue()) > 5 || std::min(GetCollectionOfParameters().At(0)->GetValue(), GetCollectionOfParameters().At(1)->GetValue()) < -5) return 1000000;
    else return 30*(0.6+GiuntaModel);

}
