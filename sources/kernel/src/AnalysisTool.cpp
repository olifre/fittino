/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AnalysisTool.h                                                   *
*                                                                              *
* Description Abstract class which provides basic functionality for analysis   *
*             tools like optimizers or samplers                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iomanip>
#include <iostream>
#include <sstream>

#include "TTree.h"

#include "AnalysisTool.h"
#include "Messenger.h"
#include "ModelBase.h"

Fittino::AnalysisTool::AnalysisTool( ModelBase* model )
        : _chi2( 1.e99 ),
          _iterationCounter( 0 ),
          _listOfLeaves( _model->GetNumberOfParameters() + _model->GetNumberOfPredictions() + 1, 0. ),
          _model( model ),
          _name( "" ),
          _outputFile( "Output.root", "RECREATE" ),
          _randomGenerator(),
          _tree( new TTree( "Tree", "Tree" ) ) {

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {

        _tree->Branch( ( _model->GetParameterVector()->at( i )->GetName() ).c_str(), &_listOfLeaves[i], ( _model->GetParameterVector()->at( i )->GetName() ).c_str() );

    }

    for ( unsigned int i = 0; i < _model->GetNumberOfPredictions(); ++i ) {

        _tree->Branch( ( _model->GetPredictionVector()->at( i )->GetName() ).c_str(), &_listOfLeaves[i + _model->GetNumberOfParameters()], ( _model->GetPredictionVector()->at( i )->GetName() ).c_str() );

    }

    _tree->Branch( "Chi2",             &_listOfLeaves[_model->GetNumberOfParameters() + _model->GetNumberOfPredictions()], "Chi2/F" );
    _tree->Branch( "IterationCounter", &_listOfLeaves[_model->GetNumberOfParameters() + _model->GetNumberOfPredictions() + 1], "IterationCounter/F" );

}

Fittino::AnalysisTool::~AnalysisTool() {

}

void Fittino::AnalysisTool::PerformAnalysis() {

    AnalysisTool::InitializeAnalysisTool();
    AnalysisTool::ExecuteAnalysisTool();
    AnalysisTool::TerminateAnalysisTool();

}

//std::vector<float> Fittino::AnalysisTool::GetLeafVector() const {
//
//    return _listOfLeaves;
//
//}

//TTree* Fittino::AnalysisTool::GetTree() {
//
//    return _tree;
//
//}

void Fittino::AnalysisTool::FillStatus() {

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {

        _listOfLeaves[i] = _model->GetParameterVector()->at( i )->GetValue();

    }

    for ( unsigned int i = 0; i < _model->GetNumberOfPredictions(); ++i ) {

        _listOfLeaves[i + _model->GetNumberOfParameters()] = _model->GetPredictionVector()->at( i )->GetPredictedValue();

    }

    _listOfLeaves[_model->GetNumberOfParameters() + _model->GetNumberOfPredictions()] = _model->GetChi2();
    _listOfLeaves[_model->GetNumberOfParameters() + _model->GetNumberOfPredictions() + 1] = _iterationCounter;

    _tree->Fill();

}

void Fittino::AnalysisTool::ExecuteAnalysisTool() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Running the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    this->Execute();

}

void Fittino::AnalysisTool::InitializeAnalysisTool() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    AnalysisTool::PrintConfiguration();

}

void Fittino::AnalysisTool::PrintConfiguration() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "   Configuration" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    this->PrintSteeringParameters();

    messenger << Messenger::ALWAYS << Messenger::Endl;

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
    messenger << Messenger::INFO << std::scientific << std::setprecision( 2 ) << "    Sum                                         " << _model->GetChi2() << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

}

void Fittino::AnalysisTool::TerminateAnalysisTool() {

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

}
