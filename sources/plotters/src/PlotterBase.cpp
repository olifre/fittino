/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PlotterBase.cpp                                                  *
*                                                                              *
* Description Base class for plotters                                          *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TCanvas.h"
#include "TStyle.h"
#include "TTree.h"

#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PlotterBase.h"
#include "PredictionBase.h"
#include "Quantity.h"

Fittino::PlotterBase::PlotterBase( ModelBase* model, std::string& dataFileName, int randomSeed )
        : _dataFileName( dataFileName ),
          _canvas( 0 ),
          _dataFile( TFile::Open( _dataFileName.c_str(), "READ" ) ),
          _tree( ( TTree* )_dataFile->Get( "Tree" ) ),
          //_tree( (TTree*)_dataFile->Get( "markovChain" ) ),
          AnalysisTool( model, randomSeed ) {

    _name = "basic plotter";

    _leafVector = std::vector<float>( _tree->GetListOfLeaves()->GetSize() );

    Int_t font = 42; // Helvetica
    Double_t tsize = 0.04;

    _fittinoStyle = new TStyle( "FITTINO", "Fittino style" );

    _fittinoStyle->SetOptTitle( 0 );
    _fittinoStyle->SetOptStat( 0 );

    _fittinoStyle->SetPalette( 1 );

    _fittinoStyle->SetPadTopMargin( 0.05 );
    _fittinoStyle->SetPadRightMargin( 0.08 );
    _fittinoStyle->SetPadBottomMargin( 0.16 );
    _fittinoStyle->SetPadLeftMargin( 0.16 );

    _fittinoStyle->SetTextFont( font );
    _fittinoStyle->SetTextSize( tsize );

    _fittinoStyle->SetLabelFont( font, "x" );
    _fittinoStyle->SetTitleFont( font, "x" );
    _fittinoStyle->SetLabelFont( font, "y" );
    _fittinoStyle->SetTitleFont( font, "y" );
    _fittinoStyle->SetLabelFont( font, "z" );
    _fittinoStyle->SetTitleFont( font, "z" );

    _fittinoStyle->SetLabelSize( tsize, "x" );
    _fittinoStyle->SetTitleSize( tsize, "x" );
    _fittinoStyle->SetLabelSize( tsize, "y" );
    _fittinoStyle->SetTitleSize( tsize, "y" );
    _fittinoStyle->SetLabelSize( tsize, "z" );
    _fittinoStyle->SetTitleSize( tsize, "z" );

    _fittinoStyle->SetFrameBorderMode( 0 );

    // Fill the quantity vector.

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {

        _quantityVector.push_back( _model->GetCollectionOfParameters().At( i ) );

    }

    for ( unsigned int i = 0; i < _model->GetNumberOfPredictions(); ++i ) {

        _quantityVector.push_back( _model->GetPredictionVector()->at( i ) );

    }

    // Set the histogram settings.

    for ( unsigned int i = 0; i < _quantityVector.size(); ++i ) {

        _tree->SetBranchAddress( _quantityVector.at( i )->GetName().c_str(), &_leafVector.at( i ) );
        _leafMap.insert( std::pair<std::string,int>( _quantityVector.at( i )->GetName().c_str(), i ) );

    }

}

Fittino::PlotterBase::~PlotterBase() {

    delete _canvas;
    delete _tree;
    delete _dataFile;

}

void Fittino::PlotterBase::PrintResult() const {

}

void Fittino::PlotterBase::PrintSteeringParameters() const {

}

void Fittino::PlotterBase::UpdateModel() {

}
