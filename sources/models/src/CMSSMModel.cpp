/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CMSSMModel.cpp                                                   *
*                                                                              *
* Description Implementation of the CMSSM model                                *
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
#include "CMSSMModel.h"
//#include "Observable.h"
#include "SLHAChi2Contribution.h"
#include "SLHAParameter.h"
#include "SLHAPrediction.h"
#include "SPhenoSLHAModelCalculator.h"

Fittino::CMSSMModel::CMSSMModel() {

    Configuration* configuration = Configuration::GetInstance();

    _name = "CMSSM model";

    _parameterVector.push_back( new SLHAParameter( "P_M0",  "M_{0}",   0., "GeV", "GeV", 1., -1.e5, 1.e5,   0., 2300., "5" ) );
    _parameterVector.push_back( new SLHAParameter( "P_M12", "M_{1/2}", 0., "GeV", "GeV", 1., -1.e5, 1.e5, 500., 3500., "5" ) );

    //_parameterVector.push_back( new SLHAParameter( "A0",      "A0",      configuration->GetSteeringParameter( "A0" ,     0. ), "GeV", "GeV", 1., -1.e5, 1.e5, -1.e5, 1.e5, "5" ) );
    //_parameterVector.push_back( new SLHAParameter( "M0",      "M0",      configuration->GetSteeringParameter( "M0" ,     0. ), "GeV", "GeV", 1.,    0., 1.e5,    0., 1.e5, "1" ) );
    //_parameterVector.push_back( new SLHAParameter( "M12",     "M12",     configuration->GetSteeringParameter( "M12" ,    0. ), "GeV", "GeV", 1.,    0., 1.e5,    0., 1.e5, "2" ) );
    //_parameterVector.push_back( new SLHAParameter( "TanBeta", "TanBeta", configuration->GetSteeringParameter( "TanBeta", 0. ),    "",    "", 1.,    0., 1.e3,    0., 1.e3, "3" ) );

    SPhenoSLHAModelCalculator* slhaModelCalculator = new SPhenoSLHAModelCalculator();
    _modelCalculatorVector.push_back( slhaModelCalculator );

    //_observableVector.push_back( new ObservableBase( new SLHAPrediction( "BR(b -> s gamma)" , "BR(b-s#gamma)",    "",      "",        0., 1.e6, slhaModelCalculator, "SPhenoLowEnergy", " 1", 1 ), 3.55e-04, 0.53e-04 ) );
    //_observableVector.push_back( new SLHAObservable( "BR(Bs -> mu+ mu-)", "BR(Bs-#mu+#mu-)",  "",      "",        0., 1.e6, 4.5e-09,  0.8e-09,  slhaModelCalculator, "SPhenoLowEnergy", " 4", 1 ) );
    //_observableVector.push_back( new SLHAObservable( "Delta(M_Bs)"      , "#Delta_{M-Bs}",    "ps^-1", "ps^{-1}", 0., 1.e6, 17.719,   4.200,    slhaModelCalculator, "SPhenoLowEnergy", " 7", 1 ) );
    //_observableVector.push_back( new SLHAObservable( "Delta(g-2)_muon"  , "#Delta_{g-2}muon", "",      "",        0., 1.e6, 28.7e-10, 8.2e-10,  slhaModelCalculator, "SPhenoLowEnergy", "11", 1 ) );

    //_chi2ContributionVector.push_back( new SLHAChi2Contribution( "TestContribution", slhaModelCalculator, "SPhenoLowEnergy", "1", 1 ) );

    PhysicsModelBase::Initialize();

}

Fittino::CMSSMModel::~CMSSMModel() {

}

Fittino::CMSSMModel* Fittino::CMSSMModel::Clone() const {

    return new CMSSMModel( *this );

}
