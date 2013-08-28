/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAeaSLHADataStorage.cpp                                        *
*                                                                              *
* Description Wrapper class for SLHAea SLHA data storages                      *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <fstream>

#include "PhysicsModelBase.h"
#include "SLHAFileException.h"
#include "SLHAeaSLHADataStorage.h"

Fittino::SLHAeaSLHADataStorage::SLHAeaSLHADataStorage() {

}

Fittino::SLHAeaSLHADataStorage::~SLHAeaSLHADataStorage() {

}

double Fittino::SLHAeaSLHADataStorage::GetEntry( const std::string& blockName, const std::string& firstIndex, const int secondIndex ) {

    double entry = 0.;

    std::stringstream stringstream;
    stringstream << _slhaeaDataStorage.at( blockName ).at( firstIndex ).at( secondIndex );
    stringstream >> entry;

    return entry;

}

double Fittino::SLHAeaSLHADataStorage::GetEntry( const std::string& blockName, const std::string& firstIndex, const std::string& secondIndex, const int thirdIndex ) {

    double entry = 0.;

    std::stringstream stringstream;
    stringstream << _slhaeaDataStorage.at( blockName ).at( firstIndex, secondIndex ).at( thirdIndex );
    stringstream >> entry;

    return entry;

}

void Fittino::SLHAeaSLHADataStorage::AddBlock( const std::string& path ) {

    std::string blockName = path.substr( 0, path.find_first_of( ":" ) );

    std::string tmpPath( path );
    std::stringstream tmpStream;

    while ( tmpPath.find_first_of( ":" ) <= tmpPath.length() ) {

        tmpPath.erase( 0, tmpPath.find_first_of( ":" ) + 1 );
        tmpStream << tmpPath.substr(0, tmpPath.find_first_of( ":" ) );
 
    }

    SLHAea::Block block(tmpStream);

    _slhaeaDataStorage[blockName] = block;

}

void Fittino::SLHAeaSLHADataStorage::AddLine( const std::string& path ) {

    // This function creates a new SLHA line within an existing SLHA block. The individual data
    // fields of this line, represented by a colon-seperated string named "path", are passed as the
    // argument.

    // Create a new line.

    SLHAea::Line line;

    // Extract the name of the SLHA block, which should be the first entry in the list of
    // colon-seperated strings.

    std::string blockName = path.substr( 0, path.find_first_of( ":" ) );

    // Copy the input path and strip the first entry. The next entry is then added to the line.
    // Continue until no further colons are found.

    std::string tmpPath( path );

    while ( tmpPath.find_first_of( ":" ) <= tmpPath.length() ) {

        tmpPath.erase( 0, tmpPath.find_first_of( ":" ) + 1 );
        line << tmpPath.substr(0, tmpPath.find_first_of( ":" ) );
 
    }

    _slhaeaDataStorage[blockName][""] << line;

}

void Fittino::SLHAeaSLHADataStorage::ReadFile( const std::string& slhaInputFileName ) {

    std::ifstream file( slhaInputFileName.c_str() );

    if ( file.is_open() ) {

        _slhaeaDataStorage = SLHAea::Coll( file );

    }
    else {

        throw SLHAFileException( "SLHA file could not be opened." );

    }

}

void Fittino::SLHAeaSLHADataStorage::WriteFile( const std::string& slhaOutputFileName ) const {

    std::ofstream file( slhaOutputFileName.c_str() );
    file << _slhaeaDataStorage;
    file.close();

}