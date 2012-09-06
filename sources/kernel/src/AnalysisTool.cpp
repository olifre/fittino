/* $Id: AnalysisTool.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

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
#include "Configuration.h"
#include "Messenger.h"
#include "ModelBase.h"

Fittino::AnalysisTool::AnalysisTool( ModelBase* model )
        : _abortCriterium( Configuration::GetInstance()->GetSteeringParameter( "AbortCriterium", 1e-6 ) ),
          _chi2( 1.e99 ),
          _iterationCounter( 0 ),
          _listOfLeaves( _model->GetNumberOfParameters() + 1, 0. ),
          _model( model ),
          _name( "" ),
          _numberOfIterations( Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", 10000 ) ),
          _outputFile( "Output.root", "RECREATE" ),
          _randomGenerator(),
          _tree( new TTree( "Tree", "Tree" ) ) {

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {

        _tree->Branch( ( ( _model->GetParameterVector() )[i].GetName() ).c_str(), &_listOfLeaves[i], ( ( _model->GetParameterVector() )[i].GetName() ).c_str() );

    }
    _tree->Branch( "Chi2", &_listOfLeaves[_model->GetNumberOfParameters()], "Chi2/F" );

}

Fittino::AnalysisTool::~AnalysisTool() {

}

void Fittino::AnalysisTool::PerformAnalysis() {

    AnalysisTool::InitializeAnalysisTool();
    AnalysisTool::ExecuteAnalysisTool();
    AnalysisTool::TerminateAnalysisTool();

}

void Fittino::AnalysisTool::FillStatus() {

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {

        _listOfLeaves[i] = ( _model->GetParameterVector() )[i].GetValue();

    }
    _listOfLeaves[_model->GetNumberOfParameters()] = _model->Evaluate();

    _tree->Fill();

}

void Fittino::AnalysisTool::ExecuteAnalysisTool() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "-------------------------------------------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Running the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    while (  _chi2 > _abortCriterium && _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;

        _chi2 = _model->Evaluate();

        AnalysisTool::PrintStatus();

        this->UpdateModel();

    }

}

void Fittino::AnalysisTool::InitializeAnalysisTool() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "-------------------------------------------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    AnalysisTool::PrintConfiguration();

}

void Fittino::AnalysisTool::PrintConfiguration() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "   Configuration" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Abort criterium              " << _abortCriterium << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations << Messenger::Endl;

    this->PrintSteeringParameters();

    messenger << Messenger::ALWAYS << Messenger::Endl;

}

void Fittino::AnalysisTool::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << "-------------------------------------------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "  Iteration step " << _iterationCounter << Messenger::Endl;

    _model->PrintStatus();

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << std::scientific << std::setprecision( 5 ) << "    Chi2    " << _chi2 << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

}

void Fittino::AnalysisTool::TerminateAnalysisTool() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "-------------------------------------------------------------------------------------" << Messenger::Endl;
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
