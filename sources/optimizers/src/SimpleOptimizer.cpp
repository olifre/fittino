/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleOptimizer.cpp                                              *
*                                                                              *
* Description Class for simple optimization                                    *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelBase.h"
#include "ModelParameter.h"
#include "SimpleOptimizer.h"

Fittino::SimpleOptimizer::SimpleOptimizer( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : OptimizerBase( model, ptree ),
      _bestEntry   ( model->GetCollectionOfParameters().At( 0 )->GetValue() ),
      _iEntry      ( model->GetCollectionOfParameters().At( 0 )->GetValue() ),
      _stepWidth   ( model->GetCollectionOfParameters().At( 0 )->GetError() ) {

    _name = ptree.get<std::string>( "Name", "simple optimizer" );

    _numberOfIterations = static_cast<unsigned int>( _model->GetCollectionOfQuantities().At( "TreeIterations" )->GetValue() );

}

Fittino::SimpleOptimizer::~SimpleOptimizer() {

}

void Fittino::SimpleOptimizer::PrintSteeringParameters() const {

    OptimizerBase::PrintSteeringParameters();

}

void Fittino::SimpleOptimizer::UpdateModel() {

    _iEntry += _stepWidth;

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    double chi2 = _model->GetChi2();

    if ( chi2 < _chi2 ) {

        _chi2 = chi2;
        _bestEntry = _iEntry;

    }

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _bestEntry );

}
