/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsRescalingCalculator.cpp                                 *
*                                                                              *
* Description Decoupling limit fix                                             *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <math.h>

#include <boost/property_tree/ptree.hpp>

#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "FeynHiggsRescalingCalculator.h"
#include "CHiggsSignals.h"

Fittino::FeynHiggsRescalingCalculator::FeynHiggsRescalingCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  : CalculatorBase( model ),
    _i_GammaTotal_h0         ( model->GetCollectionOfQuantities().At("FeynHiggs_GammaTotal_h0"                    )->GetValue() ),
    _i_Gamma_h_Wp_Wm         ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_Wp_Wm"                )->GetValue() ),
    _i_Gamma_h_Z0_Z0         ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_Z0_Z0"                )->GetValue() ),
    _i_Gamma_h_Z0_gamma      ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_Z0_gamma"             )->GetValue() ),
    _i_Gamma_h_gamma_gamma   ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_gamma_gamma"          )->GetValue() ),
    _i_Gamma_h_nue_nue       ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_nue_nue"              )->GetValue() ),
    _i_Gamma_h_e_e           ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_e_e"                  )->GetValue() ),
    _i_Gamma_h_numu_numu     ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_numu_numu"            )->GetValue() ),
    _i_Gamma_h_mu_mu         ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_mu_mu"                )->GetValue() ),
    _i_Gamma_h_nutau_nutau   ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_nutau_nutau"          )->GetValue() ),
    _i_Gamma_h_tau_tau       ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_tau_tau"              )->GetValue() ),
    _i_Gamma_h_u_u           ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_u_u"                  )->GetValue() ),
    _i_Gamma_h_d_d           ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_d_d"                  )->GetValue() ),
    _i_Gamma_h_c_c           ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_c_c"                  )->GetValue() ),
    _i_Gamma_h_s_s           ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_s_s"                  )->GetValue() ),
    _i_Gamma_h_b_b           ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_b_b"                  )->GetValue() ),
    _i_Gamma_h_chi10_chi10   ( model->GetCollectionOfQuantities().At("FeynHiggs_Gamma_h0_to_~chi10_~chi10"        )->GetValue() ),
    _i_TEV_ggh               ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_1.96TeV_h0_ggh"      )->GetValue() ),
    _i_TEV_bbh               ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_1.96TeV_h0_bbh"      )->GetValue() ),
    _i_TEV_btagbh            ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_1.96TeV_h0_btagbh"   )->GetValue() ),
    _i_TEV_Wh                ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_1.96TeV_h0_Wh"       )->GetValue() ),
    _i_TEV_Zh                ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_1.96TeV_h0_Zh"       )->GetValue() ),
    _i_TEV_qqh               ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_1.96TeV_h0_qqh"      )->GetValue() ),
    _i_TEV_tth               ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_1.96TeV_h0_tth"      )->GetValue() ),
    _i_LHC7_ggh              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_7TeV_h0_ggh"         )->GetValue() ),
    _i_LHC7_bbh              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_7TeV_h0_bbh"         )->GetValue() ),
    _i_LHC7_btagbh           ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_7TeV_h0_btagbh"      )->GetValue() ),
    _i_LHC7_Wh               ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_7TeV_h0_Wh"          )->GetValue() ),
    _i_LHC7_Zh               ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_7TeV_h0_Zh"          )->GetValue() ),
    _i_LHC7_qqh              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_7TeV_h0_qqh"         )->GetValue() ),
    _i_LHC7_tth              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_7TeV_h0_tth"         )->GetValue() ),
    _i_LHC8_ggh              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_8TeV_h0_ggh"         )->GetValue() ),
    _i_LHC8_bbh              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_8TeV_h0_bbh"         )->GetValue() ),
    _i_LHC8_btagbh           ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_8TeV_h0_btagbh"      )->GetValue() ),
    _i_LHC8_Wh               ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_8TeV_h0_Wh"          )->GetValue() ),
    _i_LHC8_Zh               ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_8TeV_h0_Zh"          )->GetValue() ),
    _i_LHC8_qqh              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_8TeV_h0_qqh"         )->GetValue() ),
    _i_LHC8_tth              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_8TeV_h0_tth"         )->GetValue() ),
    _i_LHC14_ggh             ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_14TeV_h0_ggh"        )->GetValue() ),
    _i_LHC14_bbh             ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_14TeV_h0_bbh"        )->GetValue() ),
    _i_LHC14_btagbh          ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_14TeV_h0_btagbh"     )->GetValue() ),
    _i_LHC14_Wh              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_14TeV_h0_Wh"         )->GetValue() ),
    _i_LHC14_Zh              ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_14TeV_h0_Zh"         )->GetValue() ),
    _i_LHC14_qqh             ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_14TeV_h0_qqh"        )->GetValue() ),
    _i_LHC14_tth             ( model->GetCollectionOfQuantities().At("FeynHiggs_CrossSection_14TeV_h0_tth"        )->GetValue() ),
    _SM_GammaTotal_h0        ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_GammaTotal_h0"                 )->GetValue() ),
    _SM_Gamma_h_Wp_Wm        ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_Wp_Wm"             )->GetValue() ),
    _SM_Gamma_h_Z0_Z0        ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_Z0_Z0"             )->GetValue() ),
    _SM_Gamma_h_Z0_gamma     ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_Z0_gamma"          )->GetValue() ),
    _SM_Gamma_h_gamma_gamma  ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_gamma_gamma"       )->GetValue() ),
    _SM_Gamma_h_nue_nue      ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_nue_nue"           )->GetValue() ),
    _SM_Gamma_h_e_e          ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_e_e"               )->GetValue() ),
    _SM_Gamma_h_numu_numu    ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_numu_numu"         )->GetValue() ),
    _SM_Gamma_h_mu_mu        ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_mu_mu"             )->GetValue() ),
    _SM_Gamma_h_nutau_nutau  ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_nutau_nutau"       )->GetValue() ),
    _SM_Gamma_h_tau_tau      ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_tau_tau"           )->GetValue() ),
    _SM_Gamma_h_u_u          ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_u_u"               )->GetValue() ),
    _SM_Gamma_h_d_d          ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_d_d"               )->GetValue() ),
    _SM_Gamma_h_c_c          ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_c_c"               )->GetValue() ),
    _SM_Gamma_h_s_s          ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_s_s"               )->GetValue() ),
    _SM_Gamma_h_b_b          ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_Gamma_h0_to_b_b"               )->GetValue() ),
    _SM_TEV_ggh              ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_1.96TeV_h0_ggh"   )->GetValue() ),
    _SM_TEV_bbh              ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_1.96TeV_h0_bbh"   )->GetValue() ),
    _SM_TEV_btagbh           ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_1.96TeV_h0_btagbh")->GetValue() ),
    _SM_TEV_Wh               ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_1.96TeV_h0_Wh"    )->GetValue() ),
    _SM_TEV_Zh               ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_1.96TeV_h0_Zh"    )->GetValue() ),
    _SM_TEV_qqh              ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_1.96TeV_h0_qqh"   )->GetValue() ),
    _SM_TEV_tth              ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_1.96TeV_h0_tth"   )->GetValue() ),
    _SM_LHC7_ggh             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_7TeV_h0_ggh"      )->GetValue() ),
    _SM_LHC7_bbh             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_7TeV_h0_bbh"      )->GetValue() ),
    _SM_LHC7_btagbh          ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_7TeV_h0_btagbh"   )->GetValue() ),
    _SM_LHC7_Wh              ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_7TeV_h0_Wh"       )->GetValue() ),
    _SM_LHC7_Zh              ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_7TeV_h0_Zh"       )->GetValue() ),
    _SM_LHC7_qqh             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_7TeV_h0_qqh"      )->GetValue() ),
    _SM_LHC7_tth             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_7TeV_h0_tth"      )->GetValue() ),
    _SM_LHC8_ggh             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_8TeV_h0_ggh"      )->GetValue() ),
    _SM_LHC8_bbh             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_8TeV_h0_bbh"      )->GetValue() ),
    _SM_LHC8_btagbh          ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_8TeV_h0_btagbh"   )->GetValue() ),
    _SM_LHC8_Wh              ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_8TeV_h0_Wh"       )->GetValue() ),
    _SM_LHC8_Zh              ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_8TeV_h0_Zh"       )->GetValue() ),
    _SM_LHC8_qqh             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_8TeV_h0_qqh"      )->GetValue() ),
    _SM_LHC8_tth             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_8TeV_h0_tth"      )->GetValue() ),
    _SM_LHC14_ggh            ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_14TeV_h0_ggh"     )->GetValue() ),
    _SM_LHC14_bbh            ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_14TeV_h0_bbh"     )->GetValue() ),
    _SM_LHC14_btagbh         ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_14TeV_h0_btagbh"  )->GetValue() ),
    _SM_LHC14_Wh             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_14TeV_h0_Wh"      )->GetValue() ),
    _SM_LHC14_Zh             ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_14TeV_h0_Zh"      )->GetValue() ),
    _SM_LHC14_qqh            ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_14TeV_h0_qqh"     )->GetValue() ),
    _SM_LHC14_tth            ( model->GetCollectionOfQuantities().At("FeynHiggs_SM_CrossSection_14TeV_h0_tth"     )->GetValue() ),
    _i_normSM_g_Abs2_h_Z0_Z0  ( model->GetCollectionOfQuantities().At("FeynHiggs_NormSM_g_Abs2_h0_Z0_Z0"           )->GetValue() ),
    _i_normSM_g_Abs2_h_b_b    ( model->GetCollectionOfQuantities().At("FeynHiggs_NormSM_g_Abs2h0_b_b"              )->GetValue() ),
    _i_normSM_g_Abs2_h_tau_tau( model->GetCollectionOfQuantities().At("FeynHiggs_NormSM_g_Abs2h0_tau_tau"          )->GetValue() ),
    _i_FeynHiggs_Mass_h0      ( model->GetCollectionOfQuantities().At("FeynHiggs_Mass_h0"                          )->GetValue() ) {

    _nHzero             = ptree.get<int>        ( "NHzero",             3                       );
    _nHplus             = ptree.get<int>        ( "NHPlus",             1                       );
    _whichAnalyses      = ptree.get<std::string>( "WhichAnalyses",      "LandH"                 );
    _name = "FeynHiggsRescaling";
    _tag = "FeynHiggsRescaling";
    _zero = 0;

    // recalculated

    AddQuantity( new SimplePrediction( "BR_H0_to_g_g"          , "", _zero     ) );
    AddQuantity( new SimplePrediction( "BR_A0_to_g_g"          , "", _zero     ) );
    AddQuantity( new SimplePrediction( "Gamma_A0_to_g_g"       , "", _zero     ) );
    AddQuantity( new SimplePrediction( "Gamma_H0_to_g_g"       , "", _zero     ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_H0_to_g_g", "", _zero     ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_A0_to_g_g", "", _zero     ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_H0_to_g_g"   , "", _zero     ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_A0_to_g_g"   , "", _zero     ) );

    AddQuantity( new SimplePrediction( "Original_Gamma_h0_to_g_g"        , "", _i_Gamma_h_g_g        ) );
    AddQuantity( new SimplePrediction( "Original_BR_h0_to_g_g"           , "", _i_BR_h_g_g           ) );
    AddQuantity( new SimplePrediction( "Original_NormSM_Gamma_h0_to_g_g" , "", _i_normSM_Gamma_h_g_g ) );
    AddQuantity( new SimplePrediction( "Original_NormSM_BR_h0_to_g_g"    , "", _i_normSM_BR_h_g_g    ) );
    AddQuantity( new SimplePrediction( "Original_SM_BR_h0_to_g_g"        , "", _SM_BR_h_g_g          ) );
    AddQuantity( new SimplePrediction( "Original_SM_Gamma_h0_to_g_g"     , "", _SM_Gamma_h_g_g       ) );

    // these are the rescaled quantities

    AddQuantity( new SimplePrediction( "GammaTotal_h0"           , "", _GammaTotal_h0       ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_g_g"         , "", _Gamma_h_g_g         ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_Wp_Wm"       , "", _Gamma_h_Wp_Wm       ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_Z0_Z0"       , "", _Gamma_h_Z0_Z0       ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_Z0_gamma"    , "", _Gamma_h_Z0_gamma    ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_gamma_gamma" , "", _Gamma_h_gamma_gamma ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_nue_nue"     , "", _Gamma_h_nue_nue     ) ); 
    AddQuantity( new SimplePrediction( "Gamma_h0_to_e_e"         , "", _Gamma_h_e_e         ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_numu_numu"   , "", _Gamma_h_numu_numu   ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_mu_mu"       , "", _Gamma_h_mu_mu       ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_nutau_nutau" , "", _Gamma_h_nutau_nutau ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_tau_tau"     , "", _Gamma_h_tau_tau     ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_u_u"         , "", _Gamma_h_u_u         ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_d_d"         , "", _Gamma_h_d_d         ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_c_c"         , "", _Gamma_h_c_c         ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_s_s"         , "", _Gamma_h_s_s         ) );
    AddQuantity( new SimplePrediction( "Gamma_h0_to_b_b"         , "", _Gamma_h_b_b         ) );

    AddQuantity( new SimplePrediction( "NormSM_GammaTotal_h0"    , "", _normSM_GammaTotal_h0 ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_g_g"         , "", _normSM_Gamma_h_g_g         ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_Wp_Wm"       , "", _normSM_Gamma_h_Wp_Wm       ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_Z0_Z0"       , "", _normSM_Gamma_h_Z0_Z0       ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_Z0_gamma"    , "", _normSM_Gamma_h_Z0_gamma    ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_gamma_gamma" , "", _normSM_Gamma_h_gamma_gamma ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_nue_nue"     , "", _normSM_Gamma_h_nue_nue     ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_e_e"         , "", _normSM_Gamma_h_e_e         ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_numu_numu"   , "", _normSM_Gamma_h_numu_numu   ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_mu_mu"       , "", _normSM_Gamma_h_mu_mu       ) ); 
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_nutau_nutau" , "", _normSM_Gamma_h_nutau_nutau ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_tau_tau"     , "", _normSM_Gamma_h_tau_tau     ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_u_u"         , "", _normSM_Gamma_h_u_u         ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_d_d"         , "", _normSM_Gamma_h_d_d         ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_c_c"         , "", _normSM_Gamma_h_c_c         ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_s_s"         , "", _normSM_Gamma_h_s_s         ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h0_to_b_b"         , "", _normSM_Gamma_h_b_b         ) );

    AddQuantity( new SimplePrediction( "BR_h0_to_g_g"                   , "", _BR_h_g_g                   ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_Wp_Wm"                 , "", _BR_h_Wp_Wm                 ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_Z0_Z0"                 , "", _BR_h_Z0_Z0                 ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_Z0_gamma"              , "", _BR_h_Z0_gamma              ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_gamma_gamma"           , "", _BR_h_gamma_gamma           ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_nue_nue"               , "", _BR_h_nue_nue               ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_e_e"                   , "", _BR_h_e_e                   ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_numu_numu"             , "", _BR_h_numu_numu             ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_mu_mu"                 , "", _BR_h_mu_mu                 ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_nutau_nutau"           , "", _BR_h_nutau_nutau           ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_tau_tau"               , "", _BR_h_tau_tau               ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_u_u"                   , "", _BR_h_u_u                   ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_d_d"                   , "", _BR_h_d_d                   ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_c_c"                   , "", _BR_h_c_c                   ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_s_s"                   , "", _BR_h_s_s                   ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_b_b"                   , "", _BR_h_b_b                   ) );
    AddQuantity( new SimplePrediction( "BR_h0_to_~chi10_~chi10"         , "", _BR_h_chi10_chi10           ) );
    
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_g_g"                   , "", _normSM_BR_h_g_g                   ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_Wp_Wm"                 , "", _normSM_BR_h_Wp_Wm                 ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_Z0_Z0"                 , "", _normSM_BR_h_Z0_Z0                 ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_Z0_gamma"              , "", _normSM_BR_h_Z0_gamma              ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_gamma_gamma"           , "", _normSM_BR_h_gamma_gamma           ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_nue_nue"               , "", _normSM_BR_h_nue_nue               ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_e_e"                   , "", _normSM_BR_h_e_e                   ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_numu_numu"             , "", _normSM_BR_h_numu_numu             ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_mu_mu"                 , "", _normSM_BR_h_mu_mu                 ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_nutau_nutau"           , "", _normSM_BR_h_nutau_nutau           ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_tau_tau"               , "", _normSM_BR_h_tau_tau               ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_u_u"                   , "", _normSM_BR_h_u_u                   ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_d_d"                   , "", _normSM_BR_h_d_d                   ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_c_c"                   , "", _normSM_BR_h_c_c                   ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_s_s"                   , "", _normSM_BR_h_s_s                   ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_h0_to_b_b"                   , "", _normSM_BR_h_b_b                   ) );

    AddQuantity( new SimplePrediction( "NormHB_GammaTotal_h0"                  , "", _normHB_GammaTotal                 ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_g_g"                   , "", _normHB_BR_h_g_g                   ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_Wp_Wm"                 , "", _normHB_BR_h_Wp_Wm                 ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_Z0_Z0"                 , "", _normHB_BR_h_Z0_Z0                 ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_Z0_gamma"              , "", _normHB_BR_h_Z0_gamma                 ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_gamma_gamma"           , "", _normHB_BR_h_gamma_gamma              ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_tau_tau"               , "", _normHB_BR_h_tau_tau                  ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_mu_mu"                 , "", _normHB_BR_h_mu_mu                    ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_c_c"                   , "", _normHB_BR_h_c_c                      ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_s_s"                   , "", _normHB_BR_h_s_s                      ) );
    AddQuantity( new SimplePrediction( "NormHB_BR_h0_to_b_b"                   , "", _normHB_BR_h_b_b                      ) );


    AddQuantity( new SimplePrediction( "CrossSection_1.96TeV_h0_ggh"    , "", _TEV_ggh                    ) );
    AddQuantity( new SimplePrediction( "CrossSection_1.96TeV_h0_bbh"    , "", _TEV_bbh                    ) );
    AddQuantity( new SimplePrediction( "CrossSection_1.96TeV_h0_btagbh" , "", _TEV_btagbh                 ) );
    AddQuantity( new SimplePrediction( "CrossSection_1.96TeV_h0_Wh"     , "", _TEV_Wh                     ) );
    AddQuantity( new SimplePrediction( "CrossSection_1.96TeV_h0_Zh"     , "", _TEV_Zh                     ) );
    AddQuantity( new SimplePrediction( "CrossSection_1.96TeV_h0_qqh"    , "", _TEV_qqh                    ) );
    AddQuantity( new SimplePrediction( "CrossSection_1.96TeV_h0_tth"    , "", _TEV_tth                    ) );
    
    AddQuantity( new SimplePrediction( "CrossSection_7TeV_h0_ggh"       , "", _LHC7_ggh                    ) );
    AddQuantity( new SimplePrediction( "CrossSection_7TeV_h0_bbh"       , "", _LHC7_bbh                    ) );
    AddQuantity( new SimplePrediction( "CrossSection_7TeV_h0_btagbh"    , "", _LHC7_btagbh                 ) );
    AddQuantity( new SimplePrediction( "CrossSection_7TeV_h0_Wh"        , "", _LHC7_Wh                     ) );
    AddQuantity( new SimplePrediction( "CrossSection_7TeV_h0_Zh"        , "", _LHC7_Zh                     ) );
    AddQuantity( new SimplePrediction( "CrossSection_7TeV_h0_qqh"       , "", _LHC7_qqh                    ) );
    AddQuantity( new SimplePrediction( "CrossSection_7TeV_h0_tth"       , "", _LHC7_tth                    ) );

    AddQuantity( new SimplePrediction( "CrossSection_8TeV_h0_ggh"       , "", _LHC8_ggh                    ) );
    AddQuantity( new SimplePrediction( "CrossSection_8TeV_h0_bbh"       , "", _LHC8_bbh                    ) );
    AddQuantity( new SimplePrediction( "CrossSection_8TeV_h0_btagbh"    , "", _LHC8_btagbh                 ) );
    AddQuantity( new SimplePrediction( "CrossSection_8TeV_h0_Wh"        , "", _LHC8_Wh                     ) );
    AddQuantity( new SimplePrediction( "CrossSection_8TeV_h0_Zh"        , "", _LHC8_Zh                     ) );
    AddQuantity( new SimplePrediction( "CrossSection_8TeV_h0_qqh"       , "", _LHC8_qqh                    ) );
    AddQuantity( new SimplePrediction( "CrossSection_8TeV_h0_tth"       , "", _LHC8_tth                    ) );
    
    AddQuantity( new SimplePrediction( "CrossSection_14TeV_h0_ggh"       , "", _LHC14_ggh                  ) );
    AddQuantity( new SimplePrediction( "CrossSection_14TeV_h0_bbh"       , "", _LHC14_bbh                  ) );
    AddQuantity( new SimplePrediction( "CrossSection_14TeV_h0_btagbh"    , "", _LHC14_btagbh               ) );
    AddQuantity( new SimplePrediction( "CrossSection_14TeV_h0_Wh"        , "", _LHC14_Wh                   ) );
    AddQuantity( new SimplePrediction( "CrossSection_14TeV_h0_Zh"        , "", _LHC14_Zh                   ) );
    AddQuantity( new SimplePrediction( "CrossSection_14TeV_h0_qqh"       , "", _LHC14_qqh                  ) );
    AddQuantity( new SimplePrediction( "CrossSection_14TeV_h0_tth"       , "", _LHC14_tth                  ) );
    
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_1.96TeV_h0_ggh"    , "", _normSM_TEV_ggh                    ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_1.96TeV_h0_bbh"    , "", _normSM_TEV_bbh                    ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_1.96TeV_h0_btagbh" , "", _normSM_TEV_btagbh                 ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_1.96TeV_h0_Wh"     , "", _normSM_TEV_Wh                     ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_1.96TeV_h0_Zh"     , "", _normSM_TEV_Zh                     ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_1.96TeV_h0_qqh"    , "", _normSM_TEV_qqh                    ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_1.96TeV_h0_tth"    , "", _normSM_TEV_tth                    ) );
    
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_7TeV_h0_ggh"       , "", _normSM_LHC7_ggh                    ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_7TeV_h0_bbh"       , "", _normSM_LHC7_bbh                    ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_7TeV_h0_btagbh"    , "", _normSM_LHC7_btagbh                 ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_7TeV_h0_Wh"        , "", _normSM_LHC7_Wh                     ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_7TeV_h0_Zh"        , "", _normSM_LHC7_Zh                     ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_7TeV_h0_qqh"       , "", _normSM_LHC7_qqh                    ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_7TeV_h0_tth"       , "", _normSM_LHC7_tth                    ) );

    AddQuantity( new SimplePrediction( "NormSM_CrossSection_8TeV_h0_ggh"       , "", _normSM_LHC8_ggh                    ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_8TeV_h0_bbh"       , "", _normSM_LHC8_bbh                    ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_8TeV_h0_btagbh"    , "", _normSM_LHC8_btagbh                 ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_8TeV_h0_Wh"        , "", _normSM_LHC8_Wh                     ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_8TeV_h0_Zh"        , "", _normSM_LHC8_Zh                     ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_8TeV_h0_qqh"       , "", _normSM_LHC8_qqh                    ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_8TeV_h0_tth"       , "", _normSM_LHC8_tth                    ) );
    
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_14TeV_h0_ggh"       , "", _normSM_LHC14_ggh                  ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_14TeV_h0_bbh"       , "", _normSM_LHC14_bbh                  ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_14TeV_h0_btagbh"    , "", _normSM_LHC14_btagbh               ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_14TeV_h0_Wh"        , "", _normSM_LHC14_Wh                   ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_14TeV_h0_Zh"        , "", _normSM_LHC14_Zh                   ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_14TeV_h0_qqh"       , "", _normSM_LHC14_qqh                  ) );
    AddQuantity( new SimplePrediction( "NormSM_CrossSection_14TeV_h0_tth"       , "", _normSM_LHC14_tth                  ) );

    AddQuantity( new SimplePrediction( "NormSM_g_Abs2_h0_tau_tau"       , "", _normSM_g_Abs2_h_tau_tau      ) );
    AddQuantity( new SimplePrediction( "NormSM_g_Abs2_h0_b_b"           , "", _normSM_g_Abs2_h_b_b          ) );
    AddQuantity( new SimplePrediction( "NormSM_g_Abs2_h0_Z0_Z0"         , "", _normSM_g_Abs2_h_Z0_Z0        ) );

    // FIXME: commenting this out again, as it seems to set nHZero/nHPlus to 1/0 in HB.
    //__theory_brfunctions_MOD_setup_brsm();
    
    // FIXME: maybe this is not neccessary, but not doing this results in an out-of-range for the pMSSM, due to HB apparently being initialized with a false number of Higgs bosons
    initialize_higgsbounds_chisqtables_();
    initialize_higgsbounds_( &_nHzero, &_nHplus, _whichAnalyses.c_str(), _whichAnalyses.length() );

}

Fittino::FeynHiggsRescalingCalculator::~FeynHiggsRescalingCalculator() {

}

void Fittino::FeynHiggsRescalingCalculator::CalculatePredictions() {

  // this is necesarry because the initial h->gg in the ntuple is buggy 
  
     double sum = 0;    
     sum += _i_Gamma_h_Wp_Wm;
     sum += _i_Gamma_h_Z0_Z0;
     sum += _i_Gamma_h_Z0_gamma;
     sum += _i_Gamma_h_gamma_gamma;
     sum += _i_Gamma_h_nue_nue;
     sum += _i_Gamma_h_e_e;
     sum += _i_Gamma_h_numu_numu;
     sum += _i_Gamma_h_mu_mu;
     sum += _i_Gamma_h_nutau_nutau;
     sum += _i_Gamma_h_tau_tau;
     sum += _i_Gamma_h_u_u;
     sum += _i_Gamma_h_d_d;
     sum += _i_Gamma_h_c_c;
     sum += _i_Gamma_h_s_s;
     sum += _i_Gamma_h_b_b;
     sum += _i_Gamma_h_chi10_chi10;

     _i_Gamma_h_g_g = _i_GammaTotal_h0 - sum; 
     _i_BR_h_g_g = _i_Gamma_h_g_g / _i_GammaTotal_h0; 

     sum = 0;    
     sum += _SM_Gamma_h_Wp_Wm;
     sum += _SM_Gamma_h_Z0_Z0;
     sum += _SM_Gamma_h_Z0_gamma;
     sum += _SM_Gamma_h_gamma_gamma;
     sum += _SM_Gamma_h_nue_nue;
     sum += _SM_Gamma_h_e_e;
     sum += _SM_Gamma_h_numu_numu;
     sum += _SM_Gamma_h_mu_mu;
     sum += _SM_Gamma_h_nutau_nutau;
     sum += _SM_Gamma_h_tau_tau;
     sum += _SM_Gamma_h_u_u;
     sum += _SM_Gamma_h_d_d;
     sum += _SM_Gamma_h_c_c;
     sum += _SM_Gamma_h_s_s;
     sum += _SM_Gamma_h_b_b;

     _SM_Gamma_h_g_g = _SM_GammaTotal_h0 - sum; 
     _SM_BR_h_g_g    = _SM_Gamma_h_g_g / _SM_GammaTotal_h0;

     _i_normSM_Gamma_h_g_g =  _i_Gamma_h_g_g / _SM_Gamma_h_g_g;
     _i_normSM_BR_h_g_g =  _i_BR_h_g_g / _SM_BR_h_g_g;

     // finished recalculation of h->gg
        
     _normSM_g_Abs2_h_Z0_Z0   = 1.0000*_i_normSM_g_Abs2_h_Z0_Z0; 
     _normSM_g_Abs2_h_b_b     = 0.9977*_i_normSM_g_Abs2_h_b_b;
     _normSM_g_Abs2_h_tau_tau = 0.9976*_i_normSM_g_Abs2_h_tau_tau;
     
     _TEV_ggh    = 1.2245*_i_TEV_ggh; 
     _TEV_bbh    = 0.9968*_i_TEV_bbh;   
     _TEV_btagbh = 0.9968*_i_TEV_btagbh;
     _TEV_Wh     = 0.9585*_i_TEV_Wh;  
     _TEV_Zh     = 0.9585*_i_TEV_Zh;   
     _TEV_qqh    = 0.9585*_i_TEV_qqh;
     _TEV_tth    = 0.9586*_i_TEV_tth;   

     _LHC7_ggh    = 1.0151*_i_LHC7_ggh;
     _LHC7_bbh    = 0.9968*_i_LHC7_bbh;   
     _LHC7_btagbh = 1.0000*_i_LHC7_btagbh;
     _LHC7_Wh     = 0.9585*_i_LHC7_Wh;  
     _LHC7_Zh     = 0.9585*_i_LHC7_Zh;   
     _LHC7_qqh    = 0.9585*_i_LHC7_qqh;
     _LHC7_tth    = 0.9586*_i_LHC7_tth;   

     _LHC8_ggh    = 1.0133*_i_LHC8_ggh;
     _LHC8_bbh    = 0.9968*_i_LHC8_bbh;   
     _LHC8_btagbh = 1.0000*_i_LHC8_btagbh;
     _LHC8_Wh     = 0.9585*_i_LHC8_Wh;  
     _LHC8_Zh     = 0.9585*_i_LHC8_Zh;   
     _LHC8_qqh    = 0.9585*_i_LHC8_qqh;
     _LHC8_tth    = 0.9586*_i_LHC8_tth;   

     _LHC14_ggh    = 1.0421*_i_LHC14_ggh;
     _LHC14_bbh    = 0.9968*_i_LHC14_bbh;   
     _LHC14_btagbh = 0.9968*_i_LHC14_btagbh;
     _LHC14_Wh     = 0.9585*_i_LHC14_Wh;  
     _LHC14_Zh     = 0.9585*_i_LHC14_Zh;   
     _LHC14_qqh    = 0.9585*_i_LHC14_qqh;
     _LHC14_tth    = 0.9586*_i_LHC14_tth;   

     _Gamma_h_g_g         = 0.9548*_i_Gamma_h_g_g;
     _Gamma_h_Wp_Wm       = 0.9585*_i_Gamma_h_Wp_Wm;
     _Gamma_h_Z0_Z0       = 0.9585*_i_Gamma_h_Z0_Z0;
     _Gamma_h_Z0_gamma    = 0.9586*_i_Gamma_h_Z0_gamma;
     _Gamma_h_gamma_gamma = 0.9589*_i_Gamma_h_gamma_gamma ;
     _Gamma_h_nue_nue     = _i_Gamma_h_nue_nue;
     _Gamma_h_e_e         = 0.9997*_i_Gamma_h_e_e;
     _Gamma_h_numu_numu   = _i_Gamma_h_numu_numu;
     _Gamma_h_mu_mu       = 0.9997*_i_Gamma_h_mu_mu;
     _Gamma_h_nutau_nutau = _i_Gamma_h_nutau_nutau;
     _Gamma_h_tau_tau     = 0.9997*_i_Gamma_h_tau_tau;
     _Gamma_h_u_u         = 1.0022*_i_Gamma_h_u_u;
     _Gamma_h_d_d         = 0.9999*_i_Gamma_h_d_d;
     _Gamma_h_c_c         = 1.0022*_i_Gamma_h_c_c;
     _Gamma_h_s_s         = 0.9999*_i_Gamma_h_s_s;
     _Gamma_h_b_b         = 0.9968*_i_Gamma_h_b_b;

     _GammaTotal_h0 = 0;    
     _GammaTotal_h0 += _Gamma_h_g_g;
     _GammaTotal_h0 += _Gamma_h_Wp_Wm;
     _GammaTotal_h0 += _Gamma_h_Z0_Z0;
     _GammaTotal_h0 += _Gamma_h_Z0_gamma;
     _GammaTotal_h0 += _Gamma_h_gamma_gamma;
     _GammaTotal_h0 += _Gamma_h_nue_nue;
     _GammaTotal_h0 += _Gamma_h_e_e;
     _GammaTotal_h0 += _Gamma_h_numu_numu;
     _GammaTotal_h0 += _Gamma_h_mu_mu;
     _GammaTotal_h0 += _Gamma_h_nutau_nutau;
     _GammaTotal_h0 += _Gamma_h_tau_tau;
     _GammaTotal_h0 += _Gamma_h_u_u;
     _GammaTotal_h0 += _Gamma_h_d_d;
     _GammaTotal_h0 += _Gamma_h_c_c;
     _GammaTotal_h0 += _Gamma_h_s_s;
     _GammaTotal_h0 += _Gamma_h_b_b;
     _GammaTotal_h0 += _i_Gamma_h_chi10_chi10;
  
     _BR_h_g_g         = _Gamma_h_g_g         / _GammaTotal_h0;  
     _BR_h_Wp_Wm       = _Gamma_h_Wp_Wm       / _GammaTotal_h0;  
     _BR_h_Z0_Z0       = _Gamma_h_Z0_Z0       / _GammaTotal_h0;  
     _BR_h_Z0_gamma    = _Gamma_h_Z0_gamma    / _GammaTotal_h0;  
     _BR_h_gamma_gamma = _Gamma_h_gamma_gamma / _GammaTotal_h0;  
     _BR_h_nue_nue     = _Gamma_h_nue_nue     / _GammaTotal_h0;  
     _BR_h_e_e         = _Gamma_h_e_e         / _GammaTotal_h0;  
     _BR_h_numu_numu   = _Gamma_h_numu_numu   / _GammaTotal_h0;  
     _BR_h_mu_mu       = _Gamma_h_mu_mu       / _GammaTotal_h0;  
     _BR_h_nutau_nutau = _Gamma_h_nutau_nutau / _GammaTotal_h0;  
     _BR_h_tau_tau     = _Gamma_h_tau_tau     / _GammaTotal_h0;  
     _BR_h_u_u         = _Gamma_h_u_u         / _GammaTotal_h0;  
     _BR_h_d_d         = _Gamma_h_d_d         / _GammaTotal_h0;  
     _BR_h_c_c         = _Gamma_h_c_c         / _GammaTotal_h0;  
     _BR_h_s_s         = _Gamma_h_s_s         / _GammaTotal_h0;  
     _BR_h_b_b         = _Gamma_h_b_b         / _GammaTotal_h0;  

     _BR_h_chi10_chi10 = _i_Gamma_h_chi10_chi10 / _GammaTotal_h0;

     _normSM_GammaTotal_h0       = _GammaTotal_h0       / _SM_GammaTotal_h0; 
     _normSM_Gamma_h_g_g         = _Gamma_h_g_g         / _SM_Gamma_h_g_g;
     _normSM_Gamma_h_Wp_Wm       = _Gamma_h_Wp_Wm       / _SM_Gamma_h_Wp_Wm;
     _normSM_Gamma_h_Z0_Z0       = _Gamma_h_Z0_Z0       / _SM_Gamma_h_Z0_Z0;
     _normSM_Gamma_h_Z0_gamma    = _Gamma_h_Z0_gamma    / _SM_Gamma_h_Z0_gamma;
     _normSM_Gamma_h_gamma_gamma = _Gamma_h_gamma_gamma / _SM_Gamma_h_gamma_gamma;
     _normSM_Gamma_h_nue_nue     = _Gamma_h_nue_nue     / _SM_Gamma_h_nue_nue;
     _normSM_Gamma_h_e_e         = _Gamma_h_e_e         / _SM_Gamma_h_e_e;
     _normSM_Gamma_h_numu_numu   = _Gamma_h_numu_numu   / _SM_Gamma_h_numu_numu;
     _normSM_Gamma_h_mu_mu       = _Gamma_h_mu_mu       / _SM_Gamma_h_mu_mu;
     _normSM_Gamma_h_nutau_nutau = _Gamma_h_nutau_nutau / _SM_Gamma_h_nutau_nutau;
     _normSM_Gamma_h_tau_tau     = _Gamma_h_tau_tau     / _SM_Gamma_h_tau_tau;
     _normSM_Gamma_h_u_u         = _Gamma_h_u_u         / _SM_Gamma_h_u_u;
     _normSM_Gamma_h_d_d         = _Gamma_h_d_d         / _SM_Gamma_h_d_d;
     _normSM_Gamma_h_c_c         = _Gamma_h_c_c         / _SM_Gamma_h_c_c;
     _normSM_Gamma_h_s_s         = _Gamma_h_s_s         / _SM_Gamma_h_s_s;
     _normSM_Gamma_h_b_b         = _Gamma_h_b_b         / _SM_Gamma_h_b_b;

     _normSM_BR_h_g_g         = _BR_h_g_g         / _SM_Gamma_h_g_g         * _SM_GammaTotal_h0;
     _normSM_BR_h_Wp_Wm       = _BR_h_Wp_Wm       / _SM_Gamma_h_Wp_Wm       * _SM_GammaTotal_h0;
     _normSM_BR_h_Z0_Z0       = _BR_h_Z0_Z0       / _SM_Gamma_h_Z0_Z0       * _SM_GammaTotal_h0;
     _normSM_BR_h_Z0_gamma    = _BR_h_Z0_gamma    / _SM_Gamma_h_Z0_gamma    * _SM_GammaTotal_h0;
     _normSM_BR_h_gamma_gamma = _BR_h_gamma_gamma / _SM_Gamma_h_gamma_gamma * _SM_GammaTotal_h0;
     _normSM_BR_h_nue_nue     = _BR_h_nue_nue     / _SM_Gamma_h_nue_nue     * _SM_GammaTotal_h0;
     _normSM_BR_h_e_e         = _BR_h_e_e         / _SM_Gamma_h_e_e         * _SM_GammaTotal_h0;
     _normSM_BR_h_numu_numu   = _BR_h_numu_numu   / _SM_Gamma_h_numu_numu   * _SM_GammaTotal_h0;
     _normSM_BR_h_mu_mu       = _BR_h_mu_mu       / _SM_Gamma_h_mu_mu       * _SM_GammaTotal_h0;
     _normSM_BR_h_nutau_nutau = _BR_h_nutau_nutau / _SM_Gamma_h_nutau_nutau * _SM_GammaTotal_h0;
     _normSM_BR_h_tau_tau     = _BR_h_tau_tau     / _SM_Gamma_h_tau_tau     * _SM_GammaTotal_h0;
     _normSM_BR_h_u_u         = _BR_h_u_u         / _SM_Gamma_h_u_u         * _SM_GammaTotal_h0;
     _normSM_BR_h_d_d         = _BR_h_d_d         / _SM_Gamma_h_d_d         * _SM_GammaTotal_h0;
     _normSM_BR_h_c_c         = _BR_h_c_c         / _SM_Gamma_h_c_c         * _SM_GammaTotal_h0;
     _normSM_BR_h_s_s         = _BR_h_s_s         / _SM_Gamma_h_s_s         * _SM_GammaTotal_h0;
     _normSM_BR_h_b_b         = _BR_h_b_b         / _SM_Gamma_h_b_b         * _SM_GammaTotal_h0;
    
     _normHB_GammaTotal = _normSM_GammaTotal_h0          * smgamma_h_    ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_g_g         = _normSM_BR_h_g_g         * smbr_hgg_     ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_Wp_Wm       = _normSM_BR_h_Wp_Wm       * smbr_hww_     ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_Z0_Z0       = _normSM_BR_h_Z0_Z0       * smbr_hzz_     ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_Z0_gamma    = _normSM_BR_h_Z0_gamma    * smbr_hzgam_   ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_gamma_gamma = _normSM_BR_h_gamma_gamma * smbr_hgamgam_ ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_tau_tau     = _normSM_BR_h_tau_tau     * smbr_htautau_ ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_mu_mu       = _normSM_BR_h_mu_mu       * smbr_hmumu_   ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_c_c         = _normSM_BR_h_c_c         * smbr_hcc_     ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_s_s         = _normSM_BR_h_s_s         * smbr_hss_     ( &_i_FeynHiggs_Mass_h0 );
     _normHB_BR_h_b_b         = _normSM_BR_h_b_b         * smbr_hbb_     ( &_i_FeynHiggs_Mass_h0 );

     _normSM_TEV_ggh    = _TEV_ggh    / _SM_TEV_ggh;
     _normSM_TEV_bbh    = _TEV_bbh    / _SM_TEV_bbh;  
     _normSM_TEV_btagbh = _TEV_btagbh / _SM_TEV_btagbh;  
     _normSM_TEV_Wh     = _TEV_Wh     / _SM_TEV_Wh;  
     _normSM_TEV_Zh     = _TEV_Zh     / _SM_TEV_Zh;  
     _normSM_TEV_qqh    = _TEV_qqh    / _SM_TEV_qqh;  
     _normSM_TEV_tth    = _TEV_tth    / _SM_TEV_tth;  

     _normSM_LHC7_ggh    = _LHC7_ggh    / _SM_LHC7_ggh;
     _normSM_LHC7_bbh    = _LHC7_bbh    / _SM_LHC7_bbh;  
     _normSM_LHC7_btagbh = _LHC7_btagbh / _SM_LHC7_btagbh;  
     _normSM_LHC7_Wh     = _LHC7_Wh     / _SM_LHC7_Wh;  
     _normSM_LHC7_Zh     = _LHC7_Zh     / _SM_LHC7_Zh;  
     _normSM_LHC7_qqh    = _LHC7_qqh    / _SM_LHC7_qqh;  
     _normSM_LHC7_tth    = _LHC7_tth    / _SM_LHC7_tth;  

     _normSM_LHC8_ggh    = _LHC8_ggh    / _SM_LHC8_ggh;
     _normSM_LHC8_bbh    = _LHC8_bbh    / _SM_LHC8_bbh;  
     _normSM_LHC8_btagbh = _LHC8_btagbh / _SM_LHC8_btagbh;  
     _normSM_LHC8_Wh     = _LHC8_Wh     / _SM_LHC8_Wh;  
     _normSM_LHC8_Zh     = _LHC8_Zh     / _SM_LHC8_Zh;  
     _normSM_LHC8_qqh    = _LHC8_qqh    / _SM_LHC8_qqh;  
     _normSM_LHC8_tth    = _LHC8_tth    / _SM_LHC8_tth;  

     _normSM_LHC14_ggh    = _LHC14_ggh    / _SM_LHC14_ggh;
     _normSM_LHC14_bbh    = _LHC14_bbh    / _SM_LHC14_bbh;  
     _normSM_LHC14_btagbh = _LHC14_btagbh / _SM_LHC14_btagbh;  
     _normSM_LHC14_Wh     = _LHC14_Wh     / _SM_LHC14_Wh;  
     _normSM_LHC14_Zh     = _LHC14_Zh     / _SM_LHC14_Zh;  
     _normSM_LHC14_qqh    = _LHC14_qqh    / _SM_LHC14_qqh;  
     _normSM_LHC14_tth    = _LHC14_tth    / _SM_LHC14_tth;  

}
