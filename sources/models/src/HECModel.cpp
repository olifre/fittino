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
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv.-central-highPTt_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "2", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv.-central-lowPTt_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "3", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv.-rest-highPTt_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "4", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv.-rest-lowPTt_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "5", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv.-trans._atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "6", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_ETmiss_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "7", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_highmass2jet-loose_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "8", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_highmass2jet-tight_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "9", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_lowmass2jet_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "10", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_unconv.-central-highPTt_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "11", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_unconv.-central-lowPTt_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "12", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_unconv.-rest-highPTt_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "13", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_unconv.-rest-lowPTt_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "14", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_htautau_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "15", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hWWlnulnu_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "16", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_VBFWWlnulnu_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "17", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hZZ4l_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "18", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_VhVbb_atlas", slhaModelCalculator, "HiggsSignalsPeakObservables", "19", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_arXiv", slhaModelCalculator, "HiggsSignalsPeakObservables", "20", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_htautau_arXiv", slhaModelCalculator, "HiggsSignalsPeakObservables", "21", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hWW_arXiv", slhaModelCalculator, "HiggsSignalsPeakObservables", "22", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_tthttbb_arXiv", slhaModelCalculator, "HiggsSignalsPeakObservables", "23", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_VhVbb_arXiv", slhaModelCalculator, "HiggsSignalsPeakObservables", "24", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_2jet_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "25", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_2jet-loose_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "26", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_2jet-tight_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "27", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_e_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "28", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_inclusive_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "29", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_MET_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "30", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_mu_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "31", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_htautau_0/1jet_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "32", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hWW_0/1jet_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "33", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hZZ4l_0/1jet_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "34", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hZZ4l_2jet_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "35", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_tthttbb_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "36", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_VBFtautau_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "37", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_VhVbb_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "38", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_VhVtautau_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "39", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_WhWWW_CMS", slhaModelCalculator, "HiggsSignalsPeakObservables", "40", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hbb_arXiv", slhaModelCalculator, "HiggsSignalsPeakObservables", "41", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_arXiv", slhaModelCalculator, "HiggsSignalsPeakObservables", "42", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_htautau_arXiv", slhaModelCalculator, "HiggsSignalsPeakObservables", "43", "17", 2) );
    //_predictionVector.push_back( new SLHAPrediction( "Mu_hWW_arXiv", slhaModelCalculator, "HiggsSignalsPeakObservables", "44", "17", 2) );

    //_chi2ContributionVector.push_back( new SLHAChi2Contribution( "HiggsSignals", slhaModelCalculator, "HiggsSignalsResults", "12", 1 ) );

    PhysicsModelBase::Initialize();

}

Fittino::HECModel::~HECModel() {

}

Fittino::HECModel* Fittino::HECModel::Clone() const {

    return new HECModel( *this );

}
