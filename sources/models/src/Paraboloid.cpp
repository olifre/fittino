/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Paraboloid.cpp                                                   *
*                                                                              *
* Description Implementation of a n-dimensional paraboloid function            *
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
#include "Paraboloid.h"

Fittino::Paraboloid::Paraboloid( const boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ) {

    _name = "Paraboloid";

    TestModelBase::Initialize();

}

Fittino::Paraboloid::~Paraboloid() {

}

Fittino::Paraboloid* Fittino::Paraboloid::Clone() const {

    return new Paraboloid( *this );

}

double Fittino::Paraboloid::TestModelFunction() {

    double paraboloid = 0;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        paraboloid += pow(GetCollectionOfParameters().At( i )->GetValue(), 2 );

    }

    return paraboloid;

}
