/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TreeCalculator.cpp                                               *
*                                                                              *
* Description Class for a tree calculator                                      *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>

#include "TChain.h"
#include "TFile.h"
#include "TLeaf.h"
#include "TObjArray.h"

#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "ReferenceVariable.h"
#include "SimplePrediction.h"
#include "TreeCalculator.h"

Fittino::TreeCalculator::TreeCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase         ( model ),
      _numberOfTreeIterations( 0. ),
      _inputFileName         ( ptree.get<std::string>( "InputFileName", "Fittino.old.root" ) ),
      _inputTreeName         ( ptree.get<std::string>( "InputTreeName", "Tree"             ) ),
      _inputFile             ( 0 ),
      _inputTree             ( 0 ) {

    _name = "TreeCalculator";

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "ExcludeLeaf" ) {

            _excludedLeaves.push_back( node.second.get_value<std::string>() );

        }

    }

    OpenInputFile();
    AddPredictions();

}

Fittino::TreeCalculator::~TreeCalculator() {

    delete _inputTree;

    _inputFile->Close();

    delete _inputFile;

}

void Fittino::TreeCalculator::CalculatePredictions() {

    _inputTree->GetEntry( ( int )( _model->GetCollectionOfParameters().At( 0 )->GetValue() ) );

}

void Fittino::TreeCalculator::AddPredictions( ) {

    TObjArray *arrayOfLeaves = _inputTree->GetListOfLeaves();

    for ( unsigned int i = 0; i < arrayOfLeaves->GetEntries(); ++i ) {

        TLeaf *leaf = ( TLeaf* )arrayOfLeaves->At( i );

        bool excludeLeaf = false;

        for ( unsigned int j = 0; j < _excludedLeaves.size(); ++j ) {

            if ( !strcmp( leaf->GetName(), _excludedLeaves.at( j ).c_str() ) ) {

                excludeLeaf = true;

            }

        }

        if ( excludeLeaf ) continue;

        if ( !strcmp( leaf->GetTypeName(), "Double_t" ) ) {

            _predictionMap.insert( std::make_pair( leaf->GetName(), 0. ) );

            _inputTree->SetBranchAddress( leaf->GetName(), &_predictionMap.at( leaf->GetName() ) );

            AddQuantity( new SimplePrediction( leaf->GetName(), "", _predictionMap.at( leaf->GetName() ) ) );

        }
        else if ( !strcmp( leaf->GetTypeName(), "string" ) ) {

            _strings.insert( std::make_pair( leaf->GetName(), new std::string() ) );

            _inputTree->SetBranchAddress( leaf->GetName(), &_strings.at( leaf->GetName() ) );

            AddStringVariable( new ReferenceVariable<std::string> ( leaf->GetName(),  *_strings.at( leaf->GetName() ) ) );

        }

    }

    _numberOfTreeIterations = _inputTree->GetEntries();
    AddQuantity( new SimplePrediction( "TreeIterations", "", _numberOfTreeIterations ) );

}

void Fittino::TreeCalculator::OpenInputFile() {

    _inputTree = new TChain( _inputTreeName.c_str() );
    _inputTree->Add( _inputFileName.c_str() );

}
