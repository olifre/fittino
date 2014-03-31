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
#include <boost/lexical_cast.hpp>
#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "CalculatorException.h"
#include "Factory.h"
#include "FeynHiggsCalculator.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"

#include "FeynHiggsChannel.h"
#include "FeynHiggsFermionicChannel.h"
#include "FeynHiggsBosonicChannel.h"

#include "SLHADataStorageBase.h"

Fittino::FeynHiggsCalculatorBase::FeynHiggsCalculatorBase( const PhysicsModel* model, const boost::property_tree::ptree& ptree, std::string inputMethod )
: CalculatorBase( model ),
_gammas     ( new FHRealType   [ngammas     ] ),
_gammasms   ( new FHRealType   [ngammasms   ] ),
_couplings  ( new FHComplexType[ncouplings  ] ),
_couplingsms( new FHComplexType[ncouplingsms] ),
_nu     { "",  "nue", "numu", "nutau" },
_lepton { "", "e", "mu", "tau"        },
_up     { "", "u", "c", "t"           },
_down   { "", "d", "s", "b"           },
_neu    { "", "~chi01", "~chi02", "~chi03", "~chi04" },
_cha    { "", "~chip1", "~chip2" },
_higgs  { "", "h0", "H0", "A0", "Hp" },
_inputMethod( inputMethod ),
_slhadatastorage( NULL ){

    _name = "FeynHiggsCalculator";
    
    AddQuantity( new SimplePrediction( "Mass_h",                     "", _mass_h                     ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_ggh"          , "", _normSM_sigma_ggh           ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_ggh_2"        , "", _normSM_sigma_ggh_2         ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_bbh"          , "", _normSM_sigma_bbh           ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_qqh"          , "", _normSM_sigma_qqh           ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_tth"          , "", _normSM_sigma_tth           ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_Wh"           , "", _normSM_sigma_Wh            ) );
    AddQuantity( new SimplePrediction( "NormSM_sigma_Zh"           , "", _normSM_sigma_Zh            ) );

    //AddChannels_HpHV    ();
    //AddChannels_HpNeuCha();

    // AddChannels_HpFF    ( 1, _nu, _lepton );
    //AddChannels_HpFF    ( 2, _up, _down   );
    //AddChannels_HpSfSf  ( 1, _nu, _lepton );
    //AddChannels_HpSfSf  ( 2, _up, _down   );


    for ( unsigned int iHiggs = 1; iHiggs <= 3; iHiggs++ ) {

        std::string higgsName = _higgs[iHiggs];

        AddChannels_H0VV    ( iHiggs, higgsName );
        AddChannels_H0HV    ( iHiggs, higgsName );
        AddChannels_H0HH    ( iHiggs, higgsName );
        //AddChannels_H0NeuNeu( iHiggs, higgsName );
        //AddChannels_H0ChaCha( iHiggs, higgsName );

        AddChannels_H0FF    ( iHiggs, higgsName, 1, _nu     );
        AddChannels_H0FF    ( iHiggs, higgsName, 2, _lepton );
        AddChannels_H0FF    ( iHiggs, higgsName, 3, _up     );
        AddChannels_H0FF    ( iHiggs, higgsName, 4, _down   );
        //AddChannels_H0SfSf  ( iHiggs, higgsName, 1, _nu     );
        //AddChannels_H0SfSf  ( iHiggs, higgsName, 2, _lepton );
        //AddChannels_H0SfSf  ( iHiggs, higgsName, 3, _up     );
        //AddChannels_H0SfSf  ( iHiggs, higgsName, 4, _down   );

    }

    if ( _inputMethod == "FeynHiggs" ) {


        _fileName = "FeynHiggs.in";

        BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {

            if( node.first == "Parameter" ) {

                std::string name     = node.second.get<std::string>( "Name"     );
                std::string quantity = node.second.get<std::string>( "Quantity" );

                const double& value = _model->GetCollectionOfQuantities().At( quantity )->GetValue();

                _input.AddElement( new SimplePrediction( name, "" , value ) ) ;
            
            }
        
        }

    }
    else if ( _inputMethod == "SLHA" ) {
    
        _fileName = "SPheno.spc";

        Factory factory;

        _slhadatastorage  = factory.CreateSLHAeaSLHADataStorage();

    }

    
}

void Fittino::FeynHiggsCalculatorBase::AddChannels_HpNeuCha() {


    for (unsigned int iNeu = 1; iNeu <= 4; iNeu++ ) {

        for (unsigned int iCha = 1; iCha <= 2; iCha++ ) {

            std::string channel = _neu[iNeu] + "_" + _cha[iCha];

            AddChannel( "Hp", channel, HpNeuCha( iNeu, iCha ) , true, false );

        }
        
    }

}

void Fittino::FeynHiggsCalculatorBase::AddChannels_HpHV() {

    for (unsigned int iHiggs = 1; iHiggs<=3; iHiggs++ ) {

        AddChannel( "Hp", _higgs[iHiggs] + "_W", HpHV( 1 ), false, false );

    }

}

void Fittino::FeynHiggsCalculatorBase::AddChannels_H0FF( unsigned int iHiggs, std::string higgsName, unsigned int type, std::string* names ) {

    for ( unsigned int iGen1 = 1; iGen1 <= 3; iGen1++ ) {

        for ( unsigned int iGen2 = 1; iGen2 <= 3; iGen2++ ) {

            if ( iGen1 != iGen2 ) continue;

            std::string channel = names[iGen1] + "_" + names[iGen2];

            AddChannel( higgsName, channel, H0FF( iHiggs, type, iGen1, iGen2 ), true, true );

        }

    }

}

void Fittino::FeynHiggsCalculatorBase::AddChannels_H0ChaCha( unsigned int iHiggs, std::string higgsName ) {

    AddChannel( higgsName, "~chip1_~chip1", H0ChaCha( iHiggs, 1, 1 ), true, false );
    AddChannel( higgsName, "~chip1_~chip2", H0ChaCha( iHiggs, 1, 2 ), true, false );
    AddChannel( higgsName, "~chip2_~chip1", H0ChaCha( iHiggs, 2, 1 ), true, false );
    AddChannel( higgsName, "~chip2_~chip2", H0ChaCha( iHiggs, 2, 2 ), true, false );

}

void Fittino::FeynHiggsCalculatorBase::AddChannels_HpFF( unsigned int type, std::string* names1, std::string* names2 ) {

    for ( unsigned int iGen1 = 1; iGen1 <= 3; iGen1++ ) {

        for ( unsigned int iGen2 = 1; iGen2 <= 3; iGen2++ ) {

            AddChannel( "Hp", names1[iGen1] + "_" + names2[iGen2], HpFF( type, iGen1, iGen2 ), true, false );

        }

    }

}

void Fittino::FeynHiggsCalculatorBase::AddChannels_H0NeuNeu( unsigned int iHiggs, std::string higgsName ) {

    for ( unsigned int iNeu1 = 1; iNeu1 <= 4; iNeu1++ ) {

        for ( unsigned int iNeu2 = 1; iNeu2 <= 4; iNeu2++ ) {

            AddChannel( higgsName, _neu[iNeu1] + "_" + _neu[iNeu2], H0NeuNeu( iHiggs, iNeu1, iNeu2 ), true, false );

        }

    }

}

void Fittino::FeynHiggsCalculatorBase::AddChannels_H0HV( unsigned int iHiggs, std::string higgsName ) {

    AddChannel( higgsName, "h0_Z", H0HV( iHiggs, 1 ), false, false );
    AddChannel( higgsName, "H0_Z", H0HV( iHiggs, 2 ), false, false );
    AddChannel( higgsName, "A0_Z", H0HV( iHiggs, 3 ), false, false );

}

void Fittino::FeynHiggsCalculatorBase::AddChannels_H0HH( unsigned int iHiggs, std::string higgsName ) {

    for ( unsigned int iHiggs1 = 1; iHiggs1 <= 4; iHiggs1++ ) {

        for ( unsigned int iHiggs2 = 1; iHiggs2 <= 4; iHiggs2++ ) {

            AddChannel( _higgs[iHiggs], _higgs[iHiggs1] + "_" + _higgs[iHiggs2] ,  H0HH( iHiggs, iHiggs1, iHiggs2 ), false, false );

        }

    }

}

void Fittino::FeynHiggsCalculatorBase::AddChannels_H0VV( unsigned int iHiggs, std::string higgsName ) {

    AddChannel( higgsName, "gamma_gamma", H0VV( iHiggs, 1 ), false, true );
    AddChannel( higgsName, "Z_gamma"    , H0VV( iHiggs, 2 ), false, true );
    AddChannel( higgsName, "Z_Z"        , H0VV( iHiggs, 3 ), false, true );
    AddChannel( higgsName, "W_W"        , H0VV( iHiggs, 4 ), false, true );
    AddChannel( higgsName, "g_g"        , H0VV( iHiggs, 3 ), false, true );

}



void Fittino::FeynHiggsCalculatorBase::AddChannels_H0SfSf( int iHiggs, std::string higgsName, unsigned int type, std::string* names ) {
    
    for ( unsigned int iSfermion1 =1; iSfermion1 <=2; iSfermion1++ ) {
        
        for ( unsigned int iSfermion2 =1; iSfermion2 <=2; iSfermion2++ ) {

            for ( unsigned int iGen = 1; iGen <=3; iGen++ ) {

                std::string channel;
                channel += "~" + names[iGen] + boost::lexical_cast<std::string>( iSfermion1 );
                channel += "_";
                channel += "~" + names[iGen] + boost::lexical_cast<std::string>( iSfermion2 );

                AddChannel( higgsName, channel, H0SfSf( iHiggs, iSfermion1, iSfermion2, type, iGen ), false, false );
                        
            }

        }
        
    }

}

void Fittino::FeynHiggsCalculatorBase::AddChannels_HpSfSf( unsigned int type, std::string* names1, std::string* names2 ) {

    for ( unsigned int iSfermion1 = 1; iSfermion1 <= 2; iSfermion1++ ) {

        for ( unsigned int iSfermion2 =1; iSfermion2 <=2; iSfermion2++ ) {

            for ( unsigned int iGen1 = 1; iGen1 <=3; iGen1++ ) {

                for ( unsigned int iGen2 = 1; iGen2 <= 3; iGen2++ ) {

                    std::string channel;
                    channel += "~" + names1[iGen1] + boost::lexical_cast<std::string>( iSfermion1 );
                    channel += "_";
                    channel += "~" + names2[iGen2] + boost::lexical_cast<std::string>( iSfermion2 );

                    AddChannel( "Hp", channel,  HpSfSf( iSfermion1, iSfermion2, type, iGen1, iGen2 ), false, false );

                }

            }

        }

    }

}

void Fittino::FeynHiggsCalculatorBase::AddChannel( std::string higgsName, std::string channelName, int channelNumber, bool fermionic, bool SM ) {

    FeynHiggsChannel* calc;

    if ( fermionic ) {

        calc = new FeynHiggsFermionicChannel( _gammas, _gammasms, _couplings, _couplingsms, higgsName,  channelName, channelNumber, SM );

    }
    else {
        
        calc = new FeynHiggsBosonicChannel( _gammas, _gammasms, _couplings, _couplingsms, higgsName,  channelName, channelNumber, SM );

    }

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

    RealType    record     [nrecord];
    COMPLEX     slhadata   [nslhadata];

    if ( _inputMethod == "FeynHiggs" ) {

        _fileName = "FeynHiggs.in";

        
        if ( boost::filesystem::exists( _fileName ) ) {

            boost::filesystem::rename( _fileName, _fileName + ".last" );

        }

        std::ofstream file( _fileName.c_str() );

        for ( int i = 0; i < _input.GetNumberOfElements(); i++ ) {

            file<<boost::format( "%-25s % 25.16e\n" ) % _input.At( i )->GetName() % _input.At( i )->GetValue();

        }

        file.close();

               FHReadRecord( &_error, record, slhadata, _fileName.c_str() );

        if ( _error != 2 ) {

        }
        
        FHLoopRecord( &_error, record );
        
        if ( _error != 0 ) {
            
        }
        
        FHSetRecord ( &_error, record );
        
        if ( _error != 0 ) {
            
        }

    }
    else if ( _inputMethod == "SLHA" ) {

        _slhadatastorage->ReadFile("SPheno.spc");

        SLHAClear( slhadata );
        SLHARead( &_error, slhadata, _fileName.c_str(), 1 );
        //if( error )
        //    exit(error);

        FHSetSLHA( &_error, slhadata );
        //if( error )
        //    exit(error);



    }

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

    //ComplexType couplings[ncouplings], couplingsms[ncouplingsms];
        int    fast  = 1;

    FHCouplings( &_error, _couplings, _couplingsms, _gammas, _gammasms, fast );
    
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

    if ( _inputMethod == "SLHA" ) {

        // int key = 16;
        // int key = 255;
        // FHOutputSLHA( &_error, _slhadata, key );
        // SLHAWrite(&_error, _slhadata, "FH.slha");

        _slhadatastorage->SetEntry(666, "MASS", 1, "35", "", "", "");
        _slhadatastorage->SetEntry(777, "alpha", 0, "(any)", "# alpha", "", "");
        _slhadatastorage->WriteFile("NewSPheno.spc");

    }


    //WriteOutput();

    redirector.Stop();

    for ( unsigned int i = 0; i< _channels.size(); i++ ) {

        _channels.at( i )->CalculatePredictions();

    }

}
