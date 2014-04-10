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

#include "TFile.h"
#include "TLeaf.h"
#include "TTree.h"

#include "AnalysisTool.h"
#include "ModelBase.h"

Fittino::AnalysisTool::AnalysisTool( ModelBase *model, const boost::property_tree::ptree& ptree )
    : _chi2                ( ptree.get<double>      ( "Chi2",                 std::numeric_limits<double>::max() ) ),
      _iterationCounter    ( ptree.get<unsigned int>( "IterationCounter",     0                                  ) ),
      _name                ( ptree.get<std::string> ( "Name",                 ""                                 ) ),
      _model               ( model ),
      _randomSeed          ( ptree.get<unsigned int>( "RandomSeed",           0                                  ) ),
      _chi2Name            ( ptree.get<std::string> ( "Chi2Name",             "Chi2"                             ) ),
      _iterationCounterName( ptree.get<std::string> ( "IterationCounterName", "IterationCounter"                 ) ),
      _ptree               ( ptree ),
      _metaDataTreeName    ( ptree.get<std::string> ( "MetaDataTree",         "MetaDataTree"                     ) ),
      _outputFileName      ( ptree.get<std::string> ( "OutputFile",           "Fittino.out.root"                 ) ),
      _treeName            ( ptree.get<std::string> ( "OutputTree",           "Tree"                             ) ),
      _outputFile          ( new TFile( _outputFileName, "RECREATE" ) ),
      _metaDataTree        ( new TTree( _metaDataTreeName, _metaDataTreeName ) ),
      _randomGenerator     ( _randomSeed ),
      _tree                ( new TTree( _treeName, _treeName ) ) {

    _statusParameterVector.push_back( new Quantity( _chi2Name,             "#chi^2",           _chi2,             0., 100.  ) );
    _statusParameterVector.push_back( new Quantity( _iterationCounterName, "IterationCounter", _iterationCounter, 0., 1.e10 ) );

}

Fittino::AnalysisTool::~AnalysisTool() {

    for ( unsigned int i = 0; i < _statusParameterVector.size(); ++i ) {

        delete _statusParameterVector[i];

    }

}

void Fittino::AnalysisTool::PerformAnalysis() {

    AnalysisTool::InitializeAnalysisTool();
    AnalysisTool::ExecuteAnalysisTool();
    AnalysisTool::TerminateAnalysisTool();

}

boost::property_tree::ptree Fittino::AnalysisTool::GetPropertyTree() {

    UpdatePropertyTree();
    return _ptree;

}

void Fittino::AnalysisTool::FillMetaDataTree() {

    _metaDataTree->Fill();

}

void Fittino::AnalysisTool::FillTree() {

    _tree->Fill();

}

void Fittino::AnalysisTool::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "  Iteration step " << _iterationCounter << Messenger::Endl;

    _model->PrintStatus();

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << std::scientific << "    ----------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 43 )
              << "Total chi2"
              << std::right
              << std::setw( 9 )
              << std::setprecision( 2 )
              << std::scientific
              << _model->GetChi2() << Messenger::Endl;

    messenger << Messenger::INFO << Messenger::Endl;

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

void Fittino::AnalysisTool::CheckUniqueness(TTree* tree, std::string name ) const {


    TObjArray *arrayOfLeaves = tree->GetListOfLeaves();

    for ( unsigned int i = 0; i < arrayOfLeaves->GetEntries(); ++i ) {

        TLeaf *leaf = ( TLeaf* ) arrayOfLeaves->At( i );

        if ( leaf->GetName() == name ) {

            throw ConfigurationException( "Leaf name " + name + " already exists." );

        }

    }

}

void Fittino::AnalysisTool::ExecuteAnalysisTool() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Running the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    this->Execute();

}

void Fittino::AnalysisTool::InitializeAnalysisTool() {

    InitializeBranches();

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    AnalysisTool::PrintConfiguration();

}

void Fittino::AnalysisTool::InitializeBranches() {

    // First initialize the branches of the output tree.

    for ( unsigned int i = 0; i < _model->GetCollectionOfQuantities().GetNumberOfElements(); ++i ) {

        AddBranch( _tree,
                   _model->GetCollectionOfQuantities().At( i )->GetName(),
                   _model->GetCollectionOfQuantities().At( i )->GetValue() );

    }

    for ( unsigned int i = 0; i < _model->GetCollectionOfStringVariables().GetNumberOfElements(); ++i ) {

        AddBranch( _tree,
                   _model->GetCollectionOfStringVariables().At( i )->GetName(),
                   _model->GetCollectionOfStringVariables().At( i )->GetValue() );

    }

    for ( unsigned int i = 0; i < _model->GetCollectionOfChi2Contributions().GetNumberOfElements(); ++i ) {

        AddBranch( _tree,
                   _model->GetCollectionOfChi2Contributions().At( i )->GetName(),
                   _model->GetCollectionOfChi2Contributions().At( i )->GetValue() );

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

void Fittino::AnalysisTool::PrintConfiguration() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "   Configuration" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    PrintItem( "Chi2Name",                     _chi2Name             );
    PrintItem( "InitialChi2Value",             _chi2                 );
    PrintItem( "RandomSeed",                   _randomSeed           );
    PrintItem( "OutputFileName",               _outputFileName       );
    PrintItem( "OutputTreeName",               _treeName             );
    PrintItem( "OutputMetaDataTreeName",       _metaDataTreeName     );
    PrintItem( "IterationCounterName",         _iterationCounterName );
    PrintItem( "InitialIterationCounterValue", _iterationCounter     );

    this->PrintSteeringParameters();

    messenger << Messenger::ALWAYS << Messenger::Endl;

}

void Fittino::AnalysisTool::TerminateAnalysisTool() {

    this->Terminate();

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Terminating the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    this->PrintResult();

    this->WriteResultToFile();

    _outputFile->Close();

}

void Fittino::AnalysisTool::UpdatePropertyTree() {

    _ptree.put( "Chi2", _chi2 );
    _ptree.put( "IterationCounter", _iterationCounter );

}

void Fittino::AnalysisTool::WriteResultToFile() const {

    _tree->Write();
    _metaDataTree->Write();

}
