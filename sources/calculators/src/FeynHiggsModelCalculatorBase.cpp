/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsModelCalculatorBase.cpp                                 *
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

#include "TMath.h"

#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "FeynHiggsModelCalculatorBase.h"
#include "ModelParameterBase.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsModelCalculatorBase::FeynHiggsModelCalculatorBase( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
        : ModelCalculatorBase( model ) {

    _name = "FeynHiggs";

    AddQuantity( new SimplePrediction( "Mass_h",                     "", _mass_h                     ) );  
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_gamma_gamma", "", _normSM_Gamma_h_gamma_gamma ) );  
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_Z_gamma"    , "", _normSM_Gamma_h_Z_gamma     ) );      
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_Z_Z"        , "", _normSM_Gamma_h_Z_Z         ) );         
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_W_W"        , "", _normSM_Gamma_h_W_W         ) );        
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_g_g"        , "", _normSM_Gamma_h_g_g         ) );        
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_tau_tau"    , "", _normSM_Gamma_h_tau_tau     ) );    
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_c_c"        , "", _normSM_Gamma_h_c_c         ) );         
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_s_s"        , "", _normSM_Gamma_h_s_s         ) );         
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_b_b"        , "", _normSM_Gamma_h_b_b         ) );         
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_total"      , "", _normSM_Gamma_h_total       ) );       
    AddQuantity( new SimplePrediction( "NormSM_sigma_ggh"          , "", _normSM_sigma_ggh           ) );          
    AddQuantity( new SimplePrediction( "NormSM_sigma_ggh_2"        , "", _normSM_sigma_ggh_2         ) );         
    AddQuantity( new SimplePrediction( "NormSM_sigma_bbh"          , "", _normSM_sigma_bbh           ) );          
    AddQuantity( new SimplePrediction( "NormSM_sigma_qqh"          , "", _normSM_sigma_qqh           ) );          
    AddQuantity( new SimplePrediction( "NormSM_sigma_tth"          , "", _normSM_sigma_tth           ) );          
    AddQuantity( new SimplePrediction( "NormSM_sigma_Wh"           , "", _normSM_sigma_Wh            ) );           
    AddQuantity( new SimplePrediction( "NormSM_sigma_Zh"           , "", _normSM_sigma_Zh            ) );

}

Fittino::FeynHiggsModelCalculatorBase::~FeynHiggsModelCalculatorBase() {

}

void Fittino::FeynHiggsModelCalculatorBase::SetFlags() {

    std::string flags = "400242110";

    FHSetFlagsString( &_error, flags.c_str() );

    if ( _error != 0 ) {

    }

}

void Fittino::FeynHiggsModelCalculatorBase::Calculate() {

    // calculate masses, sin(alpha), UHiggs & ZHiggs matrices

    RealType    MHiggs[4];
    ComplexType SAeff, UHiggs[3][3], ZHiggs[3][3];

    FHHiggsCorr( &_error, MHiggs, &SAeff, UHiggs, ZHiggs );

    if ( _error != 0 ) {

    }

    _mass_h = MHiggs[0];

    if ( _mass_h < 1. ) {

        std::cout<<"Problem in mh calculation"<<std::endl;

    }

    // select UHiggs or ZHiggs for calculation of couplings and gammas

    FHSelectUZ( &_error, 1, 2, 1 );

    if ( _error != 0 ) {

    }

    // calulate couplings and gammas

    ComplexType couplings[ncouplings], couplingsms[ncouplingsms];
    RealType    gammas[ngammas], gammasms[ngammasms];
    int    fast  = 1;

    FHCouplings( &_error, couplings, couplingsms, gammas, gammasms, fast );
    
    if ( _error != 0 ) {

    }

    _normSM_Gamma_h_gamma_gamma = Gamma( H0VV( 1, 1       ) ) / GammaSM   ( H0VV( 1, 1       ) );
    _normSM_Gamma_h_Z_gamma     = Gamma( H0VV( 1, 2       ) ) / GammaSM   ( H0VV( 1, 2       ) );
    _normSM_Gamma_h_Z_Z         = Gamma( H0VV( 1, 3       ) ) / GammaSM   ( H0VV( 1, 3       ) );
    _normSM_Gamma_h_W_W         = Gamma( H0VV( 1, 4       ) ) / GammaSM   ( H0VV( 1, 4       ) );
    _normSM_Gamma_h_g_g         = Gamma( H0VV( 1, 5       ) ) / GammaSM   ( H0VV( 1, 5       ) );
    _normSM_Gamma_h_tau_tau     = Gamma( H0FF( 1, 2, 3, 3 ) ) / GammaSM   ( H0FF( 1, 2, 3, 3 ) );
    _normSM_Gamma_h_c_c         = Gamma( H0FF( 1, 3, 2, 2 ) ) / GammaSM   ( H0FF( 1, 3, 2, 2 ) );
    _normSM_Gamma_h_s_s         = Gamma( H0FF( 1, 4, 2, 2 ) ) / GammaSM   ( H0FF( 1, 4, 2, 2 ) ); 
    _normSM_Gamma_h_b_b         = Gamma( H0FF( 1, 4, 3, 3 ) ) / GammaSM   ( H0FF( 1, 4, 3, 3 ) );

    _normSM_Gamma_h_total = GammaTot( 1 ) / GammaSMTot( 1 );

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

}
