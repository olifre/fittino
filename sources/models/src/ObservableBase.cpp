/* $Id: ObservableBase.cpp 844 2011-01-10 13:52:15Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ObservableBase.cpp                                               *
*                                                                              *
* Description Base class for observables                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ObservableBase.h"

Fittino::ObservableBase::ObservableBase( std::string name, int id )
                    : _id( id ),
                      _name( name ) {

    _chi2 = 1.e99;
    _deviation = 1.e99;

}

Fittino::ObservableBase::~ObservableBase() {

}

double Fittino::ObservableBase::GetChi2() const {

    return _chi2;

}

double Fittino::ObservableBase::GetDeviation() const {

    return _deviation;

}

int Fittino::ObservableBase::GetID() const {

    return _id;

}

std::string Fittino::ObservableBase::GetName() const {

    return _name;

}
