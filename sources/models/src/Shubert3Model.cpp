/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Shubert3Model.cpp                                                *
*                                                                              *
* Description Implementation of a n-dimensional Shubert3Model function         *
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
#include "Shubert3Model.h"

Fittino::Shubert3Model::Shubert3Model( const boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "Shubert3Model";

    TestModelBase::Initialize();

}

Fittino::Shubert3Model::~Shubert3Model() {

}

Fittino::Shubert3Model* Fittino::Shubert3Model::Clone() const {

    return new Shubert3Model( *this );

}

double Fittino::Shubert3Model::Summand(double x, int j){
    if (x < 0.25) return sin(ToRadians((j + 1) * 0.25));
    else if (x > 10) return sin(ToRadians((j + 1) * 10));
    else return sin(ToRadians((j + 1) * x));
}

double Fittino::Shubert3Model::ToRadians(double x){
    return (x * M_PI) / 180;
}

double Fittino::Shubert3Model::TestModelFunction() {

    double Shubert3Model = 0;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        for (unsigned int j = 0; j < GetNumberOfParameters(); j++){

            Shubert3Model += (j * Summand(GetCollectionOfParameters().At(i)->GetValue(), j)) + j;

        }

    }

    return Shubert3Model;

}
