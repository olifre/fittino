/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Univariate2Model.cpp                                             *
*                                                                              *
* Description Implementation of a n-dimensional Univariate2Model function      *
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
#include "Univariate2Model.h"

Fittino::Univariate2Model::Univariate2Model( const boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "Univariate2Model";

    TestModelBase::Initialize();

}

Fittino::Univariate2Model::~Univariate2Model() {

}

Fittino::Univariate2Model* Fittino::Univariate2Model::Clone() const {

    return new Univariate2Model( *this );

}

double Fittino::Univariate2Model::ToRadians(double x){
    return (x * M_PI) / 180;
}

double Fittino::Univariate2Model::TestModelFunction() {

    double x = GetCollectionOfParameters().At(0)->GetValue();
    return (sin(ToRadians(x)) + sin(ToRadians((10/3) * x)));

}
