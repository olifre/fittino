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

#include "Configuration.h"
#include "MSUGRAModel.h"
//#include "SLHAObservable.h"
//#include "WorkspaceObservable.h"

Fittino::MSUGRAModel::MSUGRAModel() {

    Configuration* configuration = Configuration::GetInstance();

    _numberOfParameters = 4;
    _name = "MSUGRA model";
    _parameterVector.push_back( Parameter( "A0", configuration->GetSteeringParameter( "A0", 0. ), 5 ) );
    _parameterVector.push_back( Parameter( "M0", configuration->GetSteeringParameter( "M0", 0. ), 1 ) );
    _parameterVector.push_back( Parameter( "M12", configuration->GetSteeringParameter( "M12", 0. ), 2 ) );
    _parameterVector.push_back( Parameter( "TanBeta", configuration->GetSteeringParameter( "TanBeta", 0. ), 3 ) );

    //SLHAObservable* observable = new SLHAObservable( "Br(b -> s gamma)", 3.55e-04, 0.26e-04, 1 );
    //_observableVector.push_back( observable );

    //WorkspaceObservable *observable = new WorkspaceObservable( "LHCRate",
    //                                                           0,
    //                                                           "/afs/atlass01.physik.uni-bonn.de/user/uhlenbrock/programs/WorkspaceSimpleExample/workspace.root",
    //                                                           "testWorkspace",
    //                                                           "PredictedRate.dat" );
    //_observableVector.push_back( observable );

    ModelBase::InitializeModel();

}

Fittino::MSUGRAModel::~MSUGRAModel() {

}

Fittino::MSUGRAModel* Fittino::MSUGRAModel::Clone() const {

    return new MSUGRAModel( *this );

}
