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

#include "AnalysisTool.h"
#include "Configuration.h"
#include "Messenger.h"

Fittino::AnalysisTool::AnalysisTool( ModelBase* model )
        : _chi2( 1e99 ),
          _iterationCounter( 0 ),
          _name( "" ),
          _model( model ) {

    _abortCriterium = Configuration::GetInstance()->GetSteeringParameter( "AbortCriterium", 1e-6 );
    _numberOfIterations = Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", 10000 );

}

Fittino::AnalysisTool::~AnalysisTool() {

}

void Fittino::AnalysisTool::PerformAnalysis() {

    AnalysisTool::InitializeAnalysisTool();
    AnalysisTool::ExecuteAnalysisTool();
    AnalysisTool::TerminateAnalysisTool();

}

void Fittino::AnalysisTool::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << "--------------------------------------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "  Actual best set of " << _model->GetName() << " parameters" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        messenger << Messenger::INFO
	          << "    "
                  << std::left
                  << std::setw( 11 )
                  << ( *_model->GetParameterVector() )[i].GetName()
                  << std::right
                  << std::setw( 9 )
                  << ( *_model->GetParameterVector() )[i].GetValue()
		  << Messenger::Endl;

    }

    messenger << Messenger::INFO << "                                                                                " << Messenger::Endl;
    messenger << Messenger::INFO << "    Chi2    " << _chi2                                                            << Messenger::Endl;
    messenger << Messenger::INFO << "                                                                                " << Messenger::Endl;

}

void Fittino::AnalysisTool::ExecuteAnalysisTool() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << "--------------------------------------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "  Running " << _name << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

    while (  _chi2 > _abortCriterium && _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;

        _chi2 = _model->Evaluate();

        AnalysisTool::PrintStatus();

        this->UpdateModel();

    }

}

void Fittino::AnalysisTool::InitializeAnalysisTool() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "--------------------------------------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::ALWAYS << "                                                                                " << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing " << _name                                                         << Messenger::Endl;
    messenger << Messenger::ALWAYS << "                                                                                " << Messenger::Endl;

    AnalysisTool::PrintConfiguration();

}

void Fittino::AnalysisTool::PrintConfiguration() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "   Configuration                                                                " << Messenger::Endl;
    messenger << Messenger::ALWAYS << "                                                                                " << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Abort criterium              " << _abortCriterium                             << Messenger::Endl;
    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations                         << Messenger::Endl;

    this->PrintSteeringParameters();

    messenger << Messenger::ALWAYS << "                                                                                " << Messenger::Endl;

}

void Fittino::AnalysisTool::TerminateAnalysisTool() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << "--------------------------------------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "  Terminating " << _name << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

    this->PrintResult();

}
