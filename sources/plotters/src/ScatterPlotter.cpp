/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ScatterPlotter.cpp                                               *
*                                                                              *
* Description Class for plotting 2D scatter plots                              *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <sstream>

#include "TCanvas.h"
#include "TFile.h"
#include "TGraph.h"
#include "TH1F.h"
#include "TH2F.h"
#include "TROOT.h"
#include "TTree.h"

#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PlotterBase.h"
#include "ScatterPlotter.h"

Fittino::ScatterPlotter::ScatterPlotter( ModelBase* model, std::string& dataFileName )
        : PlotterBase( model, dataFileName ) {

    _name = "scatter plotter";

    _canvas = new TCanvas( "Canvas", "Canvas", 600, 600 );

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

    _pad = (TPad*)_canvas->cd();
    _pad->SetTicks( 1, 1 );

}

Fittino::ScatterPlotter::~ScatterPlotter() {

}

void Fittino::ScatterPlotter::PrintResult() const {

}

void Fittino::ScatterPlotter::PrintSteeringParameters() const {

}

void Fittino::ScatterPlotter::UpdateModel() {

}

void Fittino::ScatterPlotter::Execute() {

    // Specify the list of quantities to be plotted.

    _activeQuantityVector.push_back( "Mass_h" );

    // Search for the lowest chi2.

    float chi2, lowestChi2 = 1.e99;

    _tree->SetBranchAddress( "Chi2", &chi2 );

    for ( Int_t iEntry = 0; iEntry < _tree->GetEntries(); ++iEntry ) {

        _tree->GetEntry( iEntry );

        if ( chi2 < lowestChi2 ) lowestChi2 = chi2;

    }

    // Convert the lowest chi2 number to a string.

    TString lowestChi2String = "";
    std::stringstream lowestChi2StringStream;
    lowestChi2StringStream << lowestChi2;
    lowestChi2StringStream >> lowestChi2String;

    // Draw the quantities.

    for ( Int_t iActiveQuantity = 0; iActiveQuantity < _activeQuantityVector.size(); ++iActiveQuantity ) {

        // Get the index of the active quantity in the list of all quantities.

        Int_t iQuantity = _leafMap.find( _activeQuantityVector.at( iActiveQuantity ) )->second;

        TString parameterName = _quantityVector.at( iQuantity )->GetName();

        TString histogramName = parameterName;
        TString histogramTitle = histogramName;
        TH2F histogram = TH2F( histogramName, histogramTitle, 10, _quantityVector.at( iQuantity )->GetPlotLowerBound(), _quantityVector.at( iQuantity )->GetPlotUpperBound(), 10, 0., 10. );

        histogram.Draw( "AXIS" );

        _tree->Draw( "Chi2-" + lowestChi2String + ":TMath::Abs(" + parameterName + "+1)-1", "Chi2<"+ lowestChi2String + "+10", "SAME" );

        histogram.GetXaxis()->SetTitle( ( _quantityVector.at( iQuantity )->GetPlotName() ).c_str() );
        histogram.GetXaxis()->SetTitleOffset( 1.1 );
        histogram.GetXaxis()->SetRangeUser( _quantityVector.at( iQuantity )->GetPlotLowerBound(), _quantityVector.at( iQuantity )->GetPlotUpperBound() );

        histogram.GetYaxis()->SetRangeUser( 0., 10. );
        histogram.GetYaxis()->SetTitle( "#Delta#chi^{2}" );

        _canvas->Update();
        _canvas->SaveAs( parameterName + ".png", "RECREATE" );

    }

}
