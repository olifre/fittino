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

#include "Chi2ContributionBase.h"
#include "Messenger.h"
#include "ModelCalculatorBase.h"
#include "ObservableBase.h"
#include "PhysicsModelBase.h"

Fittino::PhysicsModelBase::PhysicsModelBase() {

}

Fittino::PhysicsModelBase::~PhysicsModelBase() {

}

double Fittino::PhysicsModelBase::Evaluate() {

    // Let the calculators calculate the model predictions.

    for ( unsigned int i = 0; i < _modelCalculatorVector.size(); ++i ) {

        _modelCalculatorVector[i]->CalculatePredictions( this );

    }

    // Instruct the observables to update their predicted values.

    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        _observableVector[i]->UpdatePrediction();

    }

    // Update additional chi2 terms.

    for ( unsigned int i = 0; i < _chi2ContributionVector.size(); ++i ) {

        _chi2ContributionVector[i]->UpdateValue();

    }

    // Calculate and return the resulting chi2.

    return PhysicsModelBase::CalculateChi2();

}

void Fittino::PhysicsModelBase::PrintStatus() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "  Set of the " << this->GetName() << " parameters:" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

    for ( unsigned int i = 0; i < this->GetNumberOfParameters(); ++i ) {

        _parameterVector[i]->PrintStatus();

    }

    if ( _observableVector.size() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "  Summary of the " << this->GetName() << " predictions:"  << Messenger::Endl;
        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "    Observable          Predicted value                 Measured value    Deviation" << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

            _observableVector[i]->PrintStatus();

        }

    }

    if ( _chi2ContributionVector.size() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "  Summary of (additional) Chi2 terms:"  << Messenger::Endl;
        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "    Term                          Value" << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _chi2ContributionVector.size(); ++i ) {

            _chi2ContributionVector[i]->PrintStatus();

        }

    }

}

double Fittino::PhysicsModelBase::CalculateChi2() {

    double chi2 = 0.;

    // Calculate the chi2 contributions of all observables. Eventually replace
    // this formula to allow for correlated observables. 

    for ( unsigned int i = 0; i < _observableVector.size(); ++i ) {

        chi2 += pow( ( _observableVector[i]->GetPredictedValue() - _observableVector[i]->GetMeasuredValue() ) / _observableVector[i]->GetMeasuredError(), 2 );

    }

    // Add additional chi2 terms.

    for ( unsigned int i = 0; i < _chi2ContributionVector.size(); ++i ) {

	chi2 += _chi2ContributionVector[i]->GetValue();

    }

    return chi2;

}
