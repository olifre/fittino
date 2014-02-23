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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <stdlib.h>

#include <iostream>

#include <boost/property_tree/ptree.hpp>
#include <boost/foreach.hpp>

#include "TTree.h"
#include "TFile.h"
#include "TObjArray.h"
#include "TLeaf.h"

#include "TreeCalculator.h"
#include "SimpleDataStorage.h"
#include "ConfigurationException.h"
#include "PhysicsModel.h"
#include "ModelParameter.h"
#include "Factory.h"

Fittino::TreeCalculator::TreeCalculator( const PhysicsModel* model )
    : CalculatorBase( model ) {

    _name = "TreeCalculator";
    _inputFile = NULL;
    _inputFileName = "Fittino.old.root";
    _inputTreeName = "Tree";

}

Fittino::TreeCalculator::TreeCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ) {

    _name = "TreeCalculator";
    _inputFile = NULL;
    _inputFileName = ptree.get<std::string>( "InputFileName", "Fittino.old.root" ); 
    _inputTreeName = ptree.get<std::string>( "InputTreeName", "Tree" );
    
    
    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "ExcludeLeaf" ) {
           
           _excludedLeaves.push_back( node.second.get_value<std::string>() );
        
        }

    }
    
    OpenInputTree();
    CreateDefaultPredictions();

}

Fittino::TreeCalculator::~TreeCalculator() {

    delete _inputTree;
    _inputFile -> Close();
    delete _inputFile;

}


void Fittino::TreeCalculator::CalculatePredictions() {
    
    _inputTree->GetEntry( (int)(_model->GetCollectionOfParameters().At( 0 )->GetValue() ));

}

void Fittino::TreeCalculator::SetInputFileName( std::string inputFileName ) {

    _inputFileName = inputFileName;

}

void Fittino::TreeCalculator::SetInputTreeName( std::string inputTreeName ) {

    _inputTreeName = inputTreeName;

}

void Fittino::TreeCalculator::OpenInputTree() {

    _inputFile = new TFile( _inputFileName.c_str() );

    try {
        if( !_inputFile ) {
            throw ConfigurationException( "Specified input file could not be opened." );
        }
        else if( !( _inputTree = ( TTree* )_inputFile->Get( _inputTreeName.c_str() ) ) ) {
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


void Fittino::TreeCalculator::SetAllBranchAddresses() {

    for( std::map<std::string, double>::iterator itr = _simpleOutputDataStorage->GetMap()->begin(); itr != _simpleOutputDataStorage->GetMap()->end(); ++itr ) {

        _inputTree -> SetBranchAddress( ( *itr ).first.c_str(), &( *itr ).second );

    }
}

void Fittino::TreeCalculator::FillSimpleDataStorage() {

    TObjArray *arrayOfLeaves = _inputTree->GetListOfLeaves();

    for( unsigned int i = 0; i < arrayOfLeaves->GetEntries(); ++i ) {
        TLeaf *leaf = ( TLeaf* )arrayOfLeaves->At( i );
        if( !strcmp( leaf->GetTypeName(), "Double_t" ) || !strcmp( leaf->GetTypeName(), "Float_t") ) {
            _simpleOutputDataStorage->AddEntry( std::string( leaf->GetName() ), 0. );
        }
    }
    
}

void Fittino::TreeCalculator::Initialize() const {

}

void Fittino::TreeCalculator::CreateDefaultPredictions( ) {

    Factory factory;
    TObjArray *arrayOfLeaves = _inputTree->GetListOfLeaves();
    for( unsigned int i = 0; i < arrayOfLeaves->GetEntries(); ++i ) {
        TLeaf *leaf = ( TLeaf* )arrayOfLeaves->At( i );
        bool excludeLeaf = false;
        for( unsigned int j = 0; j < _excludedLeaves.size(); ++j ) {
            if( !strcmp( leaf->GetName(), _excludedLeaves.at(j).c_str() ) ) {
                excludeLeaf = true;
            }
        }
        if( excludeLeaf ) continue;

        if( !strcmp( leaf->GetTypeName(), "Double_t" ) ) {
            boost::property_tree::ptree ptree;
            ptree.put("Name", leaf->GetName() );
            ptree.put("PlotName", leaf->GetName() );
            ptree.put("Unit", "" );
            ptree.put("PlotUnit", "" );
            ptree.put("UpperBound", 10000. );
            ptree.put("LowerBound", -10000. );
            ptree.put("PredictionType", "Simple" );
            AddQuantity( factory.CreatePrediction( ptree, this ) ); 
        }
    }

}
