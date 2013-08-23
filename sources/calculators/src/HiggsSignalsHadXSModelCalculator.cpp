/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsHadXSModelCalculator.cpp                             *
*                                                                              *
* Description Wrapper class for HiggsSignals using whichinput=hadr             *
                                                                               *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "HiggsSignalsHadXSModelCalculator.h"
#include "ModelParameterBase.h"
#include "PhysicsModelBase.h"
#include "SimpleDataStorage.h"

Fittino::HiggsSignalsHadXSModelCalculator::HiggsSignalsHadXSModelCalculator( const PhysicsModelBase* model )
        :ModelCalculatorBase( model ){

    _name = "HiggsSignalsHadXSModelCalculator";

    InitializeSimpleOutputDataStorage();

}

Fittino::HiggsSignalsHadXSModelCalculator::~HiggsSignalsHadXSModelCalculator() {

}

void Fittino::HiggsSignalsHadXSModelCalculator::CalculatePredictions() {

    ConfigureInput();
    CallFunction();

}

void Fittino::HiggsSignalsHadXSModelCalculator::Initialize() const {
  
}

void Fittino::HiggsSignalsHadXSModelCalculator::InitializeSimpleOutputDataStorage() {

  //    _simpleOutputDataStorage->AddEntry

}

void Fittino::HiggsSignalsHadXSModelCalculator::CallExecutable() {

}

void Fittino::HiggsSignalsHadXSModelCalculator::CallFunction() {

}

void Fittino::HiggsSignalsHadXSModelCalculator::ConfigureInput() {

  //GetPrediction

}
