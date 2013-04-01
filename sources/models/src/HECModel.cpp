/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HECModel.cpp                                                     *
*                                                                              *
* Description Implementation of the HEC model                                  *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "HECModel.h"
#include "HiggsSignalsSLHAModelCalculator.h"

Fittino::HECModel::HECModel() {

    _name = "HEC model";

    _numberOfParameters = 19;

    _parameterVector.push_back( new PhysicsParameter( "Massh",             126., "GeV", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_hss",         1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_hss",         0.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_hcc",         1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_hcc",         0.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_hbb",         1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_hbb",         0.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_htt",         1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_htt",         0.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_hmumu",       1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_hmumu",       0.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_htautau",     1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_htautau",     0.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hWW",           1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hZZ",           1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hZgamma",       1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hgg",           1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hggZ",          1.,    "", 0.1, -10., 10. ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hgammagamma",   1.,    "", 0.1, -10., 10. ) );

    _modelCalculatorVector.push_back( new HiggsSignalsSLHAModelCalculator() );

    PhysicsModelBase::Initialize();

}

Fittino::HECModel::~HECModel() {

}

Fittino::HECModel* Fittino::HECModel::Clone() const {

    return new HECModel( *this );

}
