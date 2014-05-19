
/* $Id: VincentModel.cpp 1947 2014-03-02 19:54:40Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        VincentModel.cpp                                              *
*                                                                              *
* Description Implementation of a n-dimensional VincentModel function                           *
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
#include "VincentModel.h"

Fittino::VincentModel::VincentModel( const boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "VincentModel";

    TestModelBase::Initialize();

}

Fittino::VincentModel::~VincentModel() {

}

Fittino::VincentModel* Fittino::VincentModel::Clone() const {

    return new VincentModel( *this );

}

double Fittino::VincentModel::ToRadians(double x){
    return (x * M_PI) / 180;
}

double Fittino::VincentModel::TestModelFunction() {

    double VincentModel = 0;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        VincentModel += sin(ToRadians(10 * log(GetCollectionOfParameters().At(i)->GetValue())));

    }

    return -VincentModel;

}
