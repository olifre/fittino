/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HECCalculator.cpp                                                *
*                                                                              *
* Description Converts HEC model parameters into HiggsSignals input variables  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "HECCalculator.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"

Fittino::HECCalculator::HECCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ),
      // Initialize input quantities.
      _Delta_hss_s      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hss_s.Name",       "Delta_hss_s"       ) )->GetValue() ),
      _Delta_hss_p      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hss_p.Name",       "Delta_hss_p"       ) )->GetValue() ),
      _Delta_hcc_s      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hcc_s.Name",       "Delta_hcc_s"       ) )->GetValue() ),
      _Delta_hcc_p      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hcc_p.Name",       "Delta_hcc_p"       ) )->GetValue() ),
      _Delta_hbb_s      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hbb_s.Name",       "Delta_hbb_s"       ) )->GetValue() ),
      _Delta_hbb_p      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hbb_p.Name",       "Delta_hbb_p"       ) )->GetValue() ),
      _Delta_htt_s      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_htt_s.Name",       "Delta_htt_s"       ) )->GetValue() ),
      _Delta_htt_p      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_htt_p.Name",       "Delta_htt_p"       ) )->GetValue() ),
      _Delta_hmumu_s    ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hmumu_s.Name",     "Delta_hmumu_s"     ) )->GetValue() ),
      _Delta_hmumu_p    ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hmumu_p.Name",     "Delta_hmumu_p"     ) )->GetValue() ),
      _Delta_htautau_s  ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_htautau_s.Name",   "Delta_htautau_s"   ) )->GetValue() ),
      _Delta_htautau_p  ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_htautau_p.Name",   "Delta_htautau_p"   ) )->GetValue() ),
      _Delta_hWW        ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hWW.Name",         "Delta_hWW"         ) )->GetValue() ),
      _Delta_hZZ        ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hZZ.Name",         "Delta_hZZ"         ) )->GetValue() ),
      _Delta_hZgamma    ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hZgamma.Name",     "Delta_hZgamma"     ) )->GetValue() ),
      _Delta_hgammagamma( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hgammagamma.Name", "Delta_hgammagamma" ) )->GetValue() ),
      _Delta_hgg        ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hgg.Name",         "Delta_hgg"         ) )->GetValue() ),
      _Delta_hggZ       ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hggZ.Name",        "Delta_hggZ"        ) )->GetValue() ),
      _Delta_hihjZ      ( _model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Delta_hihjZ.Name",       "Delta_hihjZ"       ) )->GetValue() ) {

    // Initialize steering parameters common to all calculators.

    _name = ptree.get<std::string>( "Name", "HECCalculator" );

    // Add predictions.

    _g_hiss_s     = 0.;
    _g_hiss_p     = 0.;
    _g_hicc_s     = 0.;
    _g_hicc_p     = 0.;
    _g_hibb_s     = 0.;
    _g_hibb_p     = 0.;
    _g_hitt_s     = 0.;
    _g_hitt_p     = 0.;
    _g_himumu_s   = 0.;
    _g_himumu_p   = 0.;
    _g_hitautau_s = 0.;
    _g_hitautau_p = 0.;
    _g_hiWW       = 0.;
    _g_hiZZ       = 0.;
    _g_hiZga      = 0.;
    _g_higaga     = 0.;
    _g_higg       = 0.;
    _g_higgZ      = 0.;
    _g_hihjZ      = 0.;

    AddQuantity( new SimplePrediction( "g_hiss_s",     "", _g_hiss_s     ) );
    AddQuantity( new SimplePrediction( "g_hiss_p",     "", _g_hiss_p     ) );
    AddQuantity( new SimplePrediction( "g_hicc_s",     "", _g_hicc_s     ) );
    AddQuantity( new SimplePrediction( "g_hicc_p",     "", _g_hicc_p     ) );
    AddQuantity( new SimplePrediction( "g_hibb_s",     "", _g_hibb_s     ) );
    AddQuantity( new SimplePrediction( "g_hibb_p",     "", _g_hibb_p     ) );
    AddQuantity( new SimplePrediction( "g_hitt_s",     "", _g_hitt_s     ) );
    AddQuantity( new SimplePrediction( "g_hitt_p",     "", _g_hitt_p     ) );
    AddQuantity( new SimplePrediction( "g_himumu_s",   "", _g_himumu_s   ) );
    AddQuantity( new SimplePrediction( "g_himumu_p",   "", _g_himumu_p   ) );
    AddQuantity( new SimplePrediction( "g_hitautau_s", "", _g_hitautau_s ) );
    AddQuantity( new SimplePrediction( "g_hitautau_p", "", _g_hitautau_p ) );
    AddQuantity( new SimplePrediction( "g_hiWW",       "", _g_hiWW       ) );
    AddQuantity( new SimplePrediction( "g_hiZZ",       "", _g_hiZZ       ) );
    AddQuantity( new SimplePrediction( "g_hiZga",      "", _g_hiZga      ) );
    AddQuantity( new SimplePrediction( "g_higaga",     "", _g_higaga     ) );
    AddQuantity( new SimplePrediction( "g_higg",       "", _g_higg       ) );
    AddQuantity( new SimplePrediction( "g_higgZ",      "", _g_higgZ      ) );
    AddQuantity( new SimplePrediction( "g_hihjZ",      "", _g_hihjZ      ) );

}

Fittino::HECCalculator::~HECCalculator() {

}

void Fittino::HECCalculator::CalculatePredictions() {

    _g_hiss_s     = 1 + _Delta_hss_s;
    _g_hiss_p     = 1 + _Delta_hss_p;
    _g_hicc_s     = 1 + _Delta_hcc_s;
    _g_hicc_p     = 1 + _Delta_hcc_p;
    _g_hibb_s     = 1 + _Delta_hbb_s;
    _g_hibb_p     = 1 + _Delta_hbb_p;
    _g_hitt_s     = 1 + _Delta_htt_s;
    _g_hitt_p     = 1 + _Delta_htt_p;
    _g_himumu_s   = 1 + _Delta_hmumu_s;
    _g_himumu_p   = 1 + _Delta_hmumu_p;
    _g_hitautau_s = 1 + _Delta_htautau_s;
    _g_hitautau_p = 1 + _Delta_htautau_p;
    _g_hiWW       = 1 + _Delta_hWW;
    _g_hiZZ       = 1 + _Delta_hZZ;
    _g_hiZga      = 1 + _Delta_hZgamma;
    _g_higaga     = 1 + _Delta_hgammagamma;
    _g_higg       = 1 + _Delta_hgg;
    _g_higgZ      = 1 + _Delta_hggZ;
    _g_hihjZ      = 1 + _Delta_hihjZ;

}

void Fittino::HECCalculator::Initialize() {

}
