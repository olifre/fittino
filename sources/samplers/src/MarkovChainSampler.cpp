/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MarkovChainSampler.cpp                                           *
*                                                                              *
* Description Class for Markov chain parameter sampler                         *
*                                                                              *
* Authors     Matthias Hamer       <mhamer@gwdg.de>                            *
*             Mathias  Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>             *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include <boost/lexical_cast.hpp>

#include "TBranch.h"
#include "TTree.h"

#include "MarkovChainSampler.h"
#include "ModelBase.h"
#include "ModelParameter.h"
#include "RandomGenerator.h"

Fittino::MarkovChainSampler::MarkovChainSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : SamplerBase( model, ptree ),
      _parameterValuesOfLastAcceptedPoint( std::vector<double>( model->GetNumberOfParameters(), 0. ) ),
      _firstPointScalefactor( ptree.get<double>( "FirstPointScaleFactor", 0 ) ),
      _strictBounds( ptree.get<bool>( "StrictBounds", false ) ),
      _numberOfIterations( _iterationCounter + ptree.get<int>( "NumberOfIterations" ) ) {

    _name = "Markov chain parameter sampler";

    _statusParameterVector.push_back( new Quantity( "PointAccepted", "PointAccepted", 0. , 0., 1. ) );

    _pointAccepted = false;
    _numberOfRejectedPoints = 0;

    _iterationCounter == 0 ? _weight = 1 : _weight = 0;

    for ( const auto & node : ptree ) {

        if ( node.first != "Parameter" ) continue;

        std::string name = node.second.get<std::string>( "Name" );
        double value = node.second.get<double>( "Value" );

        _model->GetCollectionOfParameters().At( name )->SetValue( value );

    }

}

Fittino::MarkovChainSampler::~MarkovChainSampler() {

}

const std::vector<double>&  Fittino::MarkovChainSampler::GetParameterValuesOfLastAcceptedPoint() const {

    return _parameterValuesOfLastAcceptedPoint;

}

void Fittino::MarkovChainSampler::FinalizeStatus() {

    _chi2 = _chi2OfLastAcceptedPoint;

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _model->GetCollectionOfParameters().At( k )->SetValue( _parameterValuesOfLastAcceptedPoint.at( k ) );

    }

}

void Fittino::MarkovChainSampler::InitializeMemory() {

    MarkovChainSampler::UpdateMemory();
    UpdateParameterValuesConsideringBounds( _firstPointScalefactor );
    UpdateModel();
    MarkovChainSampler::UpdateMemory();

}

void Fittino::MarkovChainSampler::PrintSteeringParameters() const {

    AnalysisTool::PrintSteeringParameters();

    PrintItem( "FirstPointScaleFactor", _firstPointScalefactor );
    PrintItem( "StrictBounds",          _strictBounds          );
    PrintItem( "NumberOfIterations",    _numberOfIterations    );

}

void Fittino::MarkovChainSampler::UpdateMemory() {

    _chi2OfLastAcceptedPoint = _chi2;

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        _parameterValuesOfLastAcceptedPoint.at( k ) = _model->GetCollectionOfParameters().At( k )->GetValue();

    }

}

void Fittino::MarkovChainSampler::UpdateParameterValues( double scalefactor ) {

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        ModelParameter* parameter = _model->GetCollectionOfParameters().At( i );

        double value = GetParameterValuesOfLastAcceptedPoint()[i];
        double step = _randomGenerator->Gaus( 0, parameter->GetError() * scalefactor );

        parameter->SetValue( value + step );

    }

}

bool Fittino::MarkovChainSampler::IsAccepted() {

    if ( !IsInBounds() ) return false;

    double DeltaChi2 = _chi2 - _chi2OfLastAcceptedPoint;
    double rho = exp( -DeltaChi2 / 2. );
    double randomThreshold = _randomGenerator->Uniform( 1. );

    if ( rho < randomThreshold ) return false;

    return true;

}

bool Fittino::MarkovChainSampler::IsInBounds() {

    for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

        if ( !_model->GetCollectionOfParameters().At( k )->IsInBounds() ) return false;

    }

    return true;

}

void Fittino::MarkovChainSampler::CompareChi2() {

    _pointAccepted = IsAccepted();

    if ( _pointAccepted ) {

        FillBranchPointAccepted();

        _weight = 1;
        _numberOfRejectedPoints = 0;

        UpdateMemory();

    }
    else {

        _weight++;
        _numberOfRejectedPoints++;

    }

}

void Fittino::MarkovChainSampler::Execute() {

    this->FillMetaDataTree();

    _branchPointAccepted = _tree->GetBranch( "PointAccepted" );
    _branchPointAccepted->SetStatus( 0 );

    InitializeMemory();

    while ( _iterationCounter < _numberOfIterations ) {

        UpdateParameterValuesConsideringBounds( 1. );
        UpdateModel();
        CompareChi2();

    }

    FillBranchPointAccepted();

    _branchPointAccepted->SetStatus( 1 );

    FinalizeStatus();

}

void Fittino::MarkovChainSampler::FillBranchPointAccepted() {

    _branchPointAccepted->SetStatus( 1 );

    GetStatusParameterVector()->at( 2 )->SetValue( _weight );
    _branchPointAccepted->Fill();

    for ( unsigned int j = 0; j < _numberOfRejectedPoints; j++ ) {

        GetStatusParameterVector()->at( 2 )->SetValue( 0. );
        _branchPointAccepted->Fill();

    }

    _branchPointAccepted->SetStatus( 0 );

}

void Fittino::MarkovChainSampler::UpdateModel() {

    _chi2 = _model->GetChi2();
    GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );
    GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );
    AnalysisTool::PrintStatus();
    FillTree();
    _iterationCounter++;

}

void Fittino::MarkovChainSampler::UpdateParameterValuesConsideringBounds( double scalefactor ) {

    bool isInBounds = false;

    while ( !isInBounds ) {

        UpdateParameterValues( scalefactor );

        _strictBounds ? isInBounds = IsInBounds() : isInBounds = true;

    }

}
