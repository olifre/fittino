/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SARAHSPhenoSLHACalculator.cpp                                         *
*                                                                              *
* Description Wrapper class for SPheno                                         *
*                                                                              *
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
#include <TMath.h>

#include "CalculatorException.h"
#include "InputFile.h"
#include "Database.h"
#include "PhysicsModel.h"
#include "SLHADataStorageBase.h"
#include "SLHALine.h"
#include "SLHAPrediction.h"
#include "SARAHSPhenoSLHACalculator.h"
#include "TimeoutExecutorException.h"
#include "SLHAFileException.h"

Fittino::SARAHSPhenoSLHACalculator::SARAHSPhenoSLHACalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
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

    AddQuantity( new SLHAPrediction( "BR_B_tau_nu"      , "", _slhaOutputDataStorage, "FlavorKitQFV", 1, "502", "", "", "" ) );

    _dsquarkPIDs = { 1000001, 1000003, 1000005, 2000001, 2000003, 2000005 };
    _dsquarkNames = { "~dL", "~sL", "~bL", "~dR", "~sR", "~bR"  };

    for ( const auto& name : _dsquarkNames ) {

        AddOutput( "Index_" + name );
        AddOutput( "Mass_" + name );
        AddOutput( "Fraction_" + name );

    }

}

Fittino::SARAHSPhenoSLHACalculator::~SARAHSPhenoSLHACalculator() {

    delete _inputFile;
    delete _executor;

}

void Fittino::SARAHSPhenoSLHACalculator::CalculatePredictions() {

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

    TestUnitarity();

    for( unsigned int j = 0; j < 6; j++ ) {

        DetermineMass("DSQMIX", _dsquarkPIDs, _dsquarkNames, j );

    }

}

void Fittino::SARAHSPhenoSLHACalculator::DetermineMass(std::string block, const std::vector<int> pids, std::vector<std::string> names, int j )  {


    int index = -1;
    double maxFraction = 0;
    double mass = 0;

    for (int i=0; i<6; ++i ) {

        double block_ij = _slhaOutputDataStorage->GetEntry( block, 2, std::to_string(i + 1), std::to_string(j + 1), "" , "" );
        double fraction = TMath::Power( block_ij, 2 );

        if( fraction > maxFraction ){

            index = i;
            maxFraction = fraction;


        }
        else if( fraction == maxFraction ){

            index = -1;

        }

    }

    if ( index >= 0 ) {

        int pid = pids.at(index);
        mass = _slhaOutputDataStorage->GetEntry("MASS", 1, std::to_string(pid), "", "", "");

    }


    std::string name = names.at( j );

    SetOutput( "Mass_" + name, mass  );
    SetOutput( "Index_" + name, index  );
    SetOutput( "Fraction_" + name, maxFraction  );

}

void Fittino::SARAHSPhenoSLHACalculator::AddBR( std::string mother, std::string daughter1, std::string daughter2 ) {

    Database& database = Database::GetInstance();
    std::string pid0 = database.GetPIDString( mother );
    std::string pid1 = database.GetPIDString( daughter1 );
    std::string pid2 = database.GetPIDString( daughter2 );

    std::string name = "BR_" + mother + "_to_" + daughter1 + "_" + daughter2;

    AddQuantity( new SLHAPrediction( name, "", 0, _slhaOutputDataStorage, pid0, 0, "(any)", "2", pid1, pid2 ) );

}

void Fittino::SARAHSPhenoSLHACalculator::AddMass( std::string particle ) {

    std::string name = "Mass_" + particle;

    Database& database = Database::GetInstance();
    std::string pid = database.GetPIDString( particle );

    AddQuantity( new SLHAPrediction( name , "GeV", _slhaOutputDataStorage, "MASS", 1, pid, "", "", "" ) );

}

void Fittino::SARAHSPhenoSLHACalculator::AddParticle( std::string particle ) {

    AddMass ( particle );
    AddWidth( particle );

}

void Fittino::SARAHSPhenoSLHACalculator::AddWidth( std::string particle ) {

    std::string name = "GammaTotal_" + particle;

    Database& database = Database::GetInstance();
    std::string pid = database.GetPIDString( particle );

    AddQuantity( new SLHAPrediction( name, "GeV", _slhaOutputDataStorage, pid, 2, "DECAY", "", "", "" ) );

}

void Fittino::SARAHSPhenoSLHACalculator::TestUnitarity() {

    for (int i=1; i<7; i=i+1 ) {

        double sum = 0;

        for (int j = 1; j < 7; j = j + 1) {

            sum += TMath::Power(
                    _slhaOutputDataStorage->GetEntry("DSQMIX", 2, std::to_string(i), std::to_string(j), "", ""), 2);

        }

        if (TMath::Abs(sum - 1) > 1e-4) {

            throw CalculatorException("SPheno", "SPHENO_NONUNITARITY_DSQMIX");

        }

    }

}
