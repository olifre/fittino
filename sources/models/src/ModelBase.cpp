/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.cpp                                                    *
*                                                                              *
* Description Base class for Fittino models                                    *
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

#include "Chi2ContributionBase.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PredictionBase.h"

Fittino::ModelBase::ModelBase()
        : _name( "" ),
          _evaluated( false ) {

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

int Fittino::ModelBase::GetNumberOfChi2Contributions() const {

    return _chi2ContributionVector.size();

}

int Fittino::ModelBase::GetNumberOfParameters() const {

    return _parameterVector.size();

}

int Fittino::ModelBase::GetNumberOfPredictions() const {

    return _predictionVector.size();

}

std::string Fittino::ModelBase::GetName() const {

    return _name;

}

const std::vector<Fittino::Chi2ContributionBase*>* Fittino::ModelBase::GetChi2ContributionVector() const {

    return &_chi2ContributionVector;

}

const std::vector<Fittino::ModelParameterBase*>* Fittino::ModelBase::GetParameterVector() const {

    return &_parameterVector;

}

const std::vector<Fittino::PredictionBase*>* Fittino::ModelBase::GetPredictionVector() const {

    return &_predictionVector;

}

std::vector<Fittino::ModelParameterBase*>* Fittino::ModelBase::SetParameterVector() {

    _evaluated = false;
    return &_parameterVector;

}
