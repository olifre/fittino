/* $Id: WorkspaceObservable.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        WorkspaceObservable.cpp                                          *
*                                                                              *
* Description Class for observables provided in a Root Workspace               *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*     	      published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <fstream>

#include "RooAbsPdf.h"
#include "RooAbsReal.h"
#include "RooRealVar.h"
#include "RooWorkspace.h"
#include "TFile.h"

#include "ConfigurationException.h"
#include "WorkspaceObservable.h"

Fittino::WorkspaceObservable::WorkspaceObservable( std::string name, int id, std::string fileName, std::string workspaceName, std::string predictionFileName )
        : ObservableBase( name, id ),
          _workspaceFile( new TFile( fileName.c_str() ) ),
          _workspace( new RooWorkspace() ) {

    if ( _workspaceFile->IsZombie() ) {

        throw ConfigurationException("Path to workspace not found.");

    };

    _workspaceFile->GetObject( workspaceName.c_str(), _workspace );

    _workspace->var( "MuParameter" )->setVal( 1. );
    _workspace->var( "MuParameter" )->setConstant( 1. );
    _workspace->var( "NomExp_signal" )->setVal( 0. );

    _measuredValue =   _workspace->var( "Measu_signal" )->getVal()
                     + _workspace->var( "Measu_diboson" )->getVal()
                     + _workspace->var( "Measu_zjets" )->getVal()
                     + _workspace->var( "Measu_ttbar" )->getVal();

    _measuredError = sqrt( _measuredValue );

    _logLikelihood = _workspace->pdf( "full_pdf" )->createNLL( *( _workspace->data( "dataset" ) ) );
    _llBG = _logLikelihood->getVal();

    _predictionFileName = predictionFileName;

    //_workspace->Print();

}

Fittino::WorkspaceObservable::~WorkspaceObservable() {

}

void Fittino::WorkspaceObservable::UpdatePrediction() {

    ifstream predictionFile( _predictionFileName.c_str(), ios::in );
    std::map<std::string, double> updatedValues;

    while ( predictionFile.good() ) {

        std::string key, value;
        predictionFile >> key >> ws >> value;
        if ( predictionFile.eof() ) break;
        updatedValues.insert( std::pair<std::string, double>( key, atof( value.c_str() ) ) );

    }

    for ( std::map<std::string, double>::const_iterator mapItr = updatedValues.begin(); mapItr != updatedValues.end(); ++mapItr ) {

        _workspace->var( ( *mapItr ).first.c_str() )->setVal( ( *mapItr ).second );
        _predictedValue = ( *mapItr ).second;

    }

    CalculateChi2();
    CalculateDeviation();

}

void Fittino::WorkspaceObservable::CalculateChi2() {

    /*!
     *  \todo Short-term: Have to update this - need test statistics for LLR ...
     */
    _chi2 = 2 * ( _logLikelihood->getVal() - _llBG );

}
