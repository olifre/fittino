/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PlotterBase.cpp                                                  *
*                                                                              *
* Description Class for plotting                                               *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <vector>
#include <iostream>

#include "TFile.h"
#include "TGraph.h"
#include "TH1F.h"
#include "TH2F.h"
#include "TLatex.h"
#include "TLegend.h"
#include "TROOT.h"
#include "TStyle.h"
#include "TTree.h"

#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PlotterBase.h"
#include "PredictionBase.h"
#include "Quantity.h"

Fittino::PlotterBase::PlotterBase( ModelBase* model, std::string& dataFileName )
        : _dataFileName( dataFileName ),
          //_canvas( "Canvas", "Canvas", 600, 600 ),
          _canvas( "Canvas", "Canvas", 800, 600 ),
          //_canvas( "Canvas", "Canvas", 600, 800 ),
          _dataFile( TFile::Open( _dataFileName.c_str(), "READ" ) ),
          _legend( 0.52, 0.63, 0.78, 0.86 ),
          //_tree( (TTree*)_dataFile->Get( "Tree" ) ),
          _tree( (TTree*)_dataFile->Get( "markovChain" ) ),
          AnalysisTool( model ) {

    _name = "basic plotter";

    _leafVector = std::vector<float>( _tree->GetListOfLeaves()->GetSize() );

    TStyle* fittinoStyle = new TStyle( "FITTINO", "Fittino style" );
    fittinoStyle->SetOptTitle(0);
    fittinoStyle->SetOptStat(0);
    fittinoStyle->SetPalette(1);

    fittinoStyle->SetFrameBorderMode(0);

    fittinoStyle->SetPadTopMargin(0.05);
    fittinoStyle->SetPadRightMargin(0.08);
    fittinoStyle->SetPadBottomMargin(0.16);
    fittinoStyle->SetPadLeftMargin(0.16);

    Int_t font=42; // Helvetica
    Double_t tsize=0.04;
    fittinoStyle->SetTextFont(font);

    fittinoStyle->SetTextSize(tsize);
    fittinoStyle->SetLabelFont(font,"x");
    fittinoStyle->SetTitleFont(font,"x");
    fittinoStyle->SetLabelFont(font,"y");
    fittinoStyle->SetTitleFont(font,"y");
    fittinoStyle->SetLabelFont(font,"z");
    fittinoStyle->SetTitleFont(font,"z");

    fittinoStyle->SetLabelSize(tsize,"x");
    fittinoStyle->SetTitleSize(tsize,"x");
    fittinoStyle->SetLabelSize(tsize,"y");
    fittinoStyle->SetTitleSize(tsize,"y");
    fittinoStyle->SetLabelSize(tsize,"z");
    fittinoStyle->SetTitleSize(tsize,"z");

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

    _pad = (TPad*)_canvas.cd();
    _pad->SetTicks( 1, 1 );
    //_pad->SetLogx( 1 );
    //_pad->SetLogy( 1 );

    // Fill the quantity vector.

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); ++i ) {

        _quantityVector.push_back( _model->GetParameterVector()->at( i ) );

    }

    for ( unsigned int i = 0; i < _model->GetNumberOfPredictions(); ++i ) {

        _quantityVector.push_back( _model->GetPredictionVector()->at( i ) );

    }

    // Set the histogram settings.

    for ( unsigned int i = 0; i < _quantityVector.size(); ++i ) {

        _tree->SetBranchAddress( _quantityVector.at( i )->GetName().c_str(), &_leafVector[i] );
        _leafMap.insert( std::pair<std::string,int>( _quantityVector.at( i )->GetName().c_str(), i ) );

    }

    _legend.SetShadowColor(0);
    _legend.SetBorderSize(1);
    _legend.SetLineColor(0);
    _legend.SetTextSize(tsize);
    _legend.SetTextFont(font);
    _legend.SetFillColor(0);

}

Fittino::PlotterBase::~PlotterBase() {

    delete _tree;
    delete _dataFile;

}

void Fittino::PlotterBase::PrintResult() const {

}

void Fittino::PlotterBase::PrintSteeringParameters() const {

}

void Fittino::PlotterBase::UpdateModel() {

}
