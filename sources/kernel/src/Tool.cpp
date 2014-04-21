/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Tool.cpp                                                         *
*                                                                              *
* Description Abstract class which provides basic functionality for analysis   *
*             tools like optimizers or samplers                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TFile.h"

#include "Tool.h"
#include "ModelBase.h"

Fittino::Tool::Tool( ModelBase *model, const boost::property_tree::ptree& ptree )
    : _chi2            ( std::numeric_limits<double>::max() ),
      _iterationCounter( 0 ),
      _name            ( ptree.get<std::string> ( "Name", "" ) ),
      _model           ( model ),
      _ptree           ( ptree ),
      _outputFileName  ( ptree.get<std::string> ( "OutputFile", "Fittino.out.root" ) ),
      _outputFile      ( new TFile( _outputFileName, "RECREATE" ) ) {

}

Fittino::Tool::~Tool() {

}

void Fittino::Tool::PerformTask() {

    InitializeTool();

    Messenger& messenger = Messenger::GetInstance();

    //messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    Tool::PrintConfiguration();

    ExecuteTool();
    TerminateTool();

}

boost::property_tree::ptree Fittino::Tool::GetPropertyTree() {

    UpdatePropertyTree();
    return _ptree;

}

void Fittino::Tool::PrintStatus() const {

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

void Fittino::Tool::ExecuteTool() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Running the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    this->Execute();

}

void Fittino::Tool::PrintConfiguration() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "   Configuration" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    PrintItem( "OutputFileName", _outputFileName );

    this->PrintSteeringParameters();

    messenger << Messenger::ALWAYS << Messenger::Endl;

}

void Fittino::Tool::TerminateTool() {

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

void Fittino::Tool::UpdatePropertyTree() {

    _ptree.put( "Chi2", _chi2 );
    _ptree.put( "IterationCounter", _iterationCounter );

}
