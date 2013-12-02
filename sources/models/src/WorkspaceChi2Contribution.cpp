/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        WorkspaceChi2Contribution.cpp                                    *
*                                                                              *
* Description Class for chi2 contribution provided in a Root Workspace         *
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

#include <boost/property_tree/ptree.hpp>

#include "RooAbsPdf.h"
#include "RooAbsReal.h"
#include "RooRealVar.h"
#include "RooWorkspace.h"
#include "TFile.h"
#include "TRandom3.h"

#include "ConfigurationException.h"
#include "WorkspaceChi2Contribution.h"

Fittino::WorkspaceChi2Contribution::WorkspaceChi2Contribution( std::string name, std::string fileName, std::string workspaceName, std::string predictionFileName )
        : Chi2ContributionBase( name ),
          _workspaceFile( new TFile( fileName.c_str() ) ),
          _workspace( new RooWorkspace() ) {

    //if ( _workspaceFile->IsZombie() ) {

    //    throw ConfigurationException("Path to workspace not found.");

    //};

    //_workspaceFile->GetObject( workspaceName.c_str(), _workspace );

    //_workspace->var( "MuParameter" )->setVal( 1. );
    //_workspace->var( "MuParameter" )->setConstant( 1. );
    //_workspace->var( "NomExp_signal" )->setVal( 0. );

    //_measuredValue =   _workspace->var( "Measu_signal" )->getVal()
    //                 + _workspace->var( "Measu_diboson" )->getVal()
    //                 + _workspace->var( "Measu_zjets" )->getVal()
    //                 + _workspace->var( "Measu_ttbar" )->getVal();

    //_measuredError = sqrt( _measuredValue );

    //_logLikelihood = _workspace->pdf( "full_pdf" )->createNLL( *( _workspace->data( "dataset" ) ) );
    //_llBG = _logLikelihood->getVal();

    //_predictionFileName = predictionFileName;

    //_workspace->Print();

}

Fittino::WorkspaceChi2Contribution::WorkspaceChi2Contribution( const boost::property_tree::ptree& ptree ) 
                                  : _workspaceFile( new TFile( (ptree.get<std::string>( "FileName" ) ).c_str() ) ),
                                    _workspace( new RooWorkspace() ),
                                    Chi2ContributionBase( ptree ) {

}

Fittino::WorkspaceChi2Contribution::~WorkspaceChi2Contribution() {

}

void Fittino::WorkspaceChi2Contribution::UpdateValue() {

    //ifstream predictionFile( _predictionFileName.c_str(), ios::in );
    //std::map<std::string, double> updatedValues;

    //while ( predictionFile.good() ) {

    //    std::string key, value;
    //    predictionFile >> key >> ws >> value;
    //    if ( predictionFile.eof() ) break;
    //    updatedValues.insert( std::pair<std::string, double>( key, atof( value.c_str() ) ) );

    //}

    //for ( std::map<std::string, double>::const_iterator mapItr = updatedValues.begin(); mapItr != updatedValues.end(); ++mapItr ) {

    //    _workspace->var( ( *mapItr ).first.c_str() )->setVal( ( *mapItr ).second );
    //    _predictedValue = ( *mapItr ).second;

    //}

    //CalculateChi2();
    //CalculateDeviation();

}

void Fittino::WorkspaceChi2Contribution::SmearObservation( TRandom3 *rndm ) {

}
