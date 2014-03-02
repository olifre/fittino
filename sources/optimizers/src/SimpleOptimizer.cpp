/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleOptimizer.cpp                                              *
*                                                                              *
* Description Class for simple optimization                                    *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TDirectory.h"
#include "TTree.h"

#include "SimpleOptimizer.h"
#include "ModelBase.h"
#include "ModelParameter.h"

Fittino::SimpleOptimizer::SimpleOptimizer( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : OptimizerBase( model, ptree ),
      _bestEntry( 0 ),
      _iEntry( 0 ),
      _stepWidth( model->GetCollectionOfParameters().At( 0 )->GetError() ),
      _inputFileName( ptree.get<std::string>( "InputFileName", "Fittino.in.root" ) ) {

    _name = ptree.get<std::string>( "Name", "simple optimizer" );

    TDirectory *tmpDirectory = gDirectory;
    TFile* inputFile = new TFile( _inputFileName.c_str(), "READ" );

    if ( ( TTree* )inputFile->Get( _tree->GetName() ) ) {

        _numberOfIterations = ( ( TTree* )inputFile->Get( _tree->GetName() ) )->GetEntries();

    }
    else {

        throw ConfigurationException( "Could not read number of iterations from given input file/input tree. " );

    }

    inputFile->Close();
    gDirectory = tmpDirectory;
    delete inputFile;

}

Fittino::SimpleOptimizer::~SimpleOptimizer() {

}

void Fittino::SimpleOptimizer::PrintSteeringParameters() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << "    Number of iterations  " << _numberOfIterations << Messenger::Endl;

}

void Fittino::SimpleOptimizer::UpdateModel() {

    _iEntry += _stepWidth;

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    double chi2 = _model->GetChi2();

    if ( chi2 < _chi2 ) {

        _chi2 = chi2;
        _bestEntry = _iEntry;

    }

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _bestEntry );

}
