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

#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>

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
#include "TDirectory.h"

Fittino::TreeSampler::TreeSampler( Fittino::ModelBase* model, int randomSeed )
    : SamplerBase( model, randomSeed ),
      _numberOfIterations( Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", -1 ) ),
      _isToyRun( Configuration::GetInstance()->GetSteeringParameter( "PerformToyRun", false ) ) {
    _name = "Tree sampler";

    if( !_model->GetModelCalculatorVector() ) {
        throw ConfigurationException( "CalculatorVector is a NULL-pointer (did you specify a TestModel?)" );
    }
    else if( _model->GetModelCalculatorVector()->size() == 0 ) {
        throw ConfigurationException( "Could not find a calculator associated to specified model." );
    }
    

    // number of iterations is read from the input file, if it is not defined, or set to -1, in the input file
    // wow...this is ugly! there needs to be some better way to handle this:
    const boost::property_tree::ptree* propertyTree = Configuration::GetInstance()->GetPropertyTree();
    std::string filename = propertyTree->get<std::string>( "InputFile.Sampler.<xmlattr>.InputFileName", "Fittino.old.root" );
    std::string treename = propertyTree->get<std::string>( "InputFile.Sampler.<xmlattr>.InputTreeName", "Tree1" );
    
    if( _numberOfIterations == -1 ) {
        
        // if the tree in the input file has name/title "Tree", it will overwrite the existing tree from the AnalysisTool. Therefore delete that tree:
        delete _tree;
        
        // now save the address of the _outputFile from the AnalysisTool in some temporary variable:
        TDirectory *tempDirectory = gDirectory;
        // now open the input file: this will overwrite gDirectory
        TFile *f = new TFile( filename.c_str(), "READ" );
        
        // check for the tree in the input file, and set the number of iterations
        if( (TTree*)f->Get( treename.c_str() ) ) {
            
            _numberOfIterations = ((TTree*)f->Get( treename.c_str() ))->GetEntries();
        
        }
        
        else {
            
            throw ConfigurationException( "Could not read number of iterations from given input file/input tree. ");
        
        }
        // now close the file;
        f->Close();
        //re-set the gDirectory variable to it's original value (_inputFile)
        gDirectory = tempDirectory;
        // delete the pointer 
        delete f;

        //re-create the output tree
        _tree = new TTree("Tree","Tree");

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
