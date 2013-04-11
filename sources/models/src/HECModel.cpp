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
#include "PhysicsParameter.h"
#include "SLHAChi2Contribution.h"
#include "SLHAPrediction.h"

Fittino::HECModel::HECModel() {

    _name = "HEC model";

    _numberOfParameters = 22;

    _parameterVector.push_back( new PhysicsParameter( "Massh",             126., "GeV", 0.1, 120., 130., false ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_hss",         0.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_hss",        -1.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_hcc",         0.,    "", 0.1,  -1.,   5., false ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_hcc",        -1.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_hbb",         0.,    "", 0.1,  -1.,   5., false ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_hbb",        -1.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_htt",         0.,    "", 0.1,  -1.,   5., false ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_htt",        -1.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_hmumu",       0.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_hmumu",      -1.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_s_htautau",     0.,    "", 0.1,  -1.,   5., false ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_p_htautau",    -1.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hWW",           0.,    "", 0.1,  -1.,   5., false ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hZZ",           0.,    "", 0.1,  -1.,   5., false ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hZgamma",       0.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hgammagamma",   0.,    "", 0.1,  -1.,   5., false ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hgg",           0.,    "", 0.1,  -1.,   5., false ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hggZ",          0.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "Delta_hihjZ",        -1.,    "", 0.1,  -1.,   5., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "BR_hjhihi",           0.,    "", 0.1,   0.,   1., true  ) );
    _parameterVector.push_back( new PhysicsParameter( "BR_hInvisible",       0.,    "", 0.1,   0.,   1., true  ) );

    //SLHAModelCalculatorBase* slhaModelCalculator = new HiggsSignalsSLHAModelCalculator();
    //_modelCalculatorVector.push_back( slhaModelCalculator );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_1lep_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "1", "17", 2) );

    //_chi2ContributionVector.push_back( new SLHAChi2Contribution( "HiggsSignals", slhaModelCalculator, "HiggsSignalsResults", "12", 1 ) );

    PhysicsModelBase::Initialize();

}

Fittino::HECModel::~HECModel() {

}

Fittino::HECModel* Fittino::HECModel::Clone() const {

    return new HECModel( *this );

}
