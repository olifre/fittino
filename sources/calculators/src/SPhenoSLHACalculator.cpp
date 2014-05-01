/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SPhenoSLHACalculator.cpp                                         *
*                                                                              *
* Description Wrapper class for SPheno                                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/filesystem.hpp>
#include <boost/foreach.hpp>
#include <boost/lexical_cast.hpp>

#include "CalculatorException.h"
#include "Database.h"
#include "PhysicsModel.h"
#include "SLHADataStorageBase.h"
#include "SLHALine.h"
#include "SLHAPrediction.h"
#include "SPhenoSLHACalculator.h"
#include "TimeoutExecutorException.h"

Fittino::SPhenoSLHACalculator::SPhenoSLHACalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : SLHACalculatorBase( model ),
      _executor( "./SPheno", "SPheno" ) {

    _name               = "SPheno";
    _tag                = "SPheno";
    _slhaInputFileName  = "LesHouches.in";
    _slhaOutputFileName = "SPheno.spc";

    _executor.SetCompletionTimeout( 20 );

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "SLHALine" ) {

            _lines.push_back( new SLHALine( node.second, model ) );

        }

    }

    Database& database = Database::GetInstance();

    AddMass( "Wp" );
    AddMass( "Z0" );

    AddParticle( "t" );
    AddBR( "t", "b", "Wp" );
    AddBR( "t", "b", "Hp" );

    AddParticle( "h0" );
    AddParticle( "H0" );
    AddParticle( "Hp" );
    AddParticle( "A0" );

    AddQuantity( new SLHAPrediction( "sinAlpha" , "", _slhaOutputDataStorage, "alpha", 0, "(any)", "# alpha", "", "") );

    AddQuantity( new SLHAPrediction( "HMIX_Q"      , "", _slhaOutputDataStorage, "HMIX", 3, "BLOCK", "", "", "" ) );
    AddQuantity( new SLHAPrediction( "HMIX_mu"     , "", _slhaOutputDataStorage, "HMIX", 1, "1", "", "", ""     ) );
    AddQuantity( new SLHAPrediction( "HMIX_TanBeta", "", _slhaOutputDataStorage, "HMIX", 1, "2", "", "", ""     ) );
    AddQuantity( new SLHAPrediction( "HMIX_VEV"    , "", _slhaOutputDataStorage, "HMIX", 1, "3", "", "", ""     ) );
    AddQuantity( new SLHAPrediction( "HMIX_m2A"   , "", _slhaOutputDataStorage, "HMIX", 1, "4", "", "", ""     ) );

    std::vector<std::string> susyparticles = database.GetSUSYParticles();

    for ( unsigned int iParticle = 0; iParticle < susyparticles.size(); ++iParticle ) {

        AddParticle( susyparticles[iParticle] );

    }

    AddBR( "~chi20", "~eL",   "ebar"   );
    AddBR( "~chi20", "~eR",   "ebar"   );
    AddBR( "~chi20", "~muL",  "mubar"  );
    AddBR( "~chi20", "~muR" , "mubar"  );
    AddBR( "~chi20", "~tau1", "taubar" );
    AddBR( "~chi20", "~tau2", "taubar" );

    AddBR( "~chi20", "~eLbar",   "e"   );
    AddBR( "~chi20", "~eRbar",   "e"   );
    AddBR( "~chi20", "~muLbar",  "mu"  );
    AddBR( "~chi20", "~muRbar",  "mu"  );
    AddBR( "~chi20", "~tau1bar", "tau" );
    AddBR( "~chi20", "~tau2bar", "tau" );

    AddBR( "~chi20", "~chi10", "Z0" );
    AddBR( "~chi20", "~chi10", "h0" );

    AddBR( "~chi1p", "~chi10",   "Wp"     );
    AddBR( "~chi1p", "~tau1bar", "nutau"  );
    AddBR( "~chi1p", "~tau2bar", "nutau"  );
    AddBR( "~chi1p", "~nutauL",  "taubar" );
    AddBR( "~chi1p", "~numuL",   "mubar"  );
    AddBR( "~chi1p", "~nueL",    "ebar"   );

    AddBR( "~eR", "~chi10", "e" );
    AddBR( "~eR", "~chi20", "e" );

    AddBR( "~eL", "~chi10", "e" );
    AddBR( "~eL", "~chi20", "e" );

    AddBR( "~tau1", "~chi10", "tau" );

    AddBR( "~tau2", "~chi10", "tau"   );
    AddBR( "~tau2", "~chi20", "tau"   );
    AddBR( "~tau2", "~chi1m", "nutau" );
    AddBR( "~tau2", "~tau1",  "h0"    );
    AddBR( "~tau2", "~tau1",  "Z0"    );

    AddBR( "~g", "~b1", "bbar" );
    AddBR( "~g", "~b2", "bbar" );
    AddBR( "~g", "~t1", "tbar" );
    AddBR( "~g", "~t2", "tbar" );
    AddBR( "~g", "~uL", "ubar" );
    AddBR( "~g", "~uR", "ubar" );
    AddBR( "~g", "~dL", "dbar" );
    AddBR( "~g", "~dR", "dbar" );

    AddBR( "~g", "~b1bar", "b" );
    AddBR( "~g", "~b2bar", "b" );
    AddBR( "~g", "~t1bar", "t" );
    AddBR( "~g", "~t2bar", "t" );
    AddBR( "~g", "~uLbar", "u" );
    AddBR( "~g", "~uRbar", "u" );
    AddBR( "~g", "~dLbar", "d" );
    AddBR( "~g", "~dRbar", "d" );

    AddBR( "~uL", "~chi10", "u" );
    AddBR( "~uL", "~chi20", "u" );
    AddBR( "~uL", "~chi1p", "d" );
    AddBR( "~uL", "~chi2p", "d" );

    AddBR( "~uR", "~chi10", "u" );
    AddBR( "~uR", "~chi20", "u" );
    AddBR( "~uR", "~chi1p", "d" );
    AddBR( "~uR", "~chi2p", "d" );

    AddBR( "~t1", "~chi10", "t" );
    AddBR( "~t1", "~chi20", "t" );
    AddBR( "~t1", "~chi1p", "b" );
    AddBR( "~t1", "~chi2p", "b" );

    AddBR( "~b1", "~chi10", "b"  );
    AddBR( "~b1", "~chi20", "b"  );
    AddBR( "~b1", "~chi1m", "t"  );
    AddBR( "~b1", "~chi2m", "t"  );
    AddBR( "~b1", "~t1",    "Wm" );

    AddBR( "~b2", "~chi10", "b"  );
    AddBR( "~b2", "~chi20", "b"  );
    AddBR( "~b2", "~chi1m", "t"  );
    AddBR( "~b2", "~chi2m", "t"  );
    AddBR( "~b2", "~t1",    "Wm" );

}

Fittino::SPhenoSLHACalculator::~SPhenoSLHACalculator() {

    for ( unsigned int i = 0; i < _lines.size(); i++ ) {

        delete _lines[i];

    }

}

void Fittino::SPhenoSLHACalculator::CalculatePredictions() {

    if ( boost::filesystem::exists( _slhaInputFileName ) ) {

        boost::filesystem::rename( _slhaInputFileName, _slhaInputFileName + ".last" );

    }

    if ( boost::filesystem::exists( _slhaOutputFileName ) ) {

        boost::filesystem::rename( _slhaOutputFileName, _slhaOutputFileName + ".last" );

    }

    ConfigureInput();

    _slhaInputDataStorage->WriteFile( _slhaInputFileName );

    try {

        _returnValue = _executor.Execute();

    }
    catch ( const TimeoutExecutorException& e ) {

        throw CalculatorException( _name, "Timeout" );

    }

    if ( _returnValue != 0 ) {

        throw  CalculatorException( _name, "Return value " + boost::lexical_cast<std::string>( _returnValue ) );

    }

    _slhaOutputDataStorage->Clear();
    _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );

    for ( unsigned int i = 0; i < _collectionOfQuantities.GetNumberOfElements(); ++i ) {

        _collectionOfQuantities.At( i )->Update();

    }

}

void Fittino::SPhenoSLHACalculator::AddBR( std::string mother, std::string daughter1, std::string daughter2 ) {

    Database& database = Database::GetInstance();
    std::string pid0 = database.GetPIDString( mother );
    std::string pid1 = database.GetPIDString( daughter1 );
    std::string pid2 = database.GetPIDString( daughter2 );

    std::string name = "BR_" + mother + "_to_" + daughter1 + "_" + daughter2;

    AddQuantity( new SLHAPrediction( name, "", 0, _slhaOutputDataStorage, pid0, 0, "(any)", "2", pid1, pid2 ) );

}

void Fittino::SPhenoSLHACalculator::AddMass( std::string particle ) {

    std::string name = "Mass_" + particle;

    Database& database = Database::GetInstance();
    std::string pid = database.GetPIDString( particle );

    AddQuantity( new SLHAPrediction( name , "GeV", _slhaOutputDataStorage, "MASS", 1, pid, "", "", "" ) );

}

void Fittino::SPhenoSLHACalculator::AddParticle( std::string particle ) {

    AddMass ( particle );
    AddWidth( particle );

}

void Fittino::SPhenoSLHACalculator::AddWidth( std::string particle ) {

    std::string name = "GammaTotal_" + particle;

    Database& database = Database::GetInstance();
    std::string pid = database.GetPIDString( particle );

    AddQuantity( new SLHAPrediction( name, "GeV", _slhaOutputDataStorage, pid, 2, "DECAY", "", "", "" ) );

}

void Fittino::SPhenoSLHACalculator::ConfigureInput() {

    _slhaInputDataStorage->Clear();

    // Write block "MODSEL".

    _slhaInputDataStorage->AddBlock( "MODSEL:BLOCK MODSEL:# Model selection" );
    _slhaInputDataStorage->AddLine( "MODSEL:1:1:# " + _model->GetName() );
    //_slhaInputDataStorage->AddLine( "MODSEL:12:1000:# Q_EWSB (fixed)" );

    // Write block "SMINPUTS".

    _slhaInputDataStorage->AddBlock( "SMINPUTS:BLOCK SMINPUTS:# Standard model inputs" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:1:1.28952e+02:# 1/alpha_em (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:2:1.1663787e-05:# G_F (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:3:1.184e-01:# alpha_s (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:4:9.11876e+01:# mZ (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:5:4.18e+00:# mb(mb) (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:7:1.77682e+00:# mtau (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:13:1.056583715e-01:# mmu (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:23:9.5e-02:# ms(2GeV) (fixed)" );
    _slhaInputDataStorage->AddLine( "SMINPUTS:24:1.275e+00:# mc(mc) (fixed)" );

    // Write block "MINPAR".

    _slhaInputDataStorage->AddBlock( "MINPAR:BLOCK MINPAR:# Input parameters" );

    // Write block "SPHENOINPUT".

    _slhaInputDataStorage->AddBlock( "SPHENOINPUT:BLOCK SPHENOINPUT:# SPheno specific input" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:1:0:# error level" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:2:0:# if 1, then SPA conventions are used" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:11:1:# calculate branching ratios" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:12:1.00000000E-04:# write only branching ratios larger than this value" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:21:0:# calculate cross section" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:22:1.000000e+03:# cms energy in GeV" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:23:0.000000e+00:# polarisation of incoming e- beam" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:24:0.000000e+00:# polarisation of incoming e+ beam" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:25:1:# ISR is calculated" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:26:1.00000000E-05:# write only cross sections larger than this value [fb]" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:31:-1.00000000E+00:# m_GUT, if < 0 than it determined via g_1=g_2" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:32:0:# require strict unification g_1=g_2=g_3 if '1' is set" );
    _slhaInputDataStorage->AddLine( "SPHENOINPUT:80:1:# SPheno exits with non-zero value for sure" );

    // Add parameter point dependent lines to block "MINPAR".

    for ( unsigned int i = 0; i < _lines.size(); i++ ) {

        _slhaInputDataStorage->AddLine( *_lines.at( i ) );

    }

}
