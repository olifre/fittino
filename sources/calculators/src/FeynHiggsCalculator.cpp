/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsCalculator.cpp                                          *
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
#include <boost/algorithm/string.hpp>

#include "TMath.h"

#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "CalculatorException.h"
#include "Factory.h"
#include "FeynHiggsCalculator.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"
#include "SLHAPrediction.h"

#include "FeynHiggsChannel.h"
#include "FeynHiggsFermionicChannel.h"
#include "FeynHiggsBosonicChannel.h"

#include "SLHADataStorageBase.h"

Fittino::FeynHiggsCalculator::FeynHiggsCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree, std::string inputMethod )
: CalculatorBase( model ),
gammas     ( new FHRealType   [ngammas     ] ),
gammasms   ( new FHRealType   [ngammasms   ] ),
_couplings  ( new FHComplexType[ncouplings  ] ),
_couplingsms( new FHComplexType[ncouplingsms] ),
_smallObsSet( true ),
_inputMethod( inputMethod ),
_slhadatastorageFeynHiggs( NULL ),
_slhadatastorageSPheno( NULL ),
_Norm_CrossSection_LEP_Hp_Hm( 1 ){

    _name = "FeynHiggs";
    _tag = "FeynHiggs";

    _nu[0] = "";
    _nu[1] = "nue";
    _nu[2] = "numu";
    _nu[3] = "nutau";
    
    _lepton[0] = "";
    _lepton[1] = "e";
    _lepton[2] = "mu";
    _lepton[3] = "tau";

    _up[0] = "";
    _up[1] = "u";
    _up[2] = "c";
    _up[3] = "t";
    
    _down[0] = "";
    _down[1] = "d";
    _down[2] = "s";
    _down[3] = "b";

    _neu[0] = "";
    _neu[1] = "~chi10";
    _neu[2] = "~chi20";
    _neu[3] = "~chi30";
    _neu[4] = "~chi40";
      
    _cha[0] = "";
    _cha[1] = "~chi1p";
    _cha[2] = "~chi2p";

    _higgs[0] = "";
    _higgs[1] = "h0";
    _higgs[2] = "H0";
    _higgs[3] = "A0";
    _higgs[4] = "Hp";

    AddQuantity( new SimplePrediction( "BR_b_to_s_gamma", "", _bsgammaMSSM ) );
    AddQuantity( new SimplePrediction( "SM_BR_b_to_s_gamma", "", _bsgammaSM ) );
    AddQuantity( new SimplePrediction( "Delta_Mass_Bs", "", _deltaMsMSSM ) );
    AddQuantity( new SimplePrediction( "SM_Delta_Mass_Bs", "", _deltaMsSM ) );
    AddQuantity( new SimplePrediction( "BR_Bs_to_mu_mubar", "", _bsmumuMSSM ) );
    AddQuantity( new SimplePrediction( "SM_BR_Bs_to_mu_mubar", "", _bsmumuSM ) );

    AddQuantity( new SimplePrediction( "ColorBreakingMinimum", "", _ccb ) );
    AddQuantity( new SimplePrediction( "DiffSM_a_mu", "", _gm2 ) );
    AddQuantity( new SimplePrediction( "Delta_rho", "", _Deltarho ) );
    AddQuantity( new SimplePrediction( "Mass_Wp", "", _MWMSSM ) );
    AddQuantity( new SimplePrediction( "SM_Mass_Wp", "", _MWSM ) );

    AddQuantity( new SimplePrediction( "sin2_thetaEff", "", _SW2MSSM ) );
    AddQuantity( new SimplePrediction( "SM_sin2_thetaEff", "", _SW2SM ) );

    AddQuantity( new SimplePrediction( "EDM_e_Th", "", _edmeTh ) );
    AddQuantity( new SimplePrediction( "EDM_n", "", _edmn ) );
    AddQuantity( new SimplePrediction( "EDM_Hg", "", _edmHg ) );

    AddQuantity( new SimplePrediction( "Abs_Delta_b", "", _Abs_Delta_b ) );
    AddQuantity( new SimplePrediction( "Arg_Delta_b", "", _Arg_Delta_b ) );
    AddQuantity( new SimplePrediction( "TreeLevel_sin_alpha", "", _SAtree ) );
    AddQuantity( new SimplePrediction( "Abs_sin_alpha", "", _Abs_sinAlpha ) );
    AddQuantity( new SimplePrediction( "Arg_sin_alpha", "", _Arg_sinAlpha ) );

    AddQuantity( new SimplePrediction( "Mass_h0",                    "", _mass_h0                    ) );
    AddQuantity( new SimplePrediction( "Mass_H0",                    "", _mass_H0                    ) );
    AddQuantity( new SimplePrediction( "Mass_A0",                    "", _mass_A0                    ) );
    AddQuantity( new SimplePrediction( "Mass_Hp",                    "", _mass_Hp                    ) );

    AddQuantity( new SimplePrediction( "GammaTotal_h0", "", _GammaTotal_h0   ) );
    AddQuantity( new SimplePrediction( "GammaTotal_H0", "", _GammaTotal_H0   ) );
    AddQuantity( new SimplePrediction( "GammaTotal_A0", "", _GammaTotal_A0   ) );
    AddQuantity( new SimplePrediction( "GammaTotal_Hp", "", _GammaTotal_Hp   ) );

    AddQuantity( new SimplePrediction( "SM_GammaTotal_h0", "", _SM_GammaTotal_h0   ) );
    AddQuantity( new SimplePrediction( "SM_GammaTotal_H0", "", _SM_GammaTotal_H0   ) );
    AddQuantity( new SimplePrediction( "SM_GammaTotal_A0", "", _SM_GammaTotal_A0   ) );

    AddQuantity( new SimplePrediction( "NormSM_GammaTotal_h0", "", _NormSM_GammaTotal_h0   ) );
    AddQuantity( new SimplePrediction( "NormSM_GammaTotal_H0", "", _NormSM_GammaTotal_H0   ) );
    AddQuantity( new SimplePrediction( "NormSM_GammaTotal_A0", "", _NormSM_GammaTotal_A0   ) );

    // Normalized quantities for HB/HS

    AddQuantity( new SimplePrediction( "Norm_CrossSection_LEP_Hp_Hm", "", _Norm_CrossSection_LEP_Hp_Hm ) );

    AddQuantity( new SimplePrediction( "GF", "", _GF ) );
    AddQuantity( new SimplePrediction( "Mass_Z0", "", _Mass_Z0 ) );

    AddQuantity( new SimplePrediction( "Norm_g_Abs2_h0_h0_Z0", "", _Norm_g_Abs2_h0_h0_Z0 ) );
    AddQuantity( new SimplePrediction( "Norm_g_Abs2_h0_H0_Z0", "", _Norm_g_Abs2_h0_H0_Z0 ) );
    AddQuantity( new SimplePrediction( "Norm_g_Abs2_h0_A0_Z0", "", _Norm_g_Abs2_h0_A0_Z0 ) );

    AddQuantity( new SimplePrediction( "Norm_g_Abs2_H0_h0_Z0", "", _Norm_g_Abs2_H0_h0_Z0 ) );
    AddQuantity( new SimplePrediction( "Norm_g_Abs2_H0_H0_Z0", "", _Norm_g_Abs2_H0_H0_Z0 ) );
    AddQuantity( new SimplePrediction( "Norm_g_Abs2_H0_A0_Z0", "", _Norm_g_Abs2_H0_A0_Z0 ) );

    AddQuantity( new SimplePrediction( "Norm_g_Abs2_A0_h0_Z0", "", _Norm_g_Abs2_A0_h0_Z0 ) );
    AddQuantity( new SimplePrediction( "Norm_g_Abs2_A0_H0_Z0", "", _Norm_g_Abs2_A0_H0_Z0 ) );
    AddQuantity( new SimplePrediction( "Norm_g_Abs2_A0_A0_Z0", "", _Norm_g_Abs2_A0_A0_Z0 ) );


    AddChannels_HpHV    ();
    AddChannels_HpFF    ( 1, _nu, _lepton );
    AddChannels_HpFF    ( 2, _up, _down   );

    if (! _smallObsSet ) {

      AddChannels_HpNeuCha();
      AddChannels_HpSfSf  ( 1, _nu, _lepton );
      AddChannels_HpSfSf  ( 2, _up, _down   );

    }

    for ( unsigned int iHiggs = 1; iHiggs <= 3; iHiggs++ ) {

        std::string higgsName = _higgs[iHiggs];

        AddChannels_H0VV    ( iHiggs, higgsName );
        AddChannels_H0HV    ( iHiggs, higgsName );
        AddChannels_H0HH    ( iHiggs, higgsName );

        AddChannels_H0FF    ( iHiggs, higgsName, 1, _nu     );
        AddChannels_H0FF    ( iHiggs, higgsName, 2, _lepton );
        AddChannels_H0FF    ( iHiggs, higgsName, 3, _up     );
        AddChannels_H0FF    ( iHiggs, higgsName, 4, _down   );

        AddChannels_H0NeuNeu( iHiggs, higgsName );

        if ( !_smallObsSet ) {

            AddChannels_H0ChaCha( iHiggs, higgsName );
            AddChannels_H0SfSf  ( iHiggs, higgsName, 1, _nu     );
            AddChannels_H0SfSf  ( iHiggs, higgsName, 2, _lepton );
            AddChannels_H0SfSf  ( iHiggs, higgsName, 3, _up     );
            AddChannels_H0SfSf  ( iHiggs, higgsName, 4, _down   );

        }

    }

    AddChannel( "t", "b_Wp", tBF(1), true, true );
    AddChannel( "t", "b_Hp", tBF(2), true, false );

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

        _slhadatastorageFeynHiggs  = factory.CreateSLHAeaSLHADataStorage();
        _slhadatastorageSPheno     = factory.CreateSLHAeaSLHADataStorage();

        AddQuantity( new SLHAPrediction( "SLHA_sin_alpha" , "", _slhadatastorageFeynHiggs, "ALPHA", 0, "(any)", "# Alpha", "", "") );

        AddQuantity( new SLHAPrediction( "HMIX_Q"      , "", _slhadatastorageFeynHiggs, "HMIX", 3, "BLOCK", "", "", "" ) );
        AddQuantity( new SLHAPrediction( "HMIX_mu"     , "", _slhadatastorageFeynHiggs, "HMIX", 1, "1", "", "", ""     ) );
        AddQuantity( new SLHAPrediction( "HMIX_TanBeta", "", _slhadatastorageFeynHiggs, "HMIX", 1, "2", "", "", ""     ) );
        AddQuantity( new SLHAPrediction( "HMIX_VEV"    , "", _slhadatastorageFeynHiggs, "HMIX", 1, "3", "", "", ""     ) );
        AddQuantity( new SLHAPrediction( "HMIX_m2A"    , "", _slhadatastorageFeynHiggs, "HMIX", 1, "4", "", "", ""     ) );
        
    }

    _crossSections.push_back( new FeynHiggsCrossSection( "1.96" ) );
    _crossSections.push_back( new FeynHiggsCrossSection( "7" ) );
    _crossSections.push_back( new FeynHiggsCrossSection( "8" ) );
    _crossSections.push_back( new FeynHiggsCrossSection( "14" ) );


    for (unsigned int iCrossSection = 0; iCrossSection< _crossSections.size(); iCrossSection++ ) {

        for ( unsigned int iQuantity = 0; iQuantity < _crossSections.at( iCrossSection )->GetCollectionOfQuantities().GetNumberOfElements(); iQuantity++ ) {

            AddQuantity( _crossSections.at( iCrossSection )->GetCollectionOfQuantities().At( iQuantity ) );
            
        }

    }

    AddQuantity( new SimplePrediction( "Warning_ZHiggs" , "", _warning_ZHiggs  ) );
    AddQuantity( new SimplePrediction( "Warning_ExtParQ", "", _warning_ExtParQ ) );
    AddQuantity( new SimplePrediction( "Warning_gmin2"  , "", _warning_gmin2   ) );
    AddQuantity( new SimplePrediction( "Warning_other"  , "", _warning_other   ) );
    AddQuantity( new SimplePrediction( "Warning_Ab"     , "", _warning_Ab      ) );

}

void Fittino::FeynHiggsCalculator::AddChannels_HpNeuCha() {


    for (unsigned int iNeu = 1; iNeu <= 4; iNeu++ ) {

        for (unsigned int iCha = 1; iCha <= 2; iCha++ ) {

            std::string channel = _neu[iNeu] + "_" + _cha[iCha];

            AddChannel( "Hp", channel, HpNeuCha( iNeu, iCha ) , true, false );

        }
        
    }

}

void Fittino::FeynHiggsCalculator::AddChannels_HpHV() {

    for (unsigned int iHiggs = 1; iHiggs<=3; iHiggs++ ) {

        AddChannel( "Hp", _higgs[iHiggs] + "_Wp", HpHV( iHiggs ), false, false );

    }

}

void Fittino::FeynHiggsCalculator::AddChannels_H0FF( unsigned int iHiggs, std::string higgsName, unsigned int type, std::string* names ) {

    for ( unsigned int iGen1 = 1; iGen1 <= 3; iGen1++ ) {

        for ( unsigned int iGen2 = 1; iGen2 <= 3; iGen2++ ) {

          if ( _smallObsSet && ( iGen1 != iGen2 ) ) continue;

            std::string channel = names[iGen1] + "_" + names[iGen2];

            AddChannel( higgsName, channel, H0FF( iHiggs, type, iGen1, iGen2 ), true, true );

        }

    }

}

void Fittino::FeynHiggsCalculator::AddChannels_H0ChaCha( unsigned int iHiggs, std::string higgsName ) {

    AddChannel( higgsName, "~chi1p_~chi1p", H0ChaCha( iHiggs, 1, 1 ), true, false );
    AddChannel( higgsName, "~chi1p_~chi2p", H0ChaCha( iHiggs, 1, 2 ), true, false );
    AddChannel( higgsName, "~chi2p_~chi1p", H0ChaCha( iHiggs, 2, 1 ), true, false );
    AddChannel( higgsName, "~chi2p_~chi2p", H0ChaCha( iHiggs, 2, 2 ), true, false );

}

void Fittino::FeynHiggsCalculator::AddChannels_HpFF( unsigned int type, std::string* names1, std::string* names2 ) {

    for ( unsigned int iGen1 = 1; iGen1 <= 3; iGen1++ ) {

        for ( unsigned int iGen2 = 1; iGen2 <= 3; iGen2++ ) {

            AddChannel( "Hp", names1[iGen1] + "_" + names2[iGen2], HpFF( type, iGen1, iGen2 ), true, false );

        }

    }

}

void Fittino::FeynHiggsCalculator::AddChannels_H0NeuNeu( unsigned int iHiggs, std::string higgsName ) {

    for ( unsigned int iNeu1 = 1; iNeu1 <= 4; iNeu1++ ) {

        for ( unsigned int iNeu2 = 1; iNeu2 <= 4; iNeu2++ ) {

          if ( _smallObsSet && ( iNeu1!=1 || iNeu2 !=1 ) ) continue;

          AddChannel( higgsName, _neu[iNeu1] + "_" + _neu[iNeu2], H0NeuNeu( iHiggs, iNeu1, iNeu2 ), true, false );

        }

    }

}

void Fittino::FeynHiggsCalculator::AddChannels_H0HV( unsigned int iHiggs, std::string higgsName ) {

    AddChannel( higgsName, "h0_Z0", H0HV( iHiggs, 1 ), false, false );
    AddChannel( higgsName, "H0_Z0", H0HV( iHiggs, 2 ), false, false );
    AddChannel( higgsName, "A0_Z0", H0HV( iHiggs, 3 ), false, false );

}

void Fittino::FeynHiggsCalculator::AddChannels_H0HH( unsigned int iHiggs, std::string higgsName ) {

    for ( unsigned int iHiggs1 = 1; iHiggs1 <= 4; iHiggs1++ ) {

        for ( unsigned int iHiggs2 = 1; iHiggs2 <= 4; iHiggs2++ ) {

            AddChannel( _higgs[iHiggs], _higgs[iHiggs1] + "_" + _higgs[iHiggs2] ,  H0HH( iHiggs, iHiggs1, iHiggs2 ), false, true );

        }

    }

}

void Fittino::FeynHiggsCalculator::AddChannels_H0VV( unsigned int iHiggs, std::string higgsName ) {

    AddChannel( higgsName, "gamma_gamma", H0VV( iHiggs, 1 ), false, true );
    AddChannel( higgsName, "Z0_gamma"    , H0VV( iHiggs, 2 ), false, true );
    AddChannel( higgsName, "Z0_Z0"        , H0VV( iHiggs, 3 ), false, true );
    AddChannel( higgsName, "Wp_Wm"        , H0VV( iHiggs, 4 ), false, true );
    AddChannel( higgsName, "g_g"        , H0VV( iHiggs, 5 ), false, true );

}


void Fittino::FeynHiggsCalculator::AddChannels_H0SfSf( int iHiggs, std::string higgsName, unsigned int type, std::string* names ) {
    
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

void Fittino::FeynHiggsCalculator::AddChannels_HpSfSf( unsigned int type, std::string* names1, std::string* names2 ) {

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

void Fittino::FeynHiggsCalculator::AddChannel( std::string higgsName, std::string channelName, int channelNumber, bool fermionic, bool SM ) {

    FeynHiggsChannel* calc;

    if ( fermionic ) {

        calc = new FeynHiggsFermionicChannel( gammas, gammasms, _couplings, _couplingsms, higgsName,  channelName, channelNumber, SM );

    }
    else {
        
        calc = new FeynHiggsBosonicChannel( gammas, gammasms, _couplings, _couplingsms, higgsName,  channelName, channelNumber, SM );

    }

    _channels.push_back( calc );

    for ( unsigned int iQuantity = 0; iQuantity < calc->GetCollectionOfQuantities().GetNumberOfElements(); iQuantity++ ) {

        AddQuantity( calc->GetCollectionOfQuantities().At( iQuantity ) );

    }

}

Fittino::FeynHiggsCalculator::~FeynHiggsCalculator() {

}

void Fittino::FeynHiggsCalculator::CalculatePredictions() {

    std::string outputFile( "FeynHiggs.out" );

    if ( boost::filesystem::exists( outputFile ) ) {

        boost::filesystem::rename( outputFile, outputFile + ".last" );
        
    }

    if ( boost::filesystem::exists( "FeynHiggs.spc" ) ) {

      boost::filesystem::rename( "FeynHiggs.spc" , "FeynHiggs.spc.last" );
        
    }

    if ( boost::filesystem::exists( "SPheno_FeynHiggs.spc" ) ) {

      boost::filesystem::rename( "SPheno_FeynHiggs.spc" , "SPheno_FeynHiggs.spc.last" );
        
    }

    Redirector redirector( outputFile );
    redirector.Start();

    std::string flags = "400243110"; 

    FHSetFlagsString( &_error, flags.c_str() );

    if ( _error != 0 ) {

      throw CalculatorException( _name, "FHSetFlagsString" ); 

    }

    FHRealType    record     [nrecord];
    COMPLEX     slhadata   [nslhadata];

    // set input

    if ( _inputMethod == "FeynHiggs" ) {

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

          throw CalculatorException( _name, "FHReadRecord" ); 

        }
        
        FHLoopRecord( &_error, record );
        
        if ( _error != 0 ) {

          throw CalculatorException( _name, "FHLoopRecord" ); 
            
        }
        
        FHSetRecord ( &_error, record );
        
        if ( _error != 0 ) {

          throw CalculatorException( _name, "FHSetRecord" ); 
            
        }

    }
    else if ( _inputMethod == "SLHA" ) {

        SLHAClear( slhadata );

        SLHARead( &_error, slhadata, _fileName.c_str(), 1 );
        
        if( _error != 0  ) {

          throw CalculatorException( _name, "SLHARead" ); 

        }

        FHSetSLHA( &_error, slhadata );
        
        if( _error != 0  ) {

          throw CalculatorException( _name, "FHSetSLHA" ); 

        }

    }

    // calculate masses, sin(alpha), UHiggs & ZHiggs matrices

    FHRealType MHiggs[4];
    FHComplexType SAeff, UHiggs[3][3], ZHiggs[3][3];

    FHHiggsCorr( &_error, MHiggs, &SAeff, UHiggs, ZHiggs );

    if ( _error != 0 ) {

        throw CalculatorException( _name, "FHHiggsCorr" ); 

    }

    _mass_h0 = MHiggs[0];
    _mass_H0 = MHiggs[1];
    _mass_A0 = MHiggs[2];
    _mass_Hp = MHiggs[3];

    _Abs_sinAlpha = abs( SAeff );
    _Arg_sinAlpha = arg( SAeff );

    if ( _mass_h0 < 1. ) {

        throw CalculatorException( _name, "Mass_h0");

    }

    // select UHiggs or ZHiggs for calculation of couplings and gammas

    FHSelectUZ( &_error, 1, 2, 1 );

    if ( _error != 0 ) {

        throw CalculatorException( _name, "FHSelectUZ" ); 

    }

    int fast  = 1;
    FHCouplings( &_error, _couplings, _couplingsms, gammas, gammasms, fast );

    if ( _error != 0 ) {

      throw CalculatorException( _name, "FHCouplings" ); 

    }

    _GammaTotal_h0 = GammaTot(1);
    _GammaTotal_H0 = GammaTot(2);
    _GammaTotal_A0 = GammaTot(3);
    _GammaTotal_Hp = GammaTot(4);
    
    _SM_GammaTotal_h0 = GammaSMTot(1);
    _SM_GammaTotal_H0 = GammaSMTot(2);
    _SM_GammaTotal_A0 = GammaSMTot(3);

    _NormSM_GammaTotal_h0 = _GammaTotal_h0 / _SM_GammaTotal_h0;
    _NormSM_GammaTotal_H0 = _GammaTotal_H0 / _SM_GammaTotal_H0;
    _NormSM_GammaTotal_A0 = _GammaTotal_A0 / _SM_GammaTotal_A0;


    for ( unsigned int iCrossSection = 0; iCrossSection < _crossSections.size(); iCrossSection++ ) {


        _crossSections.at( iCrossSection )->CalculatePredictions();

    }

    FHRealType bsgammaMSSM;
    FHRealType bsgammaSM;
    FHRealType deltaMsMSSM;
    FHRealType deltaMsSM;
    FHRealType bsmumuMSSM;
    FHRealType bsmumuSM;

    FHFlavour( &_error,
               &bsgammaMSSM,
               &bsgammaSM,
               &deltaMsMSSM,
               &deltaMsSM,
               &bsmumuMSSM,
               &bsmumuSM );

    if ( _error != 0 ) {
      
      throw CalculatorException( _name, "FHFlavour" ); 

    }

    _bsgammaMSSM = bsgammaMSSM;
    _bsgammaSM   = bsgammaSM;
    _deltaMsMSSM = deltaMsMSSM;
    _deltaMsSM   = deltaMsSM;
    _bsmumuMSSM  = bsmumuMSSM;
    _bsmumuSM    = bsmumuSM;

    FHRealType gm2;
    FHRealType Deltarho;
    FHRealType MWMSSM;
    FHRealType MWSM;
    FHRealType SW2MSSM;
    FHRealType SW2SM;
    FHRealType edmeTh;
    FHRealType edmn;
    FHRealType edmHg;
    int ccb;
    
    FHConstraints( &_error,
                   &gm2,
                   &Deltarho,
                   &MWMSSM,
                   &MWSM,
                   &SW2MSSM,
                   &SW2SM,
                   &edmeTh,
                   &edmn,
                   &edmHg,
                   &ccb);

    if ( _error != 0 ) {
      
      throw CalculatorException( _name, "FHConstraints" ); 

    }

    _gm2      = gm2;
    _Deltarho = Deltarho;
    _MWMSSM   = MWMSSM;
    _MWSM     = MWSM;
    _SW2MSSM  = SW2MSSM;
    _SW2SM    = SW2SM;
    _edmeTh   = edmeTh;
    _edmn     = edmn;
    _edmHg    = edmHg;
    _ccb      = ccb;

    int nmfv;
    FHRealType MSf[3][5][2], MASf[5][6], MCha[2], MNeu[4];
    FHComplexType USf[3][5][2][2], UASf[5][6][6];
    FHComplexType UCha[2][2], VCha[2][2], ZNeu[4][4];
    FHComplexType DeltaMB;
    FHRealType MGl;
    FHRealType MHtree[4], SAtree;

    FHGetPara( &_error,
              &nmfv,
              MSf,
              USf,
              MASf,
              UASf,
              MCha,
              UCha,
              VCha,
              MNeu,
              ZNeu,
              &DeltaMB,
              &MGl,
              MHtree,
              &SAtree) ;

    if ( _error != 0 ) {
      
      throw CalculatorException( _name, "FHGetPara" ); 

    }

    _Abs_Delta_b = abs( DeltaMB );
    _Arg_Delta_b = arg( DeltaMB );
    _SAtree = SAtree;

    FHRealType invAlfa, AlfasMZ, GF;
    FHRealType ME, MU, MD, MM, MC, MS, ML, MB;
    FHRealType MW, MZ;
    FHRealType CKMlambda, CKMA, CKMrhobar, CKMetabar;

    FHRetrieveSMPara( &_error,
                      &invAlfa, &AlfasMZ, &GF,
                      &ME, &MU, &MD, &MM, &MC, &MS, &ML, &MB,
                      &MW, &MZ,
                      &CKMlambda, &CKMA, &CKMrhobar, &CKMetabar );

    if ( _error != 0 ) {
      
      throw CalculatorException( _name, "FHRetrieveSMPara" ); 

    }

    _GF = GF;
    _Mass_Z0 = MZ;

    if ( _inputMethod == "SLHA" ) {

        int key = 255;
        FHOutputSLHA( &_error, slhadata, key );

        if ( _error != 0 ) {
      
          throw CalculatorException( _name, "FHOutputSLHA" ); 

        }

        SLHAWrite( &_error, slhadata, "FeynHiggs.spc");

        if ( _error != 0 ) {
      
          throw CalculatorException( _name, "SLHAWrite" ); 

        }

    }

    redirector.Stop();

    for ( unsigned int i = 0; i< _channels.size(); i++ ) {

        _channels.at( i )->CalculatePredictions();

    }
    
    double norm = TMath::Sqrt2() * _GF * TMath::Power( _Mass_Z0, 2);

    _Norm_g_Abs2_h0_h0_Z0 = TMath::Power( GetCollectionOfQuantities().At( _tag + "_g_Abs_h0_h0_Z0" )->GetValue(), 2 ) / norm;
    _Norm_g_Abs2_h0_H0_Z0 = TMath::Power( GetCollectionOfQuantities().At( _tag + "_g_Abs_h0_H0_Z0" )->GetValue(), 2 ) / norm;
    _Norm_g_Abs2_h0_A0_Z0 = TMath::Power( GetCollectionOfQuantities().At( _tag + "_g_Abs_h0_A0_Z0" )->GetValue(), 2 ) / norm;

    _Norm_g_Abs2_H0_h0_Z0 = TMath::Power( GetCollectionOfQuantities().At( _tag + "_g_Abs_H0_h0_Z0" )->GetValue(), 2 ) / norm;
    _Norm_g_Abs2_H0_H0_Z0 = TMath::Power( GetCollectionOfQuantities().At( _tag + "_g_Abs_H0_H0_Z0" )->GetValue(), 2 ) / norm;
    _Norm_g_Abs2_H0_A0_Z0 = TMath::Power( GetCollectionOfQuantities().At( _tag + "_g_Abs_H0_A0_Z0" )->GetValue(), 2 ) / norm;

    _Norm_g_Abs2_A0_h0_Z0 = TMath::Power( GetCollectionOfQuantities().At( _tag + "_g_Abs_A0_h0_Z0" )->GetValue(), 2 ) / norm;
    _Norm_g_Abs2_A0_H0_Z0 = TMath::Power( GetCollectionOfQuantities().At( _tag + "_g_Abs_A0_H0_Z0" )->GetValue(), 2 ) / norm;
    _Norm_g_Abs2_A0_A0_Z0 = TMath::Power( GetCollectionOfQuantities().At( _tag + "_g_Abs_A0_A0_Z0" )->GetValue(), 2 ) / norm;

    _warning_ZHiggs  = 0;
    _warning_ExtParQ = 0;
    _warning_gmin2   = 0;
    _warning_Ab      = 0;
    _warning_other   = 0;

    std::string line;
    std::ifstream file("FeynHiggs.out");
    while ( std::getline( file, line ) ) {

        if      ( boost::algorithm::contains( line, "warning: ZHiggs possibly unreliable"           ) )              _warning_ZHiggs  = 1;
        else if ( boost::algorithm::contains( line, "warning: ExtPar_Q taken to be sqrt(M3SQ M3SU)" ) )              _warning_ExtParQ = 1;
        else if ( boost::algorithm::contains( line, "warning: g-2 possibly unreliable due to numerical problems" ) ) _warning_gmin2   = 1;
        else if ( boost::algorithm::contains( line, "warning: Questionable Ab from DRbar-to-OS conversion" ) )       _warning_Ab      = 1;
        else if ( boost::algorithm::contains( line, "warning"                                       ) )              _warning_other   = 1;

    }

    file.close();

    if ( _inputMethod == "SLHA" ) {

        _slhadatastorageSPheno   ->ReadFile("SPheno.spc");
        _slhadatastorageFeynHiggs->ReadFile("FeynHiggs.spc");

        for ( unsigned int i = 0; i < GetCollectionOfQuantities().GetNumberOfElements(); ++i ) {

          GetCollectionOfQuantities().At( i )->Update();

        }
    
        _slhadatastorageSPheno->SetEntry( _MWMSSM,  "MASS", 1, "24", "", "", "" );   
        _slhadatastorageSPheno->SetEntry( _mass_h0, "MASS", 1, "25", "", "", "" );
        _slhadatastorageSPheno->SetEntry( _mass_H0, "MASS", 1, "35", "", "", "" );
        _slhadatastorageSPheno->SetEntry( _mass_A0, "MASS", 1, "36", "", "", "" );
        _slhadatastorageSPheno->SetEntry( _mass_Hp, "MASS", 1, "37", "", "", "" );

        _slhadatastorageSPheno->ReplaceBlock( "alpha", _slhadatastorageFeynHiggs->GetBlock( "ALPHA" ) );
        _slhadatastorageSPheno->ReplaceBlock( "Hmix",  _slhadatastorageFeynHiggs->GetBlock( "HMIX"  ) );
        _slhadatastorageSPheno->ReplaceBlock( "25",    _slhadatastorageFeynHiggs->GetBlock( "25"    ) );
        _slhadatastorageSPheno->ReplaceBlock( "35",    _slhadatastorageFeynHiggs->GetBlock( "35"    ) );
        _slhadatastorageSPheno->ReplaceBlock( "36",    _slhadatastorageFeynHiggs->GetBlock( "36"    ) );
        _slhadatastorageSPheno->ReplaceBlock( "37",    _slhadatastorageFeynHiggs->GetBlock( "37"    ) );

        _slhadatastorageSPheno->WriteFile("SPheno_FeynHiggs.spc");

    }

}
