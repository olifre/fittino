/* $Id: HiggsSignalsPartXSCalculator.cpp 1982 2014-03-09 12:09:26Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */ 

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

#include <iostream>
#include <sstream>

#include "CHiggsSignals.h"
#include "HiggsSignalsPartXSCalculator.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "SimpleDataStorage.h"
#include "SimplePrediction.h"

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
    namesHzero.push_back( "h0" );
    namesHzero.push_back( "H0" );
    for( unsigned int i = 2; i < _nHzero; ++i ) {
        namesHzero.push_back( "A0" );
    }
    for( unsigned int i = 0; i < _nHplus; ++i ) {
        namesHplus.push_back( "Hp" );
    }


    for( unsigned int i = 0; i < _nHzero; ++i ) {
        
        std::stringstream number;
        number << i;

        _name_mass_h_neutral.push_back       ( ptree.get<std::string>( "MassQName_"                + number.str(), "FeynHiggs_Mass_" + namesHzero.at(i)              ) );
        _name_Gamma_Total_neutral.push_back  ( ptree.get<std::string>( "GammaTotQName_"            + number.str(), "FeynHiggs_GammaTotal_" + namesHzero.at(i)        ) );
        _name_lep_hjZ_ratio.push_back        ( ptree.get<std::string>( "CS_lep_hjZ_ratioQName_"    + number.str(), "FeynHiggs_Abs_g_" + namesHzero.at(i) + "_Z0_Z0"  ) );
        _name_CS_lep_bbhj_ratio.push_back    ( ptree.get<std::string>( "CS_lep_bbhj_ratioQName_"   + number.str(), "FeynHiggs_Abs_gs_" + namesHzero.at(i) + "_b_b"   ) );
        _name_CS_gg_hj_ratio.push_back       ( ptree.get<std::string>( "CS_gg_hj_ratioQName_"      + number.str(), "FeynHiggs_Abs_g_" + namesHzero.at(i) + "_g_g"   ) );
        _name_CS_bb_hj_ratio.push_back       ( ptree.get<std::string>( "CS_bb_hj_ratioQName_"      + number.str(), "FeynHiggs_Abs_gp_" + namesHzero.at(i) + "_b_b" ) );
        _name_CS_bg_hjb_ratio.push_back      ( ptree.get<std::string>( "CS_bg_hjb_ratioQName_"     + number.str(), "FeynHiggs_" ) );
        _name_CS_ud_hjWp_ratio.push_back     ( ptree.get<std::string>( "CS_ud_hjWp_ratioQName_"    + number.str(), "FeynHiggs_" ) );
        _name_CS_cs_hjWp_ratio.push_back     ( ptree.get<std::string>( "CS_cs_hjWp_ratioQName_"    + number.str(), "FeynHiggs_" ) );
        _name_CS_ud_hjWm_ratio.push_back     ( ptree.get<std::string>( "CS_ud_hjWm_ratioQName_"    + number.str(), "FeynHiggs_" ) );
        _name_CS_cs_hjWm_ratio.push_back     ( ptree.get<std::string>( "CS_cs_hjWm_ratioQName_"    + number.str(), "FeynHiggs_" ) );
        _name_CS_gg_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_gg_hjZ_ratioQName_"     + number.str(), "FeynHiggs_" ) ); 
        _name_CS_dd_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_dd_hjZ_ratioQName_"     + number.str(), "FeynHiggs_" ) ); 
        _name_CS_uu_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_uu_hjZ_ratioQName_"     + number.str(), "FeynHiggs_" ) ); 
        _name_CS_ss_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_ss_hjZ_ratioQName_"     + number.str(), "FeynHiggs_" ) ); 
        _name_CS_cc_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_cc_hjZ_ratioQName_"     + number.str(), "FeynHiggs_" ) ); 
        _name_CS_bb_hjZ_ratio.push_back      ( ptree.get<std::string>( "CS_bb_hjZ_ratioQName_"     + number.str(), "FeynHiggs_" ) ); 
        _name_CS_tev_vbf_ratio.push_back     ( ptree.get<std::string>( "CS_tev_vbf_ratioQName_"    + number.str(), "FeynHiggs_" ) );
        _name_CS_tev_tthj_ratio.push_back    ( ptree.get<std::string>( "CS_tev_tthj_ratioQName_"   + number.str(), "FeynHiggs_" ) );
        _name_CS_lhc7_vbf_ratio.push_back    ( ptree.get<std::string>( "CS_lhc7_vbf_ratioQName_"   + number.str(), "FeynHiggs_" ) );
        _name_CS_lhc7_tthj_ratio.push_back   ( ptree.get<std::string>( "CS_lhc7_tthj_ratioQName_"  + number.str(), "FeynHiggs_" ) );
        _name_CS_lhc8_vbf_ratio.push_back    ( ptree.get<std::string>( "CS_lhc8_vbf_ratioQName_"   + number.str(), "FeynHiggs_" ) );
        _name_CS_lhc8_tthj_ratio.push_back   ( ptree.get<std::string>( "CS_lhc8_tthj_ratioQName_"  + number.str(), "FeynHiggs_" ) );
        _name_BR_hjss.push_back              ( ptree.get<std::string>( "BR_hjssQName_"             + number.str(), "FeynHiggs_" ) );
        _name_BR_hjcc.push_back              ( ptree.get<std::string>( "BR_hjccQName_"             + number.str(), "FeynHiggs_" ) );
        _name_BR_hjbb.push_back              ( ptree.get<std::string>( "BR_hjbbQName_"             + number.str(), "FeynHiggs_" ) );
        _name_BR_hjmumu.push_back            ( ptree.get<std::string>( "BR_hjmumuQName_"           + number.str(), "FeynHiggs_" ) );
        _name_BR_hjtautau.push_back          ( ptree.get<std::string>( "BR_hjtautauQName_"         + number.str(), "FeynHiggs_" ) );
        _name_BR_hjWW.push_back              ( ptree.get<std::string>( "BR_hjWWQName_"             + number.str(), "FeynHiggs_" ) );
        _name_BR_hjZZ.push_back              ( ptree.get<std::string>( "BR_hjZZQName_"             + number.str(), "FeynHiggs_" ) );
        _name_BR_hjZga.push_back             ( ptree.get<std::string>( "BR_hjZgaQName_"            + number.str(), "FeynHiggs_" ) );
        _name_BR_hjgaga.push_back            ( ptree.get<std::string>( "BR_hjgagaQName_"           + number.str(), "FeynHiggs_" ) );
        _name_BR_hjgg.push_back              ( ptree.get<std::string>( "BR_hjggQName_"             + number.str(), "FeynHiggs_" ) );
        _name_BR_hjchi01chi01.push_back      ( ptree.get<std::string>( "BR_hjchi01chi01QName_"     + number.str(), "FeynHiggs_" ) );
        _name_BR_hjnuenue.push_back          ( ptree.get<std::string>( "BR_hjnuenueQName_"         + number.str(), "FeynHiggs_" ) );
        _name_BR_hjnumunumu.push_back        ( ptree.get<std::string>( "BR_hjnumunumuQName_"       + number.str(), "FeynHiggs_" ) );
        _name_BR_hjnutaunutau.push_back      ( ptree.get<std::string>( "BR_hjnutaunutauQName_"     + number.str(), "FeynHiggs_" ) );
        _name_BR_tWpb.push_back              ( ptree.get<std::string>( "BR_tWpbQName_"             + number.str(), "FeynHiggs_" ) );
        _name_BR_tHpjb.push_back             ( ptree.get<std::string>( "BR_tHpjbQName_"            + number.str(), "FeynHiggs_" ) );
        _name_BR_Hpjcs.push_back             ( ptree.get<std::string>( "BR_HpjcsQName_"            + number.str(), "FeynHiggs_" ) );
        _name_BR_Hpjcb.push_back             ( ptree.get<std::string>( "BR_HpjcbQName_"            + number.str(), "FeynHiggs_" ) );
        _name_BR_Hptaunu.push_back           ( ptree.get<std::string>( "BR_HptaunuQName_"          + number.str(), "FeynHiggs_" ) );
        _name_CS_lep_HpjHmi_ratio.push_back  ( ptree.get<std::string>( "CS_lep_HpjHmi_ratioQName_" + number.str(), "FeynHiggs_" ) ); 
    
        std::vector<std::string> BR_hjhihi;
        std::vector<std::string> CS_lep_hjhi;
        for( unsigned int j = 0; j < _nHzero; ++j ) {
        
            std::stringstream number2;
            number2 << j;
            BR_hjhihi.push_back( ptree.get<std::string>( "BR_hjhihiQName_" + number.str() + "_" + number2.str() ) );
            CS_lep_hjhi.push_back( ptree.get<std::string>( "CS_lep_hjhiQName_" + number.str() + "_" + number2.str() ) );



        }
        _name_BR_hjhihi.push_back( BR_hjhihi );
        _name_CS_lep_hjhi_ratio.push_back( CS_lep_hjhi );

    }

    for( unsigned int i = 0; i < _nHplus; ++i ) {
        
        std::stringstream number;
        number << i + _nHzero;
        
        _name_mass_h_charged.push_back       ( ptree.get<std::string>( "MassQName_"                + number.str(), "FeynHiggs_Mass_" + namesHzero.at(i)              ) );
        _name_Gamma_Total_charged.push_back  ( ptree.get<std::string>( "GammaTotQName_"            + number.str(), "FeynHiggs_GammaTotal_" + namesHzero.at(i)        ) );
        _name_CS_lep_HpjHmi_ratio.push_back  ( ptree.get<std::string>( "CS_lep_HpjHmi_ratioQName_" + number.str() ) );
        _name_BR_tWpb.push_back              ( ptree.get<std::string>( "BR_tWpbQName_"             + number.str() ) );
        _name_BR_tHpjb.push_back             ( ptree.get<std::string>( "BR_tHpjbQName_"            + number.str() ) );
        _name_BR_Hpjcs.push_back             ( ptree.get<std::string>( "BR_HpjcsQName_"            + number.str() ) );
        _name_BR_Hpjcb.push_back             ( ptree.get<std::string>( "BR_HpjcbQName_"            + number.str() ) );
        _name_BR_Hptaunu.push_back           ( ptree.get<std::string>( "BR_HptaunuQName_"          + number.str() ) );

    }

    int nHzeroHS = 1;
    int nHplusHS = 0;
    
    //std::string expdata = "LHC_mail_14_07_2013_HS_new_observable_set";
    std::string expdata = ptree.get<std::string>( "ExpData" );
    std::cout<<"Using ExpData = "<<expdata<<std::endl;
    initialize_higgssignals_( &nHzeroHS, &nHplusHS, expdata.c_str(), expdata.size() );
    
    int output_level = 0;
    setup_output_level_( &output_level );

    int pdf = 2; 
    setup_pdf_( &pdf );

    double dm = 0.;
    higgssignals_neutral_input_massuncertainty_( &dm );

    double range = 1000.;
    setup_assignmentrange_( &range );
                                                           
}

Fittino::HiggsSignalsPartXSCalculator::~HiggsSignalsPartXSCalculator() {

}

void Fittino::HiggsSignalsPartXSCalculator::Initialize() {

  
}


void Fittino::HiggsSignalsPartXSCalculator::CalculatePredictions() {
    
    std::vector<double> mass_h_neutral;
    std::vector<double> Gamma_Total_neutral;
    std::vector<double> mass_h_charged;
    std::vector<double> Gamma_Total_charged;
    std::vector<double> CP;
    std::vector<double> lep_hjZ_ratio;
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
    std::vector<double> BR_hjchi01chi01;
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

        mass_h_neutral.push_back        ( _model->GetCollectionOfQuantities().At( _name_mass_h_neutral.at( i ) )->GetValue() );
        Gamma_Total_neutral.push_back   ( _model->GetCollectionOfQuantities().At( _name_Gamma_Total_neutral.at(i) )->GetValue() );;
        mass_h_charged.push_back        ( _model->GetCollectionOfQuantities().At( _name_mass_h_charged.at(i) )->GetValue() );
        Gamma_Total_charged.push_back   ( _model->GetCollectionOfQuantities().At( _name_Gamma_Total_charged.at(i) )->GetValue() );
        CP.push_back                    ( i < 2 ? 1 : -1 ); 
        CS_lep_tautauhj_ratio.push_back          ( _model->GetCollectionOfQuantities().At( _name_CS_lep_tautauhj_ratio.at(i))->GetValue() );
        lep_hjZ_ratio.push_back         ( _model->GetCollectionOfQuantities().At( _name_lep_hjZ_ratio.at(i) )->GetValue() );
        CS_lep_bbhj_ratio.push_back     ( _model->GetCollectionOfQuantities().At( _name_CS_lep_bbhj_ratio.at(i) )->GetValue() );
        CS_gg_hj_ratio.push_back        ( _model->GetCollectionOfQuantities().At( _name_CS_gg_hj_ratio.at(i) )->GetValue() );
        CS_bb_hj_ratio.push_back        ( _model->GetCollectionOfQuantities().At( _name_CS_bb_hj_ratio.at(i) )->GetValue() );
        CS_bg_hjb_ratio.push_back       ( _model->GetCollectionOfQuantities().At( _name_CS_bg_hjb_ratio.at(i) )->GetValue() );
        CS_ud_hjWp_ratio.push_back      ( _model->GetCollectionOfQuantities().At( _name_CS_ud_hjWp_ratio.at(i) )->GetValue() );
        CS_cs_hjWp_ratio.push_back      ( _model->GetCollectionOfQuantities().At( _name_CS_cs_hjWp_ratio.at(i) )->GetValue() );
        CS_ud_hjWm_ratio.push_back      ( _model->GetCollectionOfQuantities().At( _name_CS_ud_hjWm_ratio.at(i) )->GetValue() );
        CS_cs_hjWm_ratio.push_back      ( _model->GetCollectionOfQuantities().At( _name_CS_cs_hjWm_ratio.at(i) )->GetValue() );
        CS_gg_hjZ_ratio.push_back       ( _model->GetCollectionOfQuantities().At( _name_CS_gg_hjZ_ratio.at(i) )->GetValue() );
        CS_dd_hjZ_ratio.push_back       ( _model->GetCollectionOfQuantities().At( _name_CS_dd_hjZ_ratio.at(i) )->GetValue() );
        CS_uu_hjZ_ratio.push_back       ( _model->GetCollectionOfQuantities().At( _name_CS_uu_hjZ_ratio.at(i) )->GetValue() );
        CS_ss_hjZ_ratio.push_back       ( _model->GetCollectionOfQuantities().At( _name_CS_ss_hjZ_ratio.at(i) )->GetValue() );
        CS_cc_hjZ_ratio.push_back       ( _model->GetCollectionOfQuantities().At( _name_CS_cc_hjZ_ratio.at(i) )->GetValue() );
        CS_bb_hjZ_ratio.push_back       ( _model->GetCollectionOfQuantities().At( _name_CS_bb_hjZ_ratio.at(i) )->GetValue() );
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
        BR_hjchi01chi01.push_back       ( _model->GetCollectionOfQuantities().At( _name_BR_hjchi01chi01.at(i) )->GetValue() );
        BR_hjnuenue.push_back           ( _model->GetCollectionOfQuantities().At( _name_BR_hjnuenue.at(i) )->GetValue() );
        BR_hjnumunumu.push_back         ( _model->GetCollectionOfQuantities().At( _name_BR_hjnumunumu.at(i) )->GetValue() );
        BR_hjnutaunutau.push_back       ( _model->GetCollectionOfQuantities().At( _name_BR_hjnutaunutau.at(i) )->GetValue() );
        
        std::vector<double> br;
        std::vector<double> cs;
        for( int j = 0; j < _nHzero; ++j ) {
            cs.push_back                ( _model->GetCollectionOfQuantities().At( _name_CS_lep_hjhi_ratio.at(i).at(j) )->GetValue() );
            br.push_back                ( _model->GetCollectionOfQuantities().At( _name_BR_hjhihi.at(i).at(j))->GetValue() );       
        }
        CS_lep_hjhi_ratio.push_back( cs );
        BR_hjhihi.push_back( br );

        BR_hjinvisible.push_back(   BR_hjchi01chi01.at(i)
                                  + BR_hjnuenue.at(i)
                                  + BR_hjnumunumu.at(i)
                                  + BR_hjnutaunutau.at(i) );
    }

    std::vector<double> CS_lep_hjhi_ratio_reformat;
    std::vector<double> BR_hjhihi_reformat;
    for( unsigned int j = 0; j < _nHzero; ++j ) {
        for( unsigned int i = 0; i < _nHzero; ++i ) {

            CS_lep_hjhi_ratio_reformat.push_back( CS_lep_hjhi_ratio.at(i).at(j));
            BR_hjhihi_reformat.push_back( BR_hjhihi.at(i).at(j) );

        }
    }

    for( int i = 0; i < _nHplus; ++i ) {

        CS_lep_HpjHmi_ratio.push_back   ( _model->GetCollectionOfQuantities().At( _name_CS_lep_HpjHmi_ratio.at(i) )->GetValue() );
        BR_tWpb.push_back               ( _model->GetCollectionOfQuantities().At( _name_BR_tWpb.at(i) )->GetValue()  );
        BR_tHpjb.push_back              ( _model->GetCollectionOfQuantities().At( _name_BR_tHpjb.at(i) )->GetValue() );
        BR_Hpjcs.push_back              ( _model->GetCollectionOfQuantities().At( _name_BR_Hpjcs.at(i) )->GetValue() );
        BR_Hpjcb.push_back              ( _model->GetCollectionOfQuantities().At( _name_BR_Hpjcb.at(i) )->GetValue() );
        BR_Hptaunu.push_back            ( _model->GetCollectionOfQuantities().At( _name_BR_Hptaunu.at(i) )->GetValue() );
   

    }
    higgsbounds_neutral_input_part_( &mass_h_neutral.at(0),
                                    &Gamma_Total_neutral.at(0),
                                    &CP.at(0),
                                    &lep_hjZ_ratio.at(0),
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

    higgsbounds_charged_input_(      &mass_h_charged.at(0),
                                    &Gamma_Total_charged.at(0),
                                    &CS_lep_HpjHmi_ratio.at(0),
                                    &BR_tWpb.at(0),
                                    &BR_tHpjb.at(0),
                                    &BR_Hpjcs.at(0),
                                    &BR_Hpjcb.at(0),
                                    &BR_Hptaunu.at(0) );


    run_higgssignals_( &_mode, &_chi2_mu, &_chi2_mass_h, &_chi2, &_nobs, &_pvalue );

    int i = 1;
    int collider = 3;
    
    get_rvalues_( &i, 
                  &collider,
                  &_R_H_WW, 
                  &_R_H_ZZ, 
                  &_R_H_gaga,
                  &_R_H_tautau,
                  &_R_H_bb,
                  &_R_VH_bb );




}


