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
*             Matthias Hamer   <matthias.hamer@cern.ch>                        *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <fstream>
#include <boost/property_tree/ptree.hpp>

#include "CalculatorException.h"
#include "TimeoutExecutorException.h"
#include "Messenger.h"

#include "SimplePrediction.h"
#include "SuperIsoCalculator.h"

Fittino::SuperIsoCalculator::SuperIsoCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ),
      _executor( "./SuperIsoWrapper.x", "SuperIsoWrapper.x" ) {

    _name = "SuperIso";
    _tag = "SuperIso";

    _slhafile = "SPheno.spc";

    _requireNeutralinoLSP = ptree.get<bool>( "RequireNeutralinoLSP", false );
   
    _executor.AddArgument( _slhafile );
    _executor.AddArgument( (_requireNeutralinoLSP) ? "1" : "0" );

    _executor.SetCompletionTimeout( 30 );

    if ( _requireNeutralinoLSP ) {

        Messenger::GetInstance() << Messenger::ALWAYS << "SuperIsoCalculator requires neutralino LSP." << Messenger::Endl;

    }

    AddQuantity( new SimplePrediction( "DiffSM_a_mu",                                   "", _amu                   ) );
    AddQuantity( new SimplePrediction( "delta0_B_to_Kstar_gamma",                       "", _delta0                ) );
    AddQuantity( new SimplePrediction( "BR_b_to_s_gamma",                               "", _bsgamma               ) );
    AddQuantity( new SimplePrediction( "BR_Bs_to_mu_mu",                                "", _bsmumu                ) );
    AddQuantity( new SimplePrediction( "UntaggedBR_Bs_to_mu_mu",                        "", _bsmumu_untag          ) );
    AddQuantity( new SimplePrediction( "BR_Bd_to_mu_mu",                                "", _bdmumu                ) );
    AddQuantity( new SimplePrediction( "BR_B_to_tau_nu",                                "", _btaunu                ) );
    AddQuantity( new SimplePrediction( "NormSM_BR_B_to_tau_nu",                         "", _normSM_btaunu         ) );
    AddQuantity( new SimplePrediction( "BR_B_to_D_tau_nu",                              "", _bdtaunu               ) );
    AddQuantity( new SimplePrediction( "Ratio_BR_B_to_D_tau_nu_BR_B_to_D_e_nu",         "", _bdtaunu_bdenu         ) );
    AddQuantity( new SimplePrediction( "BR_B_to_DStar_tau_nu",                          "", _bdstartaunu               ) );
    AddQuantity( new SimplePrediction( "Ratio_BR_B_to_DStar_tau_nu_BR_B_to_DStar_e_nu", "", _bdstartaunu_bdstarenu         ) );
    AddQuantity( new SimplePrediction( "BR_D_mu_nu",                                    "", _dmunu                 ) );
    AddQuantity( new SimplePrediction( "BR_Ds_mu_nu",                                   "", _dsmunu                ) );
    AddQuantity( new SimplePrediction( "BR_Ds_tau_nu",                                  "", _dstaunu               ) );
    AddQuantity( new SimplePrediction( "Ratio_BR_K_mu_nu_BR_pi_mu_nu",                  "", _kmunu_pimunu          ) );
    AddQuantity( new SimplePrediction( "Rmu23_K_mu_nu",                                 "", _rmu23                 ) );
    AddQuantity( new SimplePrediction( "ChargedLSP",                                    "", _chargedLSP            ) );
    AddQuantity( new SimplePrediction( "ExcludedHiggsMass",                             "", _excludedHiggsMass     ) );
    AddQuantity( new SimplePrediction( "ExcludedSusyMass",                              "", _excludedSusyMass      ) );
    AddQuantity( new SimplePrediction( "NMSSMColliderExcluded",                         "", _nmssmColliderExcluded ) );
    AddQuantity( new SimplePrediction( "NMSSMTheoryExcluded",                           "", _nmssmTheoryExcluded   ) );

}

Fittino::SuperIsoCalculator::~SuperIsoCalculator() {

}

void Fittino::SuperIsoCalculator::CalculatePredictions() {

    try {

        _returnValue = _executor.Execute();

    }
    catch ( const TimeoutExecutorException& e ) {

        throw CalculatorException( _name, "Timeout" );

    }

    switch ( _returnValue ) {

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

    if ( _returnValue < 0 ) {

        throw ConfigurationException( "SuperIso: Unknown configuration problem." );

    }

    if ( _requireNeutralinoLSP && _chargedLSP != 0 ) {

        throw CalculatorException( _name, "NoNeutralinoLSP" );

    }

    std::ifstream SuperIsoOutput( "SuperIsoOutput.txt", std::ifstream::in );
    
    std::string key, value;
    while( SuperIsoOutput.good() ) {
        SuperIsoOutput >> key >> std::ws >> value;
        if( SuperIsoOutput.eof() ) break;
        if( key == "amu" )                          _amu    = atof( value.c_str() );
        else if( key == "delta0" )                  _delta0 = atof( value.c_str() );
        else if( key == "bsgamma" )                 _bsgamma = atof( value.c_str() );
        else if( key == "bsmumu" )                  _bsmumu = atof( value.c_str() );
        else if( key == "bsmumu_untag" )            _bsmumu_untag = atof( value.c_str() );
        else if( key == "bdmumu" )                  _bdmumu = atof( value.c_str() );
        else if( key == "btaunu" )                  _btaunu = atof( value.c_str() );
        else if( key == "normSM_btaunu" )           _normSM_btaunu = atof( value.c_str() );
        else if( key == "bdtaunu" )                 _bdtaunu = atof( value.c_str() );
        else if( key == "bdtaunu_bdenu" )           _bdtaunu_bdenu = atof( value.c_str() );
        else if( key == "bdstartaunu" )             _bdstartaunu = atof( value.c_str() );
        else if( key == "bdstartaunu_bdstarenu" )   _bdstartaunu_bdstarenu = atof( value.c_str() );
        else if( key == "dmunu" )                   _dmunu = atof( value.c_str() );
        else if( key == "dsmunu" )                  _dsmunu = atof( value.c_str() );
        else if( key == "dstaunu" )                 _dstaunu = atof( value.c_str() );
        else if( key == "kmunu_pimunu" )            _kmunu_pimunu = atof( value.c_str() );
        else if( key == "rmu23" )                   _rmu23 = atof( value.c_str() );
        else if( key == "chargedLSP" )              _chargedLSP = atoi( value.c_str() );
        else if( key == "excludedHiggsMass" )       _excludedHiggsMass = atof( value.c_str() );
        else if( key == "excludedSusyMass" )        _excludedSusyMass = atof( value.c_str() );
        else if( key == "nmssmColliderExcluded" )   _nmssmColliderExcluded = atof( value.c_str() );    
        else if( key == "nmssmTheoryExcluded" )     _nmssmTheoryExcluded = atof( value.c_str() );    

    }

}
