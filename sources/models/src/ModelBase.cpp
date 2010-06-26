/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.cpp                                                    *
*                                                                              *
* Description Base class for Fittino models                                    *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelBase.h"

Fittino::ModelBase::ModelBase()
        : _numberOfParameters(0),
          _name( "" ) { 

}

Fittino::ModelBase::~ModelBase() {

}

int Fittino::ModelBase::GetNumberOfParameters() const {

    return _numberOfParameters;

}

std::string Fittino::ModelBase::GetName() const {

    return _name;

}

std::vector<double>* Fittino::ModelBase::GetParameterVector() {

    return &_parameterVector;

}
