/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AnalysisTool.cpp                                                 *
*                                                                              *
* Description Abstract class which provides basic functionality for analysis   *
*             tools like optimizers or samplers                                *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>

#include "TLeaf.h"
#include "TTree.h"

#include "AnalysisTool.h"
#include "ModelBase.h"
#include "RandomGenerator.h"
#include "CutBase.h"

Fittino::AnalysisTool::AnalysisTool( ModelBase *model, const boost::property_tree::ptree& ptree )
    : Tool                    ( model, ptree ),
      _writeAllModelQuantities( ptree.get<bool>        ( "WriteAllModelQuantities", true               ) ),
      _chi2Name               ( ptree.get<std::string> ( "Chi2Name",                "Chi2"             ) ),
      _iterationCounterName   ( ptree.get<std::string> ( "IterationCounterName",    "IterationCounter" ) ),
      _metaDataTreeName       ( ptree.get<std::string> ( "MetaDataTree",            "MetaDataTree"     ) ),
      _treeName               ( ptree.get<std::string> ( "OutputTree",              "Tree"             ) ),
      _metaDataTree           ( new TTree( _metaDataTreeName, _metaDataTreeName ) ),
      _tree                   ( new TTree( _treeName, _treeName ) ) {

    _chi2             = ptree.get<double>      ( "Chi2",             std::numeric_limits<double>::max() );
    _iterationCounter = ptree.get<unsigned int>( "IterationCounter", 0                                  );

    _statusParameterVector.push_back( new Quantity( _chi2Name,             "#chi^2",           _chi2,             0., 100.  ) );
    _statusParameterVector.push_back( new Quantity( _iterationCounterName, "IterationCounter", _iterationCounter, 0., 1.e10 ) );

    _randomGenerator = Fittino::RandomGenerator::GetInstance();

    BOOST_FOREACH( const boost::property_tree::ptree::value_type node, ptree ) {

        if ( node.first == "OutputModelQuantity" ) {

            _outputModelQuantities.push_back( node.second.data() );

        }
        else if ( node.first == "NoOutputModelQuantity" ) {

            _noOutputModelQuantities.push_back( node.second.data() );

        }

    }

}

Fittino::AnalysisTool::~AnalysisTool() {

    for ( unsigned int i = 0; i < _statusParameterVector.size(); ++i ) {

        delete _statusParameterVector[i];

    }

}

void Fittino::AnalysisTool::FillMetaDataTree() {

    _metaDataTree->Fill();

}

void Fittino::AnalysisTool::FillTree() {

    bool fillTree = true;
    for( unsigned int i = 0; i < _collectionOfCuts.GetNumberOfElements(); ++i ) {

        if( !_collectionOfCuts.At(i)->IsPassed() ) {

            fillTree = false;
            break;

        }

    }
    if( fillTree ) {
    
        _tree->Fill();
    
    }

}

void Fittino::AnalysisTool::PrintSteeringParameters() const {

    PrintItem( "Chi2Name",                     _chi2Name             );
    PrintItem( "InitialChi2Value",             _chi2                 );
    PrintItem( "IterationCounterName",         _iterationCounterName );
    PrintItem( "InitialIterationCounterValue", _iterationCounter     );
    PrintItem( "OutputTreeName",               _treeName             );
    PrintItem( "OutputMetaDataTreeName",       _metaDataTreeName     );

}

const std::vector<Fittino::Quantity*>* Fittino::AnalysisTool::GetStatusParameterVector() const {

    return &_statusParameterVector;

}

int Fittino::AnalysisTool::GetNumberOfStatusParameters() const {

    return _statusParameterVector.size();

}

void Fittino::AnalysisTool::AddBranch( TTree* tree, std::string name, const double& value ) {

    CheckUniqueness( tree, name );

    TBranch* branch = tree->Branch( name.c_str(), &const_cast<double&>( value )  );

    branch->GetLeaf( name.c_str() )->SetTitle( "" ) ;

}

void Fittino::AnalysisTool::AddBranch( TTree* tree, std::string name, const std::string& value ) {

    CheckUniqueness( tree, name );

    TBranch* branch = tree->Branch( name.c_str(), &const_cast<std::string&>( value )  );

    branch->GetLeaf( name.c_str() )->SetTitle( "" ) ;

}

void Fittino::AnalysisTool::CheckUniqueness( TTree* tree, std::string name ) const {

    TObjArray *arrayOfLeaves = tree->GetListOfLeaves();

    for ( unsigned int i = 0; i < arrayOfLeaves->GetEntries(); ++i ) {

        TLeaf *leaf = ( TLeaf* ) arrayOfLeaves->At( i );

        if ( leaf->GetName() == name ) {

            throw ConfigurationException( "Leaf name " + name + " already exists." );

        }

    }

}

void Fittino::AnalysisTool::InitializeBranches() {

    // First initialize the branches of the output tree.

    for ( unsigned int i = 0; i < _model->GetCollectionOfQuantities().GetNumberOfElements(); ++i ) {

        bool isOutputVariable = false;

        if ( _writeAllModelQuantities ) {

            isOutputVariable = true;

            for ( unsigned int j = 0; j < _noOutputModelQuantities.size(); ++j ) {

                if ( _model->GetCollectionOfQuantities().At( i )->GetName() == _noOutputModelQuantities.at( j ) ) {

                    isOutputVariable = false;
                    break;

                }

            }

            if ( !isOutputVariable ) {

                continue;

            }

            for ( unsigned int j = 0; j < GetNumberOfStatusParameters(); ++j ) {

                if ( _model->GetCollectionOfQuantities().At( i )->GetName() == GetStatusParameterVector()->at( j )->GetName() ) {

                    isOutputVariable = false;
                    Messenger& messenger = Messenger::GetInstance();
                    messenger << Messenger::ALWAYS
                              << "The ModelQuantity "
                              << _model->GetCollectionOfQuantities().At( i )->GetName()
                              << " will not be written to the output ntuple, because a StatusParameter with the same name exists."
                              << Messenger::Endl;
                    break;

                }

            }

            if ( !isOutputVariable ) {

                continue;

            }

        }
        else {

            for ( unsigned int j = 0; j < _outputModelQuantities.size(); ++j ) {

                if ( _outputModelQuantities.at( j ) == _model->GetCollectionOfQuantities().At( i )->GetName() ) {

                    isOutputVariable = true;
                    break;

                }

            }

        }

        if ( !isOutputVariable ) {

            continue;

        }

        AddBranch( _tree,
                   _model->GetCollectionOfQuantities().At( i )->GetName(),
                   _model->GetCollectionOfQuantities().At( i )->GetValue() );

    }

    for ( unsigned int i = 0; i < _model->GetCollectionOfStringVariables().GetNumberOfElements(); ++i ) {

        AddBranch( _tree,
                   _model->GetCollectionOfStringVariables().At( i )->GetName(),
                   _model->GetCollectionOfStringVariables().At( i )->GetValue() );

    }

    for ( unsigned int i = 0; i < GetNumberOfStatusParameters(); ++i ) {

        AddBranch( _tree,
                   GetStatusParameterVector()->at( i )->GetName(),
                   GetStatusParameterVector()->at( i )->GetValue() );

    }

    // Now initialize the branches of the meta data tree.

    for ( unsigned int i = 0; i < _model->GetCollectionOfMetaDataDoubleVariables().GetNumberOfElements(); ++i ) {

        AddBranch( _metaDataTree,
                   _model->GetCollectionOfMetaDataDoubleVariables().At( i )->GetName(),
                   _model->GetCollectionOfMetaDataDoubleVariables().At( i )->GetValue() );

    }

}

void Fittino::AnalysisTool::InitializeTool() {

    InitializeBranches();

}

void Fittino::AnalysisTool::WriteResultToFile() const {

    _tree->Write();
    _metaDataTree->Write();

}
