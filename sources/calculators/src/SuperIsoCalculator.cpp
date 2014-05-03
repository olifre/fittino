/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SuperIsoCalculator.cpp                                           *
*                                                                              *
* Description Wrapper class for SuperIso                                       *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <complex>

#include <boost/property_tree/ptree.hpp>

#define complex _Complex

extern "C" {

#include "include.h"

}

#include "SimplePrediction.h"
#include "SuperIsoCalculator.h"

Fittino::SuperIsoCalculator::SuperIsoCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ) {

    _name = "SuperIso";
    _tag = "SuperIso";

    _slhafile = "SPheno.spc";

    AddQuantity( new SimplePrediction( "DiffSM_a_mu",                       "", _amu                   ) );
    AddQuantity( new SimplePrediction( "delta0_B_to_Kstar_gamma",              "", _delta0                ) );
    AddQuantity( new SimplePrediction( "BR_b_to_s_gamma",                   "", _bsgamma               ) );
    AddQuantity( new SimplePrediction( "BR_Bs_to_mu_mu",                    "", _bsmumu                ) );
    AddQuantity( new SimplePrediction( "UntaggedBR_Bs_to_mu_mu",            "", _bsmumu_untag          ) );
    AddQuantity( new SimplePrediction( "BR_Bd_to_mu_mu",                    "", _bdmumu                ) );
    AddQuantity( new SimplePrediction( "BR_B_to_tau_nu",                    "", _btaunu                ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_B_to_tau_nu",             "", _normSM_btaunu         ) );
    AddQuantity( new SimplePrediction( "BR_B_to_D_tau_nu",                  "", _bdtaunu               ) );
    AddQuantity( new SimplePrediction( "Ratio_BR_D_to_tau_nu_BR_D_to_e_nu", "", _bdtaunu_bdenu         ) );
    AddQuantity( new SimplePrediction( "BR_D_mu_nu",                        "", _dmunu                 ) );
    AddQuantity( new SimplePrediction( "BR_Ds_mu_nu",                       "", _dsmunu                ) );
    AddQuantity( new SimplePrediction( "BR_Ds_tau_nu",                      "", _dstaunu               ) );
    AddQuantity( new SimplePrediction( "Ratio_BR_K_mu_nu_BR_pi_mu_nu",      "", _kmunu_pimunu          ) );
    AddQuantity( new SimplePrediction( "Rmu23_K_mu_nu",                     "", _rmu23                 ) );
    AddQuantity( new SimplePrediction( "ChargedLSP",                        "", _chargedLSP            ) );
    AddQuantity( new SimplePrediction( "ExcludedHiggsMass",                 "", _excludedHiggsMass     ) );
    AddQuantity( new SimplePrediction( "ExcludedSusyMass",                  "", _excludedSusyMass      ) );
    AddQuantity( new SimplePrediction( "NMSSMColliderExcluded",             "", _nmssmColliderExcluded ) );
    AddQuantity( new SimplePrediction( "NMSSMTheoryExcluded",               "", _nmssmTheoryExcluded   ) );

}

Fittino::SuperIsoCalculator::~SuperIsoCalculator() {

}

void Fittino::SuperIsoCalculator::CalculatePredictions() {

    std::vector<char> file( _slhafile.c_str(), _slhafile.c_str() + _slhafile.size() + 1 );

    int test = test_slha( &file[0] );

    switch ( test ) {

        case -4:
            throw ConfigurationException( "SuperIso: Input file missing." );

        case -3:
            throw ConfigurationException( "SuperIso: Input file invalid." );

        case -2:
            throw ConfigurationException( "SuperIso: Model not implemented." );

        case -1:
            throw ConfigurationException( "SuperIso: Invalid point." );

        case 2:
            throw ConfigurationException( "SuperIso: FV! Only MFV tested." );

        case 3:
            throw ConfigurationException( "SuperIso: NMSSM. Unexpected." );

        case 10:
            throw ConfigurationException( "SuperIso: THDM. Unexpected." );

    }

    if ( test < 0 ) {

        throw ConfigurationException( "SuperIso: Unknown configuration problem." );

    }

    _amu                   = muon_gm2_calculator           ( &file[0] );
    _delta0                = delta0_calculator             ( &file[0] );
    _bsgamma               = bsgamma_calculator            ( &file[0] );
    _bsmumu                = Bsmumu_calculator             ( &file[0] );
    _bsmumu_untag          = Bsmumu_untag_calculator       ( &file[0] );
    _bdmumu                = Bdmumu_calculator             ( &file[0] );
    _btaunu                = Btaunu_calculator             ( &file[0] );
    _normSM_btaunu         = RBtaunu_calculator            ( &file[0] );
    _bdtaunu               = BDtaunu_calculator            ( &file[0] );
    _bdtaunu_bdenu         = BDtaunu_BDenu_calculator      ( &file[0] );
    _dmunu                 = Dmunu_calculator              ( &file[0] );
    _dsmunu                = Dsmunu_calculator             ( &file[0] );
    _dstaunu               = Dstaunu_calculator            ( &file[0] );
    _kmunu_pimunu          = Kmunu_pimunu_calculator       ( &file[0] );
    _rmu23                 = Rmu23_calculator              ( &file[0] );
    _chargedLSP            = charged_LSP_calculator        ( &file[0] );
    _excludedHiggsMass     = excluded_Higgs_mass_calculator( &file[0] );
    _excludedSusyMass      = excluded_SUSY_mass_calculator ( &file[0] );
    _nmssmColliderExcluded = NMSSM_collider_excluded       ( &file[0] );
    _nmssmTheoryExcluded   = NMSSM_theory_excluded         ( &file[0] );

}
