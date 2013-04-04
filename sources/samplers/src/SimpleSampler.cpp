/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleSampler.cpp                                                *
*                                                                              *
* Description Class for simple parameter sampler                               *
*                                                                              *
* Authors     Pia Kullik  <kullik@physik.uni-bonn.de>                          *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelBase.h"
#include "SimpleSampler.h"

Fittino::SimpleSampler::SimpleSampler( Fittino::ModelBase* model )
          : SamplerBase( model ) {

    _name = "simple parameter sampler";

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _model->SetParameterVector()->at( k )->SetValue( _model->GetParameterVector()->at( k )->GetLowerBound() );

    }

}

Fittino::SimpleSampler::~SimpleSampler() {

}

void Fittino::SimpleSampler::Execute() {

    Scan( _model->GetNumberOfParameters() - 1 );

}

void Fittino::SimpleSampler::PrintSteeringParameters() const {

}

void Fittino::SimpleSampler::ResetValues( unsigned int iParameter ) {

    for ( unsigned int i = 0; i < iParameter; i++ ) {

        _model->SetParameterVector()->at( i )->SetValue( _model->GetParameterVector()->at( i )->GetLowerBound() );

    }

}

void Fittino::SimpleSampler::Scan( unsigned int iParameter ) {

    if ( iParameter > 0 ) {

         while ( _model->GetParameterVector()->at( iParameter )->GetValue() <= _model->GetParameterVector()->at( iParameter )->GetUpperBound() ) {

            Scan( iParameter - 1 );
            if ( _model->GetParameterVector()->at( iParameter )->IsFixed() ) break;
            ResetValues( iParameter );
            UpdateValues( iParameter );

        }

    }
    else {

        while ( _model->GetParameterVector()->at( iParameter )->GetValue() <= _model->GetParameterVector()->at( iParameter )->GetUpperBound() ) {

            _iterationCounter++;
            this->PrintStatus();
            this->FillStatus();
            if ( _model->GetParameterVector()->at( iParameter )->IsFixed() ) break;
            UpdateValues( iParameter );

        }

    }

}

void Fittino::SimpleSampler::UpdateModel() {

}

void Fittino::SimpleSampler::UpdateValues( unsigned int iParameter ) {

    _model->SetParameterVector()->at( iParameter )->SetValue( _model->GetParameterVector()->at( iParameter )->GetValue() + _model->GetParameterVector()->at( iParameter )->GetError() );

}
