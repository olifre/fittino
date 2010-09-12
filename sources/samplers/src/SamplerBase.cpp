/* $Id: SamplerBase.cpp,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SamplerBase.cpp                                                  *
*                                                                              *
* Description Base class for Fittino parameter samplers                        *
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

#include "Configuration.h"
#include "Messenger.h"
#include "SamplerBase.h"

Fittino::SamplerBase::SamplerBase( ModelBase* model )
        : _chi2( 1e99 ),
          _iterationCounter( 0 ),
          _name( "" ),
          _model( model ) {

    _abortCriterium = Configuration::GetInstance()->GetSteeringParameter( "AbortCriterium", 1e-6 );
    _numberOfIterations = Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", 10000 );

}

Fittino::SamplerBase::~SamplerBase() {

}

void Fittino::SamplerBase::PerformSampling() {

    SamplerBase::InitializeSampler();
    SamplerBase::ExecuteSampler();
    SamplerBase::TerminateSampler();

}

void Fittino::SamplerBase::PrintStatus() const {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Actual best set of " << _model->GetName() << " parameters                     " << std::endl;
    std::cout << "                                                                                " << std::endl;

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

void Fittino::SamplerBase::ExecuteSampler() {

    Messenger* messenger = Messenger::GetInstance();

    messenger->InfoMessage( "--------------------------------------------------------------------------------" );
    messenger->InfoMessage( "                                                                                " );
    messenger->InfoMessage( "  Running " + _name                                                               );
    messenger->InfoMessage( "                                                                                " );

    while (  _chi2 > _abortCriterium && _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;

        _chi2 = _model->Evaluate();

        this->UpdateModel();

        SamplerBase::PrintStatus();

    }

}

void Fittino::SamplerBase::InitializeSampler() {

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Initializing " << _name                                                         << std::endl;
    std::cout << "                                                                                " << std::endl;

    SamplerBase::PrintConfiguration();

}

void Fittino::SamplerBase::PrintConfiguration() const {

    std::cout << "   Configuration                                                                " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "    Abort criterium              " << _abortCriterium                             << std::endl;
    std::cout << "    Number of Iterations         " << _numberOfIterations                         << std::endl;

    this->PrintSteeringParameters();

    std::cout << "                                                                                " << std::endl;

}

void Fittino::SamplerBase::PrintResult() const {

    Messenger* messenger = Messenger::GetInstance();

    messenger->InfoMessage( "--------------------------------------------------------------------------------" );
    messenger->InfoMessage( "                                                                                " );
    //messenger->InfoMessage( "  Optimization converged after " + _iterationCounter + " iterations             " );
    messenger->InfoMessage( "                                                                                " );

    std::cout << "--------------------------------------------------------------------------------" << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "  Optimization results                                                          " << std::endl;
    std::cout << "                                                                                " << std::endl;
    std::cout << "   Final set of " << _model->GetName() << " parameters                          " << std::endl;
    std::cout << "                                                                                " << std::endl;

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
    std::cout << "--------------------------------------------------------------------------------" << std::endl;

}

void Fittino::SamplerBase::TerminateSampler() const {

    Messenger* messenger = Messenger::GetInstance();

    messenger->InfoMessage( "--------------------------------------------------------------------------------" );
    messenger->InfoMessage( "                                                                                " );
    messenger->InfoMessage( "  Terminating " + _name                                                           );
    messenger->InfoMessage( "                                                                                " );

    SamplerBase::PrintResult();

}
