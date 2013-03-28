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

#include "HiggsSignalsSLHAModelCalculator.h"
#include "ParameterBase.h"
#include "HECModel.h"

Fittino::HECModel::HECModel() {

    _numberOfParameters = 19;
    _name = "HEC model";

    _parameterVector.push_back( new ParameterBase( "Massh",            126., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahss_s",         1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahss_p",         0., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahcc_s",         1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahcc_p",         0., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahbb_s",         1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahbb_p",         0., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahtt_s",         1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahtt_p",         0., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahmumu_s",       1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahmumu_p",       0., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahtautau_s",     1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahtautau_p",     0., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "DeltahWW",           1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "DeltahZZ",           1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "DeltahZgamma",       1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahgg",           1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "DeltahggZ",          1., 1., -10., 10.) );
    _parameterVector.push_back( new ParameterBase( "Deltahgammagamma",   1., 1., -10., 10.) );

    //SLHAModelCalculatorBase* slhaModelCalculator = new HiggsSignalsSLHAModelCalculator();
    //_modelCalculatorVector.push_back( slhaModelCalculator );
	
    PhysicsModelBase::Initialize();

}

Fittino::HECModel::~HECModel() {

}

Fittino::HECModel* Fittino::HECModel::Clone() const {

    return new HECModel( *this );

}
