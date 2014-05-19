
/* $Id: Alpine2Model.cpp 1947 2014-03-02 19:54:40Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Alpine2Model.cpp                                              *
*                                                                              *
* Description Implementation of an n-dimensional Alpine2Model function                           *
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
#include "Alpine2Model.h"

Fittino::Alpine2Model::Alpine2Model( const boost::property_tree::ptree& ptree )
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

        Alpine2Model *= sqrt(GetCollectionOfParameters().At(i)->GetValue()) * sin(((M_PI*GetCollectionOfParameters().At(i)->GetValue()))/180);
    }

    return Alpine2Model;

}
