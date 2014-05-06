/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsBoundsHECCalculator.cpp                                     *
*                                                                              *
* Description Wrapper class for HiggsBounds                                    *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include <boost/thread.hpp>

#include "CHiggsSignals.h"
#include "ConfigurationException.h"
#include "HiggsBoundsHECCalculator.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "Observable.h"

Fittino::HiggsBoundsHECCalculator::HiggsBoundsHECCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree ) 
    : HiggsBoundsCalculator( model, ptree ),
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
     
}

Fittino::HiggsBoundsHECCalculator::~HiggsBoundsHECCalculator() {

}

void Fittino::HiggsBoundsHECCalculator::setupHiggsBounds() {

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


    double shift_mass_h = 0;
    try {

        shift_mass_h = _model->GetCollectionOfQuantities().At( "DeltaMassHHB" )->GetValue();
    
    }
    catch( std::out_of_range& oor ) {

        shift_mass_h = 0.;
    
    }
    const double mass_h_shifted = _mass_h + shift_mass_h;
    // Setup HiggsBounds.
    
    higgsbounds_neutral_input_effc_( &mass_h_shifted,
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

}

double Fittino::HiggsBoundsHECCalculator::CalculateGammahTotal( double mass_h,
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

double Fittino::HiggsBoundsHECCalculator::CalculateBRhInvisible( double Gamma_hTotal, double Gamma_hInvisible ) {

    if ( Gamma_hTotal <= 1.e-16 ) return 0.;
    else return Gamma_hInvisible / Gamma_hTotal;

}
