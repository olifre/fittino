/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CheckVacuumCalculator.cpp                                        *
*                                                                              *
* Description Wrapper class for CheckVacuum                                    *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "CheckVacuum/CheckVacuum.h"

#include "CheckVacuumCalculator.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"

Fittino::CheckVacuumCalculator::CheckVacuumCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ),
      _gridfile( ptree.get<std::string>( "GridFile" ) ),
      _m0      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "M0"      ) )->GetValue() ),
      _m12     ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "M12"     ) )->GetValue() ),
      _a0      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "A0"      ) )->GetValue() ),
      _tanbeta ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "TanBeta" ) )->GetValue() ),
      _signmu  ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "SignMu"  ) )->GetValue() ) {

    _name = "CheckVacuumCalculator";

    AddQuantity( new SimplePrediction( "VacuumLifetime" , "", _vacuumLifetime  ) );
    AddQuantity( new SimplePrediction( "VacuumStability", "", _vacuumStability ) );

    _checkVacuum = new CheckVacuum( _gridfile );

}

Fittino::CheckVacuumCalculator::~CheckVacuumCalculator() {

    delete _checkVacuum;

}

void Fittino::CheckVacuumCalculator::CalculatePredictions() {

    _vacuumStability = _checkVacuum->Stability( _m0, _m12, _tanbeta, _signmu, _a0 );
    _vacuumLifetime  = _checkVacuum->Lifetime ( _m0, _m12, _tanbeta, _signmu, _a0 );

}

void Fittino::CheckVacuumCalculator::Initialize() {

}
