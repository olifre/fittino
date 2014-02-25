/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSLHACalculator.cpp                                   *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>
#include <iostream>
#include <string>
#include <sstream>

#include "CHiggsSignals.h"
#include "ConfigurationException.h"
#include "HiggsSignalsSLHACalculator.h"
#include "PhysicsModel.h"
#include "SLHADataStorageBase.h"
#include "SimplePrediction.h"
#include "Observable.h"

Fittino::HiggsSignalsSLHACalculator::HiggsSignalsSLHACalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : SLHACalculatorBase( model ),
      // Initialize steering parameters of the HiggsSignalsSLHACalculator.
      _channelID             ( ptree.get<int>( "ChannelID",   40 ) ),
      _collider              ( ptree.get<int>( "Collider",     3 ) ),
      ///_corr_mh            ( ptree.get<int>( "Corrmh",       1 ) ),
      ///_corr_mu            ( ptree.get<int>( "Corrmu",       1 ) ),
      _detailed              ( ptree.get<int>( "Detailed",     1 ) ),
      _dm                    ( ptree.get<int>( "Dm",           0 ) ),
      _iterations            ( ptree.get<int>( "Iterations",   0 ) ),
      _mode                  ( ptree.get<int>( "Mode",         1 ) ),
      _nChannels             ( ptree.get<int>( "NChannels",    1 ) ),
      _nH                    ( ptree.get<int>( "NH",           1 ) ),
      _nHplus                ( ptree.get<int>( "NHplus",       0 ) ),
      _nHzero                ( ptree.get<int>( "NHzero",       1 ) ),
      _nobs                  ( ptree.get<int>( "NObs",         1 ) ),
      _output_level          ( ptree.get<int>( "OutputLevel",  0 ) ),
      _pdf                   ( ptree.get<int>( "PDF",          2 ) ),
      _range                 ( ptree.get<int>( "Range",        2 ) ),
      // Initialize input quantities.
      _BR_hihjhj             ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "BR_hihjhj.Name",        "BR_hihjhj"        ) )->GetValue() ),
      _g_hiss_s              ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hiss_s.Name",         "g_hiss_s"         ) )->GetValue() ),
      _g_hiss_p              ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hiss_p.Name",         "g_hiss_p"         ) )->GetValue() ),
      _g_hicc_s              ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hicc_s.Name",         "g_hicc_s"         ) )->GetValue() ),
      _g_hicc_p              ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hicc_p.Name",         "g_hicc_p"         ) )->GetValue() ),
      _g_hibb_s              ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hibb_s.Name",         "g_hibb_s"         ) )->GetValue() ),
      _g_hibb_p              ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hibb_p.Name",         "g_hibb_p"         ) )->GetValue() ),
      _g_hitt_s              ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hitt_s.Name",         "g_hitt_s"         ) )->GetValue() ),
      _g_hitt_p              ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hitt_p.Name",         "g_hitt_p"         ) )->GetValue() ),
      _g_himumu_s            ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_himumu_s.Name",       "g_himumu_s"       ) )->GetValue() ),
      _g_himumu_p            ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_himumu_p.Name",       "g_himumu_p"       ) )->GetValue() ),
      _g_hitautau_s          ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hitautau_s.Name",     "g_hitautau_s"     ) )->GetValue() ),
      _g_hitautau_p          ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hitautau_p.Name",     "g_hitautau_p"     ) )->GetValue() ),
      _g_hiWW                ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hiWW.Name",           "g_hiWW"           ) )->GetValue() ),
      _g_hiZZ                ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hiZZ.Name",           "g_hiZZ"           ) )->GetValue() ),
      _g_hiZga               ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hiZga.Name",          "g_hiZga"          ) )->GetValue() ),
      _g_higaga              ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_higaga.Name",         "g_higaga"         ) )->GetValue() ),
      _g_higg                ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_higg.Name",           "g_higg"           ) )->GetValue() ),
      _g_higgZ               ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_higgZ.Name",          "g_higgZ"          ) )->GetValue() ),
      _g_hihjZ               ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "g_hihjZ.Name",          "g_hihjZ"          ) )->GetValue() ),
      _GammaInvisible        ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Gamma_hInvisible.Name", "Gamma_hInvisible" ) )->GetValue() ),
      _mass_h                ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "mass_h.Name",           "mass_h"           ) )->GetValue() ) {

    /// \todo Decide later how to handle default quantities.
    ///
    ///try { _mass_h = _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "mass_h.Name", "mass_h" ) )->GetValue(); }
    ///catch ( const ConfigurationException& configurationException ) {

    ///    std::cout << "\n" << "WARNING: " << configurationException.what()  << std::endl;
    ///    std::cout         << "         " << "Using default value." << "\n" << std::endl;
    ///    AddQuantity( new SimplePrediction( "mass_h", "m_{h}", "GeV", "GeV", 0., 1.e6, _mass_h_default ) );
    ///    _mass_h = GetCollectionOfQuantities().At( "mass_h" )->GetValue();

    ///}
   
    /// Initialize steering parameters common to all SLHA calculators.

    _name               = ptree.get<std::string>( "Name",               "HiggsSignalsSLHACalculator" );
    _slhaOutputFileName = ptree.get<std::string>( "SLHAOutputFileName", "HS-output.slha"                  );

    /*!
     *  \todo Move back to Intitialize() function when not longer const.
     */

    initialize_higgssignals_latestresults_( &_nHzero, &_nHplus );
    setup_output_level_( &_output_level );
    setup_pdf_( &_pdf );
    higgssignals_neutral_input_massuncertainty_( &_dm );
    ///setup_correlations_( &_corr_mu, &_corr_mh );
    setup_assignmentrange_( &_range );
    setup_higgs_to_peaks_assignment_iterations_( &_iterations );

    /*!
     *  Add predictions.
     */

    AddQuantity( new SimplePrediction( "Mu_hgammgamma_1lep_ATL",                   "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (1lep)",                    "",    "",    0.,    1.e6, _Mu_hgammgamma_1lep_ATL                   ) );
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_conv_central_highPTt_ATL",   "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.-central-highPTt)",   "",    "",    0.,    1.e6, _Mu_hgammgamma_conv_central_highPTt_ATL   ) );
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_conv_central_lowPTt_ATL",    "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.-central-lowPTt)",    "",    "",    0.,    1.e6, _Mu_hgammgamma_conv_central_lowPTt_ATL    ) );
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_conv_rest_highPTt_ATL",      "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.-rest-highPTt)",      "",    "",    0.,    1.e6, _Mu_hgammgamma_conv_rest_highPTt_ATL      ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_conv_rest_lowPTt_ATL",       "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.-rest-lowPTt)",       "",    "",    0.,    1.e6, _Mu_hgammgamma_conv_rest_lowPTt_ATL       ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_conv_trans_ATL",             "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.trans.)",             "",    "",    0.,    1.e6, _Mu_hgammgamma_conv_trans_ATL             ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_ETmiss_ATL",                 "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (ETmiss)",                  "",    "",    0.,    1.e6, _Mu_hgammgamma_ETmiss_ATL                 ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_highmass2jetloose_ATL",      "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (highmass2jet,loose)",      "",    "",    0.,    1.e6, _Mu_hgammgamma_highmass2jetloose_ATL      ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_highmass2jettight_ATL",      "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (highmass2jet,tight)",      "",    "",    0.,    1.e6, _Mu_hgammgamma_highmass2jettight_ATL      ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_lowmass2jet_ATL",            "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (lowmass2jet)",             "",    "",    0.,    1.e6, _Mu_hgammgamma_lowmass2jet_ATL            ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_unconv_central_highPTt_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (unconv.-central-highPTt)", "",    "",    0.,    1.e6, _Mu_hgammgamma_unconv_central_highPTt_ATL ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_unconv_central_lowPTt_ATL",  "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (unconv.-central-lowPTt)",  "",    "",    0.,    1.e6, _Mu_hgammgamma_unconv_central_lowPTt_ATL  ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_unconv_rest_highPTt_ATL",    "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (unconv.-rest-highPTt)",    "",    "",    0.,    1.e6, _Mu_hgammgamma_unconv_rest_highPTt_ATL    ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammgamma_unconv_rest_lowPTt_ATL",     "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (unconv.-rest-lowPTt)",     "",    "",    0.,    1.e6, _Mu_hgammgamma_unconv_rest_lowPTt_ATL     ) ); 
    AddQuantity( new SimplePrediction( "Mu_htautau_ATL",                           "ATL (pp)#rightarrowh#rightarrow#tau#tau",                               "",    "",    0.,    1.e6, _Mu_htautau_ATL                           ) ); 
    AddQuantity( new SimplePrediction( "Mu_hWWlnulnu_ATL",                         "ATL (pp)#rightarrowh#rightarrowWW#rightarrowl#nul#nu",                  "",    "",    0.,    1.e6, _Mu_hWWlnulnu_ATL                         ) ); 
    AddQuantity( new SimplePrediction( "Mu_VBFWWlnulnu_ATL",                       "ATL (pp)#rightarrowVBF#rightarrowWW#rightarrowl#nul#nu",                "",    "",    0.,    1.e6, _Mu_VBFWWlnulnu_ATL                       ) ); 
    AddQuantity( new SimplePrediction( "Mu_hZZ4l_ATL",                             "ATL (pp)#rightarrowh#rightarrowZZ#rightarrow4l",                        "",    "",    0.,    1.e6, _Mu_hZZ4l_ATL                             ) ); 
    AddQuantity( new SimplePrediction( "Mu_VhVbb_ATL",                             "ATL (pp)#rightarrowVh#rightarrowVb#bar{b}",                             "",    "",    0.,    1.e6, _Mu_VhVbb_ATL                             ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammagamma_CDF",                       "CDF (pp)#rightarrowh#rightarrow#gamma#gamma",                           "",    "",    0.,    1.e6, _Mu_hgammagamma_CDF                       ) ); 
    AddQuantity( new SimplePrediction( "Mu_htautau_CDF",                           "CDF (pp)#rightarrowh#rightarrow#tau#tau",                               "",    "",    0.,    1.e6, _Mu_htautau_CDF                           ) ); 
    AddQuantity( new SimplePrediction( "Mu_hWW_CDF",                               "CDF (pp)#rightarrowh#rightarrowWW",                                     "",    "",    0.,    1.e6, _Mu_hWW_CDF                               ) ); 
    AddQuantity( new SimplePrediction( "Mu_tthttbb_CDF",                           "CDF (pp)#rightarrowt#bar{t}h#rightarrowttbb",                           "",    "",    0.,    1.e6, _Mu_tthttbb_CDF                           ) ); 
    AddQuantity( new SimplePrediction( "Mu_VhVbb_CDF",                             "CDF (pp)#rightarrowVh#rightarrowVb#bar{b}",                             "",    "",    0.,    1.e6, _Mu_VhVbb_CDF                             ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammagamma_2jet_CMS",                  "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (2jet)",                    "",    "",    0.,    1.e6, _Mu_hgammagamma_2jet_CMS                  ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammagamma_2jetloose_CMS",             "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (2jet-loose)",              "",    "",    0.,    1.e6, _Mu_hgammagamma_2jetloose_CMS             ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammagamma_2jettight_CMS",             "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (2jet-tight)",              "",    "",    0.,    1.e6, _Mu_hgammagamma_2jettight_CMS             ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammagamma_e_CMS",                     "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (e)",                       "",    "",    0.,    1.e6, _Mu_hgammagamma_e_CMS                     ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammagamma_inclusive_CMS",             "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (inclusive)",               "",    "",    0.,    1.e6, _Mu_hgammagamma_inclusive_CMS             ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammagamma_ETmiss_CMS",                "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (ETmiss)",                  "",    "",    0.,    1.e6, _Mu_hgammagamma_ETmiss_CMS                ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammagamma_mu_CMS",                    "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (#mu)",                     "",    "",    0.,    1.e6, _Mu_hgammagamma_mu_CMS                    ) ); 
    AddQuantity( new SimplePrediction( "Mu_htautau_01jet_CMS",                     "CMS (pp)#rightarrowh#rightarrow#tau#tau (0/1 jet)",                     "",    "",    0.,    1.e6, _Mu_htautau_01jet_CMS                     ) ); 
    AddQuantity( new SimplePrediction( "Mu_hWW_01jet_CMS",                         "CMS (pp)#rightarrowh#rightarrowWW (0/1 jet)",                           "",    "",    0.,    1.e6, _Mu_hWW_01jet_CMS                         ) );
    AddQuantity( new SimplePrediction( "Mu_hZZ4l_01jet_CMS",                       "CMS (pp)#rightarrowh#rightarrowZZ#rightarrow4l (0/1 jet)",              "",    "",    0.,    1.e6, _Mu_hZZ4l_01jet_CMS                       ) ); 
    AddQuantity( new SimplePrediction( "Mu_hZZ4l_2jet_CMS",                        "CMS (pp)#rightarrowh#rightarrowZZ#rightarrow4l (2jet)",                 "",    "",    0.,    1.e6, _Mu_hZZ4l_2jet_CMS                        ) ); 
    AddQuantity( new SimplePrediction( "Mu_tthttbb_CMS",                           "CMS (pp)#rightarrowt#bar{t}h#rightarrowttb#bar{b}",                     "",    "",    0.,    1.e6, _Mu_tthttbb_CMS                           ) ); 
    AddQuantity( new SimplePrediction( "Mu_VBFtautau_CMS",                         "CMS (pp)#rightarrowVBF#rightarrow#tau#tau",                             "",    "",    0.,    1.e6, _Mu_VBFtautau_CMS                         ) ); 
    AddQuantity( new SimplePrediction( "Mu_VBFWW_CMS",                             "CMS (pp)#rightarrowVBF#rightarrowWW",                                   "",    "",    0.,    1.e6, _Mu_VBFWW_CMS                             ) ); 
    AddQuantity( new SimplePrediction( "Mu_VhVbb_CMS",                             "CMS (pp)#rightarrowVh#rightarrowVb#bar{b}",                             "",    "",    0.,    1.e6, _Mu_VhVbb_CMS                             ) ); 
    AddQuantity( new SimplePrediction( "Mu_VhVtautau_CMS",                         "CMS (pp)#rightarrowVh#rightarrowV#tau#tau",                             "",    "",    0.,    1.e6, _Mu_VhVtautau_CMS                         ) ); 
    AddQuantity( new SimplePrediction( "Mu_WhWWW_CMS",                             "CMS (pp)#rightarrowWh#rightarrowWWW",                                   "",    "",    0.,    1.e6, _Mu_WhWWW_CMS                             ) ); 
    AddQuantity( new SimplePrediction( "Mu_hbb_D0",                                "D#slash{0} (pp)#rightarrowh#rightarrowb#bar{b}",                        "",    "",    0.,    1.e6, _Mu_hbb_D0                                ) ); 
    AddQuantity( new SimplePrediction( "Mu_hgammagamma_D0",                        "D#slash{0} (pp)#rightarrowh#rightarrow#gamma#gamma",                    "",    "",    0.,    1.e6, _Mu_hgammagamma_D0                        ) ); 
    AddQuantity( new SimplePrediction( "Mu_htautau_D0",                            "D#slash{0} (pp)#rightarrowh#rightarrow#tau#tau",                        "",    "",    0.,    1.e6, _Mu_htautau_D0                            ) ); 
    AddQuantity( new SimplePrediction( "Mu_hWW_D0",                                "D#slash{0} (pp)#rightarrowh#rightarrowWW",                              "",    "",    0.,    1.e6, _Mu_hWW_D0                                ) );
    AddQuantity( new SimplePrediction( "R_H_bb",                                   "R(h#rightarrowb#bar{b})",                                               "",    "",    0.,    1.e6, _R_H_bb                                   ) );
    AddQuantity( new SimplePrediction( "R_VH_bb",                                  "R(Vh#rightarrowVb#bar{b})",                                             "",    "",    0.,    1.e6, _R_VH_bb                                  ) );
    AddQuantity( new SimplePrediction( "R_H_tautau",                               "R(h#rightarrow#tau#tau)",                                               "",    "",    0.,    1.e6, _R_H_tautau                               ) );
    AddQuantity( new SimplePrediction( "R_H_WW",                                   "R(h#rightarrowWW)",                                                     "",    "",    0.,    1.e6, _R_H_WW                                   ) );
    AddQuantity( new SimplePrediction( "R_H_ZZ",                                   "R(h#rightarrowZZ)",                                                     "",    "",    0.,    1.e6, _R_H_ZZ                                   ) );
    AddQuantity( new SimplePrediction( "R_H_gammagamma",                           "R(h#rightarrow#gamma#gamma)",                                           "",    "",    0.,    1.e6, _R_H_gammagamma                           ) );
    AddQuantity( new SimplePrediction( "Gamma_hTotal",                             "#Gamma_{h}^{total}",                                                    "GeV", "GeV", 1.e-3, 1.,   _Gamma_hTotal                             ) );
    AddQuantity( new SimplePrediction( "BR_hss",                                   "BR(h#rightarrowss)",                                                    "",    "",    0.,    1.e6, _BR_hss                                   ) );
    AddQuantity( new SimplePrediction( "BR_hcc",                                   "BR(h#rightarrowcc)",                                                    "",    "",    0.,    1.e6, _BR_hcc                                   ) );
    AddQuantity( new SimplePrediction( "BR_hbb",                                   "BR(h#rightarrowbb)",                                                    "",    "",    0.,    1.e6, _BR_hbb                                   ) );
    AddQuantity( new SimplePrediction( "BR_htt",                                   "BR(h#rightarrowtt)",                                                    "",    "",    0.,    1.e6, _BR_htt                                   ) );
    AddQuantity( new SimplePrediction( "BR_hmumu",                                 "BR(h#rightarrow#mu#mu)",                                                "",    "",    0.,    1.e6, _BR_hmumu                                 ) );
    AddQuantity( new SimplePrediction( "BR_htautau",                               "BR(h#rightarrow#tau#tau)",                                              "",    "",    0.,    1.e6, _BR_htautau                               ) );
    AddQuantity( new SimplePrediction( "BR_hWW",                                   "BR(h#rightarrowWW)",                                                    "",    "",    0.,    1.e6, _BR_hWW                                   ) );
    AddQuantity( new SimplePrediction( "BR_hZZ",                                   "BR(h#rightarrowZZ)",                                                    "",    "",    0.,    1.e6, _BR_hZZ                                   ) );
    AddQuantity( new SimplePrediction( "BR_hZgamma",                               "BR(h#rightarrowZ#gamma)",                                               "",    "",    0.,    1.e6, _BR_hZgamma                               ) );
    AddQuantity( new SimplePrediction( "BR_hgammagamma",                           "BR(h#rightarrow#gamma#gamma)",                                          "",    "",    0.,    1.e6, _BR_hgammagamma                           ) );
    AddQuantity( new SimplePrediction( "BR_hgg",                                   "BR(h#rightarrowgg)",                                                    "",    "",    0.,    1.e6, _BR_hgg                                   ) );
    AddQuantity( new SimplePrediction( "BR_hss_SM",                                "BR(h#rightarrowss)^{SM}",                                               "",    "",    0.,    1.e6, _BR_hss_SM                                ) );
    AddQuantity( new SimplePrediction( "BR_hcc_SM",                                "BR(h#rightarrowcc)^{SM}",                                               "",    "",    0.,    1.e6, _BR_hcc_SM                                ) );
    AddQuantity( new SimplePrediction( "BR_hbb_SM",                                "BR(h#rightarrowbb)^{SM}",                                               "",    "",    0.,    1.e6, _BR_hbb_SM                                ) );
    AddQuantity( new SimplePrediction( "BR_htt_SM",                                "BR(h#rightarrowtt)^{SM}",                                               "",    "",    0.,    1.e6, _BR_htt_SM                                ) );
    AddQuantity( new SimplePrediction( "BR_hmumu_SM",                              "BR(h#rightarrow#mu#mu)^{SM}",                                           "",    "",    0.,    1.e6, _BR_hmumu_SM                              ) );
    AddQuantity( new SimplePrediction( "BR_htautau_SM",                            "BR(h#rightarrow#tau#tau)^{SM}",                                         "",    "",    0.,    1.e6, _BR_htautau_SM                            ) );
    AddQuantity( new SimplePrediction( "BR_hWW_SM",                                "BR(h#rightarrowWW)^{SM}",                                               "",    "",    0.,    1.e6, _BR_hWW_SM                                ) );
    AddQuantity( new SimplePrediction( "BR_hZZ_SM",                                "BR(h#rightarrowZZ)^{SM}",                                               "",    "",    0.,    1.e6, _BR_hZZ_SM                                ) );
    AddQuantity( new SimplePrediction( "BR_hZgamma_SM",                            "BR(h#rightarrowZ#gamma)^{SM}",                                          "",    "",    0.,    1.e6, _BR_hZgamma_SM                            ) );
    AddQuantity( new SimplePrediction( "BR_hgammagamma_SM",                        "BR(h#rightarrow#gamma#gamma)^{SM}",                                     "",    "",    0.,    1.e6, _BR_hgammagamma_SM                        ) );
    AddQuantity( new SimplePrediction( "BR_hgg_SM",                                "BR(h#rightarrowgg)^{SM}",                                               "",    "",    0.,    1.e6, _BR_hgg_SM                                ) );
    AddQuantity( new SimplePrediction( "BR_hInvisible",                            "BR(h#rightarrowInvisible)",                                             "",    "",    0.,    1.e6, _BR_hInvisible                            ) );
    AddQuantity( new SimplePrediction( "g2_SM_hgammagamma",                        "g^{2}(h#gamma#gamma)^{SM}",                                             "",    "",    0.,    1.e6, _g2_SM_hgammagamma                        ) );
    AddQuantity( new SimplePrediction( "g2_SM_hgg",                                "g^{2}(hgg)^{SM}",                                                       "",    "",    0.,    1.e6, _g2_SM_hgg                                ) );
    AddQuantity( new SimplePrediction( "BR_hInvisible_Limit",                      "", _BR_hInvisible_Limit  ) );
    AddQuantity( new SimplePrediction( "HS_chi2",                                  "", _chi2                 ) );
    AddQuantity( new SimplePrediction( "Gamma_hTotal_Penalty",                     "", _Gamma_hTotal_Penalty ) );

}

Fittino::HiggsSignalsSLHACalculator::~HiggsSignalsSLHACalculator() {

}

void Fittino::HiggsSignalsSLHACalculator::Initialize() const {

    /*!
     *  \todo Remove const attribute.
     */

}

void Fittino::HiggsSignalsSLHACalculator::CalculatePredictions() {

    // Calculate the squares of the coupling constants.

    double g2_hiss_s     = pow( _g_hiss_s,     2 );
    double g2_hiss_p     = pow( _g_hiss_p,     2 );
    double g2_hicc_s     = pow( _g_hicc_s,     2 );
    double g2_hicc_p     = pow( _g_hicc_p,     2 );
    double g2_hibb_s     = pow( _g_hibb_s,     2 );
    double g2_hibb_p     = pow( _g_hibb_p,     2 );
    double g2_hitt_s     = pow( _g_hitt_s,     2 );
    double g2_hitt_p     = pow( _g_hitt_p,     2 );
    double g2_himumu_s   = pow( _g_himumu_s,   2 );
    double g2_himumu_p   = pow( _g_himumu_p,   2 );
    double g2_hitautau_s = pow( _g_hitautau_s, 2 );
    double g2_hitautau_p = pow( _g_hitautau_p, 2 );
    double g2_hiWW       = pow( _g_hiWW,       2 );
    double g2_hiZZ       = pow( _g_hiZZ,       2 );
    double g2_hiZga      = pow( _g_hiZga,      2 );
    double g2_higaga     = pow( _g_higaga,     2 );
    double g2_higg       = pow( _g_higg,       2 );
    double g2_higgZ      = pow( _g_higgZ,      2 );
    double g2_hihjZ      = pow( _g_hihjZ,      2 );

    // Calculate the total width of the Higgs boson.

    _Gamma_hTotal = CalculateGammahTotal( _mass_h,
                                          g2_hiss_s,
                                          g2_hicc_s,
                                          g2_hibb_s,
                                          g2_hitt_s,
                                          g2_himumu_s,
                                          g2_hitautau_s,
                                          g2_hiWW,
                                          g2_hiZZ,
                                          g2_hiZga,
                                          g2_higaga,
                                          g2_higg,
                                          _GammaInvisible );

    // Convert GammaInvisible to the branching ratio BR(h->Invisible).

    _BR_hInvisible = CalculateBRhInvisible( _Gamma_hTotal, _GammaInvisible );

    // Set the (relative) rate uncertainties.

    SetRateUncertainties( _g_hibb_s, _g_hibb_p, _g_higg, _mass_h );

    // Setup HiggsBounds.

    higgsbounds_neutral_input_effc_( &_mass_h,
                                     &_Gamma_hTotal,
                                     &g2_hiss_s,
                                     &g2_hiss_p,
                                     &g2_hicc_s,
                                     &g2_hicc_p,
                                     &g2_hibb_s,
                                     &g2_hibb_p,
                                     &g2_hitt_s,
                                     &g2_hitt_p,
                                     &g2_himumu_s,
                                     &g2_himumu_p,
                                     &g2_hitautau_s,
                                     &g2_hitautau_p,
                                     &g2_hiWW,
                                     &g2_hiZZ,
                                     &g2_hiZga,
                                     &g2_higaga,
                                     &g2_higg,
                                     &g2_higgZ,
                                     &g2_hihjZ,
                                     &_BR_hInvisible,
                                     &_BR_hihjhj );

    // Run HiggsSignals.

    run_higgssignals_( &_mode, &_chi2_mu, &_chi2_massh, &_chi2, &_nobs, &_pvalue );

    // Calculate the R values.

    get_rvalues_( &_nH, &_collider, &_R_H_WW, &_R_H_ZZ, &_R_H_gammagamma, &_R_H_tautau, &_R_H_bb, &_R_VH_bb );

    // SM predictions of the branching fractions.

    _BR_hss_SM         = smbr_hss_    ( &_mass_h );
    _BR_hcc_SM         = smbr_hcc_    ( &_mass_h );
    _BR_hbb_SM         = smbr_hbb_    ( &_mass_h );
    _BR_htt_SM         = smbr_htoptop_( &_mass_h );
    _BR_hmumu_SM       = smbr_hmumu_  ( &_mass_h );
    _BR_htautau_SM     = smbr_htautau_( &_mass_h );
    _BR_hWW_SM         = smbr_hww_    ( &_mass_h );
    _BR_hZZ_SM         = smbr_hzz_    ( &_mass_h );
    _BR_hZgamma_SM     = smbr_hzgam_  ( &_mass_h );
    _BR_hgammagamma_SM = smbr_hgamgam_( &_mass_h );
    _BR_hgg_SM         = smbr_hgg_    ( &_mass_h );

    // Calculate the branching fractions.

    _BR_hss         = CalculateBR( g2_hiss_s,     _mass_h, _Gamma_hTotal, _BR_hss_SM );
    _BR_hcc         = CalculateBR( g2_hicc_s,     _mass_h, _Gamma_hTotal, _BR_hcc_SM );
    _BR_hbb         = CalculateBR( g2_hibb_s,     _mass_h, _Gamma_hTotal, _BR_hbb_SM );
    _BR_htt         = CalculateBR( g2_hitt_s,     _mass_h, _Gamma_hTotal, _BR_htt_SM );
    _BR_hmumu       = CalculateBR( g2_himumu_s,   _mass_h, _Gamma_hTotal, _BR_hmumu_SM );
    _BR_htautau     = CalculateBR( g2_hitautau_s, _mass_h, _Gamma_hTotal, _BR_htautau_SM );
    _BR_hWW         = CalculateBR( g2_hiWW,       _mass_h, _Gamma_hTotal, _BR_hWW_SM );
    _BR_hZZ         = CalculateBR( g2_hiZZ,       _mass_h, _Gamma_hTotal, _BR_hZZ_SM );
    _BR_hZgamma     = CalculateBR( g2_hiZga,      _mass_h, _Gamma_hTotal, _BR_hZgamma_SM );
    _BR_hgammagamma = CalculateBR( g2_higaga,     _mass_h, _Gamma_hTotal, _BR_hgammagamma_SM );
    _BR_hgg         = CalculateBR( g2_higg,       _mass_h, _Gamma_hTotal, _BR_hgg_SM );

    // Calculate the SM variations of the loop induced couplings.

    _g2_SM_hgammagamma = Calculateg2hgammagamma( _g_hibb_s,
                                                 _g_hitt_s,
                                                 _g_hitautau_s,
                                                 _g_hiWW,
                                                 _g_hiZZ,
                                                 _mass_h );

    _g2_SM_hgg = Calculateg2hgg( _g_hibb_s,
                                 _g_hitt_s,
                                 _mass_h );

    // Set the upper limit of the total width of the Higgs boson.

    _Gamma_hTotal_Penalty = 0.;

    if ( _Gamma_hTotal > 1. ) _Gamma_hTotal_Penalty = 1000000.;

    // Calculate the chi2 coming from the measured limit on invisible decays of the Higgs.

    double HZrate;
    get_rates_( &_nH, &_collider, &_nChannels, &_channelID, &HZrate );
    _BR_hInvisible_Limit = CalculateBRhInvisibleLimit( _BR_hInvisible * HZrate );

    ///double BR_Total = _BR_hss + _BR_hcc + _BR_hbb + _BR_htt + _BR_hmumu
    ///                  + _BR_htautau + _BR_hWW + _BR_hZZ + _BR_hZgamma
    ///                  + _BR_hgammagamma + _BR_hgg + _BR_hInvisible;
    ///try {
    ///
    ///    if ( BR_Total > 1. + 1.e-16 && BR_Total < 1. - 1.e-16 ) {
    ///
    ///        throw ConfigurationException( "BR_Total unequal 1" );
    ///
    ///    }
    ///
    ///}
    ///
    ///catch ( const ConfigurationException& configurationException ) {
    ///
    ///  std::cout << "\n" << configurationException.what() << "\n" << std::endl;
    ///  exit( EXIT_FAILURE );
    ///
    ///}

    // Write the HiggsSignals output to file.

    system( "rm HS-output.slha" );

    // __io_MOD_higgssignals_create_slha_output_default( &_detailed );

    // Write the additional HiggsSignals predictions to file.

    _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );

    std::string blockName = "HiggsSignalsAdditionalPredictions";

    _slhaOutputDataStorage->AddBlock( blockName + ":BLOCK " + blockName + ":# Additional predictions" );

    _slhaOutputDataStorage->AddLine( blockName +  ":1:" + String( _R_H_WW )               + ":# R_H_WW" );
    _slhaOutputDataStorage->AddLine( blockName +  ":2:" + String( _R_H_ZZ )               + ":# R_H_ZZ" );
    _slhaOutputDataStorage->AddLine( blockName +  ":3:" + String( _R_H_gammagamma )       + ":# R_H_gammagamma" );
    _slhaOutputDataStorage->AddLine( blockName +  ":4:" + String( _R_H_tautau )           + ":# R_H_tautau" );
    _slhaOutputDataStorage->AddLine( blockName +  ":5:" + String( _R_H_bb )               + ":# R_H_bb" );
    _slhaOutputDataStorage->AddLine( blockName +  ":6:" + String( _R_VH_bb )              + ":# R_VH_bb" );
    _slhaOutputDataStorage->AddLine( blockName +  ":7:" + String( _Gamma_hTotal )         + ":# Gamma_hTotal" );
    _slhaOutputDataStorage->AddLine( blockName +  ":8:" + String( _BR_hss )               + ":# BR_hss" );
    _slhaOutputDataStorage->AddLine( blockName +  ":9:" + String( _BR_hcc )               + ":# BR_hcc" );
    _slhaOutputDataStorage->AddLine( blockName + ":10:" + String( _BR_hbb )               + ":# BR_hbb" );
    _slhaOutputDataStorage->AddLine( blockName + ":11:" + String( _BR_htt )               + ":# BR_htt" );
    _slhaOutputDataStorage->AddLine( blockName + ":12:" + String( _BR_hmumu )             + ":# BR_hmumu" );
    _slhaOutputDataStorage->AddLine( blockName + ":13:" + String( _BR_htautau )           + ":# BR_htautau" );
    _slhaOutputDataStorage->AddLine( blockName + ":14:" + String( _BR_hWW )               + ":# BR_hWW" );
    _slhaOutputDataStorage->AddLine( blockName + ":15:" + String( _BR_hZZ )               + ":# BR_hZZ" );
    _slhaOutputDataStorage->AddLine( blockName + ":16:" + String( _BR_hZgamma )           + ":# BR_hZgamma" );
    _slhaOutputDataStorage->AddLine( blockName + ":17:" + String( _BR_hgammagamma )       + ":# BR_hgammagamma" );
    _slhaOutputDataStorage->AddLine( blockName + ":18:" + String( _BR_hgg )               + ":# BR_hgg" );
    _slhaOutputDataStorage->AddLine( blockName + ":19:" + String( _BR_hss_SM )            + ":# BR_hss_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":20:" + String( _BR_hcc_SM )            + ":# BR_hcc_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":21:" + String( _BR_hbb_SM )            + ":# BR_hbb_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":22:" + String( _BR_htt_SM )            + ":# BR_htt_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":23:" + String( _BR_hmumu_SM )          + ":# BR_hmumu_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":24:" + String( _BR_htautau_SM )        + ":# BR_htautau_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":25:" + String( _BR_hWW_SM )            + ":# BR_hWW_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":26:" + String( _BR_hZZ_SM )            + ":# BR_hZZ_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":27:" + String( _BR_hZgamma_SM )        + ":# BR_hZgamma_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":28:" + String( _BR_hgammagamma_SM )    + ":# BR_hgammagamma_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":29:" + String( _BR_hgg_SM )            + ":# BR_hgg_SM" );
    _slhaOutputDataStorage->AddLine( blockName + ":30:" + String( _BR_hInvisible )        + ":# BR_hjInvisible" );
    _slhaOutputDataStorage->AddLine( blockName + ":31:" + String( _g2_SM_hgammagamma )    + ":# g2_SM_hgammagamma" );
    _slhaOutputDataStorage->AddLine( blockName + ":32:" + String( _g2_SM_hgg )            + ":# g2_SM_hgg" );
    _slhaOutputDataStorage->AddLine( blockName + ":33:" + String( _Gamma_hTotal_Penalty ) + ":# Gamma_hTotal_Penalty" );
    _slhaOutputDataStorage->AddLine( blockName + ":34:" + String( _BR_hInvisible_Limit )  + ":# BR_hInvisible_Limit" );

    _slhaOutputDataStorage->WriteFile( _slhaOutputFileName );

    _Mu_hgammgamma_1lep_ATL                   = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables",  "1", "17", 2 );
    _Mu_hgammgamma_conv_central_highPTt_ATL   = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables",  "2", "17", 2 ); 
    _Mu_hgammgamma_conv_central_lowPTt_ATL    = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables",  "3", "17", 2 );
    _Mu_hgammgamma_conv_rest_highPTt_ATL      = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables",  "4", "17", 2 );
    _Mu_hgammgamma_conv_rest_lowPTt_ATL       = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables",  "5", "17", 2 );
    _Mu_hgammgamma_conv_trans_ATL             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables",  "6", "17", 2 );
    _Mu_hgammgamma_ETmiss_ATL                 = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables",  "7", "17", 2 );
    _Mu_hgammgamma_highmass2jetloose_ATL      = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables",  "8", "17", 2 );
    _Mu_hgammgamma_highmass2jettight_ATL      = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables",  "9", "17", 2 );
    _Mu_hgammgamma_lowmass2jet_ATL            = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "10", "17", 2 );
    _Mu_hgammgamma_unconv_central_highPTt_ATL = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "11", "17", 2 );
    _Mu_hgammgamma_unconv_central_lowPTt_ATL  = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "12", "17", 2 );
    _Mu_hgammgamma_unconv_rest_highPTt_ATL    = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "13", "17", 2 );
    _Mu_hgammgamma_unconv_rest_lowPTt_ATL     = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "14", "17", 2 );
    _Mu_htautau_ATL                           = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "15", "17", 2 );
    _Mu_hWWlnulnu_ATL                         = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "16", "17", 2 );
    _Mu_VBFWWlnulnu_ATL                       = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "17", "17", 2 );
    _Mu_hZZ4l_ATL                             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "18", "17", 2 );
    _Mu_VhVbb_ATL                             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "19", "17", 2 );
    _Mu_hgammagamma_CDF                       = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "20", "17", 2 );
    _Mu_htautau_CDF                           = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "21", "17", 2 );
    _Mu_hWW_CDF                               = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "22", "17", 2 );
    _Mu_tthttbb_CDF                           = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "23", "17", 2 );
    _Mu_VhVbb_CDF                             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "24", "17", 2 );
    _Mu_hgammagamma_2jet_CMS                  = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "25", "17", 2 );
    _Mu_hgammagamma_2jetloose_CMS             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "26", "17", 2 );
    _Mu_hgammagamma_2jettight_CMS             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "27", "17", 2 );
    _Mu_hgammagamma_e_CMS                     = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "28", "17", 2 );
    _Mu_hgammagamma_inclusive_CMS             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "29", "17", 2 );
    _Mu_hgammagamma_ETmiss_CMS                = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "30", "17", 2 );
    _Mu_hgammagamma_mu_CMS                    = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "31", "17", 2 );
    _Mu_htautau_01jet_CMS                     = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "32", "17", 2 );
    _Mu_hWW_01jet_CMS                         = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "33", "17", 2 );
    _Mu_hZZ4l_01jet_CMS                       = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "34", "17", 2 );
    _Mu_hZZ4l_2jet_CMS                        = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "35", "17", 2 );
    _Mu_tthttbb_CMS                           = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "36", "17", 2 );
    _Mu_VBFtautau_CMS                         = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "37", "17", 2 );
    _Mu_VBFWW_CMS                             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "38", "17", 2 );
    _Mu_VhVbb_CMS                             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "39", "17", 2 );
    _Mu_VhVtautau_CMS                         = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "40", "17", 2 );
    _Mu_WhWWW_CMS                             = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "41", "17", 2 );
    _Mu_hbb_D0                                = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "42", "17", 2 );
    _Mu_hgammagamma_D0                        = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "43", "17", 2 );
    _Mu_htautau_D0                            = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "44", "17", 2 );
    _Mu_hWW_D0                                = _slhaOutputDataStorage->GetEntry( "HiggsSignalsPeakObservables", "45", "17", 2 );

}

double Fittino::HiggsSignalsSLHACalculator::CalculateBRhInvisible( double Gamma_hTotal, double Gamma_hInvisible ) {

    if ( Gamma_hTotal <= 1.e-16 ) return 0.;
    else return Gamma_hInvisible / Gamma_hTotal;

}

double Fittino::HiggsSignalsSLHACalculator::CalculateBRhInvisibleLimit( double x ) {

    double f;

    if ( x < 1. ) {

        f =   3090.5 * pow( x, 10 ) - 16155 * pow( x, 9 ) + 36200.6 * pow( x, 8 ) - 45432.4 * pow( x, 7 )
            + 35006.7 * pow( x, 6 ) - 17068.7 * pow( x, 5 ) + 5228.65 * pow( x, 4 ) - 963.046 * pow( x, 3 )
            + 100.961 * pow( x, 2 );

    }
    else {

        f = 3.322 * pow( x, 2 ) + 4.92 * x;

    }

    return f;

}

double Fittino::HiggsSignalsSLHACalculator::Calculateg2hgg( double g_hbb,
                                                            double g_htt,
                                                            double mass_h ) {

    double g2_hgg;

    try {

        if  ( mass_h >= 123 && mass_h <= 129. ) {

            g2_hgg =   g_htt * g_htt * ( -9.10e-04 * mass_h +  1.23e00 );
                     + g_hbb * g_hbb * ( -2.86e-04 * mass_h + 4.74e-02 );
                     + g_htt * g_hbb * (  1.12e-03 * mass_h - 2.73e-01 );

        }
        else {

            throw ConfigurationException( "Higgs mass out of range." );

        }

    }
    catch ( const ConfigurationException& configurationException ) {

        std::cout << "\n" << configurationException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

    return g2_hgg;

}

double Fittino::HiggsSignalsSLHACalculator::Calculateg2hgammagamma( double g_hbb,
                                                                    double g_htt,
                                                                    double g_htautau,
                                                                    double g_hWW,
                                                                    double g_hZZ,
                                                                    double mass_h ) {

    double g2_hgammagamma;

    try {

        if  ( mass_h >= 123 && mass_h <= 129. ) {

            g2_hgammagamma =   g_htt     * g_htt     * ( -5.85e-04 * mass_h + 1.45e-01 );
                             + g_hbb     * g_hbb     * ( -6.74e-07 * mass_h + 1.04e-04 );
                             + g_hWW     * g_hWW     * ( -2.48e-03 * mass_h +  1.90e00 );
                             + g_htt     * g_hbb     * (  3.51e-05 * mass_h - 6.16e-03 );
                             + g_htt     * g_hWW     * (  3.30e-03 * mass_h -  1.09e00 );
                             + g_hbb     * g_hWW     * ( -1.39e-04 * mass_h + 2.58e-02 );
                             + g_htautau * g_htautau * ( -7.89e-07 * mass_h + 1.22e-04 );
                             + g_htt     * g_htautau * (  3.78e-05 * mass_h - 6.64e-03 );
                             + g_hbb     * g_htautau * ( -1.46e-06 * mass_h + 2.25e-04 );
                             + g_htautau * g_hWW     * ( -1.50e-04 * mass_h + 2.78e-02 );

        }
        else {

            throw ConfigurationException( "Higgs mass out of range." );

        }

    }
    catch ( const ConfigurationException& configurationException ) {

        std::cout << "\n" << configurationException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );

    }

    return g2_hgammagamma;

}

double Fittino::HiggsSignalsSLHACalculator::CalculateSinglehUncertainty( double d_hbb,
                                                                         double d_hgg,
                                                                         double g2_hbb,
                                                                         double g2_hgg,
                                                                         double mass_h ) {

    double singlehUncertainty;
    double vsmall = 1.e-16;

    if ( g2_hgg <= vsmall && g2_hbb <= vsmall ) {

        singlehUncertainty = 0.;

    }
    else {

              //singlehUncertainty =   ( g2hgg * __theory_collidersfunctions_MOD_lhc8_rh_gg( &massh ) * dhgg
              //                     +   g2hbb * __theory_collidersfunctions_MOD_lhc8_rh_bb( &massh ) * dhbb )
              //                     / ( g2hgg * __theory_collidersfunctions_MOD_lhc8_rh_gg( &massh )
              //                     +   g2hbb * __theory_collidersfunctions_MOD_lhc8_rh_bb( &massh ) );

    }

    return singlehUncertainty;

}

double Fittino::HiggsSignalsSLHACalculator::CalculateGammahTotal( double mass_h,
                                                                  double g2_hiss_s,
                                                                  double g2_hicc_s,
                                                                  double g2_hibb_s,
                                                                  double g2_hitt_s,
                                                                  double g2_himumu_s,
                                                                  double g2_hitautau_s,
                                                                  double g2_hiWW,
                                                                  double g2_hiZZ,
                                                                  double g2_hiZga,
                                                                  double g2_higaga,
                                                                  double g2_higg,
                                                                  double Gamma_hInvisible ) {

    double Gamma_hTotal = smgamma_h_( &mass_h )
                          * ( 1
                          + ( g2_hiss_s - 1 ) * smbr_hss_( &mass_h )
                          + ( g2_hicc_s - 1 ) * smbr_hcc_( &mass_h )
                          + ( g2_hibb_s - 1 ) * smbr_hbb_( &mass_h )
                          + ( g2_hitt_s - 1 ) * smbr_htoptop_( &mass_h )
                          + ( g2_himumu_s - 1 ) * smbr_hmumu_( &mass_h )
                          + ( g2_hitautau_s - 1 ) * smbr_htautau_( &mass_h )
                          + ( g2_hiWW - 1 ) * smbr_hww_( &mass_h )
                          + ( g2_hiZZ - 1 ) * smbr_hzz_( &mass_h )
                          + ( g2_hiZga - 1 ) * smbr_hzgam_( &mass_h )
                          + ( g2_higaga - 1 ) * smbr_hgamgam_( &mass_h )
                          + ( g2_higg - 1 ) * smbr_hgg_( &mass_h ) )
                          + Gamma_hInvisible;

    return Gamma_hTotal;

}

void Fittino::HiggsSignalsSLHACalculator::SetRateUncertainties( double g2_hibb_s,
                                                                double g2_hibb_p,
                                                                double g2_higg,
                                                                double mass_h ) {

    double dCS[5], dBR[5];

    double g2_hibb = g2_hibb_s + g2_hibb_p;
    double d_hbb = 0.2, d_hgg = 0.147;

    dCS[0] = 0.147;
    ///dCS[0] = 0.2;
    ///dCS[0] = CalculateSinglehUncertainty( d_hbb, d_hgg, g2_hibb, g2_higg, mass_h ); // singleH
    dCS[1] = 0.028; // VBF
    dCS[2] = 0.037; // HW
    dCS[3] = 0.051; // HZ
    dCS[4] = 0.12;  // ttH

    dBR[0] = 0.054; // gammagamma
    dBR[1] = 0.048; // WW
    dBR[2] = 0.048; // ZZ
    dBR[3] = 0.061; // tautau
    dBR[4] = 0.028; // bbbar

    setup_rate_uncertainties_( dCS, dBR );

}

double Fittino::HiggsSignalsSLHACalculator::CalculateBR( double g2_hixx,
                                                         double mass_h,
                                                         double Gamma_hTotal,
                                                         double BR_SM ) {

    double BR = g2_hixx * ( smgamma_h_( &mass_h ) / Gamma_hTotal ) * BR_SM;

    return BR;

}

void Fittino::HiggsSignalsSLHACalculator::SetupMeasuredValues() {

    // get number of observable from HiggsSignals and loop over it
    int ntotal, npeakmu, npeakmh, nmpred, nanalyses;
    // get_number_of_observables_( &ntotal, &npeakmu, &npeakmh, &nmpred, &nanalyses );

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

            throw ConfigurationException( "Incomplete set of HiggsSignals Observables: Missing at least one (mu, mh) for HiggsSignalsObservable_ " + s_index );

        }

        // get observable ID from HiggsSignals
        int obsID = 0;
        // get_id_of_peakobservable_( &i, &obsID );

        // assign the new values
        assign_toyvalues_to_peak_( &obsID, &measuredValue_mu, &measuredValue_mh );

    }

}
