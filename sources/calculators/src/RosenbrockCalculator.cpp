/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RosenbrockCalculator.cpp                                         *
*                                                                              *
* Description Calculates the Rosenbrock function                               *
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

#include "ModelBase.h"
#include "ModelParameter.h"
#include "RosenbrockCalculator.h"

Fittino::RosenbrockCalculator::RosenbrockCalculator( const Fittino::ModelBase* model, const boost::property_tree::ptree &ptree )
    : CalculatorBase( model ) {

    _name = ptree.get<std::string>( "Name", "Rosenbrock" );
    _tag = ptree.get<std::string>( "Tag", _name );

    _returnValue = new Quantity( "ReturnValue", "", 0, 0, 0 );
    AddQuantity( _returnValue );

}

Fittino::RosenbrockCalculator::~RosenbrockCalculator() {

}

void Fittino::RosenbrockCalculator::CalculatePredictions() {

    double returnValue = 0;

    for ( unsigned int i = 1; i < _model->GetNumberOfParameters(); i++ ) {

        returnValue += pow( 1 - _model->GetCollectionOfParameters().At( i - 1 )->GetValue(), 2 ) + 100 * pow( _model->GetCollectionOfParameters().At( i )->GetValue() - pow( _model->GetCollectionOfParameters().At( i - 1 )->GetValue(), 2 ), 2 );

    }

    _returnValue->SetValue( returnValue );

}
