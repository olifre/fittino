/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MinuitAdapter.cpp                                                *
*                                                                              *
* Description Adapter class for Minuit                                         *
*                                                                              *
* Authors     Peter Wienemann  <wienemann@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "MinuitAdapter.h"
#include "ModelParameter.h"

Fittino::MinuitAdapter::MinuitAdapter( ModelBase* model )
    : _model( model ) {

}

Fittino::MinuitAdapter::~MinuitAdapter() {

}

double Fittino::MinuitAdapter::Up() const {

    return _errorDef;

}

void Fittino::MinuitAdapter::SetErrorDef( double err ) {

    _errorDef = err;

}

double Fittino::MinuitAdapter::operator()( const std::vector<double>& parameterVector ) const {

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        _model->GetCollectionOfParameters().At( i )->SetValue( parameterVector[i] );

    }

    return _model->GetChi2();

}
