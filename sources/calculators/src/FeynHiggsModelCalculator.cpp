/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsModelCalculator.cpp                                     *
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

#include <boost/property_tree/ptree.hpp>
#include <boost/foreach.hpp>
#include "boost/format.hpp"
#include <boost/filesystem.hpp>

#include "TMath.h"

#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "FeynHiggsModelCalculator.h"
#include "ModelParameterBase.h"
#include "PhysicsModelBase.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsModelCalculator::FeynHiggsModelCalculator( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree )
        : ModelCalculatorBase( model ) {

    _name = "FeynHiggs";

    std::string flags = "400242110";

    FHSetFlagsString( &_error, flags.c_str() );

    if ( _error != 0 ) {

    }

    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {
    
      if( node.first == "Parameter" ) {

        std::string name     = node.second.get<std::string>( "Name"     );
        std::string quantity = node.second.get<std::string>( "Quantity" );

        const double& value = _model->GetCollectionOfQuantities().At( quantity )->GetValue();
        // std::string   unit  = _model->GetCollectionOfQuantities().At( quantity )->GetUnit(); Quantity does not yet have a unit

        _input.AddElement( new SimplePrediction( name, "" , value ) ) ;

      }

    }
    
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

Fittino::FeynHiggsModelCalculator::~FeynHiggsModelCalculator() {

}

void Fittino::FeynHiggsModelCalculator::CalculatePredictions() {

    std::string fileName = "FeynHiggs.in";

    if ( boost::filesystem::exists( fileName ) ) {

        boost::filesystem::rename( fileName, fileName + ".last" );

    }
   
    std::ofstream file( fileName.c_str() );

    for ( int i = 0; i < _input.GetNumberOfElements(); i++ ) {

        file<<boost::format( "%-25s % 25.16e\n" ) % _input.At( i )->GetName() % _input.At( i )->GetValue();

    }

    file.close();
    
    int         fast = 0;
    double      sqrts = 8;
    ComplexType SAeff;
    ComplexType UHiggs     [3][3];
    ComplexType ZHiggs     [3][3];
    ComplexType couplings  [ncouplings];
    ComplexType couplingsms[ncouplingsms];
    RealType    MHiggs     [4];
    RealType    gammas     [ngammas];
    RealType    gammasms   [ngammasms];
    RealType    record     [nrecord];
    RealType    prodxs     [nprodxs];
    COMPLEX     slhadata   [nslhadata];

    FHReadRecord( &_error, record, slhadata, fileName.c_str() ); 

    if ( _error != 2 ) {
      
    }

    FHLoopRecord( &_error, record                             );

    if ( _error != 0 ) {

    }


    FHSetRecord ( &_error, record                             );

    if ( _error != 0 ) {

    }
    
    FHHiggsCorr ( &_error, MHiggs, &SAeff, UHiggs, ZHiggs     );


    if ( _error != 0 ) {

    }

    //FHSelectUZ(&_error, 1, 1, 1); // U
    FHSelectUZ( &_error, 1, 2, 1 ); // Z

    if ( _error != 0 ) {

    }


    _m_h = MHiggs[0];

    if ( _m_h < 1. ) {

        std::cout<<"Problem in mh calculation"<<std::endl;

    }

    FHCouplings( &_error, couplings, couplingsms, gammas, gammasms, fast );
    
    if ( _error != 0 ) {

    }



    FHHiggsProd( &_error, sqrts, prodxs );

    if ( _error != 0 ) {

    }
        

    _normSM_Gamma_h_gamma_gamma = Gamma   ( H0VV( 1, 1       ) ) / GammaSM   ( H0VV( 1, 1       ) );
    _normSM_Gamma_h_Z_gamma     = Gamma   ( H0VV( 1, 2       ) ) / GammaSM   ( H0VV( 1, 2       ) );
    _normSM_Gamma_h_Z_Z         = Gamma   ( H0VV( 1, 3       ) ) / GammaSM   ( H0VV( 1, 3       ) );
    _normSM_Gamma_h_W_W         = Gamma   ( H0VV( 1, 4       ) ) / GammaSM   ( H0VV( 1, 4       ) );
    _normSM_Gamma_h_g_g         = Gamma   ( H0VV( 1, 5       ) ) / GammaSM   ( H0VV( 1, 5       ) );
    _normSM_Gamma_h_tau_tau     = Gamma   ( H0FF( 1, 2, 3, 3 ) ) / GammaSM   ( H0FF( 1, 2, 3, 3 ) );
    _normSM_Gamma_h_c_c         = Gamma   ( H0FF( 1, 3, 2, 2 ) ) / GammaSM   ( H0FF( 1, 3, 2, 2 ) );
    _normSM_Gamma_h_s_s         = Gamma   ( H0FF( 1, 4, 2, 2 ) ) / GammaSM   ( H0FF( 1, 4, 2, 2 ) ); 
    _normSM_Gamma_h_b_b         = Gamma   ( H0FF( 1, 4, 3, 3 ) ) / GammaSM   ( H0FF( 1, 4, 3, 3 ) );
    _normSM_Gamma_h_total       = GammaTot( 1                  ) / GammaSMTot( 1                  );
    _normSM_sigma_ggh           = ggh     ( 1                  ) / gghSM     ( 1                  ); 
    _normSM_sigma_ggh_2         = ggh2    ( 1                  ) / gghSM     ( 1                  );
    _normSM_sigma_bbh           = bbh     ( 1                  ) / bbhSM     ( 1                  );
    _normSM_sigma_qqh           = qqh     ( 1                  ) / qqhSM     ( 1                  );
    _normSM_sigma_tth           = tth     ( 1                  ) / tthSM     ( 1                  );
    _normSM_sigma_Wh            = Wh      ( 1                  ) / WhSM      ( 1                  ); 
    _normSM_sigma_Zh            = Zh      ( 1                  ) / ZhSM      ( 1                  ); 


    FHLoopRecord( &_error, record                             );

    if ( _error != -1 ) {
      
    }

  
}

void Fittino::FeynHiggsModelCalculator::Initialize() const {

}

void Fittino::FeynHiggsModelCalculator::CallExecutable() {

}

void Fittino::FeynHiggsModelCalculator::CallFunction() {

}

void Fittino::FeynHiggsModelCalculator::ConfigureInput() {

}

