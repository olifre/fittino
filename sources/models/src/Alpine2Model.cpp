/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Alpine2Model.cpp                                                 *
*                                                                              *
* Description Implementation of an n-dimensional Alpine2Model function         *
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
#include "Alpine2Model.h"

Fittino::Alpine2Model::Alpine2Model( boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "Alpine2Model";

    TestModelBase::Initialize();

}

Fittino::Alpine2Model::~Alpine2Model() {

}

Fittino::Alpine2Model* Fittino::Alpine2Model::Clone() const {

    return new Alpine2Model( *this );

}

double Fittino::Alpine2Model::TestModelFunction() {

    double Alpine2Model = 1;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        Alpine2Model *= sqrt(GetCollectionOfParameters().At(i)->GetValue()) * sin(GetCollectionOfParameters().At(i)->GetValue());
    }

    if(GetCollectionOfParameters().At(0)->GetValue()>=GetCollectionOfParameters().At(0)->GetLowerBound() && GetCollectionOfParameters().At(0)->GetValue()<=GetCollectionOfParameters().At(0)->GetUpperBound() && GetCollectionOfParameters().At(1)->GetValue()>=GetCollectionOfParameters().At(1)->GetLowerBound() && GetCollectionOfParameters().At(1)->GetValue()<=GetCollectionOfParameters().At(1)->GetUpperBound()){
        return -2.4*Alpine2Model;
    } else return 100000;

}
