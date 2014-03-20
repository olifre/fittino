/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsCalculatorBase.cpp                                      *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>
#include <fstream>

#include <boost/foreach.hpp>
#include "boost/format.hpp"
#include <boost/filesystem.hpp>
#include <boost/property_tree/ptree.hpp>

#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "CalculatorException.h"
#include "FeynHiggsCalculatorBase.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"

#include "FeynHiggsChannel.h"

Fittino::FeynHiggsCalculatorBase::FeynHiggsCalculatorBase( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
: CalculatorBase( model ) {

    _name = "FeynHiggsCalculator";

    AddQuantity( new SimplePrediction( "Mass_h",                     "", _mass_h                     ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_ggh"          , "", _normSM_sigma_ggh           ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_ggh_2"        , "", _normSM_sigma_ggh_2         ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_bbh"          , "", _normSM_sigma_bbh           ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_qqh"          , "", _normSM_sigma_qqh           ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_tth"          , "", _normSM_sigma_tth           ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_Wh"           , "", _normSM_sigma_Wh            ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_Zh"           , "", _normSM_sigma_Zh            ) );

    _gammas = new FHRealType[ngammas];
    _gammasms = new FHRealType[ngammasms];
    _couplings = new FHComplexType[ncouplings];
    _couplingsms = new FHComplexType[ncouplingsms];

    std::string higgs[4] = { "h0", "H0", "A0" , "H+" };
    std::string nu[3] = { "nue", "numu", "nutau" };
    std::string lepton[3] = { "e", "mu", "tau" };
    std::string up[3] = { "u", "c", "t" };
    std::string down[3] = { "d", "s", "b"};

    for ( unsigned int iHiggs = 1; iHiggs < 4; iHiggs++ ) {

        std::string higgsName = higgs[iHiggs-1];

        AddChannel( higgsName, "gamma_gamma", H0VV( iHiggs, 1 ), true );
        AddChannel( higgsName, "Z_gamma"    , H0VV( iHiggs, 2 ), true );
        AddChannel( higgsName, "Z_Z"        , H0VV( iHiggs, 3 ), true );
        AddChannel( higgsName, "W_W"        , H0VV( iHiggs, 4 ), true );
        AddChannel( higgsName, "g_g"        , H0VV( iHiggs, 3 ), true );

        AddChannel( higgsName, "nue_nue",     H0FF( iHiggs, 1, 1, 1 ), true );
        AddChannel( higgsName, "numu_numu",   H0FF( iHiggs, 1, 2, 2 ), true );
        AddChannel( higgsName, "nutau_nutau", H0FF( iHiggs, 1, 3, 3 ), true );
        AddChannel( higgsName, "e_e",         H0FF( iHiggs, 2, 1, 1 ), true );
        AddChannel( higgsName, "mu_mu",       H0FF( iHiggs, 2, 2, 2 ), true );
        AddChannel( higgsName, "tau_tau",     H0FF( iHiggs, 2, 3, 3 ), true );
        AddChannel( higgsName, "u_u",         H0FF( iHiggs, 3, 1, 1 ), true );
        AddChannel( higgsName, "c_c",         H0FF( iHiggs, 3, 2, 2 ), true );
        AddChannel( higgsName, "t_t",         H0FF( iHiggs, 3, 3, 3 ), true );
        AddChannel( higgsName, "d_d",         H0FF( iHiggs, 4, 1, 1 ), true );
        AddChannel( higgsName, "s_s",         H0FF( iHiggs, 4, 2, 2 ), true );
        AddChannel( higgsName, "b_b",         H0FF( iHiggs, 4, 3, 3 ), true );

        AddChannel( higgsName, "~chi01_~chi01", H0ChaCha( iHiggs, 1, 1 ), false );
        AddChannel( higgsName, "~chi01_~chi02", H0ChaCha( iHiggs, 1, 2 ), false );
        AddChannel( higgsName, "~chi02_~chi01", H0ChaCha( iHiggs, 2, 1 ), false );
        AddChannel( higgsName, "~chi02_~chi02", H0ChaCha( iHiggs, 2, 2 ), false );

        AddChannel( higgsName, "Z_" + higgsName, H0HH( iHiggs, 1, 1 ), true ); // SM?


        for ( unsigned int iHiggs1 = 1; iHiggs1 < 5; iHiggs1++ ) {


        }

    }

}

void Fittino::FeynHiggsCalculatorBase::AddChannel( std::string higgsName, std::string channelName, int channelNumber, bool SM ) {

    FeynHiggsChannel* calc = new FeynHiggsChannel( _gammas, _gammasms, _couplings, _couplingsms, higgsName,  channelName, channelNumber, SM );

    _channels.push_back( calc );

    for ( unsigned int iQuantity = 0; iQuantity < calc->GetCollectionOfQuantities().GetNumberOfElements(); iQuantity++ ) {

        AddQuantity( calc->GetCollectionOfQuantities().At( iQuantity ) );

    }

}

Fittino::FeynHiggsCalculatorBase::~FeynHiggsCalculatorBase() {

}

void Fittino::FeynHiggsCalculatorBase::CalculatePredictions() {

    std::string outputFile( "FeynHiggs.out" );

    if ( boost::filesystem::exists( outputFile ) ) {

        boost::filesystem::rename( outputFile, outputFile + ".last" );
        
    }

    Redirector redirector( outputFile );
    redirector.Start();

    std::string flags = "400243110";

    FHSetFlagsString( &_error, flags.c_str() );

    if ( _error != 0 ) {

    }

    ConfigureInput();

    // calculate masses, sin(alpha), UHiggs & ZHiggs matrices

    RealType    MHiggs[4];
    ComplexType SAeff, UHiggs[3][3], ZHiggs[3][3];

    FHHiggsCorr( &_error, MHiggs, &SAeff, UHiggs, ZHiggs );

    if ( _error != 0 ) {

    }

    _mass_h = MHiggs[0];

    if ( _mass_h < 1. ) {

      throw CalculatorException( _name, "Mass h less than 1 GeV.");

    }

    // select UHiggs or ZHiggs for calculation of couplings and gammas

    FHSelectUZ( &_error, 1, 2, 1 );

    if ( _error != 0 ) {

    }

    // calulate couplings and gammas

    ComplexType couplings[ncouplings], couplingsms[ncouplingsms];
        int    fast  = 1;

    FHCouplings( &_error, couplings, couplingsms, _gammas, _gammasms, fast );
    
    if ( _error != 0 ) {

    }

    // calculate xs

    double sqrts = 8;
    RealType    prodxs     [nprodxs];
    FHHiggsProd( &_error, sqrts, prodxs );

    if ( _error != 0 ) {

    }
        
    _normSM_sigma_ggh   = ggh ( 1 ) / gghSM( 1 ); 
    _normSM_sigma_ggh_2 = ggh2( 1 ) / gghSM( 1 );
    _normSM_sigma_bbh   = bbh ( 1 ) / bbhSM( 1 );
    _normSM_sigma_qqh   = qqh ( 1 ) / qqhSM( 1 );
    _normSM_sigma_tth   = tth ( 1 ) / tthSM( 1 );
    _normSM_sigma_Wh    = Wh  ( 1 ) / WhSM ( 1 ); 
    _normSM_sigma_Zh    = Zh  ( 1 ) / ZhSM ( 1 );

    WriteOutput();

    redirector.Stop();

    for ( unsigned int i = 0; i< _channels.size(); i++ ) {

        _channels.at( i )->CalculatePredictions();

    }

}
