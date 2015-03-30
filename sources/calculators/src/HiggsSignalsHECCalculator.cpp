/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsHECCalculator.cpp                                    *
*                                                                              *
* Description Wrapper class for HiggsSignals using whichinput=hec              *
                                                                               *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/property_tree/ptree.hpp>

#include <iostream>

#include "CHiggsSignals.h"
#include "HiggsSignalsHECCalculator.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"

Fittino::HiggsSignalsHECCalculator::HiggsSignalsHECCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  :CalculatorBase       ( model                                                                         ){

    _name = "HiggsSignalsHadXSCalculator";

    AddQuantity( new SimplePrediction( "HS_chi2"                , "", _chi2                ) );  
    AddQuantity( new SimplePrediction( "HS_chi2_mass_h"         , "", _chi2_mass_h         ) );
    AddQuantity( new SimplePrediction( "HS_chi2_mu"             , "", _chi2_mu             ) );
    AddQuantity( new SimplePrediction( "HS_pvalue"              , "", _pvalue              ) ); 

    int nHzero = 1;
    int nHplus = 0;
    std::string expdata = ptree.get<std::string>( "ExpData" );
    std::cout<<"Using ExpData = "<<expdata<<std::endl;
    initialize_higgssignals_( &nHzero, &nHplus, expdata.c_str(), expdata.size() );
    
    int output_level = 0;
    setup_output_level_( &output_level );

    int pdf = 2; 
    setup_pdf_( &pdf );

    double dm = 0.;
    higgssignals_neutral_input_massuncertainty_( &dm );

    double range = 1000.;
    setup_assignmentrange_( &range );
                                                           
}

Fittino::HiggsSignalsHECCalculator::~HiggsSignalsHECCalculator() {

}

void Fittino::HiggsSignalsHECCalculator::Initialize() {

  
}

void Fittino::HiggsSignalsHECCalculator::CalculatePredictions() {


  // setup the HS input. 
  // _mh             = _in->Get("FH_massh0");
  // _gammaTotal     = _in->Get("FH_Z_GTot_Model")*smgamma_h_( &_mh )/_in->Get("FH_Z_GTot_SM");
  // _g2hjss_s       = _in->Get("FH_Z_g2hss_s_GammaNorm");
  // _g2hjcc_s       = _in->Get("FH_Z_g2hcc_s_GammaNorm");
  // _g2hjbb_s       = _in->Get("FH_Z_bbh_Model")/_in->Get("FH_Z_bbh_SM");
  // _g2hjtt_s       = _in->Get("FH_Z_tth_Model")/_in->Get("FH_Z_tth_SM");
  // _g2hjmumu_s     = _in->Get("FH_Z_g2hmumu_s_GammaNorm");
  // _g2hjtautau_s   = _in->Get("FH_Z_g2htautau_s_GammaNorm");
  // _g2hjWW         = _in->Get("FH_Z_g2hWW_GammaNorm");
  // _g2hjZZ         = _in->Get("FH_Z_g2hZZ_GammaNorm");
  // _g2hjZga        = 1;
  // _g2hjgaga       = _in->Get("FH_Z_g2hgaga_GammaNorm");
  // _g2hjgg         = _in->Get("FH_Z_ggh_Model")/_in->Get("FH_Z_ggh_SM");
  // _g2hjggZ        = 1;
  // _g2hjhiZ        = 0;
  // _BR_hjinvisible = _in->Get("FH_Z_G(h->n1n1)_Model")/_in->Get("FH_Z_GTot_Model");

  _BR_hjhihi =0;

  _g2hjss_p = 0;  
  _g2hjcc_p = 0;
  _g2hjbb_p = 0;
  _g2hjtt_p = 0;
  _g2hjmumu_p = 0;
  _g2hjtautau_p =0;


  higgsbounds_neutral_input_effc_( &_mh,
                                   &_gammaTotal,
                                   &_g2hjss_s,
                                   &_g2hjss_p,
                                   &_g2hjcc_s,
                                   &_g2hjcc_p,
                                   &_g2hjbb_s,
                                   &_g2hjbb_p,
                                   &_g2hjtt_s,
                                   &_g2hjtt_p,
                                   &_g2hjmumu_s,
                                   &_g2hjmumu_p,
                                   &_g2hjtautau_s,
                                   &_g2hjtautau_p,
                                   &_g2hjWW,
                                   &_g2hjZZ,
                                   &_g2hjZga,
                                   &_g2hjgaga,
                                   &_g2hjgg,
                                   &_g2hjggZ,
                                   &_g2hjhiZ,
                                   &_BR_hjinvisible,
                                   &_BR_hjhihi);

  int _mode = 1;
  int _nobs;
  run_higgssignals_( &_mode, &_chi2_mu, &_chi2_mass_h, &_chi2, &_nobs, &_pvalue );

}


