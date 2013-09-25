/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TreeCalculator.cpp                                               *
*                                                                              *
* Description Base class for SLHA compatible model calculators                 *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of       *
*	      the License, or (at your option) any later version.                  *
*                                                                              *
*******************************************************************************/

#include <stdlib.h>

#include <iostream>

#include "TTree.h"
#include "TFile.h"
#include "TObjArray.h"
#include "TLeaf.h"

#include "TreeCalculator.h"
#include "SimpleDataStorage.h"
#include "ConfigurationException.h"

Fittino::TreeCalculator::TreeCalculator( const PhysicsModelBase* model, std::string inputFileName, std::string inputTreeName )
    : ModelCalculatorBase( model ),
      _inputFile( new TFile( inputFileName.c_str() ) ) {

    _name = "TreeCalculator";
    _currentEntry = 0;

    try {
        if( !_inputFile ) {
            throw ConfigurationException( "Specified input file could not be opened." );
        }
        else if( !( _inputTree = ( TTree* )_inputFile->Get( inputTreeName.c_str() ) ) ) {
            throw ConfigurationException( "Specified input tree could not be retrieved from input file." );
        }
    }
    catch ( const ConfigurationException& configurationException ) {
        std::cout << "\n" << configurationException.what() << "\n" << std::endl;
        exit( EXIT_FAILURE );
    }

    FillSimpleDataStorage();
    SetAllBranchAddresses();

}

Fittino::TreeCalculator::~TreeCalculator() {

    delete _inputTree;
    _inputFile -> Close();
    delete _inputFile;

}


void Fittino::TreeCalculator::CalculatePredictions() {

    _inputTree->GetEntry( _currentEntry++ );

}



void Fittino::TreeCalculator::SetAllBranchAddresses() {

    for( std::map<std::string, double>::iterator itr = _simpleOutputDataStorage->GetMap()->begin(); itr != _simpleOutputDataStorage->GetMap()->end(); ++itr ) {

        _inputTree -> SetBranchAddress( ( *itr ).first.c_str(), &( *itr ).second );

    }
}

void Fittino::TreeCalculator::FillSimpleDataStorage() {

    TObjArray *arrayOfLeaves = _inputTree->GetListOfLeaves();

    for( unsigned int i = 0; i < arrayOfLeaves->GetEntries(); ++i ) {
        TLeaf *leaf = ( TLeaf* )arrayOfLeaves->At( i );
        if( !strcmp( leaf->GetTypeName(), "Double_t" ) ) {
            _simpleOutputDataStorage->AddEntry( std::string( leaf->GetName() ), 0. );
        }
    }

}
