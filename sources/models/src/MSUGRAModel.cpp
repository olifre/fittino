/* $Id: MSUGRAModel.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MSUGRAModel.cpp                                                  *
*                                                                              *
* Description Implementation of the MSUGRA model                               *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include "Configuration.h"
#include "MSUGRAModel.h"
//#include "SLHAFileInterpreter.h"

Fittino::MSUGRAModel::MSUGRAModel() {

    Configuration* configuration = Configuration::GetInstance();

    _numberOfParameters = 4;
    _name = "MSUGRA model";
    _parameterVector.push_back( Parameter( "A0", configuration->GetSteeringParameter( "A0", 0. ) ) );
    _parameterVector.push_back( Parameter( "M0", configuration->GetSteeringParameter( "M0", 0. ) ) );
    _parameterVector.push_back( Parameter( "M12", configuration->GetSteeringParameter( "M12", 0. ) ) );
    _parameterVector.push_back( Parameter( "TanBeta", configuration->GetSteeringParameter( "TanBeta", 0. ) ) );

    ModelBase::InitializeModel();

}

Fittino::MSUGRAModel::~MSUGRAModel() {

}

double Fittino::MSUGRAModel::Evaluate() {

    //SLHAFileInterpreter* _inputSLHAFileInterpreter = new SLHAFileInterpreter();
    //_inputSLHAFileInterpreter->ReadFile( "SPheno.spc" );
    // std::cout << _inputSLHAFileInterpreter->GetMODSEL() << std::endl;

    return 1.e-6;

}

Fittino::MSUGRAModel* Fittino::MSUGRAModel::Clone() const {

    return new MSUGRAModel( *this );

}

Fittino::MSUGRAFCN::MSUGRAFCN( const std::vector<double>& meas, const std::vector<double>& pos, const std::vector<double>& mvar )
        : theMeasurements( meas ),
          thePositions( pos ),
          theMVariances( mvar ),
          theErrorDef( 1. ) {

}

Fittino::MSUGRAFCN::~MSUGRAFCN() {

}

double Fittino::MSUGRAFCN::Up() const {

    return theErrorDef;

}

double Fittino::MSUGRAFCN::operator()( const std::vector<double>& parameterVector ) const {

    return 1.e-7;

}
