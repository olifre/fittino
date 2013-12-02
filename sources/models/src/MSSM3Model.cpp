/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MSSM3Model.cpp                                                   *
*                                                                              *
* Description A constrained version of MSSM to test SM limit of calculators    *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Configuration.h"
#include "MSSM3Model.h"
#include "Observable.h"
#include "ModelCalculatorBase.h"
#include "SLHAParameter.h"
#include "SimplePrediction.h"
#include "Factory.h"

Fittino::MSSM3Model::MSSM3Model() {

    Configuration* configuration = Configuration::GetInstance();

    _name = "SMLimit model";

    AddParameter( new PhysicsParameter( "MSusy", "MSusy", 1000, "GeV", "GeV", 1e3, 1000, 20000, 100, 10000, false ) );

    AddParameter( new PhysicsParameter( "TanBeta", "tan#beta", 10, "", "", 1e1, 10, 50, 3, 60, true ) );

    AddParameter( new PhysicsParameter( "relXt", "relXt", -5, "", "", 1e-1, -3, 3, -3, 3, false ) );

    AddParameter( new PhysicsParameter( "signMu", "sign #mu", 1, "", "", 2, -1, 1, -1, 1, true ) );

    Factory factory;
    ModelCalculatorBase* feynHiggsModelCalculator = factory.CreateCalculator(Configuration::FEYNHIGGSCALCULATOR, this);
    //_modelCalculatorVector.push_back( feynHiggsModelCalculator );

    PredictionBase* pred = 0;

    pred = new SimplePrediction( "mass_h", "mass_h", "GeV", "GeV", 0, 500, feynHiggsModelCalculator);
    AddPrediction( pred );
    
    pred = new SimplePrediction( "FH_error", "FH_error", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "sigma_ggh_smratio", "sigma_ggh", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "sigma_ggh2_smratio", "sigma_ggh", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "sigma_bbh_smratio", "sigma_bbh", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "sigma_qqh_smratio", "sigma_qqh", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "sigma_tth_smratio", "sigma_tth", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );
    
    pred = new SimplePrediction( "sigma_Wh_smratio", "sigma_Wh", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "sigma_Zh_smratio", "sigma_Zh", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "gamma_h_tautau_smratio", "gamma_h_tautau", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "gamma_h_cc_smratio", "gamma_h_cc", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "gamma_h_ss_smratio", "gamma_h_ss", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "gamma_h_bb_smratio", "gamma_h_bb", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "gamma_h_gaga_smratio", "gamma_h_gaga", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "gamma_h_Zga_smratio", "gamma_h_Zga", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "gamma_h_ZZ_smratio", "gamma_h_ZZ", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "gamma_h_WW_smratio", "gamma_h_WW", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );

    pred = new SimplePrediction( "gamma_h_gg_smratio", "gamma_h_gg", "", "", -1000, 1000, feynHiggsModelCalculator );
    AddPrediction( pred );


    PhysicsModelBase::Initialize();

}

Fittino::MSSM3Model::~MSSM3Model() {

}

Fittino::MSSM3Model* Fittino::MSSM3Model::Clone() const {

    return new MSSM3Model( *this );

}
