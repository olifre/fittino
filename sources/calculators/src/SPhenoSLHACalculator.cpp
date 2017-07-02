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
#include "InputFile.h"
#include "Database.h"
#include "PhysicsModel.h"
#include "SLHADataStorageBase.h"
#include "SLHALine.h"
#include "SLHAPrediction.h"
#include "SPhenoSLHACalculator.h"
#include "TimeoutExecutorException.h"
#include "SLHAFileException.h"

Fittino::SPhenoSLHACalculator::SPhenoSLHACalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : SLHACalculatorBase( model )//,
      //_executor( "./SPheno", "SPheno" )
      {

    _name               = "SPheno";
    _tag                = "SPheno";
    _slhaOutputFileName = ptree.get<std::string>("OutputFile");
          _inputFile = new InputFile( ptree.get_child("InputFile"), model );
          _slhaInputFileName  = _inputFile->GetName();


          std::string exename = "Executable";

#ifdef SPHENO_EXECUTABLE

    std::string executable = ptree.get<std::string>( exename, SPHENO_EXECUTABLE );

#else

    if ( ptree.count( exename ) == 0 ) {

        throw ConfigurationException( "SPheno was not found. Please set " + exename + " in the input file." );

    }

    std::string executable = ptree.get<std::string>( exename );

#endif

    _executor = new Executor( executable, "SPheno" );
    _executor->AddArgument( _slhaInputFileName );

    _executor->SetCompletionTimeout( 60 );

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

   // AddQuantity( new SLHAPrediction( "sinAlpha" , "", _slhaOutputDataStorage, "alpha", 0, "(any)", "# alpha", "", "" ) ); not in contained in output of SARAH_SPHENO

 //   AddQuantity( new SLHAPrediction( "BR_B_tau_nu"      , "", _slhaOutputDataStorage, "FlavorKitQFV", 1, "502", "", "", "" ) );


    AddQuantity( new SLHAPrediction( "HMIX_Q"      , "", _slhaOutputDataStorage, "HMIX", 3, "BLOCK", "", "", "" ) );
    AddQuantity( new SLHAPrediction( "HMIX_mu"     , "", _slhaOutputDataStorage, "HMIX", 1, "1", "", "", ""     ) );
 //   AddQuantity( new SLHAPrediction( "HMIX_TanBeta", "", _slhaOutputDataStorage, "HMIX", 1, "2", "", "", ""     ) );
    AddQuantity( new SLHAPrediction( "HMIX_VEV"    , "", _slhaOutputDataStorage, "HMIX", 1, "3", "", "", ""     ) );
  //  AddQuantity( new SLHAPrediction( "HMIX_m2A"    , "", _slhaOutputDataStorage, "HMIX", 1, "4", "", "", ""     ) );

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

    delete _inputFile;
    delete _executor;

}

void Fittino::SPhenoSLHACalculator::CalculatePredictions() {

    _inputFile->Write();

    try {

        _returnValue = _executor->Execute();

    }
    catch ( const TimeoutExecutorException& e ) {

        throw CalculatorException( _name, "Timeout" );

    }

    if ( _returnValue != 0 ) {

        throw  CalculatorException( _name, "Return value " + boost::lexical_cast<std::string>( _returnValue ) );

    }

    _slhaOutputDataStorage->Clear();
    try {
        
        _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );
    
    }
    catch ( const SLHAFileException& e ) {
        
        throw CalculatorException( _name, "Could not read SLHA File" );

    }

    for ( unsigned int i = 0; i < GetCollectionOfQuantities().GetNumberOfElements(); ++i ) {

        GetCollectionOfQuantities().At( i )->Update();

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


