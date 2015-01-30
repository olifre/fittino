/* $Id$ */

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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <stdlib.h>

#include <cmath>
#include <iostream>

#include <boost/foreach.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>

#include "TBranch.h"
#include "TDirectory.h"
#include "TTree.h"

#include "CalculatorBase.h"
#include "ConfigurationException.h"
#include "Messenger.h"
#include "ModelBase.h"
#include "ModelParameter.h"
#include "Observable.h"
#include "SimpleDataStorage.h"
#include "TreeCalculator.h"
#include "TreeSampler.h"

Fittino::TreeSampler::TreeSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : SamplerBase( model, ptree ),
      _numberOfIterations( ptree.get<int>( "NumberOfIterations", -1 ) ) {

    _firstIteration = _model->GetCollectionOfParameters().At( 0 )->GetValue();
    _name = "Tree Sampler";

    if ( _model->GetCollectionOfCalculators().GetNumberOfElements() == 0 ) {

        throw ConfigurationException( "Could not find a calculator associated to specified model." );

    }

    // Still ugly...
    std::string filename = ptree.get<std::string>( "InputFileName", "Fittino.old.root" );
    std::string treename = ptree.get<std::string>( "InputTreeName", "Tree1" );

    if ( _numberOfIterations == -1 ) {

        TDirectory *tempDirectory = gDirectory;
        TFile *f = new TFile( filename.c_str(), "READ" );
        if ( ( TTree* )f->Get( treename.c_str() ) ) {

            _numberOfIterations = ( ( TTree* )f->Get( treename.c_str() ) )->GetEntries();

        }
        else {

            throw ConfigurationException( "Could not read number of iterations from given input file/input tree." );

        }

        f->Close();
        gDirectory = tempDirectory;
        delete f;
        _tree = new TTree( "Tree", "Tree" );

    }

}

Fittino::TreeSampler::~TreeSampler() {

}

void Fittino::TreeSampler::Execute() {

    this->FillMetaDataTree();

    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );

        this->UpdateModel();

    }

}

void Fittino::TreeSampler::PrintSteeringParameters() const {

    PrintItem( "NumberOfIterations", _numberOfIterations );

}

void Fittino::TreeSampler::UpdateModel() {

    _chi2 = _model->GetChi2();
    GetStatusParameterVector()->at( 0 )->SetValue( _chi2 );

    AnalysisTool::PrintStatus();

    FillTree();

    // The model parameter is the iteration. Increase that by one each time the model is updated.
    _model->GetCollectionOfParameters().At( 0 )->SetValue( _model->GetCollectionOfParameters().At( 0 )->GetValue() + 1. );

}
