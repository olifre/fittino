/* $Id: OptimizerBase.cpp,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        OptimizerBase.cpp                                                *
*                                                                              *
* Description Base class for Fittino parameter optimizers                      *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wiene@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "OptimizerBase.h"

Fittino::OptimizerBase::OptimizerBase() {

}

Fittino::OptimizerBase::~OptimizerBase() {

}

void Fittino::OptimizerBase::Execute() {

    while ( !( _abortCriterium < 1e-6 ) ) {
        //_iterationsCounter = 1;
        //while ( _iterationsCounter <= _numberOfIterations ) {

        _model = this->UpdateModel();
        //_abortCriterium = this->EvaluateModel( _model );

    }

}

//double Fittino::EvaluateModel( ModelBase& model ) {
//
//    double chi2;
//
//    //chi2 = pow( ( 1 - _position[0] ), 2 ) + 100 * pow( _position[1] - pow( _position[0], 2 ), 2 );
//
//    return chi2;
//
//}
