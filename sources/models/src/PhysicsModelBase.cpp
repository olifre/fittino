/* $Id: PhysicsModelBase.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsModelBase.cpp                                             *
*                                                                              *
* Description Base class for Fittino physics models                            *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>
#include <iomanip>

#include "Messenger.h"
#include "ObservableBase.h"
#include "PhysicsModelBase.h"
//#include "SLHAeaSLHAFileHandler.h"

Fittino::PhysicsModelBase::PhysicsModelBase() {

}

Fittino::PhysicsModelBase::~PhysicsModelBase() {

}

double Fittino::PhysicsModelBase::Evaluate() {

    PhysicsModelBase::UpdateSLHAConfiguration();
    PhysicsModelBase::UpdateObservablePredictions();
    return PhysicsModelBase::CalculateChi2();

}

void Fittino::PhysicsModelBase::PrintStatus() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << "-------------------------------------------------------------------------------------" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "  Set of the " << this->GetName() << " parameters:" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

    for ( unsigned int i = 0; i < this->GetNumberOfParameters(); i++ ) {

        messenger << Messenger::INFO
	          << "    "
                  << std::left
                  << std::setw( 11 )
                  << _parameterVector[i].GetName()
                  << std::right
                  << std::setw( 12 )
                  << std::setprecision( 5 )
                  << std::scientific
                  << _parameterVector[i].GetValue()
		  << Messenger::Endl;

    }

    messenger << Messenger::Endl;
    messenger << Messenger::INFO << "  Summary of the " << this->GetName() << " predictions:"  << Messenger::Endl;
    messenger << Messenger::Endl;
    messenger << Messenger::INFO << "    Observable          Predicted value                 Measured value    Deviation" << Messenger::Endl;
    messenger << Messenger::Endl;

    for ( unsigned int i = 0; i < _observableVector.size(); i++ ) {

        _observableVector[i]->PrintStatus();

    }

}

double Fittino::PhysicsModelBase::CalculateChi2() {

    double chi2 = 1.e99;

    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        chi2 += _observableVector[i]->GetChi2();

    }

    return chi2;

}

void Fittino::PhysicsModelBase::UpdateObservablePredictions() {

    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        _observableVector[i]->UpdatePrediction();

    }

}

void Fittino::PhysicsModelBase::UpdateSLHAConfiguration() {

    //SLHAeaSLHAFileHandler slhaeaSLHAFileHandler;
    //slhaeaSLHAFileHandler.WriteInputFile( "LesHouches.in", this );

}
