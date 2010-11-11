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

    Messenger* messenger = Messenger::GetInstance();

    messenger->PrintINFOMessage( "--------------------------------------------------------------------------------\n" );
    messenger->PrintINFOMessage( "\n" );
    messenger->PrintINFOMessage( "  Actual best set of " + _model->GetName() + " parameters\n" );
    messenger->PrintINFOMessage( "\n" );

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        std::cout << "    "
                  << std::left
                  << std::setw( 11 )
                  << std::setiosflags( std::ios::fixed )
                  << std::setprecision( 6 )
                  << ( *_model->GetParameterVector() )[i].GetName()
                  << std::right
                  << std::setw( 9 )
                  << ( *_model->GetParameterVector() )[i].GetValue()                                << std::endl;

    }

    std::cout << "                                                                                " << std::endl;
    std::cout << "    Chi2    " << _chi2                                                            << std::endl;
    std::cout << "                                                                                " << std::endl;

}

void Fittino::AnalysisTool::ExecuteAnalysisTool() {

    Messenger* messenger = Messenger::GetInstance();

    messenger->PrintINFOMessage( "--------------------------------------------------------------------------------\n" );
    messenger->PrintINFOMessage( "\n" );
    messenger->PrintINFOMessage( "  Running " + _name + "\n" );
    messenger->PrintINFOMessage( "\n" );

    while (  _chi2 > _abortCriterium && _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;

        _chi2 = _model->Evaluate();

        AnalysisTool::PrintStatus();

        this->UpdateModel();

    }

}

void Fittino::AnalysisTool::InitializeAnalysisTool() const {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Initializing " << _name                                                         << std::endl;
    std::cout << "                                                                                " << std::endl;

    AnalysisTool::PrintConfiguration();

}

void Fittino::AnalysisTool::PrintConfiguration() const {

    std::cout << "   Configuration                                                                " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    Abort criterium              " << _abortCriterium                             << std::endl;
    std::cout << "    Number of iterations         " << _numberOfIterations                         << std::endl;

    this->PrintSteeringParameters();

    std::cout << "                                                                                " << std::endl;

}

void Fittino::AnalysisTool::TerminateAnalysisTool() const {

    Messenger* messenger = Messenger::GetInstance();

    messenger->PrintINFOMessage( "--------------------------------------------------------------------------------\n" );
    messenger->PrintINFOMessage( "\n" );
    messenger->PrintINFOMessage( "  Terminating " + _name + "\n" );
    messenger->PrintINFOMessage( "\n" );

    this->PrintResult();

}
