
/* $Id: GiuntaModel.cpp 1947 2014-03-02 19:54:40Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GiuntaModel.cpp                                              *
*                                                                              *
* Description Implementation of a n-dimensional GiuntaModel function                           *
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
#include "GiuntaModel.h"

Fittino::GiuntaModel::GiuntaModel( const boost::property_tree::ptree& ptree )
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

        GiuntaModel += pow(sin(ToRadians(1 - ((16 * GetCollectionOfParameters().At(i)->GetValue()) / 15))), 2) - (sin(ToRadians(4 - ((64 * GetCollectionOfParameters().At(i)->GetValue()) / 15))) / 50) - sin(ToRadians(1 - ((16 * GetCollectionOfParameters().At(i)->GetValue()) / 15)));

    }

    return 0.6+GiuntaModel;

}
