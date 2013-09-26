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
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
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
#include "Chi2ContributionBase.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "ParameterBase.h"
#include "PredictionBase.h"
#include "Observable.h"


Fittino::AnalysisTool::AnalysisTool( ModelBase* model )
    : _chi2( 1.e99 ),
      _iterationCounter( 0 ),
      _model( model ),
      _name( "" ),
      _outputFile( "Fittino.out.root", "RECREATE" ),
      _randomGenerator(),
      _tree( new TTree( "Tree", "Tree" ) ) {

    _statusParameterVector.push_back( new ParameterBase( "Chi2",             "#chi^2",           1.e99, 0., 100.  ) ),
                                      _statusParameterVector.push_back( new ParameterBase( "IterationCounter", "IterationCounter", 0,     0., 1.e10 ) );

}

Fittino::AnalysisTool::~AnalysisTool() {

}

void Fittino::AnalysisTool::PerformAnalysis() {

    AnalysisTool::InitializeAnalysisTool();
    AnalysisTool::ExecuteAnalysisTool();
    AnalysisTool::TerminateAnalysisTool();

}

int Fittino::AnalysisTool::GetNumberOfStatusParameters() const {

    return _statusParameterVector.size();

}

void Fittino::AnalysisTool::FillTree() {

    for ( unsigned int i = 0; i < _model->GetNumberOfChi2Contributions(); ++i ) {

        _leafVector[i] = _model->GetChi2ContributionVector()->at( i )->GetValue();

    }

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {

        _leafVector[i + _model->GetNumberOfChi2Contributions()] = _model->GetParameterVector()->at( i )->GetValue();

    }

    for ( unsigned int i = 0; i < _model->GetNumberOfPredictions(); ++i ) {

        _leafVector[i + _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters()] = _model->GetPredictionVector()->at( i )->GetValue();

    }

    for ( unsigned int i = 0; i < _model->GetNumberOfObservables(); ++i ) {

        _leafVector[i + _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters() + _model->GetNumberOfPredictions()] = _model->GetObservableVector()->at( i )->GetPrediction()->GetValue();

    }

    for ( unsigned int i = 0; i < GetNumberOfStatusParameters(); ++i ) {
        _leafVector[i + _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters() + _model->GetNumberOfPredictions() + _model->GetNumberOfObservables()] = GetStatusParameterVector()->at( i )->GetValue();

    }
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
    messenger << Messenger::INFO << std::scientific << std::setprecision( 2 ) << "    Sum                                         " << _model->GetChi2() << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

}

const std::vector<Fittino::ParameterBase*>* Fittino::AnalysisTool::GetStatusParameterVector() const {

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

    _leafVector = std::vector<double>( _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters() + _model->GetNumberOfPredictions() + _model->GetNumberOfObservables() + GetNumberOfStatusParameters() );

    for ( unsigned int i = 0; i < _model->GetNumberOfChi2Contributions(); ++i ) {

        _tree->Branch( _model->GetChi2ContributionVector()->at( i )->GetName().c_str(),
                       &_leafVector[i] );
        //_model->GetChi2ContributionVector()->at( i )->GetName().c_str() );

    }

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {

        _tree->Branch( _model->GetParameterVector()->at( i )->GetName().c_str(),
                       &_leafVector[i + _model->GetNumberOfChi2Contributions()] );
        //_model->GetParameterVector()->at( i )->GetName().c_str() );

    }

    for ( unsigned int i = 0; i < _model->GetNumberOfPredictions(); ++i ) {

        _tree->Branch( _model->GetPredictionVector()->at( i )->GetName().c_str(),
                       &_leafVector[i + _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters()] );
        //_model->GetPredictionVector()->at( i )->GetName().c_str() );

    }
    
    for ( unsigned int i = 0; i < _model->GetNumberOfObservables(); ++i ) {

        _tree->Branch( _model->GetObservableVector()->at( i )->GetPrediction()->GetName().c_str(),
                       &_leafVector[i + _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters() + _model->GetNumberOfPredictions()] );
        //_model->GetPredictionVector()->at( i )->GetName().c_str() );

    }

    for ( unsigned int i = 0; i < GetNumberOfStatusParameters(); ++i ) {

        _tree->Branch( GetStatusParameterVector()->at( i )->GetName().c_str(),
                       &_leafVector[i + _model->GetNumberOfChi2Contributions() + _model->GetNumberOfParameters() + _model->GetNumberOfPredictions() + _model->GetNumberOfObservables()] );
        //GetStatusParameterVector()->at( i )->GetName().c_str() );

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
