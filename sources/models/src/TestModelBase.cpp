/* $Id: TestModelBase.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TestModelBase.cpp                                                *
*                                                                              *
* Description Base class for Fittino test models                               *
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

#include "Messenger.h"
#include "TestModelBase.h"

Fittino::TestModelBase::TestModelBase() {

}

Fittino::TestModelBase::~TestModelBase() {

}

void Fittino::TestModelBase::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "  Set of " << _name << " parameters:" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

    for ( unsigned int i = 0; i < this->GetNumberOfParameters(); i++ ) {

        messenger << Messenger::INFO
	          << "    "
                  << std::left
                  << std::setw( 11 )
                  << _parameterVector[i]->GetName()
                  << std::right
                  << std::setw( 12 )
                  << std::setprecision( 5 )
                  << std::scientific
                  << _parameterVector[i]->GetValue()
		  << Messenger::Endl;

    }

}

void Fittino::TestModelBase::Initialize() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing the " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "   Initializing the list of model parameters" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    for ( unsigned int i = 0; i < _numberOfParameters; i++ ) {

        messenger << Messenger::ALWAYS
                  << "    "
                  << std::left
                  << std::setw( 19 )
                  << this->GetParameterVector()->at( i )->GetName()
                  << std::right
                  << std::setw( 12 )
                  << std::setprecision( 5 )
                  << std::scientific
                  << this->GetParameterVector()->at( i )->GetValue()
                  << Messenger::Endl;

    }

    messenger << Messenger::ALWAYS << Messenger::Endl;

}

double Fittino::TestModelBase::Evaluate() {

    return this->TestModelFunction();

}
