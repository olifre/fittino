/* $Id: SLHAeaSLHADataStorage.cpp 844 2011-01-10 13:52:15Z uhlenbrock $ */

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

#include "TString.h"

#include "PhysicsModelBase.h"
#include "SLHAFileException.h"
#include "SLHAeaSLHADataStorage.h"

Fittino::SLHAeaSLHADataStorage::SLHAeaSLHADataStorage() {

}

Fittino::SLHAeaSLHADataStorage::~SLHAeaSLHADataStorage() {

}

double Fittino::SLHAeaSLHADataStorage::GetEntry( const std::string& blockName, const int firstIndex, const int secondIndex ) {

    double entry = 0.;

    std::stringstream stringstream;
    stringstream << _slhaeaDataStorage[blockName][firstIndex][secondIndex];
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

void Fittino::SLHAeaSLHADataStorage::ReadFile( const TString& slhaInputFileName ) {

    std::ifstream file( slhaInputFileName );

    if ( file.is_open() ) {

        _slhaeaDataStorage = SLHAea::Coll( file );

    }
    else {

        throw SLHAFileException( "SLHA file could not be opened." );

    }

}

void Fittino::SLHAeaSLHADataStorage::WriteFile( const TString& slhaOutputFileName ) const {

    std::ofstream file( slhaOutputFileName.Data() );
    file << _slhaeaDataStorage;
    file.close();

}
