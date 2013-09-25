/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TreeSampler.cpp                                                  *
*                                                                              *
* Description Class for Tree sampler - to be used in PP                        *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of       *
*	      the License, or (at your option) any later version.                  *
*                                                                              *
*******************************************************************************/

#include <iostream>
#include <stdlib.h>

#include <cmath>

#include "TTree.h"
#include "TBranch.h"

#include "Configuration.h"
#include "TreeSampler.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "ModelCalculatorException.h"
#include "ModelCalculatorBase.h"
#include "SimpleDataStorage.h"
#include "ConfigurationException.h"

Fittino::TreeSampler::TreeSampler( Fittino::ModelBase* model )
    : SamplerBase( model ),
      _numberOfIterations( Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", 1 ) ),
      _isToyRun( Configuration::GetInstance()->GetSteeringParameter( "PerformToyRun", false ) ) {
    _name = "Tree sampler";

    if( !_model->GetModelCalculatorVector() ) {
        throw ConfigurationException( "CalculatorVector is a NULL-pointer (did you specify a TestModel?)" );
    }
    else if( _model->GetModelCalculatorVector()->size() == 0 ) {
        throw ConfigurationException( "Could not find a calculator associated to specified model." );
    }

}

Fittino::TreeSampler::~TreeSampler() {

}

void Fittino::TreeSampler::Execute() {

    if( _isToyRun ) _model->SmearObservables( &_randomGenerator );

    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );

        AnalysisTool::PrintStatus();

        this->UpdateModel();

    }

}

void Fittino::TreeSampler::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations << Messenger::Endl;

}

void Fittino::TreeSampler::UpdateModel() {

    GetStatusParameterVector()->at( 0 )->SetValue( _model->GetChi2() );

    for( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {
        _model->GetParameterVector()->at( k )->SetValue( _model->GetModelCalculatorVector()->at( 0 )->GetSimpleOutputDataStorage()->GetMap()->at( _model->GetParameterVector()->at( k )->GetName() ) );
    }

    this->FillTree();
}
