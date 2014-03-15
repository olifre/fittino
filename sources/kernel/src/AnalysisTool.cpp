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

#include "TTree.h"
#include "TLeaf.h"

#include "AnalysisTool.h"
#include "ModelBase.h"
#include "Observable.h"

Fittino::AnalysisTool::AnalysisTool( ModelBase *model, const boost::property_tree::ptree& ptree )
    : _chi2( ptree.get<double>( "Chi2", 1.e99 ) ),
      _iterationCounter( ptree.get<unsigned int>( "IterationCounter", 0 ) ),
      _name( ptree.get<std::string>( "Name", "" ) ),
      _model( model ),
      _outputFile( ( ptree.get<std::string>( "OutputFile", "Fittino.out.root" ) ).c_str(), "RECREATE" ),
      _randomGenerator( ptree.get<int>( "RandomSeed", 0 ) ),
      _metaDataTree( new TTree( ( ptree.get<std::string>( "MetaDataTree", "MetaDataTree" ) ).c_str(), ( ptree.get<std::string>( "MetaDataTree", "MetaDataTree" ) ).c_str() ) ),
      _tree( new TTree( ( ptree.get<std::string>( "OutputTree", "Tree" ) ).c_str(), ( ptree.get<std::string>( "OutputTree", "Tree" ) ).c_str() ) ) {

    _statusParameterVector.push_back( new Quantity( "Chi2",             "#chi^2",           _chi2,             0., 100.  ) );
    _statusParameterVector.push_back( new Quantity( "IterationCounter", "IterationCounter", _iterationCounter, 0., 1.e10 ) );

    _ptree = ptree;

}

Fittino::AnalysisTool::~AnalysisTool() {

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

void Fittino::AnalysisTool::AddBranch( TTree* tree, std::string name, std::string type,  const void* address ) {

    TObjArray *arrayOfLeaves = tree->GetListOfLeaves();

    for( unsigned int i = 0; i < arrayOfLeaves->GetEntries(); ++i ) {

        TLeaf *leaf = ( TLeaf* ) arrayOfLeaves->At( i );

        if( leaf->GetName() == name ) {

            throw ConfigurationException("Leaf name already exists.");

        }

    }

     TBranch* branch = tree->Branch( name.c_str(), const_cast<void*>( address ), ( name + "/" + type ).c_str() );

    branch->GetLeaf( name.c_str() )->SetTitle( "" );

}

int Fittino::AnalysisTool::GetNumberOfStatusParameters() const {

    return _statusParameterVector.size();

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

void Fittino::AnalysisTool::UpdatePropertyTree() {

    _ptree.put( "Chi2", _chi2 );
    _ptree.put( "IterationCounter", _iterationCounter );

}

const std::vector<Fittino::Quantity*>* Fittino::AnalysisTool::GetStatusParameterVector() const {

    return &_statusParameterVector;

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
                   "D",
                   &_model->GetCollectionOfQuantities().At( i )->GetValue() );
    }

    for ( unsigned int i = 0; i < _model->GetCollectionOfStringVariables().GetNumberOfElements(); ++i ) {

        AddBranch( _tree,
                  _model->GetCollectionOfStringVariables().At( i )->GetName(),
                  "C",
                  &_model->GetCollectionOfStringVariables().At( i )->GetValue() );
    }

    for ( unsigned int i = 0; i < _model->GetCollectionOfChi2Contributions().GetNumberOfElements(); ++i ) {

        AddBranch( _tree,
                  _model->GetCollectionOfChi2Contributions().At( i )->GetName(),
                  "D",
                  &_model->GetCollectionOfChi2Contributions().At( i )->GetValue() );
    }

    for ( unsigned int i = 0; i < GetNumberOfStatusParameters(); ++i ) {

        AddBranch( _tree, 
                  GetStatusParameterVector()->at( i )->GetName(),
                  "D",
                  &GetStatusParameterVector()->at( i )->GetValue() );
    }

    // Now initialize the branches of the meta data tree.

    if ( _model->GetObservableVector() ) {

        for ( unsigned int i = 0; i < _model->GetObservableVector()->size(); ++i ) {

            std::string measuredValueBranchName = "measuredValue_" + _model->GetObservableVector()->at( i )->GetPrediction()->GetName();
            std::string uncertaintyBranchName = "uncertainty_" + _model->GetObservableVector()->at( i )->GetPrediction()->GetName();

            AddBranch( _metaDataTree, 
                      measuredValueBranchName,
                      "D",
                      & _model->GetObservableVector()->at( i )->GetMeasuredValue() );

            AddBranch( _metaDataTree, 
                      uncertaintyBranchName,
                      "D",
                      & _model->GetObservableVector()->at( i )->GetMeasuredError() );

        }

    }

}

void Fittino::AnalysisTool::PrintConfiguration() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "   Configuration" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

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

    _outputFile.Close();

}

void Fittino::AnalysisTool::WriteResultToFile() const {

    _tree->Write();
    _metaDataTree->Write();

}
