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

Fittino::TreeCalculator::TreeCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase         ( model ),
      _numberOfTreeIterations( 0. ),
      _inputFileName         ( ptree.get<std::string>( "InputFileName", "Fittino.old.root" ) ),
      _excludeAllLeaves      ( ptree.get<bool>( "ExcludeAllLeaves", false ) ),
      _inputFile             ( 0 ),
      _inputTree             ( 0 ) {

    _name = "TreeCalculator";

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "ExcludeLeaf" ) {

            _excludedLeaves.push_back( node.second.get_value<std::string>() );

        }
        else if ( node.first == "IncludeLeaf" ) {

            _includedLeaves.push_back( node.second.get_value<std::string>() );

        }
        else if ( node.first == "ExchangeLeaf" ) {
            
            std::stringstream leafNames;
            leafNames << node.second.get_value<std::string>();
            std::string oldName, newName;
            leafNames >> oldName >> std::ws >> newName;
            _exchangeLeaves.push_back( std::pair<std::string,std::string>(oldName, newName ) );

        }
        else if ( node.first == "InputTreeName" ) {

            _inputTreeName.push_back( node.second.get_value<std::string>() );

        }

    }

    if ( _inputTreeName.empty() ) {

        _inputTreeName.push_back( "Tree" );

    }

    OpenInputFile();
    AddPredictions();
    CalculatePredictions();

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

    TIterator *iter = _inputTree->GetIteratorOnAllLeaves();

    while ( TObject* obj = ( *iter )() ) {

        TLeaf *leaf = ( TLeaf* ) obj;

        bool excludeLeaf = false;

        for ( unsigned int j = 0; j < _excludedLeaves.size(); ++j ) {

            if ( !strcmp( leaf->GetName(), _excludedLeaves.at( j ).c_str() ) ) {

                excludeLeaf = true;

            }

        }

        if ( _excludeAllLeaves ) excludeLeaf = true;

        for ( unsigned int j = 0; j < _includedLeaves.size(); ++j ) {

            if ( !strcmp( leaf->GetName(), _includedLeaves.at( j ).c_str() ) ) {

                excludeLeaf = false;

            }

        }

        if ( excludeLeaf ) continue;

        if ( !strcmp( leaf->GetTypeName(), "Double_t" ) ) {

            _predictionMap.insert( std::make_pair( leaf->GetName(), 0. ) );
            _inputTree->SetBranchStatus( leaf->GetName(), 1 ) ;
            _inputTree->SetBranchAddress( leaf->GetName(), &_predictionMap.at( leaf->GetName() ) );

            bool exchangeLeaf = false;
            std::string newName;
            for( unsigned int j = 0; j < _exchangeLeaves.size(); ++j ) {
                
                if( !strcmp( leaf->GetName(), _exchangeLeaves.at(j).first.c_str() ) ) {
                    
                    exchangeLeaf = true;
                    newName = _exchangeLeaves.at(j).second;

                }
            }
           
            if( exchangeLeaf ) {
                std::cout << "replacing " << leaf->GetName() << " with " << newName << std::endl;
                AddQuantity( new SimplePrediction( newName.c_str(), "", _predictionMap.at( leaf->GetName() ) ) );               
            }
            else {
                AddQuantity( new SimplePrediction( leaf->GetName(), "", _predictionMap.at( leaf->GetName() ) ) );
            }

        }

    }

    _numberOfTreeIterations = _inputTree->GetEntries();
    AddQuantity( new SimplePrediction( "TreeIterations", "", _numberOfTreeIterations ) );

}

void Fittino::TreeCalculator::OpenInputFile() {

    _inputTree = new TChain( _inputTreeName.at( 0 ).c_str() );
    _inputTree->Add( _inputFileName.c_str() );

    for ( unsigned int i = 1; i < _inputTreeName.size(); i++ ) {

        TChain* chain = new TChain( _inputTreeName.at( i ).c_str() );
        chain->Add( _inputFileName.c_str() );
        _inputTree->AddFriend( chain );

    }

    _inputTree->SetBranchStatus( "*", 0 ) ;

}
