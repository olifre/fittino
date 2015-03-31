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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelBase.h"
#include "ModelParameter.h"
#include "SimpleSampler.h"

Fittino::SimpleSampler::SimpleSampler( ModelBase* model, const boost::property_tree::ptree& ptree )
    : SamplerBase( model, ptree ) {

    _name = "Simple parameter sampler";

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _model->GetCollectionOfParameters().At( k )->SetValue( _model->GetCollectionOfParameters().At( k )->GetLowerBound() );

    }

}

Fittino::SimpleSampler::~SimpleSampler() {

}

void Fittino::SimpleSampler::ResetValues( unsigned int iParameter ) {

    for ( unsigned int i = 0; i < iParameter; i++ ) {

        _model->GetCollectionOfParameters().At( i )->SetValue( _model->GetCollectionOfParameters().At( i )->GetLowerBound() );

    }

}

void Fittino::SimpleSampler::Scan( unsigned int iParameter ) {

    if ( iParameter > 0 ) {

        while ( _model->GetCollectionOfParameters().At( iParameter )->GetValue() < _model->GetCollectionOfParameters().At( iParameter )->GetUpperBound() ) {

            Scan( iParameter - 1 );
            if ( _model->GetCollectionOfParameters().At( iParameter )->IsFixed() ) break;
            ResetValues( iParameter );
            UpdateValues( iParameter );

        }

    }
    else {

        while ( _model->GetCollectionOfParameters().At( iParameter )->GetValue() < _model->GetCollectionOfParameters().At( iParameter )->GetUpperBound() ) {

            _iterationCounter++;
            _chi2 = _model->GetChi2();
            GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );
            this->PrintStatus();
            this->FillTree();
            if ( _model->GetCollectionOfParameters().At( iParameter )->IsFixed() ) break;
            UpdateValues( iParameter );

        }

    }

}

void Fittino::SimpleSampler::UpdateValues( unsigned int iParameter ) {

    _model->GetCollectionOfParameters().At( iParameter )->SetValue( _model->GetCollectionOfParameters().At( iParameter )->GetValue() + _model->GetCollectionOfParameters().At( iParameter )->GetError() );

}

void Fittino::SimpleSampler::Execute() {

    this->FillMetaDataTree();

    Scan( _model->GetNumberOfParameters() - 1 );

}

void Fittino::SimpleSampler::PrintSteeringParameters() const {

    AnalysisTool::PrintSteeringParameters();

}

void Fittino::SimpleSampler::UpdateModel() {

}
