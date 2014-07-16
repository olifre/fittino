/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsPartXSCalculator.cpp                                  *
*                                                                              *
* Description Wrapper class for HiggsSignals using whichinput=hadr             *
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
#include <boost/thread.hpp>

#include <iostream>
#include <sstream>

#include "CHiggsSignals.h"
#include "HiggsSignalsPartXSCalculator.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "SimpleDataStorage.h"
#include "SimplePrediction.h"
#include "Observable.h"

Fittino::HiggsSignalsPartXSCalculator::HiggsSignalsPartXSCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    :CalculatorBase       ( model                                                                         ) {
    
    _name               = ptree.get<std::string>( "Name",               "HiggsSignalsCalculator" );
    _nH                 = ptree.get<int>        ( "NH",                 4                       );
    _nHzero             = ptree.get<int>        ( "NHzero",             3                       );
    _nHplus             = ptree.get<int>        ( "NHPlus",             1                       );
    _whichAnalyses      = ptree.get<std::string>( "WhichAnalyses",      "onlyL"                 );
    _HBresult           = -1;
    _channel            = 0;
    _obsratio           = 0.;
    _ncombined          = 0;
    _theoryUncertainty1s = ptree.get<double>    ( "TheoryUncertainty",  1.5 );
    _chi2WithTheory     = 0.;
    _chi2WithoutTheory  = 0.;
    _bestChannelChi2    = 0;
    std::cout << "running with " << _nHzero << " Hzero and " << _nHplus << " HPlus" << std::endl;
    AddQuantity( new SimplePrediction( "HB_result",             "HB_result",             "",    "",    -1.e4,    1.e4, _HBresult  ) ); 
    AddQuantity( new SimplePrediction( "HB_obsratio",           "HB_obsratio",           "",    "",    -1.e4,    1.e4, _obsratio  ) ); 
    AddQuantity( new SimplePrediction( "HB_channel",            "HB_channel",            "",    "",    -1.e4,    1.e4, _channel  ) ); 
    AddQuantity( new SimplePrediction( "HB_chi2WithTheory",     "HB_chi2WithTheory",     "",    "",    -1.e4,    1.e4, _chi2WithTheory  ) ); 
    AddQuantity( new SimplePrediction( "HB_chi2WithoutTheory",  "HB_chi2WithoutTheory",  "",    "",    -1.e4,    1.e4, _chi2WithoutTheory  ) ); 
    AddQuantity( new SimplePrediction( "HB_bestChannelChi2",    "HB_bestChannelChi2",    "",    "",    -1.e4,    1.e4, _bestChannelChi2  ) ); 


    AddQuantity( new SimplePrediction( "HS_weight_xs_ggh"       , "", _weight_xs_ggh       ) );
    AddQuantity( new SimplePrediction( "HS_weight_xs_bbh"       , "", _weight_xs_bbh       ) );
    AddQuantity( new SimplePrediction( "HS_chi2"                , "", _chi2                ) );  
    AddQuantity( new SimplePrediction( "HS_chi2_mass_h"         , "", _chi2_mass_h         ) );
    AddQuantity( new SimplePrediction( "HS_chi2_mu"             , "", _chi2_mu             ) );
    AddQuantity( new SimplePrediction( "HS_pvalue"              , "", _pvalue              ) ); 
    AddQuantity( new SimplePrediction( "HS_R_H_bb"              , "", _R_H_bb              ) ); 
    AddQuantity( new SimplePrediction( "HS_R_H_gaga"            , "", _R_H_gaga            ) ); 
    AddQuantity( new SimplePrediction( "HS_R_H_tautau"          , "", _R_H_tautau          ) ); 
    AddQuantity( new SimplePrediction( "HS_R_H_WW"              , "", _R_H_WW              ) ); 
    AddQuantity( new SimplePrediction( "HS_R_H_ZZ"              , "", _R_H_ZZ              ) ); 
    AddQuantity( new SimplePrediction( "HS_R_VH_bb"             , "", _R_VH_bb             ) ); 
    
    //For the moment, add defaul names for the MSSM
    std::vector<std::string> namesHzero;
    std::vector<std::string> namesHplus;
    std::vector<std::string> couplingNames;
    namesHzero.push_back( "h0" );
    namesHzero.push_back( "H0" );
    couplingNames.push_back( "gs" );
    couplingNames.push_back( "gs" );
    for( unsigned int i = 2; i < _nHzero; ++i ) {
        namesHzero.push_back( "A0" );
        couplingNames.push_back( "gp" );
    }
    for( unsigned int i = 0; i < _nHplus; ++i ) {
        namesHplus.push_back( "Hp" );
    }


    for( unsigned int i = 0; i < _nHzero; ++i ) {
        
        std::stringstream number;
        number << i;

        _name_mass_h_neutral_shift.push_back ( ptree.get<std::string>( "DeltaMassQName_"           + number.str(), "DeltaMass_" + namesHzero.at(i)  ) );
        _mass_h_neutral_shift.push_back      ( 0. );        
        _name_mass_h_neutral.push_back       ( ptree.get<std::string>( "MassQName_"                + number.str(), "FeynHiggs_Mass_" + namesHzero.at(i)              ) );
        //_name_Gamma_Total_neutral.push_back  ( ptree.get<std::string>( "GammaTotQName_"            + number.str(), "FeynHiggs_GammaTotal_" + namesHzero.at(i)        ) );
        _name_Gamma_Total_neutral.push_back  ( ptree.get<std::string>( "GammaTotQName_"            + number.str(), "SPheno_GammaTotal_" + namesHzero.at(i)        ) );
        _name_CS_lep_tautauhj_ratio.push_back( ptree.get<std::string>( "CS_lep_tautauhj_ratioQName"+ number.str(), "FeynHiggs_NormSM_Abs_" + couplingNames.at(i) + "_" + namesHzero.at(i) + "_tau_tau" ) );
        _name_CS_lep_hjZ_ratio.push_back     ( ptree.get<std::string>( "CS_lep_hjZ_ratioQName_"    + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0"  ) );
        _name_CS_lep_bbhj_ratio.push_back    ( ptree.get<std::string>( "CS_lep_bbhj_ratioQName_"   + number.str(), "FeynHiggs_NormSM_Abs_" + couplingNames.at(i) + "_" + namesHzero.at(i) + "_b_b" ) );
        _name_CS_gg_hj_ratio.push_back       ( ptree.get<std::string>( "CS_gg_hj_ratioQName_"      + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_g_g"   ) );
        _name_CS_bb_hj_ratio.push_back       ( ptree.get<std::string>( "CS_bb_hj_ratioQName_"      + number.str(), "FeynHiggs_NormSM_Abs_" + couplingNames.at(i) + "_" + namesHzero.at(i) + "_b_b" ) );
        _name_CS_bg_hjb_ratio.push_back      ( ptree.get<std::string>( "CS_bg_hjb_ratioQName_"     + number.str(), "FeynHiggs_NormSM_Abs_" + couplingNames.at(i) + "_" + namesHzero.at(i) + "_b_b" ) );
        _name_CS_ud_hjWp_ratio.push_back     ( ptree.get<std::string>( "CS_ud_hjWp_ratioQName_"    + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) );
        _name_CS_cs_hjWp_ratio.push_back     ( ptree.get<std::string>( "CS_cs_hjWp_ratioQName_"    + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) );
        _name_CS_ud_hjWm_ratio.push_back     ( ptree.get<std::string>( "CS_ud_hjWm_ratioQName_"    + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) );
        _name_CS_cs_hjWm_ratio.push_back     ( ptree.get<std::string>( "CS_cs_hjWm_ratioQName_"    + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) );
        
        // this will be set to 0 alls the time.
        _name_CS_gg_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_gg_hjZ_ratioQName_"     + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) ); 
        
        _name_CS_dd_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_dd_hjZ_ratioQName_"     + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) ); 
        _name_CS_uu_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_uu_hjZ_ratioQName_"     + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) ); 
        _name_CS_ss_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_ss_hjZ_ratioQName_"     + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) ); 
        _name_CS_cc_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_cc_hjZ_ratioQName_"     + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) ); 
        _name_CS_bb_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_bb_hjZ_ratioQName_"     + number.str(), "FeynHiggs_NormSM_Abs_g_" + namesHzero.at(i) + "_Z0_Z0" ) ); 
        _name_CS_tev_vbf_ratio.push_back     ( ptree.get<std::string>( "CS_tev_vbf_ratioQName_"    + number.str(), "FeynHiggs_CrossSection_1.96TeV_" + namesHzero.at(i) + "_qqh" ) );
        _name_CS_tev_tthj_ratio.push_back    ( ptree.get<std::string>( "CS_tev_tthj_ratioQName_"   + number.str(), "FeynHiggs_CrossSection_1.96TeV_" + namesHzero.at(i) + "_tth" ) );
        _name_CS_lhc7_vbf_ratio.push_back    ( ptree.get<std::string>( "CS_lhc7_vbf_ratioQName_"   + number.str(), "FeynHiggs_CrossSection_7TeV_" + namesHzero.at(i) + "_qqh" ) );
        _name_CS_lhc7_tthj_ratio.push_back   ( ptree.get<std::string>( "CS_lhc7_tthj_ratioQName_"  + number.str(), "FeynHiggs_CrossSection_7TeV_" + namesHzero.at(i) + "_tth" ) );
        _name_CS_lhc8_vbf_ratio.push_back    ( ptree.get<std::string>( "CS_lhc8_vbf_ratioQName_"   + number.str(), "FeynHiggs_CrossSection_8TeV_" + namesHzero.at(i) + "_qqh" ) );
        _name_CS_lhc8_tthj_ratio.push_back   ( ptree.get<std::string>( "CS_lhc8_tthj_ratioQName_"  + number.str(), "FeynHiggs_CrossSection_8TeV_" + namesHzero.at(i) + "_tth" ) );
        _name_BR_hjss.push_back              ( ptree.get<std::string>( "BR_hjssQName_"             + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_s_s" ) );
        _name_BR_hjcc.push_back              ( ptree.get<std::string>( "BR_hjccQName_"             + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_c_c" ) );
        _name_BR_hjbb.push_back              ( ptree.get<std::string>( "BR_hjbbQName_"             + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_b_b" ) );
        _name_BR_hjmumu.push_back            ( ptree.get<std::string>( "BR_hjmumuQName_"           + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_mu_mu" ) );
        _name_BR_hjtautau.push_back          ( ptree.get<std::string>( "BR_hjtautauQName_"         + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_tau_tau" ) );
        _name_BR_hjWW.push_back              ( ptree.get<std::string>( "BR_hjWWQName_"             + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_Wp_Wm" ) );
        _name_BR_hjZZ.push_back              ( ptree.get<std::string>( "BR_hjZZQName_"             + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_Z0_Z0" ) );
        _name_BR_hjZga.push_back             ( ptree.get<std::string>( "BR_hjZgaQName_"            + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_Z0_gamma" ) );
        _name_BR_hjgaga.push_back            ( ptree.get<std::string>( "BR_hjgagaQName_"           + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_gamma_gamma" ) );
        _name_BR_hjgg.push_back              ( ptree.get<std::string>( "BR_hjggQName_"             + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_g_g" ) );
        _name_BR_hjchi10chi10.push_back      ( ptree.get<std::string>( "BR_hjchi10chi10QName_"     + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_~chi10_~chi10" ) );
        _name_BR_hjnuenue.push_back          ( ptree.get<std::string>( "BR_hjnuenueQName_"         + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_nue_nue" ) );
        _name_BR_hjnumunumu.push_back        ( ptree.get<std::string>( "BR_hjnumunumuQName_"       + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_numu_numu" ) );
        _name_BR_hjnutaunutau.push_back      ( ptree.get<std::string>( "BR_hjnutaunutauQName_"     + number.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_nutau_nutau" ) );
    
        std::vector<std::string> BR_hjhihi;
        std::vector<std::string> CS_lep_hjhi;
        for( unsigned int j = 0; j < _nHzero; ++j ) {
        
            std::stringstream number2;
            number2 << j;
            BR_hjhihi.push_back( ptree.get<std::string>( "BR_hjhihiQName_" + number.str() + "_" + number2.str(), "FeynHiggs_BR_" + namesHzero.at(i) + "_to_" + namesHzero.at(j) + "_" + namesHzero.at(j) ) );
            CS_lep_hjhi.push_back( ptree.get<std::string>( "CS_lep_hjhiQName_" + number.str() + "_" + number2.str(), "FeynHiggs_Abs_g_" + namesHzero.at(i) + "_" + namesHzero.at(j) + "_Z0" ) );



        }
        _name_BR_hjhihi.push_back( BR_hjhihi );
        _name_CS_lep_hjhi_ratio.push_back( CS_lep_hjhi );

    }

    for( unsigned int i = 0; i < _nHplus; ++i ) {
        
        std::stringstream number;
        number << i + _nHzero;
       
        _name_mass_h_charged_shift.push_back ( ptree.get<std::string>( "DeltaMassQName_"           + number.str(), "DeltaMass_" + namesHplus.at(i)  ) );
        _mass_h_charged_shift.push_back      ( 0. );
        _name_mass_h_charged.push_back       ( ptree.get<std::string>( "MassQName_"                + number.str(), "FeynHiggs_Mass_" + namesHplus.at(i)              ) );
        _name_Gamma_Total_charged.push_back  ( ptree.get<std::string>( "GammaTotQName_"            + number.str(), "SPheno_GammaTotal_" + namesHplus.at(i)        ) );
        
        // this will be set to 1 later 
        _name_CS_lep_HpjHmi_ratio.push_back  ( ptree.get<std::string>( "CS_lep_HpjHmi_ratioQName_" + number.str(), "NONE" ) );
        _name_BR_tWpb.push_back              ( ptree.get<std::string>( "BR_tWpbQName_"             + number.str(), "FeynHiggs_BR_t_to_b_Wp" ) );
        _name_BR_tHpjb.push_back             ( ptree.get<std::string>( "BR_tHpjbQName_"            + number.str(), "FeynHiggs_BR_t_to_b_" + namesHplus.at(i) ) );
        _name_BR_Hpjcs.push_back             ( ptree.get<std::string>( "BR_HpjcsQName_"            + number.str(), "FeynHiggs_BR_" + namesHplus.at(i) + "_to_c_s" ) );
        _name_BR_Hpjcb.push_back             ( ptree.get<std::string>( "BR_HpjcbQName_"            + number.str(), "FeynHiggs_BR_" + namesHplus.at(i) + "_to_c_b" ) );
        _name_BR_Hptaunu.push_back           ( ptree.get<std::string>( "BR_HptaunuQName_"          + number.str(), "FeynHiggs_BR_" + namesHplus.at(i) + "_to_nutau_tau" ) );

    }

    initialize_higgsbounds_chisqtables_();
    char whichAnalyses[256];
    sprintf( whichAnalyses, "%s", _whichAnalyses.c_str() );
    initialize_higgsbounds_( &_nHzero, &_nHplus, _whichAnalyses.c_str(), _whichAnalyses.length() );

    
    //std::string expdata = "LHC_mail_14_07_2013_HS_new_observable_set";
    std::string expdata = ptree.get<std::string>( "ExpData" );
    std::cout<<"Using ExpData = "<<expdata<<std::endl;
    //initialize_higgssignals_( &_nHzero, &_nHplus, expdata.c_str(), expdata.size() );
    
    int output_level = 0;
    //setup_output_level_( &output_level );

    int pdf = 2; 
    //setup_pdf_( &pdf );

    for( int i = 0; i < _nHzero; ++i ) {
    
        _dm_neut.push_back(0);

    }
    for( int i = 0; i < _nHplus; ++i ) {
    
        _dm_charg.push_back(0);

    }
    //higgssignals_neutral_input_massuncertainty_( &_dm_neut.at(0) );
    //higgsbounds_set_mass_uncertainties_( &_dm_neut.at(0), &_dm_charg.at(0) );

    double range = 150.;
    //setup_assignmentrange_( &range );
                                                           
}

Fittino::HiggsSignalsPartXSCalculator::~HiggsSignalsPartXSCalculator() {

}

void Fittino::HiggsSignalsPartXSCalculator::Initialize() {

  
}


void Fittino::HiggsSignalsPartXSCalculator::CallHiggsBounds() {

    std::vector<double> mass_h_neutral;
    std::vector<double> Gamma_Total_neutral;
    std::vector<double> mass_h_charged;
    std::vector<double> Gamma_Total_charged;
    std::vector<double> CP;
    std::vector<double> CS_lep_hjZ_ratio;
    std::vector<double> CS_lep_bbhj_ratio;
    std::vector<std::vector<double> > CS_lep_hjhi_ratio;
    std::vector<double> CS_gg_hj_ratio;
    std::vector<double> CS_bb_hj_ratio;
    std::vector<double> CS_bg_hjb_ratio;
    std::vector<double> CS_ud_hjWp_ratio;
    std::vector<double> CS_cs_hjWp_ratio;
    std::vector<double> CS_ud_hjWm_ratio;
    std::vector<double> CS_cs_hjWm_ratio;
    std::vector<double> CS_gg_hjZ_ratio;
    std::vector<double> CS_dd_hjZ_ratio;
    std::vector<double> CS_uu_hjZ_ratio;
    std::vector<double> CS_ss_hjZ_ratio;
    std::vector<double> CS_cc_hjZ_ratio;
    std::vector<double> CS_bb_hjZ_ratio;
    std::vector<double> CS_tev_vbf_ratio;
    std::vector<double> CS_tev_tthj_ratio;
    std::vector<double> CS_lhc7_vbf_ratio;
    std::vector<double> CS_lhc7_tthj_ratio;
    std::vector<double> CS_lhc8_vbf_ratio;
    std::vector<double> CS_lhc8_tthj_ratio;
    std::vector<double> BR_hjss;
    std::vector<double> BR_hjcc;
    std::vector<double> BR_hjbb;
    std::vector<double> BR_hjmumu;
    std::vector<double> BR_hjtautau;
    std::vector<double> BR_hjWW;
    std::vector<double> BR_hjZZ;
    std::vector<double> BR_hjZga;
    std::vector<double> BR_hjgaga;
    std::vector<double> BR_hjgg;
    std::vector<double> BR_hjchi10chi10;
    std::vector<double> BR_hjnuenue;
    std::vector<double> BR_hjnumunumu;
    std::vector<double> BR_hjnutaunutau;
    std::vector<double> CS_lep_HpjHmi_ratio;
    std::vector<double> BR_tWpb;
    std::vector<double> BR_tHpjb;
    std::vector<double> BR_Hpjcs;
    std::vector<double> BR_Hpjcb;
    std::vector<double> BR_Hptaunu;
    std::vector<double> BR_hjinvisible;
    std::vector<double> CS_lep_tautauhj_ratio;
    std::vector<std::vector<double> > BR_hjhihi;
  
    for( int i = 0; i < _nHzero; ++i ) {
        mass_h_neutral.push_back        ( _model->GetCollectionOfQuantities().At( _name_mass_h_neutral.at( i ) )->GetValue() + _mass_h_neutral_shift.at(i) );
        Gamma_Total_neutral.push_back   ( _model->GetCollectionOfQuantities().At( _name_Gamma_Total_neutral.at(i) )->GetValue() );;
        CP.push_back                    ( i < 2 ? 1 : -1 ); 
        CS_lep_tautauhj_ratio.push_back ( pow( _model->GetCollectionOfQuantities().At( _name_CS_lep_tautauhj_ratio.at(i))->GetValue(),2 ));
        CS_lep_hjZ_ratio.push_back      ( pow( _model->GetCollectionOfQuantities().At( _name_CS_lep_hjZ_ratio.at(i) )->GetValue(),2 ));
        CS_lep_bbhj_ratio.push_back     ( pow( _model->GetCollectionOfQuantities().At( _name_CS_lep_bbhj_ratio.at(i) )->GetValue(),2 ));
        //CS_gg_hj_ratio.push_back        ( _model->GetCollectionOfQuantities().At( _name_CS_gg_hj_ratio.at(i) )->GetValue() );
        CS_gg_hj_ratio.push_back        ( 0. ); 
        CS_bb_hj_ratio.push_back        ( pow( _model->GetCollectionOfQuantities().At( _name_CS_bb_hj_ratio.at(i) )->GetValue(),2 ));
        CS_bg_hjb_ratio.push_back       ( pow( _model->GetCollectionOfQuantities().At( _name_CS_bg_hjb_ratio.at(i) )->GetValue(),2) );
        CS_ud_hjWp_ratio.push_back      ( pow( _model->GetCollectionOfQuantities().At( _name_CS_ud_hjWp_ratio.at(i) )->GetValue(),2) );
        CS_cs_hjWp_ratio.push_back      ( pow( _model->GetCollectionOfQuantities().At( _name_CS_cs_hjWp_ratio.at(i) )->GetValue(),2) );
        CS_ud_hjWm_ratio.push_back      ( pow( _model->GetCollectionOfQuantities().At( _name_CS_ud_hjWm_ratio.at(i) )->GetValue(),2) );
        CS_cs_hjWm_ratio.push_back      ( pow( _model->GetCollectionOfQuantities().At( _name_CS_cs_hjWm_ratio.at(i) )->GetValue(),2) );
        CS_gg_hjZ_ratio.push_back       ( pow( _model->GetCollectionOfQuantities().At( _name_CS_gg_hjZ_ratio.at(i) )->GetValue(),2 ));
        CS_dd_hjZ_ratio.push_back       ( pow( _model->GetCollectionOfQuantities().At( _name_CS_dd_hjZ_ratio.at(i) )->GetValue(),2 ));
        CS_uu_hjZ_ratio.push_back       ( pow( _model->GetCollectionOfQuantities().At( _name_CS_uu_hjZ_ratio.at(i) )->GetValue(),2 ));
        CS_ss_hjZ_ratio.push_back       ( pow( _model->GetCollectionOfQuantities().At( _name_CS_ss_hjZ_ratio.at(i) )->GetValue(),2 ));
        CS_cc_hjZ_ratio.push_back       ( pow( _model->GetCollectionOfQuantities().At( _name_CS_cc_hjZ_ratio.at(i) )->GetValue(),2 ));
        CS_bb_hjZ_ratio.push_back       ( pow( _model->GetCollectionOfQuantities().At( _name_CS_bb_hjZ_ratio.at(i) )->GetValue(),2 ));
        CS_tev_vbf_ratio.push_back      ( _model->GetCollectionOfQuantities().At( _name_CS_tev_vbf_ratio.at(i) )->GetValue() );
        CS_tev_tthj_ratio.push_back     ( _model->GetCollectionOfQuantities().At( _name_CS_tev_tthj_ratio.at(i) )->GetValue() );
        CS_lhc7_vbf_ratio.push_back     ( _model->GetCollectionOfQuantities().At( _name_CS_lhc7_vbf_ratio.at(i) )->GetValue() );
        CS_lhc7_tthj_ratio.push_back    ( _model->GetCollectionOfQuantities().At( _name_CS_lhc7_tthj_ratio.at(i) )->GetValue() );
        CS_lhc8_vbf_ratio.push_back     ( _model->GetCollectionOfQuantities().At( _name_CS_lhc8_vbf_ratio.at(i) )->GetValue() );
        CS_lhc8_tthj_ratio.push_back    ( _model->GetCollectionOfQuantities().At( _name_CS_lhc8_tthj_ratio.at(i) )->GetValue() );
        BR_hjss.push_back               ( _model->GetCollectionOfQuantities().At( _name_BR_hjss.at(i) )->GetValue() );
        BR_hjcc.push_back               ( _model->GetCollectionOfQuantities().At( _name_BR_hjcc.at(i) )->GetValue() );
        BR_hjbb.push_back               ( _model->GetCollectionOfQuantities().At( _name_BR_hjbb.at(i) )->GetValue() );
        BR_hjmumu.push_back             ( _model->GetCollectionOfQuantities().At( _name_BR_hjmumu.at(i) )->GetValue() );
        BR_hjtautau.push_back           ( _model->GetCollectionOfQuantities().At( _name_BR_hjtautau.at(i) )->GetValue() );
        BR_hjWW.push_back               ( _model->GetCollectionOfQuantities().At( _name_BR_hjWW.at(i) )->GetValue() );
        BR_hjZZ.push_back               ( _model->GetCollectionOfQuantities().At( _name_BR_hjZZ.at(i) )->GetValue() );
        BR_hjZga.push_back              ( _model->GetCollectionOfQuantities().At( _name_BR_hjZga.at(i) )->GetValue() );
        BR_hjgaga.push_back             ( _model->GetCollectionOfQuantities().At( _name_BR_hjgaga.at(i) )->GetValue() );
        BR_hjgg.push_back               ( _model->GetCollectionOfQuantities().At( _name_BR_hjgg.at(i) )->GetValue() );
        BR_hjchi10chi10.push_back       ( _model->GetCollectionOfQuantities().At( _name_BR_hjchi10chi10.at(i) )->GetValue() );
        BR_hjnuenue.push_back           ( _model->GetCollectionOfQuantities().At( _name_BR_hjnuenue.at(i) )->GetValue() );
        BR_hjnumunumu.push_back         ( _model->GetCollectionOfQuantities().At( _name_BR_hjnumunumu.at(i) )->GetValue() );
        BR_hjnutaunutau.push_back       ( _model->GetCollectionOfQuantities().At( _name_BR_hjnutaunutau.at(i) )->GetValue() );
        
        std::vector<double> br;
        std::vector<double> cs;
        for( int j = 0; j < _nHzero; ++j ) {
            cs.push_back                ( pow( _model->GetCollectionOfQuantities().At( _name_CS_lep_hjhi_ratio.at(i).at(j) )->GetValue(),2 ));
            br.push_back                ( _model->GetCollectionOfQuantities().At( _name_BR_hjhihi.at(i).at(j))->GetValue() );       
        }
        CS_lep_hjhi_ratio.push_back( cs );
        BR_hjhihi.push_back( br );

        BR_hjinvisible.push_back(   BR_hjchi10chi10.at(i)
                                  + BR_hjnuenue.at(i)
                                  + BR_hjnumunumu.at(i)
                                  + BR_hjnutaunutau.at(i) );
    }
    

    std::vector<double> CS_lep_hjhi_ratio_reformat;
    std::vector<double> BR_hjhihi_reformat;
    for( unsigned int j = 0; j < _nHzero; ++j ) {
        for( unsigned int i = 0; i < _nHzero; ++i ) {

            CS_lep_hjhi_ratio_reformat.push_back( pow( CS_lep_hjhi_ratio.at(i).at(j),2));
            BR_hjhihi_reformat.push_back( BR_hjhihi.at(i).at(j) );

        }
    }
    

    for( int i = 0; i < _nHplus; ++i ) {

        mass_h_charged.push_back        ( _model->GetCollectionOfQuantities().At( _name_mass_h_charged.at(i) )->GetValue() + _mass_h_charged_shift.at(i) );    
        Gamma_Total_charged.push_back   ( _model->GetCollectionOfQuantities().At( _name_Gamma_Total_charged.at(i) )->GetValue() );
        //CS_lep_HpjHmi_ratio.push_back   ( _model->GetCollectionOfQuantities().At( _name_CS_lep_HpjHmi_ratio.at(i) )->GetValue() );
        CS_lep_HpjHmi_ratio.push_back   ( 1. ); 
        BR_tWpb.push_back               ( _model->GetCollectionOfQuantities().At( _name_BR_tWpb.at(i) )->GetValue()  );
        BR_tHpjb.push_back              ( _model->GetCollectionOfQuantities().At( _name_BR_tHpjb.at(i) )->GetValue() );
        BR_Hpjcs.push_back              ( _model->GetCollectionOfQuantities().At( _name_BR_Hpjcs.at(i) )->GetValue() );
        BR_Hpjcb.push_back              ( _model->GetCollectionOfQuantities().At( _name_BR_Hpjcb.at(i) )->GetValue() );
        BR_Hptaunu.push_back            ( _model->GetCollectionOfQuantities().At( _name_BR_Hptaunu.at(i) )->GetValue() );
         

    }
    
    higgsbounds_neutral_input_part_( &mass_h_neutral.at(0),
                                    &Gamma_Total_neutral.at(0),
                                    &CP.at(0),
                                    &CS_lep_hjZ_ratio.at(0),
                                    &CS_lep_bbhj_ratio.at(0),
                                    &CS_lep_tautauhj_ratio.at(0),
                                    &CS_lep_hjhi_ratio_reformat.at(0),
                                    &CS_gg_hj_ratio.at(0),
                                    &CS_bb_hj_ratio.at(0),
                                    &CS_bg_hjb_ratio.at(0),
                                    &CS_ud_hjWp_ratio.at(0),
                                    &CS_cs_hjWp_ratio.at(0),
                                    &CS_ud_hjWm_ratio.at(0),
                                    &CS_cs_hjWm_ratio.at(0),
                                    &CS_gg_hjZ_ratio.at(0),
                                    &CS_dd_hjZ_ratio.at(0),
                                    &CS_uu_hjZ_ratio.at(0),
                                    &CS_ss_hjZ_ratio.at(0),
                                    &CS_cc_hjZ_ratio.at(0),
                                    &CS_bb_hjZ_ratio.at(0),
                                    &CS_tev_vbf_ratio.at(0),
                                    &CS_tev_tthj_ratio.at(0),
                                    &CS_lhc7_vbf_ratio.at(0),
                                    &CS_lhc7_tthj_ratio.at(0),
                                    &CS_lhc8_vbf_ratio.at(0),
                                    &CS_lhc8_tthj_ratio.at(0),
                                    &BR_hjss.at(0),
                                    &BR_hjcc.at(0),
                                    &BR_hjbb.at(0),
                                    &BR_hjmumu.at(0),
                                    &BR_hjtautau.at(0),
                                    &BR_hjWW.at(0),
                                    &BR_hjZZ.at(0),
                                    &BR_hjZga.at(0),
                                    &BR_hjgaga.at(0),
                                    &BR_hjgg.at(0),
                                    &BR_hjinvisible.at(0),
                                    &BR_hjhihi_reformat.at(0) );
    
    if( _nHplus > 0 ) {
        higgsbounds_charged_input_(     &mass_h_charged.at(0),
                                        &Gamma_Total_charged.at(0),
                                        &CS_lep_HpjHmi_ratio.at(0),
                                        &BR_tWpb.at(0),
                                        &BR_tHpjb.at(0),
                                        &BR_Hpjcs.at(0),
                                        &BR_Hpjcb.at(0),
                                        &BR_Hptaunu.at(0) );
    }
    _globalHiggsBoundsChi2 = RunHiggsBounds();

}

double Fittino::HiggsSignalsPartXSCalculator::RunHiggsBounds() {

    std::cout << "now running higgsbounds " << std::endl;
    run_higgsbounds_( &_HBresult, &_channel, &_obsratio, &_ncombined );
    std::cout << "hb result is " << _HBresult << " " << _channel << " " << _obsratio << " " << _ncombined << std::endl;
    if( _HBresult < 0 || _HBresult > 1 ) {
        
        return -1.0;

    }

    for( int i = 0; i < _model->GetObservableVector()->size(); ++i ) {
    
        std::string name = _model->GetObservableVector()->at(i)->GetPrediction()->GetName();
        if( name == _name_mass_h_neutral.at(0) ) {
            _theoryUncertainty1s = _model->GetObservableVector()->at(i)->GetMeasuredError();
            break;
        }

    }
    hb_calc_stats_( &_theoryUncertainty1s, &_chi2WithoutTheory, &_chi2WithTheory, &_bestChannelChi2 );
    std::cout << "hb_calc_stats_result is " << _chi2WithoutTheory << " " << _chi2WithTheory << " " << _bestChannelChi2 << std::endl;
    if( _chi2WithoutTheory < 0. ) {
        
        return -1.0;
    
    }

    if( _chi2WithTheory < 0. && _chi2WithoutTheory > 0. ) {

        return -1.0;

    }

    if( _channel != _bestChannelChi2 ) {

        if( _HBresult == 0 ) {
            
            _chi2WithoutTheory = 1000.;
            _chi2WithTheory = 1000.;
        
        }

    }
    return _chi2WithTheory;

}

void Fittino::HiggsSignalsPartXSCalculator::CalculatePredictions() {

    _globalHiggsBoundsChi2 = -1.;
    boost::thread threadHB( boost::bind( &Fittino::HiggsSignalsPartXSCalculator::CallHiggsBounds, this ) );
    threadHB.join();
    if( _globalHiggsBoundsChi2 < 0 ) {
        
        _chi2WithTheory = 10000.;
        _chi2WithoutTheory = 10000.;
        _globalHiggsBoundsChi2 = 10000.;

    }
    //run_higgssignals_( &_mode, &_chi2_mu, &_chi2_mass_h, &_chi2, &_nobs, &_pvalue );

    int i = 1;
    int collider = 3;
   
    /*
    get_rvalues_( &i, 
                  &collider,
                  &_R_H_WW, 
                  &_R_H_ZZ, 
                  &_R_H_gaga,
                  &_R_H_tautau,
                  &_R_H_bb,
                  &_R_VH_bb );
   */



}


void Fittino::HiggsSignalsPartXSCalculator::SetupMeasuredValues() {
    /* 
    // setup the delta mass values for higgs bounds
    for( int i = 0; i < _model->GetObservableVector()->size(); ++i ) {
       
        for( int j = 0; j < _nHzero; ++j ) {
        
            if( _model->GetObservableVector()->at(i)->GetPrediction()->GetName() == _name_mass_h_neutral_shift.at(j) ) {

                _mass_h_neutral_shift.at(j) = _model->GetObservableVector()->at(i)->GetMeasuredValue();

            }
        
        }
        
        for( int j = 0; j < _nHplus; ++j ) {
        
            if( _model->GetObservableVector()->at(i)->GetPrediction()->GetName() == _name_mass_h_charged_shift.at(j) ) {

                _mass_h_charged_shift.at(j) = _model->GetObservableVector()->at(i)->GetMeasuredValue();

            }
        
        }

    }
    */
    /*
    // get number of observable from HiggsSignals and loop over it
    int ntotal, npeakmu, npeakmh, nmpred, nanalyses;
    //__io_MOD_get_number_of_observables( &ntotal, &npeakmu, &npeakmh, &nmpred, &nanalyses );
    ntotal = 0;
    for ( int i = 1; i <= ntotal; ++i ) {

        double measuredValue_mh = -1.e9;
        double measuredValue_mu = -1.e9;
        std::ostringstream ss_index;
        ss_index << i;
        std::string s_index = ss_index.str();
        std::string fittinoName_mh = "HiggsSignalsObservable_" + s_index + "_mh";
        std::string fittinoName_mu = "HiggsSignalsObservable_" + s_index + "_mu";

        // get measured values from the model
        for ( int j = 0; j < _model->GetObservableVector()->size(); ++j ) {

            if ( _model->GetObservableVector()->at(j)->GetPrediction()->GetName() == fittinoName_mh ) {

                measuredValue_mh = _model->GetObservableVector()->at(j)->GetMeasuredValue();

            }

            if ( _model->GetObservableVector()->at(j)->GetPrediction()->GetName() == fittinoName_mu ) {

                measuredValue_mu = _model->GetObservableVector()->at(j)->GetMeasuredValue();

            }

        }

        // test if all observable were acutally defined
        if ( measuredValue_mh < -1.e-8 || measuredValue_mu < -1.e-8 ) {

    //       throw ConfigurationException( "Incomplete set of HiggsSignals Observables: Missing at least one (mu, mh) for HiggsSignalsObservable_ " + s_index );

        }

        // get observable ID from HiggsSignals
        int obsID = 0;
        //__io_MOD_get_id_of_peakobservable( &i, &obsID );

        // assign the new values
        //assign_toyvalues_to_peak_( &obsID, &measuredValue_mu, &measuredValue_mh );

    }
    */
}
