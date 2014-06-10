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

Fittino::Shubert3Model::Shubert3Model( boost::property_tree::ptree& ptree )
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
    if (x < 0.25) return 100000.;
    else if (x > 10) return 100000.;
    else return sin((j + 1) * x);
}

double Fittino::Shubert3Model::ToRadians(double x){
    return (x * M_PI) / 180;
}

double Fittino::Shubert3Model::TestModelFunction() {

    double Shubert3Model = 0;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        for (unsigned int j = 0; j < 5; j++){

            Shubert3Model += (j * sin((j + 1) * GetCollectionOfParameters().At(i)->GetValue())) + j;

        }

    }

    if(GetCollectionOfParameters().At(0)->GetValue()>=0.25 && GetCollectionOfParameters().At(0)->GetValue()<=10.25 && GetCollectionOfParameters().At(1)->GetValue()>=0.25 && GetCollectionOfParameters().At(1)->GetValue()<=10.25){
        return Shubert3Model;
    } else return 1000000.;
}
