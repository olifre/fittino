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
#include "Observable.h"
#include "ModelParameterBase.h"
#include "ModelCalculatorException.h"
#include "ModelCalculatorBase.h"
#include "Chi2ContributionBase.h"
#include "SimpleDataStorage.h"
#include "ConfigurationException.h"
#include "TDirectory.h"
#include "TreeCalculator.h"
#include "PhysicsModelBase.h"

Fittino::TreeSampler::TreeSampler( Fittino::ModelBase* model, int randomSeed )
    : SamplerBase( model, randomSeed ),
      _numberOfIterations( Configuration::GetInstance()->GetSteeringParameter( "NumberOfIterations", -1 ) ),
      _isToyRun( Configuration::GetInstance()->GetSteeringParameter( "PerformToyRun", false ) ),
      _determineBestFitValues( Configuration::GetInstance()->GetSteeringParameter( "DetermineBestFitValues", false ) ),
      _lowestChi2( 1.e99 ),
      _bestFitIndex( 0 ),
      _inputLowestChi2( 1.e99 ),
      _inputBestFitIndex( 0 ) {
    _name = "Tree sampler";

    if( _model->GetCollectionOfCalculators().GetNumberOfElements() == 0 ) {
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

Fittino::TreeSampler::TreeSampler( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree ) 
    : SamplerBase( model, ptree ),
      _numberOfIterations( ptree.get<int> ( "NumberOfIterations", -1 ) ),
      _isToyRun( ptree.get<bool>( "PerformToyRun", false ) ),
      _determineBestFitValues( ptree.get<bool>( "DetermineBestFitValues", false ) ),
      _lowestChi2( 1.e99 ),
      _bestFitIndex( 0 ),
      _inputLowestChi2( 1.e99 ),
      _inputBestFitIndex( 0 ) {

      _name = "Tree Sampler";
      
      if( _model->GetCollectionOfCalculators().GetNumberOfElements() == 0 ) {
        throw ConfigurationException( "Could not find a calculator associated to specified model." );
      }
      
      //still ugly...
      std::string filename = ptree.get<std::string>( "InputFileName", "Fittino.old.root" );
      std::string treename = ptree.get<std::string>( "InputTreeName", "Tree1" );

      if( _numberOfIterations == -1 ) {
       
        TDirectory *tempDirectory = gDirectory;
        TFile *f = new TFile( filename.c_str(), "READ" );
        if( (TTree*)f->Get( treename.c_str() ) ) {

           _numberOfIterations = ((TTree*)f->Get( treename.c_str() ))->GetEntries();

        }

        else {

          throw ConfigurationException( "Could not read number of iterations from given input file/input tree. ");

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

    if( _isToyRun ) {
      
      if( _determineBestFitValues ) {

        DetermineBestFitValues();

      }
      _model->SmearObservables( &_randomGenerator );
    
    }
    while ( _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;
        GetStatusParameterVector()->at( 1 )->SetValue( _iterationCounter );

        AnalysisTool::PrintStatus();

        this->UpdateModel();

    }
    
    
    if( _isToyRun ) {
      
      
      // find and fill only the best fit point into the ntuple;
      _model->GetCollectionOfParameters().At( 0 )->SetValue( (double)_bestFitIndex );
      GetStatusParameterVector()->at(0)->SetValue( _model->GetChi2() );
      GetStatusParameterVector()->at(1)->SetValue( _bestFitIndex + 1);

      this->FillTree();
    
    }
   
}

void Fittino::TreeSampler::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Number of iterations         " << _numberOfIterations << Messenger::Endl;

}

void Fittino::TreeSampler::UpdateModel() {

  double chi2 = _model->GetChi2();
  GetStatusParameterVector()->at( 0 )->SetValue( chi2 );
     
  // the model parameter is the iteration. Increase that by one each time the model is updated.
  _model->GetCollectionOfParameters().At( 0 )->SetValue( _model->GetCollectionOfParameters().At( 0 )->GetValue() + 1. );
  
  if( !_isToyRun ) {
    this->FillTree();
  }
  
  else {
    
    if( _lowestChi2 > chi2 ) {
      _lowestChi2 = chi2;
      _bestFitIndex = _iterationCounter-1; 
    } 
     
  }
  
}

void Fittino::TreeSampler::DetermineBestFitValues() {

  // loop over all iterations and find the best fit value:
  int counter = 0;
  while( counter < _numberOfIterations ) {

    // set the model paramter to the current iteration and get the chi2:
    _model->GetCollectionOfParameters().At( 0 )->SetValue( (double)counter );
    double chi2 = _model->GetChi2();

    // check if chi2 is smaller than the lowest chi2 so far, and if yes, update values of best fit index and best fit chi2:
    if( chi2 < _inputLowestChi2 ) { 
      
      _inputLowestChi2 = chi2;
      _inputBestFitIndex = counter;
    
    }
  
    counter++;

  }
  
  // set model parameter value to best fit index and get the predictiosn at the best fit index:
  _model->GetCollectionOfParameters().At( 0 )->SetValue( (double)_inputBestFitIndex );
  _model->GetCollectionOfCalculators().At( 0 )->CalculatePredictions();
  
  // set the best fit predictions for all observables of the original model; this will now include the physical model parameters:
  std::vector<Observable*>* observableVector = _model->GetObservableVector();

  for( int i = 0; i < observableVector->size(); ++i ) {
      
    observableVector->at(i)->SetBestFitPrediction( _model->GetCollectionOfCalculators().At( 0 )->GetSimpleOutputDataStorage()->GetMap()->at( observableVector->at(i)->GetPrediction()->GetName() ) );

  }
  
  // reset the model parameter to 0:
  _model->GetCollectionOfParameters().At( 0 )->SetValue( 0. );

}
