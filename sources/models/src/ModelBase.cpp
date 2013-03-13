/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.cpp                                                    *
*                                                                              *
* Description Base class for Fittino models                                    *
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

#include "Messenger.h"
#include "ModelBase.h"

Fittino::ModelBase::ModelBase()
        : _numberOfParameters( 0 ),
          _name( "" ) {

}

Fittino::ModelBase::~ModelBase() {

}

double Fittino::ModelBase::GetChi2() {

    if ( !_evaluated ) {

        _chi2 = Evaluate();
	_evaluated = true;
    
    }

    return _chi2;

}

int Fittino::ModelBase::GetNumberOfParameters() const {

    return _numberOfParameters;

}

std::string Fittino::ModelBase::GetName() const {

    return _name;

}

const std::vector<Fittino::ParameterBase*>* Fittino::ModelBase::GetParameterVector() const {

    return &_parameterVector;

}

std::vector<Fittino::ParameterBase*>* Fittino::ModelBase::SetParameterVector() {

    _evaluated=false;
    return &_parameterVector;

}

void Fittino::ModelBase::InitializeModel() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "-------------------------------------------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Initializing " << _name << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    ModelBase::PrintConfiguration();

}

void Fittino::ModelBase::PrintConfiguration() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "   Starting values" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    for ( unsigned int i = 0; i < _numberOfParameters; i++ ) {

        messenger << Messenger::ALWAYS
	          << "    "
                  << std::left
                  << std::setw( 11 )
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
